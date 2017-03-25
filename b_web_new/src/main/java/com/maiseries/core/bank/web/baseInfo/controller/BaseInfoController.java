package com.maiseries.core.bank.web.baseInfo.controller;
import java.util.Date;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.ehcache.CacheKit;
import com.maiseries.core.bank.web.baseInfo.service.BaseInfoService;
import com.maiseries.core.bank.web.baseInfo.service.impl.BaseInfoServiceImpl;
import com.maiseries.core.bank.web.common.controller.BaseController;
import com.maiseries.core.bank.web.common.kit.CaptchaKit;
import com.maiseries.core.bank.web.common.kit.DesUtil;
import com.maiseries.core.bank.web.common.kit.PhoneRegularUtil;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.SmsInfo;
import com.maiseries.core.bank.web.common.util.DateTimeUtils;
import com.maiseries.core.bank.web.common.util.IPUtil;
import com.maiseries.core.bank.web.common.util.SendMsgUtil;

/**
 * 
 * @author shiyaning
 * 关于注册，登录，退出的action
 * 切记返回路径前不需加/
 *
 */
public class BaseInfoController extends BaseController {
	private  BaseInfoService  baseInfoService=new BaseInfoServiceImpl();
	private  boolean  result;
	private BaseInfo baseInfo;
	private SmsInfo smsInfo;
	/*
	 * 主页
	 * */
	public void index(){
		renderJsp("index.jsp");
	}
	/*
	 * 登录操作
	 * */
	public  void login(){
		System.out.println("我要登录");
		renderJsp("login.jsp");
	}
	/*
	 * 注册操作
	 * */
	public  void register(){
		System.out.println("我要注册");
		renderJsp("register.jsp");
	}
	/**
	 * 验证码
	 */
	public void authimg() {
		renderCaptcha();
	}
	/**
	 * 验证登录信息
	 */
	
	public void checkLogin(){
		String mobilePhone=getPara("userName");
		String password=getPara("password");
		String code=getPara("code");
		boolean result=CaptchaKit.validateCatchakit(code, this);
		baseInfo=CacheKit.get("loginAccount", "baseInfo");
		//检验手机号是否合法
		if(result){
			baseInfo=baseInfoService.checkBaseInfo(mobilePhone, password);
			//检验用户是否存在
			if(baseInfo!=null){
				setAttr("value", "03");
				setSessionAttr("status", "01");
				setSessionAttr("baseInfoId", baseInfo.getID());
				setSessionAttr("baseInfo", baseInfo);
				//做一些数据加密
				CacheKit.put("loginAccount", "baseInfo", baseInfo);
			}else{
				//用户不存在
			}
		}else{
			setAttr("yzm", "06");
		}
		renderJson();
	}
	
	//验证手机号是否注册
	public void valdatePhone(){
		String ph=getPara("phone");
		result=baseInfoService.findBaseInfoByPhone(ph);
		if (result) {
			setAttr("flag", "0");
		}else{
			//手机已经注册
			setAttr("flag", "1");
		}
		renderJson();
	}
	//验证邀请码是否合法并且存在
	public void valInvitedCode(){
		String ph=getPara("invitedCode");
		result=baseInfoService.findBaseInfoByPhone(ph);
		if (result) {
			//手机号不存在
			setAttr("flag", "0");
		}else{
			//手机号存在
			setAttr("flag", "1");
		}
		renderJson();
	}
	/**
	 * 获取验证码 -注册验证码
	 */
	public void getRegisterCode() throws Exception{
		//判断图片验证码是否正确
		String code=getPara("code");
		String timeOut = getPara("timeOut");
		boolean result=CaptchaKit.validateCatchakit(code, this);
		//计时开始时间
		setAttr("time", String.valueOf(new Date().getTime()));
		if(result){
		//手机号合法验证
		String phone = DesUtil.strDec(getPara("phone"));
		boolean isPhone=PhoneRegularUtil.phoneCheck(phone);
		if(isPhone){
			//发送验证码
			String YZM=SendMsgUtil.sendMsg(phone, "003");
			if("error".equals(YZM)){
				//短信发送失败
			}else{
				//短信发送成功 将短息信息保存到数据库
				addSmsInfo(phone, YZM,"注册验证码");
				setAttr("flag1", "1");
			}
		}else{
			//手机不合法
			setAttr("flag1", "NoPhone");
		}
		}else{
			//图片验证码错误
			setAttr("flag1", "06");
		}		
		renderJson();
	}
	
	/**
	 * 成功注册
	 */
	public void successRegister(){
		String ph = getPara("mobilePhone");
		String password=getPara("password");
		System.out.println(password);
		String invitedCode = getPara("invitedCode");
		String code = getPara("code");
		baseInfo=new BaseInfo();
		baseInfo.setMobilePhone(ph).setPassword(password).setInviteCode(invitedCode).setID(StrKit.getRandomUUID());
		//是否超时
		smsInfo=getSessionAttr("smsInfo");
		String mobileYZM=smsInfo.getContent();
		//返回短信发送时间与验证时间的毫秒值
		long passTime=DateTimeUtils.diffDays(DateTimeUtils.getCurrentDateTime(), DateTimeUtils.parseDate2(smsInfo.getSendTime()));
		if(passTime<60000){
			//短信验证码验证
			if(mobileYZM.equals(code)){
				baseInfoService.addBaseInfo(baseInfo);
				//注册成功
				setAttr("success", "5");
				setAttr("pathUrl", "login");
			}else{
				//验证码错误
				setAttr("success", "1");
			}
		}else{
			//短信超时
			setAttr("success", "3");
		}
		renderJson();
	}
	/**
	 * 检验密码是否正确
	 */
	public void checkPassword(){
		String baseInfoId=getSessionAttr("baseInfoId");
		baseInfo=baseInfoService.queryBaseInfoById(baseInfoId);
		//输入的旧密码
		String passwordW=getPara("password");
		//数据库的真实密码
		String passwordO=baseInfo.getPassword();
		if(passwordW.equals(passwordO)){
			//密码验证通过
		}else{
			//密码验证失败
		}
		
		
	}
	/**
	 * 修改密码
	 */
	public void updatePassword(){
		baseInfo=getSessionAttr("baseInfo");
		String phone=getPara("phone");
		String YZM=SendMsgUtil.sendMsg(phone, "002");
		String newPassword=getPara("newPassword");
		
		
	}
	/**
	 * 安全退出
	 */
	public void loginOut(){
		
		String status=getSessionAttr("status");
		System.out.println(status);
		if(status==null||status.isEmpty()){
		}else{
			removeSessionAttr("status");
			removeSessionAttr("YZMId");
		}
		render("login.jsp");
	}
	/**
	 * 将发送的消息添加到数据库
	 * @param phone
	 * @param YZM
	 * @param messageType
	 */
	public void addSmsInfo(String phone,String YZM,String messageType){
		SmsInfo smsInfo=new SmsInfo().setMessageType(messageType).setMobilePhone(phone)
				.setIp(IPUtil.getMAC()).setContent(YZM).setSendTime(DateTimeUtils.timeToString2(DateTimeUtils.getCurrentDateTime()));
		baseInfoService.addSmsInfo(smsInfo);
		setSessionAttr("mobileYZM", YZM);
		setSessionAttr("smsInfo", smsInfo);
	}
	
}
