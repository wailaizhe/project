package com.maiseries.core.bank.web.activity.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import code.main.account.dao.AccountDao;
import code.main.account.service.AccountService;
import code.main.archive.dao.BaseInfoDao;
import code.main.archive.dao.SmsInfoDao;
import code.main.archive.entity.BaseInfo;
import code.main.archive.entity.SmsInfo;
import code.main.archive.service.BaseInfoService;
import code.main.archive.service.SmsInfoService;
import code.main.base.util.DateTimeUtils;
import code.main.base.util.DesUtil;
import code.main.base.util.FxStringUtil;
import code.main.base.util.IPUtil;
import code.main.base.util.PhoneRegularUtil;
import code.main.base.util.mailUtil.shortMessageModel;
import fengx.com.AesDataTools;

@Service("smsInfoService")
@Transactional
public class SmsInfoServiceImpl  implements SmsInfoService {

	@Resource(name = "smsInfoDao")
	private SmsInfoDao smsInfoDao;
	
	@Resource(name = "baseInfoDao")
	private BaseInfoDao baseInfoDao;
	@Resource(name = "AccountDao")
	private AccountDao accountDao;
	@Resource
	private AccountService accountService;
	@Resource
	private BaseInfoService baseInfoService;
	private static Logger log = (Logger) LoggerFactory.getLogger(SmsInfoServiceImpl.class);
	/**
	 * 保存验证码信息
	 */
	public String addCode(SmsInfo sms) {
		String ms = "1"; // 验证码正确
		try{
			smsInfoDao.saveOrUpdate(sms);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return ms;
	}

	public int addCodes(SmsInfo sms) {
		int i=1;
		try{
			smsInfoDao.saveOrUpdate(sms);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
	    return i;
	}

	/**
	 * 查询验证码信息
	 */
	public List<SmsInfo> queryAuthCode(String phone, String messageType,String operId,String ip,String serialNumber) {
		List smsInfo=null;
		try{
			String hql;
			if ("005".equals(messageType)||"007".equals(messageType)) {
				hql = "from SmsInfo where mobilePhone=? and ip=? and messageType=? order by  send_time desc ";
				smsInfo = smsInfoDao.pageList(hql, 0, 3,phone,ip,messageType);
			}else if("009".equals(messageType)){
				if(FxStringUtil.isNullOrEmpty(serialNumber)){
					hql = "from SmsInfo where mobilePhone=? and messageType=? and operId=? and ip=? order by  send_time desc ";
					smsInfo = smsInfoDao.pageList(hql, 0, 5, phone,messageType,operId,ip);
				}else{
					hql = "from SmsInfo where mobilePhone=? and messageType=? and operId=? and ip=? and fkOrderInfoSerialNumber=?  order by  send_time desc ";
					smsInfo = smsInfoDao.pageList(hql, 0, 5, phone,messageType,operId,ip,serialNumber);
				}
			}else{
				hql = "from SmsInfo where mobilePhone=? and messageType=? and operId=? and ip=? order by  send_time desc ";
				smsInfo = smsInfoDao.pageList(hql, 0, 3, phone,messageType,operId,ip);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return smsInfo;
	}

	@Override
	public SmsInfo isCode(String phone) {
		   SmsInfo smsInfo=null;
		  try {
			  String hql="from SmsInfo where mobilePhone=?";
			  smsInfo=  smsInfoDao.findObject(hql, phone);
	      } catch (Exception ex) {
			  ex.printStackTrace();
			  log.error(SmsInfoServiceImpl.class.toString(),ex);
		  }
		  return smsInfo;
	 }
	
	/**
	 * 登陆验证码 registerCode
	 */
	@Override
	public String registerCode(HttpServletRequest request){
		String second = null;
		String flag1 = null;
		// 获得验证的手机号
		DesUtil desUtil = new DesUtil();
		try {
		String phone = desUtil.strDec(request.getParameter("phone"));
		String messageType = request.getParameter("messageType");
		PhoneRegularUtil phontU = new PhoneRegularUtil();
		//if(phone!=null&&phone!=""&&phontU.phoneCheck(phone)){
		if(!FxStringUtil.isNullOrEmpty(phone)&&phontU.phoneCheck(phone)){
				if("007".equals(messageType)){
					messageType="007";
				}else{
				   messageType = "005";
				}
				String ipC = IPUtil.getIp(request);
				List<SmsInfo> smsInfo2 = this.queryAuthCode(phone,messageType,"",ipC,"");
				//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (smsInfo2 != null && smsInfo2.size() == 3) {
					//Date date11 = sdf1.parse(smsInfo2.get(2).getToSendTime());
					Date date11 = DateTimeUtils.parseDate2(smsInfo2.get(2).getToSendTime());
					long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
					long mins = tempD / 1000 / 60; // 相差分钟数
					if (mins < 10L) {
						flag1 = "2"; // 验证码超出10分钟3次
					}
			    }
				if("005".equals(messageType)&&!"2".equals(messageType)&&smsInfo2.size()>0){ //获取倒计时数
					
					//Date date12 = sdf1.parse(smsInfo2.get(0).getToSendTime());
					Date date12 = DateTimeUtils.parseDate2(smsInfo2.get(0).getToSendTime());
					long tempD1 = new Date().getTime() - date12.getTime(); // 相差毫秒数
					long mins1 = tempD1/1000; // 相差分钟数
					//System.err.println(smsInfo2.get(0).getToSendTime()+"---"+mins1);
					if(mins1<120){
						second =String.valueOf(120-mins1);
						flag1 ="2";
					}
				}
			    if ("2" != flag1) {
			    	AesDataTools tools = new AesDataTools();
					SmsInfo smsInfo1 = new SmsInfo();
					//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date now = new Date();
					Date afterDate = new Date(now.getTime() + 300000);
					String ip = IPUtil.getIp(request);
					//smsInfo1.setToSendTime(sdf.format(now));
					smsInfo1.setToSendTime(DateTimeUtils.getNowTime());
					int jj = (int) ((Math.random() * 9 + 1) * 100000); // 生成时间戳
					smsInfo1.setAuthCode(String.valueOf(jj)); // 生成6位数 随机验证码
					smsInfo1.setMobilePhone(phone);
					smsInfo1.setMessageType(messageType);
					String model;
					if("007".equals(messageType)){
						model =ShortMessageModel.send007+String.valueOf(jj)+ShortMessageModel.send0071;
					}else{
						model =ShortMessageModel.send001+String.valueOf(jj)+ShortMessageModel.send0011;
					}
					smsInfo1.setContent(model);  // 需要加密的手机内容和短信模板
					smsInfo1.setEncodeStr(tools.encode(String.valueOf(jj)));// 已经加密的短信模板
					smsInfo1.setSendFlag("02");   //设置该条短信的状态
					//smsInfo1.setValidTime(sdf.format(afterDate));
					smsInfo1.setValidTime(DateTimeUtils.timeToString2(afterDate));
					smsInfo1.setIp(ip);
					flag1 = this.addCode(smsInfo1);
			 }
			    
			 if("2".equals(flag1)&&second!=null){
				 flag1  = second;
			 }
			    
		 }
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag1;
	}
    
	@Override
	public String saveCode(HttpServletRequest request,BaseInfo bInfo){
		String phone = bInfo.getMobilePhone();
		String flag1 = null;
		try{
			PhoneRegularUtil phontU = new PhoneRegularUtil();
		    //if(phone!=null&&phone!=""&&phontU.phoneCheck(phone)){
			if(!FxStringUtil.isNullOrEmpty(phone)&&phontU.phoneCheck(phone)){
			    AesDataTools tools = new AesDataTools();
				String messageType = request.getParameter("messageType"); // 消息类型
				String ipC = IPUtil.getIp(request);
				List<SmsInfo> smsInfoi;
				//if(phone!=null&&phone!=""&&messageType=="007"){
				if(!FxStringUtil.isNullOrEmpty(phone)&&messageType=="007"){
					smsInfoi = this.queryAuthCode(phone,messageType,"",ipC,"");
				}else{
					smsInfoi = this.queryAuthCode(bInfo.getMobilePhone(),messageType,bInfo.getId(),ipC,"");
				}
				if("008".equals(messageType)&&smsInfoi != null && smsInfoi.size()==1){
						    //SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							//Date date11 = sdf1.parse(smsInfoi.get(0).getToSendTime());
							Date date11 = DateTimeUtils.parseDate2(smsInfoi.get(0).getToSendTime());
							long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
							long mins = tempD / 1000 / 60; // 相差分钟数
							if (mins < 10L) {
								flag1 = "2"; // 验证码10内已经验证一次！
							}
				}
				if (smsInfoi != null && smsInfoi.size() == 3) {
		
					try {
						//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						//Date date11 = sdf1.parse(smsInfoi.get(2).getToSendTime());
						Date date11 = DateTimeUtils.parseDate2(smsInfoi.get(2).getToSendTime());
						long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
						long mins = tempD / 1000 / 60; // 相差分钟数
						if (mins < 10L) {
							flag1 = "2"; // 验证码超出10分钟3次
						}
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
				if ("2" != flag1) {
					SmsInfo smsInfo = new SmsInfo();
					//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date now = new Date();
					Date afterDate;
					if("008".equals(messageType)){
						 afterDate = new Date(now.getTime() + 600000);
					}else{
						 afterDate = new Date(now.getTime() + 300000);
					}
					String ip = IPUtil.getIp(request);
					//smsInfo.setToSendTime(sdf.format(now));
					smsInfo.setToSendTime(DateTimeUtils.getNowTime());
					int jj = (int) ((Math.random() * 9 + 1) * 100000); // 生成时间戳
					smsInfo.setAuthCode(String.valueOf(jj)); // 生成6位数 随机验证码
					smsInfo.setMobilePhone(bInfo.getMobilePhone());
					smsInfo.setMessageType(messageType);
					String model;
					if("003".equals(messageType)||"002".equals(messageType)){       //绑定邮箱
						model=ShortMessageModel.send003+String.valueOf(jj)+ShortMessageModel.send0031;
					}else if("008".equals(messageType)){ // 实名认证
						model=ShortMessageModel.sen005+String.valueOf(jj)+ShortMessageModel.sen0051;
					}else if("001".equals(messageType)){  // 修改密码
						model=ShortMessageModel.send002+String.valueOf(jj)+ShortMessageModel.send0021;
					}else if("007".equals(messageType)){  // 修改密码
						model=ShortMessageModel.send002+String.valueOf(jj)+ShortMessageModel.send0021;
					}else{
						model=String.valueOf(jj);
					}
					smsInfo.setContent(model);  // 需要加密的手机内容和短信模板
					smsInfo.setEncodeStr(tools.encode(String.valueOf(jj)));// 已经加密的短信模板
					smsInfo.setSendFlag("02");   //设置该条短信的状态
					//smsInfo.setValidTime(sdf.format(afterDate));
					smsInfo.setValidTime(DateTimeUtils.timeToString2(afterDate));
					smsInfo.setOperId(bInfo.getId());
					smsInfo.setIp(ip);
					flag1 = this.addCode(smsInfo);
					}
		  }
		 }catch(Exception ex){
		   ex.printStackTrace();
		   log.error(SmsInfoServiceImpl.class.toString(),ex);
	     }
		return flag1;
	}
	
	public String valAuthCode(HttpServletRequest request,BaseInfo bInfo){
		String flag = null;
		try {
			String authCode = request.getParameter("authCode");
			String messageType = request.getParameter("messageType");
			String ip = IPUtil.getIp(request);
			//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			List<SmsInfo> smsInfo = this.queryAuthCode(bInfo.getMobilePhone(),messageType, bInfo.getId(),ip,"");
			if (smsInfo != null && smsInfo.size() == 3) {
					/*Date valiD = sdf1.parse(smsInfo.get(0).getValidTime());
					Date date11 = sdf1.parse(smsInfo.get(0).getToSendTime());
					Date date22 = sdf1.parse(smsInfo.get(2).getToSendTime());*/
					Date valiD = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
					Date date11 = DateTimeUtils.parseDate2(smsInfo.get(0).getToSendTime());
					Date date22 = DateTimeUtils.parseDate2(smsInfo.get(2).getToSendTime());
					long temp = date11.getTime() - date22.getTime(); // 相差毫秒数
					long tempD = valiD.getTime() - new Date().getTime(); // 相差毫秒数
					long minsDD = tempD / 1000 / 60; // 相差分钟数
                     if (smsInfo != null && authCode.equals(smsInfo.get(0).getAuthCode())) {
						flag = "0"; // 验证码正确
						if (minsDD < 0L) {
							flag = "3"; // 验证码已过期
						} 
					 } else {
							flag = "1"; // 验证码错误
					 }
			} else if(!"3".equals(flag)){
				if (smsInfo != null&&authCode.equals(smsInfo.get(0).getAuthCode())) {
					flag = "0"; // 验证码正确
					//Date date11 = sdf1.parse(smsInfo.get(0).getValidTime());
					Date date11 = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
					long temp = date11.getTime() - new Date().getTime(); // 相差毫秒数
					long mins = temp / 1000 / 60; // 相差分钟数
					if (mins < 0L) {
						flag = "3"; // 验证码已过期
					}
				} else {
					flag = "1"; // 验证码错误
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	
	public String getCode(HttpServletRequest request,String  phone){
		String flag = "1";
		try{   
			 PhoneRegularUtil phontU = new PhoneRegularUtil();
			 //if(phone!=null&&phone!=""&&phontU.phoneCheck(phone)){
			 if(!FxStringUtil.isNullOrEmpty(phone)&&phontU.phoneCheck(phone)){
				String ip = IPUtil.getIp(request);
				String authCode = request.getParameter("code");
				String messageType = request.getParameter("messageType");
				//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				List<SmsInfo> smsInfo;
				if("007".equals(messageType)){
					smsInfo = this.queryAuthCode(phone,"007","",ip,"");
				}else{
					smsInfo = this.queryAuthCode(phone,"005","",ip,"");
				}
				if (smsInfo != null && smsInfo.size() == 3) {
					//Date valiD = sdf1.parse(smsInfo.get(0).getValidTime());
					Date valiD = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
					long tempD = valiD.getTime() - new Date().getTime(); // 相差毫秒数
					long minsDD = tempD / 1000 / 60; // 相差分钟数
						if (smsInfo != null	&& authCode.equals(smsInfo.get(0).getAuthCode())) {
							flag = "0"; // 验证码正确
							if (minsDD < 0L) {
								flag = "3"; // 验证码已过期
							} 
						}else {
							flag = "1"; // 验证码错误
						}
			} else if(!"3".equals(flag)){
				if (smsInfo != null&&smsInfo.size()>0&&authCode.equals(smsInfo.get(0).getAuthCode())) {
					flag = "0"; // 验证码正确
					//Date date11 = sdf1.parse(smsInfo.get(0).getValidTime());
					Date date11 = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
					long temp = date11.getTime() - new Date().getTime(); // 相差毫秒数
					long mins = temp / 1000 / 60; // 相差分钟数
					if (mins < 0L) {
						flag = "3"; // 验证码已过期
					}
				} else {
					flag = "1"; // 验证码错误
				}
			}
		 }
		}catch(Exception ex){
			 ex.printStackTrace();
			 log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	public String valresetPwd(HttpServletRequest request,String phone){
		String flag = "1";
		try{   
			 String authCode = request.getParameter("code");
			 String ip = IPUtil.getIp(request);
			 AesDataTools tools = new AesDataTools();
			 PhoneRegularUtil phontU = new PhoneRegularUtil();
			 //if(phone!=null&&phone!=""&&phontU.phoneCheck(phone)){
			 if(!FxStringUtil.isNullOrEmpty(phone)&&phontU.phoneCheck(phone)){
				//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				List<SmsInfo>  smsInfo = this.queryAuthCode(phone,"007","",ip,"");
				if (smsInfo != null && smsInfo.size() == 3) {
					//Date valiD = sdf1.parse(smsInfo.get(0).getValidTime());
					Date valiD = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
					long tempD = valiD.getTime() - new Date().getTime(); // 相差毫秒数
					long minsDD = tempD / 1000 / 60; // 相差分钟数
					if (smsInfo != null	&& authCode.equals(smsInfo.get(0).getAuthCode())) {
							flag = "0"; // 验证码正确
							if (minsDD < 0L) {
								flag = "3"; // 验证码已过期
							} 
						}else {
							flag = "1"; // 验证码错误
					}
			   }else if(!"3".equals(flag)){
				 if (smsInfo != null&&smsInfo.size()>0&&authCode.equals(smsInfo.get(0).getAuthCode())) {
					flag = "0"; // 验证码正确
					//Date date11 = sdf1.parse(smsInfo.get(0).getValidTime());
					Date date11 = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
					long temp = date11.getTime() - new Date().getTime(); // 相差毫秒数
					long mins = temp / 1000 / 60; // 相差分钟数
					if (mins < 0L) {
						flag = "3"; // 验证码已过期
					}
				} else {
					flag = "1"; // 验证码错误
				}
			 }
		  }
			 if("0".equals(flag)){
				 HttpSession session = request.getSession();
				 session.setAttribute("code", tools.encode(phone));
				 session.setAttribute("authCode", authCode);
				 session.setAttribute("messageType","007");
			 }
		}catch(Exception ex){
			 ex.printStackTrace();
			 log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	/**
	 * String转long
	 */
	public Long stringDate2Long(String dateStr) {
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Long timeMills = 0L;
		if (null != dateStr) {
			//Date date = sdf.parse(dateStr);
			Date date = DateTimeUtils.parseDate2(dateStr);
			timeMills = date.getTime();
		}
		return timeMills;
	}

	/**
	 * 去库中查询该次行为的前10分内的纪录数
	 */
	public int getMsgCount(String ip, Long currentMills) {
		long before10Min = currentMills - 600000;
		Date date = new Date();
		date.setTime(before10Min);
		int count = 0;
		Object[] obj = { ip, date };
		String hql = " select count(s.sms_id) from SmsInfo s where s.ip=? and s.toSendTime >? ";
		try {
			count = smsInfoDao.count(hql, obj);
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return count;
	}


	@Override
	public BaseInfo isPhone(String phone) {
		
		BaseInfo baseInfo = null;
		String hql = "from BaseInfo where mobilePhone=?";
		try {
			baseInfo = baseInfoDao.findObject(hql, phone);
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return baseInfo;
	}
	
	/**
	 *  快捷支付验证码
	 */
	@Override
	public String saveGoldeQuick(HttpServletRequest request,String mobliePhone,String messageType,BaseInfo bInfo){
		String flag1 = "1";
		try{
			PhoneRegularUtil phontU = new PhoneRegularUtil();
			if(!FxStringUtil.isNullOrEmpty(mobliePhone)&&bInfo!=null&&phontU.phoneCheck(mobliePhone)){
				String ipC = IPUtil.getIp(request);
				List<SmsInfo> smsInfoi =  this.queryAuthCode(mobliePhone,messageType,bInfo.getId(),ipC,"");
				if (smsInfoi != null && smsInfoi.size() == 5) {
					Date date11 = DateTimeUtils.parseDate2(smsInfoi.get(4).getToSendTime());
					long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
					long mins = tempD / 1000 / 60; // 相差分钟数
					if (mins < 10L) {
						flag1 = "2"; // 验证码超出10分钟3次
					}
				}
//				if ("2" != flag1) {
//					SmsInfo smsInfo = new SmsInfo();
//					//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//					Date now = new Date();
//					Date afterDate = new Date(now.getTime() + 300000);
//					String ip = IPUtil.getIp(request);
//					//smsInfo.setToSendTime(sdf.format(now));
//					smsInfo.setToSendTime(DateTimeUtils.getNowTime());
//					int jj = (int) ((Math.random() * 9 + 1) * 100000); // 生成时间戳
//					smsInfo.setAuthCode(String.valueOf(jj)); // 生成6位数 随机验证码
//					smsInfo.setMobilePhone(mobliePhone);
//					smsInfo.setMessageType(messageType);
//					String model=shortMessageModel.send003+String.valueOf(jj)+shortMessageModel.send0031;
//					smsInfo.setContent(model);  // 需要加密的手机内容和短信模板
//					smsInfo.setEncodeStr(tools.encode(String.valueOf(jj)));// 已经加密的短信模板
//					smsInfo.setSendFlag("02");   //设置该条短信的状态
//					//smsInfo.setValidTime(sdf.format(afterDate));
//					smsInfo.setValidTime(DateTimeUtils.timeToString2(afterDate));
//					smsInfo.setOperId(bInfo.getId());
//					smsInfo.setIp(ip);
//					flag1 = this.addCode(smsInfo);
//			   }
		  }
		 }catch(Exception ex){
		   ex.printStackTrace();
		   log.error(SmsInfoServiceImpl.class.toString(),ex);
		   flag1="2";
	     }
		return flag1;
	}
	
	
	public String valGoldeQuick(HttpServletRequest request,BaseInfo bInfo,String mobilePhone,String authCode,String serialNumber){
		String flag = null;
		try {
			String ip = IPUtil.getIp(request);
			PhoneRegularUtil phontU = new PhoneRegularUtil();
			if(!FxStringUtil.isNullOrEmpty(mobilePhone)&&!FxStringUtil.isNullOrEmpty(authCode)&&phontU.phoneCheck(mobilePhone)){
				List<SmsInfo> smsInfo = this.queryAuthCode(mobilePhone,"009", bInfo.getId(),ip,serialNumber);
				if (smsInfo != null && smsInfo.size() == 5) {
						Date valiD = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
						long tempD = valiD.getTime() - new Date().getTime(); // 相差毫秒数
						long minsDD = tempD / 1000 / 60; // 相差分钟数
	                     if (smsInfo != null && authCode.equals(smsInfo.get(0).getAuthCode())) {
							flag = "0";     // 验证码正确
							if (minsDD < 0L) {
								flag = "3"; // 验证码已过期
							} 
						 } else {
								flag = "1"; // 验证码错误
						 }
				}else if(!"3".equals(flag)){
					if (smsInfo != null&&authCode.equals(smsInfo.get(0).getAuthCode())) {
						flag = "0"; // 验证码正确
						Date date11 = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
						long temp = date11.getTime() - new Date().getTime(); // 相差毫秒数
						long mins = temp / 1000 / 60; // 相差分钟数
						if (mins < 0L) {
							flag = "3"; // 验证码已过期
						}
					} else {
						flag = "1"; // 验证码错误
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	 /**
	  * 添加银行成功 发送短信
	  */
	public  void bankPhoneYZM(HttpServletRequest request,BaseInfo baseInfo){
		try{     
			    DesUtil desUtil = new DesUtil(); // 解密
			    AesDataTools tools = new AesDataTools();
			    String cardNumber = desUtil.strDec(request.getParameter("BankAccountName")); // 开 户 名 
			    cardNumber = cardNumber.substring(cardNumber.length() - 4,cardNumber.length());
				String bankName = desUtil.strDec(request.getParameter("BankName"));          // 银行名称 开户行
			    //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    SmsInfo smsInfo = new SmsInfo();
			    String mobie = desUtil.strDec(request.getParameter("BankAccountNo"));      // 添加账户的手机号码
			    //smsInfo.setToSendTime(sdf.format(new Date()));
			    smsInfo.setToSendTime(DateTimeUtils.getNowTime());
				int jj1 = (int) ((Math.random() * 9 + 1) * 100000); // 生成时间戳
				smsInfo.setAuthCode(String.valueOf(jj1)); // 生成6位数 随机验证码
				smsInfo.setMobilePhone(mobie);
				smsInfo.setMessageType("010"); // 用户平台登录
				String model=ShortMessageModel.send010+cardNumber+"的"+bankName+ShortMessageModel.send0101;
				smsInfo.setContent(model);  // 需要加密的手机内容和短信模板
				smsInfo.setEncodeStr(tools.encode(String.valueOf(jj1)));// 已经加密的短信模板
				smsInfo.setSendFlag("02");   //设置该条短信的状态
				//smsInfo.setValidTime(sdf.format(new Date()));
				smsInfo.setValidTime(DateTimeUtils.getNowTime());
				smsInfo.setOperId(baseInfo.getId());
				smsInfo.setIp(IPUtil.getIp(request));
				this.addCode(smsInfo);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		 
	 }

	/**
	  * 验证当前用户 忘记密码尝试次数  false 被锁住  不能通过
	  * @param request
	  */
	@Override
	public boolean checkForgetPasswordIntoService(HttpServletRequest request) {
		boolean flag =false;
		// 获得验证的手机号
		try{
			//BaseInfo bInfo = accountService.queryInfoByPhone(request);
			DesUtil desUtil = new DesUtil(); // 解密
			BaseInfo bInfo=null;
			if(FxStringUtil.isNullOrEmpty(request.getParameter("phone"))==false){
				String phone = desUtil.strDec(request.getParameter("phone"));
				String hql = " from BaseInfo where mobilePhone = ? ";
				 bInfo =accountDao.findObject(hql, phone);
			}else{
				 bInfo = accountService.queryInfoByPhone(request);
			}
			String forgetFlag=bInfo.getForgetPassword();//忘记密码 尝试标志
			//if(forgetFlag!=null&&!"".equals(forgetFlag)){
			if(!FxStringUtil.isNullOrEmpty(forgetFlag)){
				String[] arr=forgetFlag.split("@");
				//获取当前日期 
				//Date todayDate=new Date();
				//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
				//String todayStr=sdf1.format(todayDate);
				String todayStr=DateTimeUtils.getTodayStr("yyyyMMdd");
				int todayInt=Integer.parseInt(todayStr);
				int flagInt=Integer.parseInt(arr[0]);
				//判断上次尝试错误是否是今天
				if(flagInt<todayInt){
					//数据库中标记清除
					bInfo.setForgetPassword(null);
					baseInfoService.update(bInfo);
					flag=true;
				}else{
					int numFlag=Integer.parseInt(arr[1]);
					//是今天  判断错误次数 大于4次 锁死 
					if(numFlag<4){
						flag=true;
					}else{
						flag=false;
					}
				}
			}else{
				flag=true;
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}

	/**
	  * 找回密码 进行短信验证码校验
	  * @param request
	  * @return
	  */
	@Override
	public String valresetPwdIntoService(HttpServletRequest request) {
		String flag = "1";
		try{   
			DesUtil desUtil = new DesUtil(); // 解密
			String phone = desUtil.strDec(request.getParameter("phone"));
			String txt_indetify = desUtil.strDec(request.getParameter("txt_indetify")); // 身份证号
			String txt_realName = desUtil.strDec(request.getParameter("txt_realName")); // 真实姓名
			PhoneRegularUtil phontU = new PhoneRegularUtil();
			//if(!"".equals(phone)&&phone!=null&&phontU.phoneCheck(phone)){
			if(!FxStringUtil.isNullOrEmpty(phone)&&phontU.phoneCheck(phone)){
				//判断该用户是否被锁定
				boolean  linkFlag=this.checkForgetPasswordIntoService(request);
				if(linkFlag==false){
					flag ="link";  // 该用户 今天内连续输入10次错误短信验证码 锁定
				}
				else{
					flag = this.valresetPwd(request, phone);
					BaseInfo bInfo = baseInfoService.isPhone(phone);
					if("0".equals(flag)){  // 验证码正确查询当前用户输入的实名信息是否正确
						AesDataTools tools = new AesDataTools();
						//if(!"".equals(bInfo.getIdentityCard())&&bInfo.getIdentityCard()!=null){
						if(!FxStringUtil.isNullOrEmpty(bInfo.getIdentityCard())){
							if(bInfo.getIdentityCard().equals(tools.encode(txt_indetify))&&bInfo.getRealName().equals(tools.encode(txt_realName))){
								flag ="0";  // 身份证与姓名匹配
							}else{
								flag ="5";  // 身份证与姓名不匹配
							}
						}
						bInfo.setForgetPassword(null);
						baseInfoService.update(bInfo);
					}
					 if("1".equals(flag)){//密码错误  并且身份证和姓名匹配
						String forgetFlag=bInfo.getForgetPassword();//忘记密码 尝试标志
						//if(forgetFlag!=null&&!"".equals(forgetFlag)){
						if(!FxStringUtil.isNullOrEmpty(forgetFlag)){
							String[] arr=forgetFlag.split("@");
							int flagInt=Integer.parseInt(arr[0]);
							int numFlag=Integer.parseInt(arr[1]);
							bInfo.setForgetPassword(arr[0]+"@"+(numFlag+1));
							baseInfoService.update(bInfo);
						}else{
							//Date todayDate=new Date();
							//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
							//String todayStr=sdf1.format(todayDate);
							String todayStr=DateTimeUtils.getTodayStr("yyyyMMdd");
							bInfo.setForgetPassword(todayStr+"@"+1);
							baseInfoService.update(bInfo);
						}
					}
				}
			}
		}catch(Exception ex){
			 ex.printStackTrace();
			 log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	
	/**
	 * 短信验证码发送公共方法
	 * ip,用户ID(注册，找回密码不用传值null即可)，手机号，短信验证码类型，短信内容(参考短信模板)，10分钟内的限制次数（支付5次其余都是3次）
	 * 返回参数 0 发送失败，1 发送成功，2 10分钟内发送多次
	 */
	public String sendPublicCode(String ip,String  usId,String mobliePhone,String messageType,String model,int frequency){
		String flag = "0";  // 失败
		try {
			PhoneRegularUtil phontU = new PhoneRegularUtil();
			if(!FxStringUtil.isNullOrEmpty(mobliePhone)&&phontU.phoneCheck(mobliePhone)){
				List<SmsInfo> smsInfoi =  this.queryAuthCode(mobliePhone,messageType,usId,ip,"");
				if (smsInfoi != null && smsInfoi.size() == frequency) {
					Date date11 = DateTimeUtils.parseDate2(smsInfoi.get(frequency-1).getToSendTime());
					long tempD = new Date().getTime() - date11.getTime(); // 相差毫秒数
					long mins = tempD / 1000 / 60; // 相差分钟数
					if (mins < 10L) {
						flag = "2"; // 验证码超出10分钟 3次或多次
					}
				}
				if ("2" != flag) {
					SmsInfo smsInfo = new SmsInfo();
					Date now = new Date();
					Date afterDate = new Date(now.getTime() + 300000);
					smsInfo.setToSendTime(DateTimeUtils.getNowTime()); // 发送时间
					int jj = (int) ((Math.random() * 9 + 1) * 100000); // 生成随机数
					smsInfo.setAuthCode(String.valueOf(jj)); // 生成6位数 随机验证码
					smsInfo.setMobilePhone(mobliePhone);  //手机号
					smsInfo.setMessageType(messageType); //短信发送类型 参考实体
					smsInfo.setContent(model);  // 短信内容
					smsInfo.setSendFlag("02");   //设置该条短信的状态 01已发送 02未发送
					smsInfo.setValidTime(DateTimeUtils.timeToString2(afterDate));//过期时间
					smsInfo.setOperId(usId); // 用户ID
					smsInfo.setIp(ip); //用户IP
					flag = this.addCode(smsInfo);  //短信验证码发送成功返回 1
			   }
		  }
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	/**
	 * 公共短信验证码校验方法
	 * ip，用户ID，手机号,短信验证码，短信验证码类型（参考实体）
	 * 返回参数 0 校验成功，1 验证码错误，2 验证码过期
	 */
	public String checkPublicCode(String ip,String usId,String mobilePhone,String authCode,String messageType){
		String flag = null;
		try {
			PhoneRegularUtil phontU = new PhoneRegularUtil();
			if(!FxStringUtil.isNullOrEmpty(mobilePhone)&&!FxStringUtil.isNullOrEmpty(authCode)&&phontU.phoneCheck(mobilePhone)){
				List<SmsInfo> smsInfo = this.queryAuthCode(mobilePhone,messageType,usId,ip,"");
				if(smsInfo!=null){
						Date valiD = DateTimeUtils.parseDate2(smsInfo.get(0).getValidTime());
						long tempD = valiD.getTime() - new Date().getTime(); // 相差毫秒数
						long minsDD = tempD / 1000 / 60; // 相差分钟数
	                    if (authCode.equals(smsInfo.get(0).getAuthCode())) {
							flag = "0";     // 验证码正确
							if (minsDD < 0L) {
								flag = "2"; // 验证码已过期
							} 
						}else{
								flag = "1"; // 验证码错误
						}
				}else{
					flag = "1"; // 验证码错误
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	
	/**
	 * 快捷支付保存验证码
	 */
	public String savePhoneQuick(HttpServletRequest request,String usId,String mobliePhone,String messageType,String fkOrderInfoId){
		String flag = "0";  // 失败
		try {
			AesDataTools tools = new AesDataTools();
			SmsInfo smsInfo = new SmsInfo();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date now = new Date();
			Date afterDate = new Date(now.getTime() + 300000);
			String ip = IPUtil.getIp(request);
			smsInfo.setToSendTime(sdf.format(now));
			int jj = (int) ((Math.random() * 9 + 1) * 100000); // 生成时间戳
			smsInfo.setAuthCode(String.valueOf(jj)); // 生成6位数 随机验证码
			smsInfo.setMobilePhone(mobliePhone);
			smsInfo.setMessageType(messageType);
			String model=ShortMessageModel.send003+String.valueOf(jj)+ShortMessageModel.send0031;
			smsInfo.setContent(model);  // 需要加密的手机内容和短信模板
			smsInfo.setEncodeStr(tools.encode(String.valueOf(jj)));// 已经加密的短信模板
			smsInfo.setSendFlag("02");   //设置该条短信的状态
			smsInfo.setValidTime(sdf.format(afterDate));
			smsInfo.setOperId(usId);
			smsInfo.setIp(ip);
			smsInfo.setFkOrderInfoSerialNumber(fkOrderInfoId);
			smsInfoDao.saveOrUpdate(smsInfo);
			flag="1";
		} catch (Exception ex) {
			flag="0";
			ex.printStackTrace();
			log.error(SmsInfoServiceImpl.class.toString(),ex);
		}
		return flag;
	}
	
	
	
}
