package com.maiseries.core.bank.web.activity.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.maiseries.core.bank.web.activity.service.AccountService;
import com.maiseries.core.bank.web.common.dao.AccountDao;
import com.maiseries.core.bank.web.common.dao.DicRegionDao;
import com.maiseries.core.bank.web.common.dao.MessageContentDao;
import com.maiseries.core.bank.web.common.dao.PersonAccountInfoDao;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;
import com.maiseries.core.bank.web.common.model.domain.Page;
import com.maiseries.core.bank.web.common.util.DesUtil;
import com.maiseries.core.bank.web.common.util.FxStringUtil;
import com.maiseries.core.bank.web.common.util.PropertiesServiceUtil;
import com.maiseries.core.bank.web.common.util.mail.MailSenderInfo;
import com.maiseries.core.bank.web.common.util.mail.SimpleMailSender;

import payment.api.tx.cmb.Tx7201Response;

@Transactional
@Service("AccountService")
public class AccountServiceImpl implements AccountService {
	@Resource(name = "AccountDao")
	private AccountDao accountDao;

	@Resource(name = "PersonAccountInfoDao")
	private PersonAccountInfoDao personAccountInfoDao;

	@Resource(name = "MessageContentDao")
	private MessageContentDao messageContentDao;
    
	@Resource(name = "dicRegionDao")
	private DicRegionDao dicRegionDao;
	
	private static Logger log = (Logger) LoggerFactory.getLogger(AccountServiceImpl.class);
	
	/**
	 * 根据用户id查询 用户的详细信息
	 * 
	 * @param id
	 * @return
	 */
	public BaseInfo getBaseInfoById(String id) {
		BaseInfo baseInfo=null;
		try{
			String hql = "from BaseInfo where mainSerialNumber=?";
			baseInfo =accountDao.findObject(hql, id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return baseInfo;
	}

	/**
	 * 修改密码
	 */
	public void updatePassWord(String id, String passWord, String passWordFlag,String lockPass) {
		try{
			String hql = "update t_base_info set  password_Flag=?, password=?,password_Flag=? where id=? ";
			accountDao.doSql(hql, passWordFlag,passWord,lockPass,id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	}

	/**
	 * 找回密码
	 */
	public void findPassWord(String code, String passWord, String passWordFlag) {
		try{
			String hql = "update t_base_info set  password_Flag=?, password=? where mobile_phone=? ";
			accountDao.doSql(hql, passWordFlag,passWord,code);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	}

	/**
	 * 根据手机号查询 好友信息
	 * 
	 * @param mobilePhone
	 * @return
	 */
	public List<BaseInfo> getFriendByPhone(String mobilePhone, String lk,String state) {
		String hql;
		List<BaseInfo> list=null;
		try{
			//if (!"".equals(lk) && null != lk) {
			if (!FxStringUtil.isNullOrEmpty(lk)) {
				hql = " SELECT * from t_base_info k where k.invite_code=? and k.mobile_phone like '%?%' ";
				list = accountDao.jdbcQuery(hql, mobilePhone,lk);
			}
			else {
				hql = "from BaseInfo where inviteCode=?";
				list = accountDao.findList(hql, mobilePhone);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return list;
	}

	/**
	 * 根据主键ID修改信息
	 */
	public String updateIdcode(BaseInfo baseInfo) {
		try{
			accountDao.saveOrUpdate(baseInfo);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return "ok";
	}
    /**
     * 查询绑定银行卡的张数和号码
     */
	public String querySizeBank(HttpServletRequest request,BaseInfo bInfo){
		String result="1";
		try{
			String sizeB= this.queryBnakbindingSize(bInfo.getId());
			if("6".equals(sizeB)){
				result="9";  //30分钟内多次绑卡（包括成功与失败）
			}else{
				AesDataTools tools = new AesDataTools();
				DesUtil desUtil = new DesUtil(); // 解密
				List<PersonAccountInfo> personAccou = this.mybankcard(bInfo.getId());				
				String cardNumber = desUtil.strDec(request.getParameter("BankAccountName")); // 开 户 名 
				if(personAccou.size()>0){
					for(PersonAccountInfo a:personAccou){
						 if(tools.encode(cardNumber).equals(a.getCardNumber())){
							 result="3";
						 }
					}
				}
				if(personAccou.size()>0&&personAccou.size()>=10){
					result="2";
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 保存银行卡信息
	 */
	public String savePersonAccountInfo(HttpServletRequest request,BaseInfo bInfo) {
//		public String savePersonAccountInfo(HttpServletRequest request,BaseInfo bInfo,Tx7201Response tx7201r) {
		String result=null;
		try{    
			    DesUtil desUtil = new DesUtil(); // 解密
			    AesDataTools tools = new AesDataTools();
			    String cardNumber = desUtil.strDec(request.getParameter("BankAccountName")); // 开 户 名 
				String BankCode = desUtil.strDec(request.getParameter("BankCode"));          // 银行编号
				String bankName = desUtil.strDec(request.getParameter("BankName"));          // 银行名称 开户行
				String cardProvince = request.getParameter("BankCity");      // 选择省份
				String card_city = request.getParameter("BankCityCode");     // 选择市区
			    String cardSubBank = desUtil.strDec(request.getParameter("cardSubBank"));    // 支行
				String cityName = request.getParameter("cityName");          // 城市名称
				String provinceName = request.getParameter("provinceName");  // 支行
				String mobiePhone = desUtil.strDec(request.getParameter("BankAccountNo"));   // 添加账户的手机号码
				
				String identityCard=null;
				String realName=null;
				if(FxStringUtil.isNullOrEmpty(bInfo.getIdentityCard())||FxStringUtil.isNullOrEmpty(bInfo.getRealName())){
				    identityCard = desUtil.strDec(request.getParameter("identity"));
				    realName = desUtil.strDec(request.getParameter("realName"));
				    identityCard =tools.encode(identityCard);
				    realName =tools.encode(realName);
				}else{
					identityCard=bInfo.getIdentityCard();
					realName=bInfo.getRealName();
				}
				
				// 防止 用户重复添加银行卡
				List<Object> list=new ArrayList();
				result=RandomStringUtils.randomAlphanumeric(32);
				list.add(result);
				list.add(identityCard);
				list.add(realName);
				list.add(BankCode);
				list.add(tools.encode(cardNumber));
				list.add(cardProvince);
				list.add(cardSubBank);
				list.add(card_city);
				list.add(bInfo.getId());
				list.add(bankName);
				list.add(cityName);
				list.add(new Date());
				list.add(provinceName);
				//石亚宁修改
//				tx7201r.setTxSNBinding("TxSNBinding");
//				tx7201r.setStatus("30");
//				tx7201r.setBankTxTime("2010-10-10");;
//				list.add(tx7201r.getResponseMessage());
				//结尾
				list.add("TxSNBinding");
				list.add("30");
				list.add("2010-10-10");
				list.add(mobiePhone);
				list.add("PC");
				list.add("ResponseMessage");
				
				list.add(tools.encode(cardNumber));
				list.add(bInfo.getId());
				String sql="INSERT INTO t_person_account_info " +
						" (id,account_code,account_name,card_bank,card_number,card_province,card_sub_bank,card_city," +
						" fk_base_info_id,bank_name,city_name,create_date,province_name,binding_number,binding_state," +
						" binding_time,binding_mobie_phone,bingding_client_type,fail_reason) " +
						" SELECT ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? FROM DUAL WHERE NOT EXISTS " +
						" (SELECT 1 FROM t_person_account_info  WHERE card_number = ? and fk_base_info_id=? and binding_state='30' )";
				personAccountInfoDao.doSql(sql, list.toArray());
				
				String hql="select count(id) from t_person_account_info k where k.id=? ";
				int kk = personAccountInfoDao.jdbcFindCount(hql, result);
				if(1==kk){
					result="1";
				}else{
					result="3";
				}
	    }catch(Exception ex){
	    	ex.printStackTrace();
	    	log.error(AccountServiceImpl.class.toString(), ex);
	    	result="3";
	    }
		return result;
	}

	/**
	 * 查询银行卡信息
	 */
	public List<PersonAccountInfo> mybankcard(String id) {
		List<PersonAccountInfo> list=null;
		try{
			String hql = "from PersonAccountInfo where fk_base_info_id=? and  bindingState='30' ";
			list = personAccountInfoDao.findList(hql, id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return list;
	}

	/**
	 * 查询订单银行卡
	 */
	public List<PersonAccountInfo> mybankcardOrder(String cardId, String baseId) {
		List<PersonAccountInfo>  list =null;
		try{
			String hql = "from PersonAccountInfo where fk_base_info_id=? and  id=?";
			list = personAccountInfoDao.findList(hql, baseId,cardId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return list;
	}

	/**
	 * 删除银行卡信息
	 */
	public String delFriden(String id) {
		try{
			String hql = "update t_base_info set invite_Code=''  where id =? ";
			accountDao.doSql(hql,id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return "1";
	}

	/**
	 * 根据用户ID查询订单表和投资记录 进行页面展示
	 */
	public List queryInvestmentRecords(String id, String state,String startDate, String endDate) {
		List list = null;
		try{
			String sql = " SELECT k.order_type, DATE_FORMAT(k.create_date,'%Y-%m-%d') as nian,DATE_FORMAT(k.create_date,'%H:%i:%s') as ri,t.item_name,t.total_finance_money,t.invester_year_rate,t.invest_unit_fee,t.finance_period,t.id  from t_order_info k LEFT JOIN t_item_info t on k.fk_item_id = t.id   "
					+ " where k.fk_item_id in ("
					+ " select kk.fk_item_id from t_base_info tt,t_order_info kk where tt.id = kk.fk_base_info_id "
					+ " and tt.id=? )" + " and k.fk_base_info_id=?";
			//if ("" != state && null != state) {
			if (!FxStringUtil.isNullOrEmpty(state)) {
				sql += " AND k.order_type=? ";
			}
			//if ("" != startDate && null != startDate) {
			if (!FxStringUtil.isNullOrEmpty(startDate)) {
				sql += "and k .create_date >= date_format(?,'%Y-%m-%d') ";
			}
			//if ("" != endDate && null != endDate) {
			if (!FxStringUtil.isNullOrEmpty(endDate)) {
				sql += "and  k .create_date <=date_format(?,'%Y-%m-%d') ";
			}
			list = accountDao.jdbcQuery(sql,id,id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return list;
	}

	/**
	 * 根据用户ID查询投资收益 进行页面展示
	 * @update show after 30min
	 * @date 2015/01/06
	 */
	public List queryProfit(String id,String payStatus) {
		List list = null;
		try{
			StringBuffer sql = new StringBuffer("SELECT SUM(CAST(e.capital AS decimal(20,2))) capital, SUM(CAST(e.income AS decimal(20,2))) income FROM t_order_info e, t_item_info t WHERE e.fk_item_id = t.id AND e.fk_base_info_id = ? AND  e.pay_status = '01' and  t.finance_end_date > NOW() ");
			sql.append("and round((UNIX_TIMESTAMP(NOW())-UNIX_TIMESTAMP(e.pay_date))/60)>30");  //交易30分钟后显示在持有资产里
			list = accountDao.jdbcQuery(sql.toString(),id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return list;
	}

	/**
	 * 根据用户ID查询投资收益 进行页面展示
	 */
	public String queryOrder(String id) {
		String ordeDdate = "暂无";
		try{
			String sql = " select DATE_FORMAT(k.create_date,'%Y-%m-%d  %H:%i:%s') ordeDdate from t_order_info k where k.fk_base_info_id=? ORDER BY k.create_date desc";
			List list = accountDao.jdbcQuery(sql, id);
			//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (list.size()>0&&!list.isEmpty()) {
				Map map = (Map) list.get(0);
				ordeDdate = map.get("ordeDdate").toString();
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return ordeDdate;
	}

	/**
	 * 查询消息列表
	 */
	public List queryMessageContent(String id) {
		List list=null;
		try{
			String hql = "from MessageContent where baseinfoId = ? and  state='1' order by creatDate desc";
			list = messageContentDao.pageList(hql, 0, 5, id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return  list;
	}

	/**
	 * 消息中心 删除消息
	 * 
	 * @param id
	 * @return
	 */
	public String delMessage(String id) {
		try {
			String sql = "update t_message_content set state='0' where  id=? ";
			messageContentDao.doSql(sql,id);
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
			return "0";
		}
		return "1";
	}

	/**
	 * 根据手机号查询个人信息
	 */
	public BaseInfo queryInfoByPhone(HttpServletRequest request) {
		String hql = "";
		String mobilePhone = "";
		try {
			AesDataTools tools = new AesDataTools();
			Cookie[] cookie = request.getCookies();
			if(cookie!=null&&cookie.length>0){
				for (int i = 0,l=cookie.length; i < l; i++) {
					if ("userName".equals(cookie[i].getName())) {
						mobilePhone = cookie[i].getValue();
						if (mobilePhone != null) {
							mobilePhone = tools.decode(mobilePhone);
						}
					}
				}
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		hql = " from BaseInfo where mobilePhone = ? ";
		return accountDao.findObject(hql, mobilePhone);
	}

	/**
	 * 投资详情列表
	 */
	public List investment_Detaillist(String id, String itemId, String orderId) {
		List list = null;
		try{
			String sql= "SELECT t.repay_source_type, t.contract_number,t.item_dtl_info,t.invest_unit_fee," +
					"t.finance_period,t.organization_number,t.loan_apply_number," +
					"t.invester_year_rate,t.item_prefix,t.finance_account_name," +
					"k.fk_account_info_id, t.max_finance_money, t.invester_year_rate,"
				+ " t.finance_period,k.order_number,DATE_FORMAT(k.pay_date, '%Y年%m月%d日') payDate,"
				+ "k.capital, k.income, k.pay_status, t.item_name,DATE_FORMAT(t.loan_Date, '%Y年%m月%d日') loanDate, "
				+ "DATE_FORMAT( t.interest_start_date, '%Y年%m月%d日' ) startDate, "
				+ "DATE_FORMAT( t.finance_end_date, '%Y年%m月%d日') endDate, k.create_date,k.deduction_fee ,DATE_FORMAT( t.finance_end_date, '%Y/%m/%d') endDateTime "
				+ " FROM t_order_info k, t_item_info t WHERE t.id = k.fk_item_id "
				+ " AND k.fk_item_id = ? and  k.id = ? ";
           list = accountDao.findListBySql(sql.toString(), itemId,orderId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return list;
	}

	/**
	 * 查询投资列表
	 */

	public Page investment_list(JSONObject jsonObj) {
		Page page = null;
		try {
			String state = jsonObj.getString("state");
			String id = jsonObj.getString("id");
			String now = jsonObj.getString("now");
			
			List queryParams = new ArrayList();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT k.id ,k.fk_item_id ,k.capital, k.income, k.pay_status, t.item_name, DATE_FORMAT( t.interest_start_date, '%Y-%m-%d' ) startDate,"
							+ " DATE_FORMAT( t.finance_end_date, '%Y-%m-%d' ) endDate,DATE_FORMAT(k.create_date,'%Y-%m-%d %H:%i:%s') creatDate, " +
								"t.item_prefix,DATE_FORMAT( t.interest_start_date, '%Y-%m-%d' ) interestStartDate, " +
								"DATE_FORMAT( t.finance_end_date, '%Y-%m-%d' ) repayClearDate,k.capital_income, t.invester_year_rate, t.finance_period,t.special_Flag,k.pay_Date,t.is_New_Exclusive,t.white_flag "
							+ " FROM t_order_info k, t_item_info t WHERE k.fk_item_id = t.id "
							+ " AND k.fk_base_info_id = ?  ");
			queryParams.add(id);
			//if (!"".equals(state)&& !"02".equals(state)&&state!=null&&!"06".equals(state)) {
			if (!FxStringUtil.isNullOrEmpty(state)&& !"02".equals(state)&&!"06".equals(state)) {
				if("002".equals(state)){        // 投资记录 未支付
					sql.append("and (k.pay_status ='07' or k.pay_status = '02' or k.pay_status = '08') ");
				}else if("003".equals(state)){  // 支付成功，投标失败
					sql.append("and (k.pay_status ='03' or k.pay_status = '04' or k.pay_status = '05'  or k.pay_status = '09') ");
				}else if("011".equals(state)){  // 投标成功，待回款
					sql.append("and (k.pay_status ='01' or k.pay_status = '10') ");
				}else{
					sql.append("AND k.pay_status = ? ");
					queryParams.add(state);
				}
			}
			if ("01".equals(state)) {
				sql.append("and t.finance_end_date > now() and round((UNIX_TIMESTAMP(NOW())-UNIX_TIMESTAMP(k.pay_date))/60)>30");   //支付成功后，订单30分钟内不显示在资产里
			}
			
			if ("02".equals(state)) {
				sql.append("and (k.pay_status is null or k.pay_status = '02') ");
			}
		    if("06".equals(now)&&"06".equals(state)){    // 历史资产
		    	sql.append("AND t.finance_end_date < NOW() and  (k.pay_status = '01' or k.pay_status = '06' or k.pay_status = '10')  ");
			}
		    if("".equals(state)&&"2".equals(now)){ // 投资记录显示 未支付 已支付 超募 处理中 已退款 支付失败的信息
		    	sql.append(" and (k.pay_status ='01' or  k.pay_status ='05' or  k.pay_status ='09' or  k.pay_status ='10' or k.pay_status = '02' or k.pay_status = '03' or k.pay_status = '07' or k.pay_status = '08' or k.pay_status='04' or k.pay_status='06' ) ");
		    }
		    if("06".equals(now)&&"06".equals(state)){
		    	sql.append(" ORDER BY t.finance_end_date desc,k.create_date desc");
		    }else{
		    	sql.append(" ORDER BY k.create_date DESC");
		    }
			
			int pageIndex = jsonObj.getInt("PageIndex");
			int pageSize = jsonObj.getInt("PageSize");
			page = accountDao.findExtPageBySql(sql.toString(), pageIndex,pageSize, queryParams.toArray());
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return page;

	}

	/**
	 * 查询好友列表
	 */
	public Page to_myFridenList(JSONObject jsonObj) {
		Page page = null;
		StringBuffer hql = new StringBuffer();
		try {
			AesDataTools tools = new AesDataTools();
			int pageIndex = jsonObj.getInt("PageIndex");
			int pageSize = jsonObj.getInt("PageSize");
			String mobePhone = jsonObj.getString("mobePhone");
			String MP = jsonObj.getString("name");
			String start = jsonObj.getString("start");
			List queryParams = new ArrayList();
			hql.append("select nickName,companyName,id,mobilePhone  from BaseInfo where inviteCode=? ");
			if (!MP.isEmpty()) {
				hql.append("and mobilePhone like '%?%' ");
			}
			queryParams.add(mobePhone);
			page = accountDao.findPapeList(hql.toString(), queryParams.toArray(), pageIndex, pageSize);
			List list = page.getDatas();
			for (int i = 0; i < list.size(); i++) {
				Object[] obj = (Object[]) list.get(i);
				String ki = (String) obj[2];
				String uuu = this.queryOrder(ki);
				obj[0] = uuu;
				String mb2 = (String) obj[3];
				String moBo = mb2.substring(0, 3) + "****"+ mb2.substring(7, mb2.length());
				obj[3] = moBo;
				list.set(i, obj);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return page;
	}

	/**
	 * 邮件激活
	 */
	public void updateMail(String id, String state, String mailDate,String mainSerialNumber) {
		try{
			String hql = "update t_base_info set activation_mail=?,mail_date=?,main_serial_number=? where id=?";
			accountDao.doSql(hql,state,mailDate,mainSerialNumber,id);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	}
    
	/**
	 * 邮件激活状态修改
	 */
	public void updateMailSerialNumber(String state, String mailDate,String mainSerialNumber) {
		try{
			String hql = "update t_base_info set activation_mail=?,mail_date=? where main_serial_number=?";
			accountDao.doSql(hql,state,mailDate,mainSerialNumber);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	}
	
	
	/**
	 * 邮件发送接口
	 */
	public Boolean sendmMail(String ip, String mB, String id, String mail) {
		Boolean ku = null;
		try {
			String moBo = mB.substring(0, 3) + "****"+ mB.substring(7, mB.length());
			// 这个类主要是设置邮件
			MailSenderInfo mailInfo = new MailSenderInfo();
			mailInfo.setMailServerHost("smtp.mxhichina.com"); // 邮件服务器
			mailInfo.setMailServerPort("25");
			mailInfo.setValidate(true);
			mailInfo.setUserName("kufu@welianxin.cn"); // 您的邮箱用户名
			mailInfo.setPassword("4esz$ESZ"); // 您的邮箱密码
			mailInfo.setFromAddress("kufu@welianxin.cn"); // 您的邮箱
			mailInfo.setToAddress(mail); // 发送的邮件地址
			mailInfo.setContent(
			"<div style='font-family:'微软雅黑';width:730px;height:auto;background-color:#fff;margin:30px auto;padding:20px 20px 60px 20px;'>"
			+"<h3 style='font-size:16px;color:#3e6224;line-height:24px;'>蒲公英银行互联网金融平台绑定邮箱验证邮件</h3>"
		    +"<h3 style='font-size:16px;color:#3e6224;line-height:24px;'>亲爱的：&nbsp;&nbsp;&nbsp; "+moBo+" &nbsp;&nbsp;&nbsp; 您好！</h3>"
		    +"<p style='font-size:14px;color:#3e6224;line-height:24px;margin-top:35px;'>您的蒲公英银行互联网金融平台账号正在绑定您的验证邮箱，请复制该网址复制至新的浏览器窗口直接打开。</p>"
		    +"<a style='font-size:14px;color:#f27d00;' href='"+PropertiesServiceUtil.getValue("mailSendUrl")+"account/activationMail?codeId="+id+"'>"+PropertiesServiceUtil.getValue("mailSendUrl")+"account/activationMail?codeId="+id+"</a>"
		    +"<p style='font-size:14px;color:#3e6224;line-height:24px;'>(请在24小时内完成确认，24小时后邮件失效)</p>"
		    +"<p style='font-size:14px;color:#3e6224;line-height:24px;'>此邮件由蒲公英银行互联网金融平台自动发出，请勿直接回复。</p>"
		    +"<p style='font-size:14px;color:#3e6224;line-height:24px;'>如有任何疑问，请访问蒲公英银行互联网金融平台获取帮助。</p>"
		    +"</div>");
			mailInfo.setSubject("蒲公英金融服务平台绑定邮箱验证邮件");
			// 这个类主要来发送邮件
			SimpleMailSender sms = new SimpleMailSender();
			ku = sms.sendHtmlMail(mailInfo);// 发送html格式
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
			ku=false;
		}
		return ku;
	}

	/**
	 * 根据手机号修改借款状态
	 */
	public boolean updateInfoByPhone(String mobilePhone) {
		String hql = "";
		hql = " from BaseInfo where mobilePhone = ? ";
		String updateIsList = "update t_base_info set is_loan='1' where mobile_phone=? ";
		try {
			accountDao.doSql(updateIsList,mobilePhone);
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return false;
	}
	
	/**
	 * 查询所有相关的银行卡 模糊查询
	 */
	public List queryBank(String autValue) { 
		List list=null;
		try{
			 String hql = " select text,code from t_dic_system where  big_type='banks' and type='bankName' and (remark is null or remark='')  ORDER BY statue desc  ";  // statue
			 list = dicRegionDao.jdbcQuery(hql);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	    return list;
	}
	
	/**
	 * 查询所有可上架且有图标的银行列表
	 */
	public List queryBankIcon() { 
		List list=null;
		try{
			 String hql = "SELECT text,code,encoding,remark,k.max_limit from  t_dic_system k  where k.type='bankname' and k.big_type='banks' and (remark is null or remark='') and encoding is NOT null  ORDER BY k.statue desc ";  // statue
			 list = dicRegionDao.jdbcQuery(hql);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	    return list;
	}
	
	
	/**
	 * 实名认证查询（重复校验）
	 */
	public BaseInfo queryIndentify(String identityCard) { 
		BaseInfo baseInfo=null;
		try{
			String hql = "from BaseInfo where identityCard=?";
			baseInfo =accountDao.findObject(hql, identityCard);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	    return baseInfo;
	}
	
	/**
	 * 实名认证修改真实信息
	 */
	public void updateRealName(BaseInfo baseInfo){ 
		try{
			String sql="update t_base_info k set k.identity_card=?,k.real_name=?,k.user_birthday=? where k.id=? "; 
			accountDao.doSql(sql, baseInfo.getIdentityCard(),baseInfo.getRealName(),baseInfo.getUserBirthday(),baseInfo.getId());
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	}
	
	/**
	 * 查询与当前用户关联的银行
	 */
	public int queryBankById(String baseId,String bankId){ 
		int kk=0;
		try{
			Object[] obj = {baseId, bankId};
			String sql="select count(k.id) from PersonAccountInfo k where k.fk_base_info_id=? and k.id=?  and bindingState='30' "; 
			kk = accountDao.count(sql,obj);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return  kk;
	}
	
	/**
	 * 银行卡解绑(逻辑解绑)
	 */
	public void  delBank(String baseId,String bankId,String time){
		try{
			String sql="update t_person_account_info k set k.unbundling_client_type='PC', k.binding_state='50',k.unbundling_time=?  where k.fk_base_info_id=? and k.id=? "; 
			accountDao.doSql(sql,time,baseId,bankId);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
	}
	
	/**
	 * 查询银卡绑定次数
	 */
	@SuppressWarnings("unchecked")
	public String queryBnakbindingSize(String id) {
		String sizeb=null;
		try{
			String hql =" from PersonAccountInfo where fk_base_info_id=? order by  createDate desc ";
			List<PersonAccountInfo> persion  = (List<PersonAccountInfo>) personAccountInfoDao.pageList(hql, 0,6,id);
			if(persion!=null&&persion.size()==6){
				Date date11 = persion.get(5).getCreateDate();
				long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
				long mins = tempD / 1000 / 60; // 相差分钟数
				if (30L>mins) {
					sizeb = "6";  //绑卡次数超出30分钟6次
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return sizeb;
	}
	
	/**
	 *判断当前用户是否首次绑卡 01首次绑卡 02多次绑卡
	 */
	public String firstBindBnak(String userId){
		String size="01";
		try{
			String sql="select count(1) from t_person_account_info where fk_base_info_id='"+userId+"' and (binding_state='30' or binding_state='50')";
			int aa  =personAccountInfoDao.executeSqlCount(sql);
			if(aa>1){
				size="02";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return  size;
	}
	
	/**
	 * 查询当前用户的推荐人
	 */
	public String queryTuiPerson(String userId){
		String size="01";
		try{
			String sql="SELECT id from  t_base_info t where t.mobile_phone=(SELECT invited_code from  t_base_info k where k.id=?) ";
			List list  =personAccountInfoDao.executeSqlQuery(sql,userId);
            if(list.size()>0){
            	size  = list.get(0).toString();
            }
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AccountServiceImpl.class.toString(), ex);
		}
		return  size;
	}

	/**
	 * 判断用户有没有投资
	 * retutn    true已投   false 没投
	 */
	
	public boolean isInvest(String baseId) {
		boolean flag = true;
		//BaseInfo baseInfo = queryInfoByPhone(request);
		String sql = "select count(1) from t_order_info o,t_base_info b where o.fk_base_info_id=b.id and pay_status in(?,?,?) and b.identity_card=(SELECT identity_card FROM t_base_info WHERE id=?)";
		Object[] params = {"01","06","10",baseId};
		List list = accountDao.executeSqlQuery(sql, params);
		int n = 0;
		if(list != null && list.size() > 0){
			BigInteger big = (BigInteger)list.get(0);
			n = big.intValue();
		}
		if(n > 0){//已投过
			flag = true;
		}else{//没投
			flag = false;
		}
		return flag;
	}

	/**
	 * 查询用户是否在白名单
	 */
	
	public boolean queryUserisInWhiteList(String phoneNo,String itemId) {
		boolean flag = false;
		String sql = "select count(1) from t_whitelists_info where wt_item_id=? and white_name=?";
		Object[] params = {itemId,phoneNo};
		List list = accountDao.executeSqlQuery(sql, params);
		int n = 0;
		if(list != null && list.size() > 0){
			BigInteger big = (BigInteger)list.get(0);
			n = big.intValue();
		}
		if(n > 0){//用户在白名单里
			flag = true;
		}else{//用户不在白名单
			flag = false;
		}
		return flag;
	}

	/**
	 * 查询用户剩余的限额
	 * @param request
	 * @return
	 */
	
	public String queryWhiteUserLimit(HttpServletRequest request,String itemId) {
		BaseInfo baseInfo = queryInfoByPhone(request);
//		String itemId = request.getParameter("itemId");
		String ph = baseInfo.getMobilePhone();
		String baseId = baseInfo.getId();
		String sql1 = "select max_limit from t_whitelists_info where white_name=? and wt_item_id=?";
		Object[] params1 = {ph,itemId};
		List list1 = accountDao.executeSqlQuery(sql1, params1);
		BigDecimal big1 = new BigDecimal("0");
		if(list1 != null && list1.size() > 0){
			big1 = (BigDecimal)list1.get(0);
		}
		
		String sql2 = "select sum(capital) from t_order_info where fk_base_info_id=? and fk_item_id=? and pay_status in(?,?,?) ";
		Object[] params2 = {baseId,itemId,"01","06","10"};
		List list2 = accountDao.executeSqlQuery(sql2, params2);
		BigDecimal big2 = new BigDecimal("0");
		if(list2 != null && list2.size() >0){
			Double d = (Double)list2.get(0);
			if(d == null || d == 0){
				big2 = big2.valueOf(0);
			}else{
				big2 = BigDecimal.valueOf(d);
			}
		}
		BigDecimal leftLimit = big1.subtract(big2);
		return leftLimit.toString();
	}
}
