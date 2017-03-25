package com.maiseries.core.bank.web.activity.service.impl;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maiseries.core.bank.web.activity.service.AccountService;
import com.maiseries.core.bank.web.activity.service.ArcOrderService;
import com.maiseries.core.bank.web.activity.service.GoldPaymentService;
import com.maiseries.core.bank.web.activity.service.RewardService;
import com.maiseries.core.bank.web.common.dao.ArcAddOrderDao;
import com.maiseries.core.bank.web.common.dao.ArcAddaccountDao;
import com.maiseries.core.bank.web.common.dao.OrderDao;
import com.maiseries.core.bank.web.common.dao.ItemDao;
import com.maiseries.core.bank.web.common.dao.MessageContentDao;
import com.maiseries.core.bank.web.common.dao.PersonAccountInfoDao;
import com.maiseries.core.bank.web.common.model.ItemInfo;
import com.maiseries.core.bank.web.common.model.OrderInfo;

import payment.api.system.CMBEnvironment;
import payment.api.system.TxMessenger;
import payment.api.tx.accountvalidation.Tx2310Request;
import payment.api.tx.accountvalidation.Tx2310Response;
import payment.api.tx.cmb.Tx7211Request;
import payment.api.tx.cmb.Tx7213Response;

@Service("arcOrderService")
@Transactional
public class ArcOrderServiceImpl implements ArcOrderService {

	@Resource(name = "arcOrderDao")
	private OrderDao arcOrderDao;
	@Resource(name = "arcAddaccountDao")
	private ArcAddaccountDao arcAddaccountDao;
	@Resource(name = "arcAddOrderDao")
	private ArcAddOrderDao arcAddOrderDao;
	@Resource(name="ItemDao")
	private ItemDao itemDao;
	@Resource(name="MessageContentDao")
	private MessageContentDao messageContentDao;
	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbc;
	@Resource(name = "PersonAccountInfoDao")
	private PersonAccountInfoDao personAccountInfoDao;
	@Resource
	private AccountService accountService;//修改用户信息
	@Resource(name = "rewardService")
	private RewardService rewardService;//修改用户信息
	@Resource(name = "goldPaymentService")
	private GoldPaymentService goldPaymentService;
	private static Logger log = (Logger) LoggerFactory.getLogger(ArcOrderServiceImpl.class);
 
	
	
	
	/**
	 * 单条项目查询
	 * (non-Javadoc)
	 * @see code.main.order.service.ArcOrderService#fingDetail(java.lang.String)
	 */
	public Item fingDetail(String itemId){
		ItemInfo item = null;
		String hql = "from Item where id=?";
		try{
			item = itemDao.findObject(hql, itemId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return item;
	}
    
	/**
	 * 保存新订单
	 */
	public void addOrder(OrderInfo order) {
		try{
			arcAddOrderDao.add(order);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}

	/**
	 * 已投金额、当前进度
	 */
	public String succe(String itemId) {
		String total = "";
		String hql = "select sum(ao.capital) from ArcOrder ao where ao.fkItemId=? and ao.payStatus=?";
		try{
			Object temp = arcAddOrderDao.findByHql(hql, itemId,"01");
			if(temp==null||"".equals(temp)){
			//if(FxStringUtil.isNullOrEmpty(temp.toString())){
				total = "0.00";
			}else{
				total = (String)temp;
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return total;
	}

	/**
	 * 关联银行账户（关联查询）
	 */
	@Override
	public List bankAccount(String userId) {
		String hql = "from PersonAccountInfo where fk_base_info_id = ? and bindingState='30' order by createDate desc";
		List<PersonAccountInfo> personAccou1 = new ArrayList<PersonAccountInfo>();
		try{
			List<PersonAccountInfo> bankList = personAccountInfoDao.findList(hql, userId);
			AesDataTools tools = new AesDataTools();
			for (PersonAccountInfo a : bankList) {
				PersonAccountInfo pa = new PersonAccountInfo();
				String acctCode=tools.decode(a.getAccountCode());   // 身份证号
				String acctNumber=tools.decode(a.getCardNumber());  // 银行卡账号
				int alength = acctCode.length();
				String IdentityCard = acctCode.substring(alength - 4,alength);
				String IdentityCard2 = acctCode.substring(0,alength - 4);
				int clength = acctNumber.length();
				String IdentityCard3 = acctNumber.substring(0,clength - 4);
				String IdentityCard4 = acctNumber.substring(clength - 4,clength);
				pa.setAccountCode(IdentityCard2.replaceAll("[0-9]", "*")+ IdentityCard);
				pa.setCardNumber(IdentityCard3.replaceAll("[0-9]", "*")+ IdentityCard4);
				pa.setCardBank(a.getCardBank());
				String accoutName= tools.decode(a.getAccountName());
				int nameL=accoutName.length();
				String realName = accoutName.substring(nameL-1,nameL);
				String realNameC = accoutName.substring(0,nameL-1);
				pa.setAccountName(realNameC.replaceAll("[^x00-xff]", "*")+realName);
				pa.setId(a.getId());
				pa.setBankName(a.getBankName());
				personAccou1.add(pa);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return personAccou1;
	}

	/**
	 * 添加银行账户
	 */
	@Override
	public Map addAccount(PersonAccountInfo personInfo) {
		Map m = new HashMap();
		String id = null;
		//判断银行账号是否存在?
		PersonAccountInfo accountInfo = arcAddaccountDao.findObject(
				"from PersonAccountInfo where cardNumber=?", personInfo.getCardNumber());
		if (accountInfo == null) {
			try{
				id = (String)arcAddaccountDao.addReturn(personInfo);
				m.put("id", id);
			}catch(Exception ex){
				ex.printStackTrace();
				log.error(ArcOrderServiceImpl.class.toString(),ex);
			}
			m.put("success", true);
			m.put("msg", "TIP011");
		} else {
			accountInfo.setCardNumber(personInfo.getCardNumber());
			arcAddaccountDao.update(accountInfo);
		}
		return m;
	}


	/**
	 * 添加订单/保存订单,生成消息
	 */
	@Override
	public void saveOrder(ArcOrder order) {
		try{
			arcAddOrderDao.saveOrUpdate(order);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}


	/**
	 * 查询订单表流水号
	 */
	@Override
	public List SerialNumber() {
		List list = null;
		String hql = "from ArcOrder";
		try {
			list =  arcOrderDao.executeSqlQuery(hql);
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return list;
	}

	/**
	 * 查询当前项目的投资记录
	 */
	@Override
	public Page getPayList(JSONObject jsonObj) {
		Page page = null;
		//取出项目id
		String itemId = jsonObj.getString("itemId");
		//分页信息
		int pageIndex = jsonObj.getInt("PageIndex");
		int pageSize = jsonObj.getInt("PageSize");
		try{
			List queryParams = new ArrayList();
			String hql = "from ArcOrder where fkItemId=? and (payStatus=? or payStatus=? or payStatus=?) order by payDate desc ";
			queryParams.add(itemId);
			queryParams.add("01");
			queryParams.add("06");
			queryParams.add("10");
			List<ArcOrder> list = null;
			List<ArcOrder> resultList = new ArrayList<ArcOrder>();
			page = arcOrderDao.findPapeList(hql.toString(),queryParams.toArray(),pageIndex,pageSize);
			list = page.getDatas();
			if(list != null && list.size()>0){
				for(int i=0;i<list.size();i++){
					ArcOrder order = list.get(i);
					ArcOrder o = new ArcOrder();
					String phone = order.getMobilePhone();
					String moB = phone.substring(9,phone.length());
					String mobo = phone.substring(0,3);
					o.setMobilePhone(mobo+"******"+moB);
					o.setPayDate(order.getPayDate());
					o.setCapital(order.getCapital());
					resultList.add(o);
				}
				page.setDatas(resultList);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return page;
	}
	
	
   /**
    * 查询订单
    */
	public ArcOrder  findArcOrder(String orderNumber){
		ArcOrder arcOrder = null;
		try{
			String hql="from ArcOrder where orderNumber=?";
			arcOrder = (ArcOrder)arcOrderDao.findByHql(hql, orderNumber);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return arcOrder;
	}
	
	/**
	 * 查询流水号
	 */
	public ArcOrder findSerial(String sailId){
		ArcOrder arcOrder = null;
		try{
			String hql="from ArcOrder where serialNumber=?";
			arcOrder = (ArcOrder)arcOrderDao.findByHql(hql, sailId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return arcOrder;
	}
    /**
     * 修改订单状态  已支付 、 未支付、已超募、
     */
	
	public void updateOrder(String orderNumber,String orderType){
		try{
			String sql="update  t_order_info set order_type=? where order_number=?";
			arcOrderDao.doSql(sql, orderType,orderNumber);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}
	/**
	 * 修改流水号的支付状态
	 */
	public void updateSerialNumberr(String payStatus,String serialId,String payDate,String orderCompleteDate,String errMessage){
		try{
			String sql="update  t_order_info set pay_status=?,pay_date=?,order_complete_date=?,err_message=? where serial_number=? ";
			arcOrderDao.doSql(sql, payStatus,payDate,orderCompleteDate,errMessage,serialId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}
    
	/**
	 * 查询当前融资进度是否完成融资
	 */
	public  String therRaised(HttpServletRequest request,String fire){
		String flag="err";
		try{
			
		    String itemID = request.getParameter("itemID");
		    String totalMoney = request.getParameter("totalMoney");
		    String invCode = request.getParameter("invCode"); // 识别码
		    String counSize = this.succe(itemID);
		    Item item = this.fingDetail(itemID);
		    if(!"2".equals(fire)){
		    	 //if(!"".equals(item.getInvestorCode())&&null!=item.getInvestorCode()){
		    	 if(!FxStringUtil.isNullOrEmpty(item.getInvestorCode())){
						//if(!"".equals(invCode)&&null!=invCode){
						if(!FxStringUtil.isNullOrEmpty(invCode)){
					    	if(invCode.equals(item.getInvestorCode())){
					    		flag ="1";  // 识别码正确
					    	}else{
					    		flag ="2";  // 识别码错误
					    	}
					    }else{
					    	flag ="2";  // 识别码错误	
					    }
					}else{
						flag ="1";  // 无识别码正确
					}
		    }else{
		    	flag ="1";
		    }
		    //System.err.println(item.getInvestEndDate().getTime()<(new Date()).getTime());
		    if("1".equals(flag)&&item.getInvestEndDate().getTime()>new Date().getTime()){//识别码正确并且投标结束日大于当前时间
			    BigDecimal bigDecimal = item.getMaxFinanceMoney();
			    BigDecimal totalMoney2= BigDecimal.valueOf(Double.valueOf(totalMoney));  //当前订单预期投资金额
			    BigDecimal counSize2 = BigDecimal.valueOf(Double.valueOf(counSize));     //已经投资的订单总额
			    BigDecimal BD = bigDecimal.subtract(counSize2);                          // 最大发行规模- 已投资订单总额
			    BigDecimal kbd= BD.subtract(totalMoney2);                                // 最大发行规模- 当前订单预期投资金额
			    int ld = kbd.intValue();
			    if(ld>=0){  //刚好完成融资 或还未完成融资
			    	flag="ok";
			    }else{     //已完成融资
			    	flag="err";
			    }
		    }else if(!"2".equals(flag)){  // 验证码错误或识别码错误
		    	flag="err";
		    }
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	    return flag;
	}
	
	
	/**
	 * 生成 用户支付成功消息
	 */
	public void saveMessage(ArcOrder order,BaseInfo baseInfo,Item item,String state){
		// 生成消息，插入消息表
		try{
//			MessageContent am = new MessageContent();
			List<Object> list=new ArrayList<Object>();
			//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			 list.add(UUID.randomUUID().toString().replaceAll("-", ""));
			 list.add(baseInfo.getId());
			 String mB = baseInfo.getMobilePhone();
			 String moBo =mB.substring(0,3)+"****"+ mB.substring(7,mB.length());
			 if("01".equals(state)){
					list.add("尊敬的客户【"+moBo+"】，您参与蒲公英金融服务平台："+item.getItemPrefix()+item.getItemName()+"项目，" +
							" 出资金额"+order.getCapital()+"元，预期收益"+order.getIncome()+"元，投标成功。");
				}else if("03".equals(state)){
					list.add("尊敬的客户【"+moBo+"】，您参与蒲公英金融服务平台："+item.getItemPrefix()+item.getItemName()+"项目已超募，" +
							" 登录平台投资记录可查询投资详情。");
				}
			 //list.add(sdf1.format(new Date()));
			 list.add(DateTimeUtils.getNowTime());
			 list.add(order.getId());
			 list.add("1");
			 list.add(order.getId());
			String sql="INSERT INTO t_message_content ( id, baseinfo_id, content, creat_date, oredr_id, state ) SELECT ?,?,?,?,?,? FROM DUAL WHERE NOT EXISTS ( SELECT 1 FROM t_message_content t WHERE t.oredr_id = ? )";
			messageContentDao.doSql(sql, list.toArray());
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}
	
	/**
	 * 银行卡账户 中金支付 银行卡中金支付 快捷支付校验
	 */
	public  String  isBank(HttpServletRequest request,BaseInfo baseInfo){
		   String isVerify="4";
		   try{ 
			    
			    //Date nowdate = new Date();
			   	//DateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSSS"); 
			   	int numN = (int) (Math.random()*9000+1000);     //生成4位随机数
			   	//String txSN = numN+format.format(nowdate)+numN; // 27 位
			   	String txSN = numN+DateTimeUtils.getTodayStr("yyyyMMddHHmmssSSSS")+numN; // 27 位
	            String bankID = request.getParameter("BankCode");  // 银行对应 code
	            String accountNumber = request.getParameter("BankAccountName"); // 账户号码 卡号
	            String mobiePhone = request.getParameter("BankAccountNo");      // 添加账户的手机号码
	            String identity = request.getParameter("identity");      //  身份证号
	            String realName = request.getParameter("realName");      //  真实姓名
	            
	            // 2.创建交易请求对象
	            Tx2310Request tx2310Request = new Tx2310Request();
	            tx2310Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));
	            tx2310Request.setTxSN(txSN);
	            
	            if("700".equals(PropertiesServiceUtil.getValue("bankID"))){ // 动态配置银行ID
	            	tx2310Request.setBankID("700");       //  付款银行
	            }else{
	            	tx2310Request.setBankID(bankID);       //  付款银行
	            }
	            tx2310Request.setAccountType("11"); // 个人账户11 或者 企业账户 12
	            tx2310Request.setAccountNumber(accountNumber);
	            tx2310Request.setAccountName(realName);   //真实姓名
	            tx2310Request.setIdentificationType("0");
	            tx2310Request.setIdentificationNumber(identity); // 身份证号
	            tx2310Request.setRemark("晋城农商银行");
	            tx2310Request.setPhoneNumber(mobiePhone);
	            // tx2310Request.setEmail(email);
	            // 3.执行报文处理
	            tx2310Request.process();
		        TxMessenger txMessenger = new TxMessenger();
	            String[] respMsg  = txMessenger.send(tx2310Request.getRequestMessage(), tx2310Request.getRequestSignature());
	            Tx2310Response txResponse = new Tx2310Response(respMsg[0], respMsg[1]);
	            if(20==txResponse.getStatus()){  // 实名认证成功
	            	isVerify="02";
	            }
		        }catch(Exception ex){
		        	ex.printStackTrace();
		        	log.error(ArcOrderServiceImpl.class.toString(),ex);
		        }
		        return isVerify;
	}
	/**
	 * 身份证实名校验  中金支付 实名校验
	 */
	public String isIndentify(HttpServletRequest request){
		
		String isIfy="2";
//		String userName = request.getParameter("realName");
//	    String identificationNumber = request.getParameter("identityCard");
//	    try{
//	        // 1.取得参数
//	        if(userName!=null&&userName!=""&&identificationNumber!=null&&identificationNumber!=""){
//			   	Date nowdate = new Date();
//			   	DateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSSS"); 
//			   	int numN = (int) (Math.random()*9000+1000);     //生成4位随机数
//			   	String orderNumber = numN+format.format(nowdate)+numN; // 27 位
//		        
//		        // 2.创建交易请求对象
//		        Tx2320Request tx2320Request = new Tx2320Request();
//		        tx2320Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID")); //  交易编码
//		        tx2320Request.setTxSN(orderNumber);       // 流水号
//		        tx2320Request.setUserName(userName);
//		        tx2320Request.setIdentificationNumber(identificationNumber);
//		        // 3.执行报文处理
//		        tx2320Request.process();
//		        TxMessenger txMessenger = new TxMessenger();
//	            String[] respMsg  = txMessenger.send(tx2320Request.getRequestMessage(), tx2320Request.getRequestSignature());
//	            Tx2320Response txResponse = new Tx2320Response(respMsg[0], respMsg[1]);
//	            if(10==txResponse.getStatus()){  // 实名认证成功
//	            	 isIfy="2";
//	            }
//	         }
//	        }catch(Exception ex){
//	        	ex.printStackTrace();
//	        	log.error(ArcOrderServiceImpl.class.toString(),ex);
//	        }
	        return isIfy;
	 }
	
	/**
	 * 查询当前用户提交订单的次数
	 */
	public String querOrderTime(String mobiePhone){
		 String state="err";
		 try{
			 String sql=" from ArcOrder where mobilePhone=? order by createDate desc ";
		     List  list =arcOrderDao.pageList(sql, 0, 5, mobiePhone);
		     if(list.size()>0&&list.size()==5){
		    	   ArcOrder arcOrd=  (ArcOrder) list.get(4);
	    		   //SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				   //Date date11 = sdf1.parse(arcOrd.getCreateDate().toString());
				   Date date11 = DateTimeUtils.parseDate2(arcOrd.getCreateDate().toString());
				   long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
				   long mins = tempD / 1000 / 60; // 相差分钟数
				   if(mins<10l){
			    	   for(int j=0,l=list.size();j<l;j++){
		    		       ArcOrder arc =  (ArcOrder) list.get(j);
						   if(!"02".equals(arc.getPayStatus())){
			    			   state="ok";
			    		   }
			    	  }
				  }else{
					  state="ok";
				  }
		     }else{
		    	 state="ok";
		     }
		 }catch(Exception ex){
			 ex.printStackTrace();
			 log.error(ArcOrderServiceImpl.class.toString(),ex);
		 }
	     return state;
	}
	/**
	 * 项目完成修改项目状态 01 
	 */
	public void updateItemState(String itemId){
		try{
			String sql="update  t_item_info set full_flag='01' where id=? ";
			arcOrderDao.doSql(sql, itemId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}
	/**
	 * 获取当前用户支付完成的次数
	 */
	public String queryPayCount(String mobilePhone){
		 String stateCon="01";
		try{
			String sql="select COUNT(1) from t_order_info k  where  k.mobile_phone=? and  not (pay_type ='01')";
			int con = arcOrderDao.jdbcFindCount(sql, mobilePhone);
			if(con>0){
				stateCon="02";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return stateCon;
	}
	/**
	 * 订单修改银行卡
	 */
	public void updateOrderBank(String serialNumber,String bankCode){
		try{
			String sql="update t_order_info k set  k.fk_account_info_id=? where k.serial_number=? ";
			arcOrderDao.doSql(sql,bankCode,serialNumber);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
	}
	
	/**
	 * 订单支付完成调用存储过程接口
	 */
	@SuppressWarnings("unchecked")
	public String orderState(final String serNumbner,final String itemId,final int captions,final String bankNotificationTime){
		String param2Value=null;
		try{
			 param2Value = (String)jdbc.execute(  
				     new CallableStatementCreator() {  
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {  
				           //SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
				           String storedProc = "{call pay_orderState(?,?,?,?,?,?)}";// 调用的sql  
				           CallableStatement cs = con.prepareCall(storedProc);  
				           cs.setString(1, serNumbner);
				           cs.setString(2, itemId);
				           cs.setInt(3, captions);
				           cs.setString(4, bankNotificationTime);
				           //cs.setString(5,sdf1.format(new Date()));
				           cs.setString(5,DateTimeUtils.getNowTime());
				           cs.registerOutParameter(6, Types.VARCHAR);   
				           return cs;  
				        }  
				     }, new CallableStatementCallback() {  
				         public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException{  
				           cs.execute();  
				           return cs.getString(6);// 获取输出参数的值  
				     }  
				  });   
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
		}
		return param2Value;
	}
	
	
	/**
	 * 查询订是否超募 或满标  01:未满标 02:项目已满标  03:加上这笔钱 超募
	 */
	public  String  checkItemInvestStatus(HttpServletRequest request,String itemId,BigDecimal capital){
		String state=null;
		boolean okTouzi = false; // 判断新用户专享
		boolean whiteList = false; // 白名单项目判断
		try{ 
			Item item = this.fingDetail(itemId); // 查询项目信息
			if(item!=null&&item.getInvestEndDate().getTime()>new Date().getTime()&&item.getInvestStartDate().getTime()<new Date().getTime()){ // 投标结束时间大于当前时间
				BaseInfo baseInfo = accountService.queryInfoByPhone(request);
				if("01".equals(item.getIsNewExclusive())){ // 判断是否新用户专享
					okTouzi = accountService.isInvest(baseInfo.getId()); //投资为true ,未投资为false
				}
				//加悲观锁
				String sql = "SELECT 1 from t_base_info r where r.id=? for UPDATE "; // 指定引擎为innoDB并指定主键锁查询数据否则锁整个表（慎用）
				Map mapUpdate = null;
				try{
					List<Map<?, ?>> list = arcAddOrderDao.findListBySql(sql, baseInfo.getId());
					if(list.size()>0){
						mapUpdate=list.get(0);
					}
				}catch(Exception ex){
					throw new RuntimeException(ex);
				}
				
				if("01".equals(item.getWhiteFlag())){ // 当前项目是否属于白名单项目
				    whiteList = accountService.queryUserisInWhiteList(baseInfo.getMobilePhone(),itemId); //白名单项目判断 用户信息判断
					if(whiteList){
						String investmentSize = accountService.queryWhiteUserLimit(request,itemId);
						if(capital.compareTo(new BigDecimal(investmentSize))<=0){ //投资额度小于剩余额度
							whiteList =false; 
						}
					} 
				}
				if(!whiteList&&!okTouzi){
					String hql = "select IFNULL(sum(k.capital),0)  from  t_order_info  k where k.fk_item_id=? and k.pay_status='01' ";
					List list  = arcAddOrderDao.executeSqlQuery(hql, itemId);
				    BigDecimal maxFinanceMoney = item.getMaxFinanceMoney();//项目最大发行规模
				    BigDecimal avaliableAmount = maxFinanceMoney.subtract(new BigDecimal(list.get(0).toString()));//项目剩余可投金额
				    BigDecimal result = avaliableAmount.subtract(capital);//剩余可投金额减当前投资金额
				    int ld = result.intValue();
					if(ld>=0){
						state="01"; // 未满标或加上投资金额刚好满标
					}else{
						if(avaliableAmount.intValue()==0){
							state="02"; // 项目已满标
						}else{
							state="03"; // 加上这笔钱 超募
						}
					}
				}else{
					state="03"; // 时间到期暂不可投
				}
			}else{
				state="03"; // 时间到期暂不可投
			}
		 }catch(Exception ex){
			 ex.printStackTrace();
			 log.error(ArcOrderServiceImpl.class.toString(),ex);
			 throw new RuntimeException(ex);
		 }
		return state;
	}
	
	/**
	 * gatewayPay 网关保存订单
	 */
	public String gatewayPay(HttpServletRequest request,HttpServletResponse response){
		String state=null;
		try{
			Date nowdate = new Date();
			//DateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
			int num = (int) (Math.random()*9000+1000);//生成4位随机数
			//String orderNumber = "ORDER"+num+format.format(nowdate);
			String orderNumber = "ORDER"+num+DateTimeUtils.getTodayStr("yyyyMMddHHmmss");
			String orderBoJson = request.getParameter("bidData");//获取项目信息json字符串
			ArcOrder orderBo = null;
			orderBo = (ArcOrder) JsonUtil.jsonStrToObj(orderBoJson,ArcOrder.class);// 将json字符串 转为java对象
			orderBo.setOrderNumber(orderNumber);  // 订单号
			orderBo.setCreateDate(nowdate);       // 创建时间
			BaseInfo baseInfo = accountService.queryInfoByPhone(request); //取当前登录用户对象
			Item item = this.fingDetail(orderBo.getFkItemId());
			if(item!=null&&baseInfo!=null){
					orderBo.setFkBaseInfoId(baseInfo.getId());        //用户ID
					orderBo.setMobilePhone(baseInfo.getMobilePhone());//用户手机号
				    //  确认投标金额 防止用户随意注入 填写任意投资金额
					//if(!"".equals(orderBo.getCapital())&&null!=orderBo.getCapital()){
					if(!FxStringUtil.isNullOrEmpty(orderBo.getCapital())){
						double w = Integer.parseInt(orderBo.getCapital());
				        int e= (int)Math.ceil(w/item.getInvestUnitFee().intValue())*item.getInvestUnitFee().intValue();
				        if(String.valueOf(e).equals(orderBo.getCapital())){
				        	orderBo.setCapital(orderBo.getCapital()+".00");
				        }else{
				        	orderBo.setCapital(String.valueOf(e)+".00");
				        }
					}
					request.setAttribute("order", orderBo);
					/**
					 * 使用本金和预期年化收益率计算 应得收益
					 */
					BigDecimal investerYearRate =  BigDecimal.valueOf(Double.valueOf(item.getInvesterYearRate().toString()));  // 出资方预期年化收益率
					BigDecimal financePeriod =  BigDecimal.valueOf(Double.valueOf(item.getFinancePeriod().toString()));        // 当前项目的融资期限
					BigDecimal capital2 = BigDecimal.valueOf(Double.valueOf(orderBo.getCapital()));
					BigDecimal year = BigDecimal.valueOf(Double.valueOf("360")).multiply(BigDecimal.valueOf(Double.valueOf("100")));
					BigDecimal inC = investerYearRate.multiply(financePeriod).multiply(capital2);
					if(inC.divide(year, 2, BigDecimal.ROUND_FLOOR).compareTo(BigDecimal.valueOf(Double.valueOf(orderBo.getIncome())))!=0){
						orderBo.setIncome(inC.divide(year, 2, BigDecimal.ROUND_FLOOR).toString());
					}
					request.setAttribute("itemInfo", item);
					String ip = IPUtil.getIp(request); //获取ip
					orderBo.setIp(ip);
					orderBo.setItemNumber(item.getItemNo());
					String inCome = BigDecimal.valueOf(Double.valueOf(orderBo.getCapital())).add(BigDecimal.valueOf(Double.valueOf(orderBo.getIncome()))).toString();
					orderBo.setCapitalIncome(inCome);
					orderBo.setPayStatus("02");  // 默认为未支付
					orderBo.setPayType("01");    // 支付类型网关支付
					orderBo.setClientType("PC");
					orderBo.setDeductionFee("0");
					String  serialNumber = UUID.randomUUID().toString().replaceAll("-","");   // 支付交易流水号
					orderBo.setSerialNumber(serialNumber);
					
					List<PersonAccountInfo>  person= accountService.mybankcardOrder(orderBo.getFkAccountInfoId(), baseInfo.getId()); //  查询银行卡信息
					if(person.size()>0){
						orderBo.setPayMobiePhone(person.get(0).getBindingMobiePhone());  // 保存与银行卡绑定的手机号（柜台预留）
					}
					this.saveOrder(orderBo); //保存订单
					state =  orderNumber;
			  }
		  }catch(Exception ex){
				ex.printStackTrace();
				log.error(ArcOrderServiceImpl.class.toString(),ex);
		  }
		  return state;
	}
	
	
	/**
	 * 快捷保存订单
	 */
	public String  saveGoldQuickPay(HttpServletRequest request,HttpServletResponse response){
		String serialNumber=null;
		try{
		    Date nowdate = new Date();
			int num = (int) (Math.random() * 9000 + 1000);// 生成4位随机数
			String orderNumber = "ORDER" + num + DateTimeUtils.getTodayStr("yyyyMMddHHmmss");
			String fkItemId = request.getParameter("fkItemId");
			String capital = request.getParameter("capital");
			String income = request.getParameter("income");
			String bankCode = request.getParameter("bankCode");
			String coinCount=request.getParameter("coinCount"); //抵扣金币数
			ArcOrder orderBo = new ArcOrder();
			orderBo.setFkItemId(fkItemId);
			orderBo.setCapital(capital);
			orderBo.setIncome(income);
			orderBo.setFkAccountInfoId(bankCode);
			Item item = this.fingDetail(orderBo.getFkItemId());
			BaseInfo baseInfo = accountService.queryInfoByPhone(request);
			if (item != null && baseInfo != null){
				   String isRaised = this.checkItemInvestStatus(request,orderBo.getFkItemId(), new BigDecimal(capital)); // 判断是否超募
				   int residualGold = rewardService.queryUserCoin(baseInfo.getId(),""); //查询用户剩余可投金币数
				   int calCoinCount = rewardService.calCoinCount(fkItemId, capital); //当前最大可抵用金币
				   if(FxStringUtil.isNullOrEmpty(coinCount)||residualGold-Integer.valueOf(coinCount)<0||calCoinCount-Integer.valueOf(coinCount)<0){  // 判断当前抵扣金币是否小于等于剩余抵扣金币
						 coinCount="0";
				    }
				 if ("01".equals(isRaised)) {
					orderBo.setOrderNumber(orderNumber); // 订单号
					orderBo.setCreateDate(nowdate); // 创建时间
					// 取当前登录用户对象
					orderBo.setFkBaseInfoId(baseInfo.getId()); // 用户ID
					orderBo.setMobilePhone(baseInfo.getMobilePhone());// 用户手机号

					// 确认投标金额 防止用户随意注入 填写任意投资金额
					if (!FxStringUtil.isNullOrEmpty(orderBo.getCapital())){
						double w = Integer.parseInt(orderBo.getCapital());
						int e = (int) Math.ceil(w/ item.getInvestUnitFee().intValue())* item.getInvestUnitFee().intValue();
						if(String.valueOf(e).equals(orderBo.getCapital())) {
							orderBo.setCapital(orderBo.getCapital() + ".00");
						}else {
							orderBo.setCapital(String.valueOf(e) + ".00");
						}
					}

					/**
					 * 使用本金和预期年化收益率计算 应得收益
					 */
					BigDecimal investerYearRate = BigDecimal.valueOf(Double
							.valueOf(item.getInvesterYearRate().toString())); // 出资方预期年化收益率
					BigDecimal financePeriod = BigDecimal.valueOf(Double
							.valueOf(item.getFinancePeriod().toString())); // 当前项目的融资期限
					BigDecimal capital2 = BigDecimal.valueOf(Double
							.valueOf(orderBo.getCapital()));
					BigDecimal year = BigDecimal
							.valueOf(Double.valueOf("360"))
							.multiply(BigDecimal.valueOf(Double.valueOf("100")));
					BigDecimal inC = investerYearRate.multiply(financePeriod)
							.multiply(capital2);

					if (inC.divide(year, 2, BigDecimal.ROUND_FLOOR).compareTo(BigDecimal.valueOf(Double.valueOf(orderBo.getIncome()))) != 0) {
						orderBo.setIncome(inC.divide(year, 2,BigDecimal.ROUND_FLOOR).toString());
					}
					request.setAttribute("order", orderBo);
					request.setAttribute("itemInfo", item);
					// 获取 ip
					String ip = IPUtil.getIp(request);
					orderBo.setIp(ip);
					orderBo.setItemNumber(item.getItemNo());
					String inCome = BigDecimal.valueOf(Double.valueOf(orderBo.getCapital())).add(BigDecimal.valueOf(Double.valueOf(orderBo.getIncome()))).toString();
					orderBo.setCapitalIncome(inCome);
					orderBo.setSerialNumber(UUID.randomUUID().toString().replaceAll("-", "")); // 支付交易流水号
					orderBo.setPayStatus("02"); // 默认为未支付
					orderBo.setPayType("02"); // 支付类型 快捷支付
					orderBo.setClientType("PC");
					
					orderBo.setDeductionFee(coinCount); //抵扣金币数
					
					List<PersonAccountInfo> person = accountService.mybankcardOrder(orderBo.getFkAccountInfoId(),baseInfo.getId()); // 查询银行卡信息
					if (person.size() > 0) {
						orderBo.setPayMobiePhone(person.get(0).getBindingMobiePhone()); // 保存与银行卡绑定的手机号（柜台预留）
					}
					this.saveOrder(orderBo); // 保存订单
					serialNumber = orderBo.getSerialNumber();
				} else { // 项目超募或不可投
					serialNumber = "err";
				}
			} else {
				serialNumber = "err";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcOrderServiceImpl.class.toString(),ex);
			serialNumber = "err";
		}
		return serialNumber;
	}
    
	
	
	/**
	 * 中金快捷支付支付主方法(内部调用)
	 */
	public String  goldQuickPay(HttpServletRequest request,HttpServletResponse response){
		 String serialNumber=null;
		 try{
			 BaseInfo baseInfo = accountService.queryInfoByPhone(request); // 中金支付 账户验证
			 serialNumber =  request.getParameter("serialNumber");       // 流水号
			 if(baseInfo!=null&&!FxStringUtil.isNullOrEmpty(serialNumber)){
				 ArcOrder  arcOrder = this.findSerial(serialNumber);
				 List<PersonAccountInfo>  person= accountService.mybankcardOrder(arcOrder.getFkAccountInfoId(), baseInfo.getId()); //  查询银行卡信息
				 BigDecimal bgSize = BigDecimal.valueOf(Double.valueOf(arcOrder.getCapital())); //  当前投资的金额
				 String isRaised = this.checkItemInvestStatus(request,arcOrder.getFkItemId(),bgSize); // 判断是否超募
				 if(arcOrder!=null&&"02".equals(arcOrder.getPayStatus())&&person.size()>0&&"01".equals(isRaised)){
					    if("30".equals(person.get(0).getBindingState())){ // 银行绑定成功
						 String statef=null;
						 Item item = this.fingDetail(arcOrder.getFkItemId());  // 支付主方法
						 int captio =  Integer.parseInt(arcOrder.getCapital().replace(".", ""))-Integer.valueOf(arcOrder.getDeductionFee())*10; // 实际支付金额（投标金额-抵扣金额）
						 AesDataTools tools = new AesDataTools();
						 Tx7213Response tx7213Response =goldPaymentService.goldQuickpayment(tools.decode(person.get(0).getCardNumber()), tools.decode(person.get(0).getAccountName()), captio, person.get(0).getBindingNumber(),serialNumber, item.getItemNo());
						 if(tx7213Response!=null){
							 if("20".equals(tx7213Response.getStatus())){
								 String [] capt = arcOrder.getCapital().toString().replace(".", "=").split("=");
								 if(capt.length!=0&&capt.length>0){  // 支付成功调用存储过程
								     String aa = this.orderState(tx7213Response.getQuickPaymentNo(), arcOrder.getFkItemId(),Integer.valueOf(capt[0]), tx7213Response.getBankTxTime());
									 if("1".equals(aa)){
										 statef="01";
										 String ko = rewardService.queryItemLuckyDraw(baseInfo.getId(), arcOrder.getFkItemId()); //查询当前投资的项目是否已经获得抽奖机会
										 if("01".equals(ko)){  // 投资成功获得一次抽奖机会
											 rewardService.addAwardChance(baseInfo.getId(), arcOrder.getFkItemId(), "02");
										 }
										 if(!"0".equals(arcOrder.getDeductionFee())){ //确认使用金币进行抵扣
											 rewardService.queryAndSaveGold(baseInfo.getId(), arcOrder.getId(), Integer.valueOf(arcOrder.getDeductionFee()));
										 }
									 }else{
										 statef="03";
									 }
									
									 this.saveMessage(arcOrder, baseInfo,item,statef); // 保存消息
								 }
						     }else if("10".equals(tx7213Response.getStatus())){  //交易正在处理中
		 				    	 statef="07";
		 				    	this.updateSerialNumberr(statef, tx7213Response.getQuickPaymentNo(),DateTimeUtils.getNowTime(), tx7213Response.getBankTxTime(),tx7213Response.getResponseMessage());
						     }else{ //  支付失败
						    	 statef="08";
						    	 this.updateSerialNumberr(statef, tx7213Response.getQuickPaymentNo(),DateTimeUtils.getNowTime(), tx7213Response.getBankTxTime(),tx7213Response.getResponseMessage());
						     }
						 }
					 }
				 } 
		    }
		 }catch(Exception ex){
			  ex.printStackTrace();
			  log.error(ArcOrderCtl.class.toString(), ex);
		 }
		 return  "/arcOrder/orderPay?paymentNo="+serialNumber;
	}
	
	/**
	 * 调用中金接口拼接加密数据  调用中金支付接口(网关支付)
	 */
	public Map<String,String>  orderTransmission(HttpServletRequest request){
		 Map<String, String> map = new HashMap<String, String>();
		  try{
			   String orderNumber = request.getParameter("orderNumber");  
			   ArcOrder orderBo = this.findArcOrder(orderNumber);
			   BaseInfo baseInfo = accountService.queryInfoByPhone(request);
			   if(orderBo!=null&&baseInfo!=null&&"02".equals(orderBo.getPayStatus())){
				   String timeOut  = this.checkItemInvestStatus(request,orderBo.getFkItemId(), new BigDecimal(orderBo.getCapital()));
				   if("01".equals(timeOut)){  // 项目可投 
							 Tx7211Request tx7211Request = goldPaymentService.orderTransmission(request, orderBo, baseInfo);
				             map.put("message", tx7211Request.getRequestMessage());
				             map.put("signature",tx7211Request.getRequestSignature());
				             map.put("paymentNo",orderBo.getSerialNumber());
				             map.put("url",CMBEnvironment.cmbpaymentURL);
				   }else{
					   map.put("flag", "full");
				   }
			  }else{
				  map.put("err", "err");
			  }
		   }catch(Exception ex){
			   ex.printStackTrace();
			   map.put("err", "err");
			   log.error(ArcOrderCtl.class.toString(), ex);
		   }
		   return map;
	}
}