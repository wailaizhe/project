package com.maiseries.core.bank.web.activity.service.impl;
 
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.exception.DataException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;

import code.main.archive.Commonality.SendMsgUtil;
import code.main.archive.dao.BaseInfoDao;
import code.main.archive.dao.SmsInfoDao;
import code.main.archive.entity.BaseInfo;
import code.main.archive.service.BaseInfoService;
import code.main.archive.service.SmsInfoService;
import code.main.base.domain.Page;
import code.main.base.util.DateTimeUtils;
import code.main.base.util.DesUtil;
import code.main.base.util.FxStringUtil;
import code.main.base.util.IPUtil;
import code.main.base.util.JdbcUtil;
import code.main.base.util.PhoneRegularUtil;
import code.main.base.util.PropertiesServiceUtil;
import code.main.reward.service.RewardService;
import fengx.com.AesDataTools;
import net.sf.json.JSONObject;
 

@Service("baseInfoService")
@Transactional
public class  BaseInfoServiceImpl implements BaseInfoService {
	 
	@Resource(name="baseInfoDao")
	protected BaseInfoDao baseInfoDao;
	
	@Resource(name = "smsInfoDao")
	private SmsInfoDao smsInfoDao;
	
	@Resource(name = "smsInfoService")
	private SmsInfoService smsInfoService;
	
	@Resource(name = "baseInfoService")
	private BaseInfoService baseInfoService;
	
	@Resource(name="rewardService")
	private RewardService rewardService;
    
	private static Logger log = (Logger) LoggerFactory.getLogger(BaseInfoServiceImpl.class);
	/** 
	 * 验证手机和登陆
	 */
		@Override
	  public BaseInfo isPhone(String phone) {
			BaseInfo baseInfo = null;
			String hql = "from BaseInfo where mobilePhone=?";
			try {
				baseInfo = baseInfoDao.findObject(hql, phone);
			} catch (Exception ex) {
				ex.printStackTrace();
				log.error(BaseInfoServiceImpl.class.toString(),ex);
			}
			return baseInfo;
		}
 
         
	@Override
	public Map addUser(BaseInfo base) {
		
		Map map = new HashMap();
		try {
			Object obj = baseInfoDao.addReturn(base);
			map.put("flag", "ok");
		} catch (DataException ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
			map.put("flag", "注册失败。");
		}
		return map;
	}
 

	/**
	 * 根据用户名查找企业信息
	 * @return
	 */
	@Override
	public BaseInfo findObjByUserName(String userName){
		BaseInfo baseInfo = null;
		String hql="from BaseInfo where Mobile=? and registerType=?";
		try {
			 baseInfo= baseInfoDao.findObject(hql, userName,"02");
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
		}
		return baseInfo;
	}


	@Override
	public BaseInfo isLogin(String phone, String pass) {

		    BaseInfo baseInfo=null;
			String hql = "from BaseInfo where mobilePhone=? and password=?";
			try {
				baseInfo = baseInfoDao.findObject(hql, phone, pass);
			} catch (Exception ex) {
				ex.printStackTrace();
				log.error(BaseInfoServiceImpl.class.toString(),ex);
			}
			return baseInfo;
	}
	/**
	 * 登陆接口调用
	 */
	@Override
	public Map<String, String>  registerIsLogin(HttpServletResponse response, HttpServletRequest request,String userName, String password) {
		Map<String, String> loginMap = new HashMap<String, String>();
		try {//周报表
			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			AesDataTools tools = new AesDataTools();
			String sql="from BaseInfo where mobilePhone = ? ";
			BaseInfo baseInfo = (BaseInfo)baseInfoDao.findByHql(sql, userName);
			if(baseInfo==null){
				loginMap.put("err", "");
			}else if("02".equals(baseInfo.getRegisterType())) {  //企业用户暂不允许登陆
				loginMap.put("err", "02");
			}else{
				String psFlag = baseInfo.getPasswordFlag();
				String lockDate="1";
				//if(psFlag!=null&&!psFlag.isEmpty()&&Integer.parseInt(psFlag)>=3&&!baseInfo.getLockPassDate().isEmpty()){
				if(!FxStringUtil.isNullOrEmpty(psFlag)&&Integer.parseInt(psFlag)>=3&&!baseInfo.getLockPassDate().isEmpty()){
					//Date date11 = sdf.parse(baseInfo.getLockPassDate());
					Date date11 = DateTimeUtils.parseDate2(baseInfo.getLockPassDate());
					long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
					long mins = tempD / 1000 / 60; // 相差分钟数
					if (mins < 1440L) {
						lockDate = "2"; // 密码24小时内错误3次
					}else{
						baseInfo.setPasswordFlag("");
						baseInfo.setLockPassDate("");
						baseInfoDao.saveOrUpdate(baseInfo);
						lockDate = "1";
					}
				}
				
				if("2".equals(lockDate)&&!psFlag.isEmpty()&&Integer.parseInt(psFlag)>=3){
					 loginMap.put("err", "lock");
				}else{
					password =tools.encode(password);  // 对密码进行加密
//					Object[] params = new Object[] { userName, password };
//					Object[] paramNames = new Object[] { "arg0", "arg1" };
					Object obj = JdbcUtil.checkLoginStatus(userName, password);
//					Object obj = WebServiceClientService.invokeWebService(PropertiesServiceUtil.getValue("loginCheck"),"http://login.webservice.main.code/", "checkLogin", params,
//							paramNames);
					String value = obj.toString();
//					loginMap = XMLParserUtil.getMapByXml(retStr);
//					String value = loginMap.get("idNo");
					if("02".equals(value)){ // 密码输入错误进行校验 和锁定
						//if("".equals(baseInfo.getPasswordFlag())||baseInfo.getPasswordFlag()==null){
						if(FxStringUtil.isNullOrEmpty(baseInfo.getPasswordFlag())){
							baseInfo.setPasswordFlag("1");
							//baseInfo.setLockPassDate(sdf.format(new Date()));
							baseInfo.setLockPassDate(DateTimeUtils.getNowTime());
							baseInfoDao.saveOrUpdate(baseInfo);
							loginMap.put("err", "2");
						}else{
							int flag =Integer.parseInt(baseInfo.getPasswordFlag())+1;
							baseInfo.setPasswordFlag(String.valueOf(flag));
							//baseInfo.setLockPassDate(sdf.format(new Date()));
							baseInfo.setLockPassDate(DateTimeUtils.getNowTime());
							baseInfoDao.saveOrUpdate(baseInfo);
							loginMap.put("err", String.valueOf(3-flag));
						}
					}
					userName = tools.encode(userName); // 加密手机号
					loginMap.put("value", value);
					
					if ("03".equals(value)) {// 校验成功
						// 向客户端写cookie
						Cookie cookie = new Cookie("userName", userName);
						//cookie.setMaxAge(60 * 3); //设置失效过期时间  3分钟  石亚宁 放开
						cookie.setPath("/");
						String doMain=PropertiesServiceUtil.getValue("setDomain");
						if(!"doMomain".equals(doMain)){
						   cookie.setDomain(doMain);
						}
						response.addCookie(cookie);
						baseInfo.setPasswordFlag("");
						baseInfo.setLockPassDate("");
						String sendTime = baseInfo.getThetimeLogin();
						if(!"".equals(sendTime)&&baseInfo.getThetimeLogin()!=null){
							baseInfo.setUserCheckTime(baseInfo.getThetimeLogin());
							//baseInfo.setThetimeLogin(sdf.format(new Date()) ); // 当前登录时间
						}else{
							//baseInfo.setThetimeLogin(sdf.format(new Date()));
							//baseInfo.setUserCheckTime(sdf.format(new Date()));
							baseInfo.setUserCheckTime(DateTimeUtils.getNowTime());
						}
						baseInfo.setThetimeLogin(DateTimeUtils.getNowTime());
						baseInfoDao.saveOrUpdate(baseInfo);
					}
					loginMap.put("success", "5");
					loginMap.put("pathUrl", "/baseInfo/registerhrsuc");
				}
		  }
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
			loginMap.put("success", "0");
		}
		 return loginMap;
	}
 
	
	/**
	 * 验证码校验
	 */
	public String checkYzm(HttpServletRequest request){
		String flag="06";
		try{
			String codeType = request.getParameter("codeType");
	        String validateC = (String) request.getSession().getAttribute(codeType);        
	        String veryCode = request.getParameter("code");        
	        //if(!"".equals(validateC)&&validateC!=null&&!"".equals(veryCode)&&veryCode!=null&&validateC.equalsIgnoreCase(veryCode)){
	        if(!FxStringUtil.isNullOrEmpty(validateC)&&!FxStringUtil.isNullOrEmpty(veryCode)&&validateC.equalsIgnoreCase(veryCode)){
	        	flag="07";
	        }else{
	        	flag="06";
	        } 
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	/**
	 * 退出系统
	 */
	public void loginOut(HttpServletResponse response,HttpServletRequest request){
		try{
			Cookie[] cookies = request.getCookies();
			if(cookies!=null&&cookies.length>0){
				for (int i = 0, len = cookies.length; i < len; i++) {
					Cookie cookie = new Cookie(cookies[i].getName(), null);
					if (cookie != null) {
						cookie.setMaxAge(0);
						cookie.setPath("/");
						cookie.setValue(null);
						String doMain=PropertiesServiceUtil.getValue("setDomain");
						if(!"doMomain".equals(doMain)){
						   cookie.setDomain(doMain);
						}
						response.addCookie(cookie);
					}
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
		}
	}
	
	
	public void update(BaseInfo baseInfo)
	{
		baseInfoDao.update(baseInfo);
	}
	public Map insertBaseInfo(String sql,Object[] params)
	{
		Map map = new HashMap();
		try {
			baseInfoDao.doSql(sql, params);
			map.put("flag", "ok");
		} catch (DataException ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
			map.put("flag", "注册失败。");
		}
		return map;
	}

	/**
	  * 注册
	  * @param request
	  * @param response
	  * @return
	  */
	@Override
	public Map<String, String> userRegisterIntoService(HttpServletRequest request, HttpServletResponse response) {
		AesDataTools tools = null;
		Map<String,String> returnMap = new HashMap();
		DesUtil desUtil = new DesUtil(); // 解密
		try {   
			    String moPhone = desUtil.strDec(request.getParameter("mobilePhone"));
			    String password = desUtil.strDec(request.getParameter("password"));
			    //石亚宁修改
//			    String flag1 = smsInfoService.getCode(request, moPhone);
			    String flag1 = "0";
			    String invitedCode = request.getParameter("invitedCode");
			    if("0" ==flag1){
			    	PhoneRegularUtil phontU = new PhoneRegularUtil();
				    if(!FxStringUtil.isNullOrEmpty(moPhone)&&phontU.phoneCheck(moPhone)){
				    	BaseInfo BI = this.isPhone(moPhone);
				    	if(BI==null){
				    		BaseInfo referBI = baseInfoService.isPhone(invitedCode);//查询该邀请码是否存在
				    		if(!FxStringUtil.isNullOrEmpty(invitedCode) && null == referBI){//如果页面传过来邀请码，但是在数据库中没有查询到
					    		returnMap.put("err", "invitedCodeErr");
					    	}else{
					    		List<Object> list=new ArrayList();
					    		BaseInfo baseInfo= new BaseInfo();
					    		tools = new AesDataTools(); // 生成随机数
								String code1 = SendMsgUtil.createRandomVcode();
								String ip = IPUtil.getIp(request); // 获取客户端IP
								String nickName = "user" + code1 + "_"; // 设置用户名b
								//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 获得系统当前时间(将字符串转换成日期)
								//String ly_time = sdf.format(new Date());
								//Date date   = sdf.parse(ly_time);
								Date date = DateTimeUtils.getCurrentDateTime();
								String baseInfoId = UUID.randomUUID().toString().replace("-", "");//用户id
								list.add(baseInfoId);
								//if(baseInfo.getCompanyName()!=null&&!baseInfo.getCompanyName().isEmpty()){
								if(!FxStringUtil.isNullOrEmpty(baseInfo.getCompanyName())){
									baseInfo.setRegisterType("02");  // 企业注册
									list.add("02");
								}else{
									baseInfo.setRegisterType("01");  // 个人注册
									list.add("01");
								}
								String passWord=tools.encode(password); // 对密码进行加密

								/*baseInfo.setCustomerIp(ip);  // 设置当前客户端iP
								baseInfo.setCreateDate(date); // 设置当前系统时间
								baseInfo.setNickName(nickName);
								baseInfo.setAccSeq(RandomStringUtils.randomAlphanumeric(4));
								baseInfo.setPassword(passWord);
								baseInfo.setMobilePhone(moPhone);
								baseInfo.setClientType("PC");
								returnMap = baseInfoService.addUser(baseInfo); // 对手机进行加密
								 	*/		
								list.add(date);
								list.add(ip);
								list.add(nickName);
								list.add(RandomStringUtils.randomAlphanumeric(4));
								list.add(passWord);
								list.add(moPhone);
								list.add("PC");
								list.add(moPhone);
								list.add(invitedCode);//被邀请码
								list.add(moPhone);
								//returnMap = baseInfoService.addUser(baseInfo); // 对手机进行加密
								String sql="INSERT INTO t_base_info ( id, register_type,create_date, customerip, nick_name, acc_seq, PASSWORD, mobile_phone, client_type,invitation_code,invited_code ) SELECT ?,?,?,?,?,?,?,?,?,?,? FROM DUAL WHERE NOT EXISTS ( SELECT 1 FROM t_base_info t WHERE t.mobile_phone = ? )";
								returnMap =	this.insertBaseInfo(sql,list.toArray());
								rewardService.addAwardChance(baseInfoId, null,"02");//给注册用户一次抽取4等奖的机会
								if(!FxStringUtil.isNullOrEmpty(invitedCode)){//如果邀请码不为空，则给推荐人一次抽奖机会
									BaseInfo invideBI = this.isPhone(invitedCode);
									String invideId = invideBI.getId();
									rewardService.addAwardChance(invideId, null,"02");//给邀请人一次抽取4等奖的机会
								}
					    	}
					    }else{
					    	returnMap.put("err", "1");
					    }
				    }else{
				    	returnMap.put("err", "2");
				    }
			    }else{
			    	returnMap.put("success", flag1);
			    }
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),ex);
		}
		return returnMap;
	}
	
	
	/**
	 * @author yangdongxu
	 * @date Feb 18, 2016 10:42:25 AM
	 * @version 版本号码
	 * @TODO 查询我所邀请的人员
	 */
	@Override
	public Page queryInvited(JSONObject jsonObj) {
		Page page = null;
		StringBuffer hql = new StringBuffer(" select t.realName,t.mobilePhone,DATE_FORMAT(t.createDate,'%Y-%m-%d ') from BaseInfo t  ");
		hql.append(" where t.invitedCode=? order by t.createDate desc ");
		String invitedCode = jsonObj.getString("invitedCode");
		int pageIndex = jsonObj.getInt("PageIndex");
		int pageSize = jsonObj.getInt("PageSize"); 
		List params = new ArrayList();
		params.add(invitedCode);
		try {
			page = baseInfoDao.findPage(hql.toString(), pageIndex, pageSize, params.toArray());	
			List<Object[]> list=page.getDatas();
			List resultList=new ArrayList();
			AesDataTools tools = new AesDataTools();
			for(Object[] obj:list)
			{
				Object[] resultObj=obj;
				if(obj[0]==null){
					resultObj[0]="未实名认证";
				}else{
					resultObj[0]=tools.decode(obj[0].toString());
				}
				String phone = obj[1].toString();
				String phone1 = phone.substring(0, 3);
				String phone2 = phone.substring(7, 11);
				phone = phone1+"****"+phone2;
				resultObj[1]=phone;
				resultList.add(resultObj);
			}
			page.setDatas(resultList);
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(), ex);
		}
		return page;
	}
	
	/**
	 * @author yangdongxu
	 * @date Feb 18, 2016 10:42:25 AM
	 * @version 版本号码
	 * @TODO 查询我的金币详情
	 */
	@Override
	public Page queryGoldDetail(JSONObject jsonObj) {
		Page page = null;
		try {
			StringBuffer hql = new StringBuffer(" SELECT * FROM ( ");
			hql.append(" select * from(select t.create_time,t.total_coin_num,t.rank from t_award_info t where fk_base_info_id=? AND t.total_coin_num!=0 ORDER BY t.create_time DESC ) A ");
			hql.append("UNION  SELECT * from (select u.create_time,-sum(u.used_coin_num),'used' from t_used_award_info u where u.fk_base_info_id=? AND is_valid='02' GROUP BY u.fk_order_id ORDER BY u.create_time DESC ) B ) ");
			hql.append(" C ORDER BY C.create_time DESC ");
			String userid = jsonObj.getString("userid");
			int pageIndex = jsonObj.getInt("PageIndex");
			int pageSize = jsonObj.getInt("PageSize"); 
			List params = new ArrayList();
			params.add(userid);
			params.add(userid);
			page = baseInfoDao.findExtPageByComplexSql(hql.toString(), pageIndex, pageSize, params.toArray());	
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(), ex);
		}
		return page;
	}


	@Override
	public Page queryInvitedActivity(JSONObject jsonObj) {
		
		StringBuilder sql = new StringBuilder(" select t.real_name,t.mobile_phone,DATE_FORMAT(t.create_date,'%Y-%m-%d %H:%i:%s'),t.id,t.invited_code,IF(t.real_name!='',true,false)");
		sql.append(" from t_base_info t where create_date BETWEEN '"+ActivityDateEnum.START.getValue()+"' and '"+ActivityDateEnum.END.getValue()+"'");
		String invitedCode = jsonObj.getString("invitedCode");
		List params = new ArrayList();
		if(!invitedCode.isEmpty()){
			params.add(invitedCode);
			sql.append(" and t.invited_code=?");
		}else{
			sql.append(" and t.invited_code <>''");
		}
		sql.append(" order by t.create_date desc");
		int pageIndex = jsonObj.getInt("PageIndex");
		int pageSize = jsonObj.getInt("PageSize");
		
		Page page = null;
		try {
			page = baseInfoDao.findExtPageBySql(sql.toString(), pageIndex, pageSize,params.toArray());
			List<Object[]> list = page.getDatas();
			List resultList = new ArrayList();
			AesDataTools tools = new AesDataTools();
			
			
			
			if(!invitedCode.isEmpty()){
				//邀请人绑卡数量
				int count2 = baseInfoDao.executeSqlCount("select count(1) from t_person_account_info p,t_base_info b where p.fk_base_info_id=b.id and p.binding_state='30' and b.invitation_code="+invitedCode);
				//有效绑卡数量
				int validCount = baseInfoDao.executeSqlCount("select count(1) from t_base_info t where create_date BETWEEN '"+ActivityDateEnum.START.getValue()+"' and '"+ActivityDateEnum.END.getValue()+"' and t.real_name!=\'\' and t.invited_code="+invitedCode);//有效的邀请人数
				if(count2 == 0){//如果邀请人没有绑卡
					validCount = 0;
				}
				Map<String,Object> extendDatas = Maps.newHashMap();
				extendDatas.put("validCount", validCount);
				page.setExtendDatas(extendDatas);
			}
			
			for(Object[] obj:list)
			{
				Object[] resultObj = obj;
				String phone = obj[1].toString();
				String phone1 = phone.substring(0, 3);
				String phone2 = phone.substring(8, 11);
				
				resultObj[1] = phone1+"*****"+phone2;
				
				String phoneInvited = obj[4].toString();
				if(invitedCode.isEmpty()){
					if(phoneInvited.length() == 11){
						resultObj[4] = phoneInvited.substring(0, 3)+"*****"+phoneInvited.substring(8, 11);
					}
				}
				//邀请人绑卡数量
				int count2 = baseInfoDao.executeSqlCount("select count(1) from t_person_account_info p,t_base_info b where p.fk_base_info_id=b.id and p.binding_state='30' and b.invitation_code="+phoneInvited);
				
				resultObj[3] = Integer.valueOf(resultObj[5].toString()) == 1 && count2 > 0 ? true : false;//是否有效
				
				resultList.add(resultObj);
			}
			page.setDatas(resultList);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(BaseInfoServiceImpl.class.toString(),e);
		}
		return page;
	}
	
	
}
