package com.maiseries.core.bank.web.activity.service;
 
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import code.main.archive.entity.BaseInfo;
import code.main.archive.entity.SmsInfo;

public interface SmsInfoService {

	String addCode(SmsInfo  sms); 
	int addCodes(SmsInfo  sms);
	/**
	 * 反写验证码
	 * @param phone
	 * @return
	 */
    
	List<SmsInfo> queryAuthCode(String phone,String messageType,String operId,String ip,String serialNumber);

	SmsInfo isCode(String phone);
 
    /**
     * 登陆验证码
     */
	String registerCode(HttpServletRequest request);
	/**
	 * 普通验证码校验 添加
	 */
	String saveCode(HttpServletRequest request,BaseInfo bInfo);
	/**
	 * 验证码校验 
	 */
	 String valAuthCode(HttpServletRequest request,BaseInfo bInfo);
	/**
	 * 获取验证码
	 */
	 String getCode(HttpServletRequest request,String phone);
	 /**
	  * 密码验证码校验
	  */
	 String valresetPwd(HttpServletRequest request,String phone);
	 /**
	  * 查询手机号
	  * @param ph
	  * @return
	  */
	 BaseInfo isPhone(String ph);
	 /**
	  *  快捷支付验证码
	  */
	 String saveGoldeQuick(HttpServletRequest request,String mobliePhone,String messageType,BaseInfo bInfo);
	 /**
	  * 快捷支付验证码 校验
	  * @return
	  */
	 String valGoldeQuick(HttpServletRequest request,BaseInfo bInfo,String mobilePhone,String authCode,String serialNumber);
	 
	 /**
	  * 添加银行成功 发送短信
	  */
	 void bankPhoneYZM(HttpServletRequest request,BaseInfo baseInfo);
	 
	 /**
	  * 验证当前用户 忘记密码尝试次数  false 被锁住  不能通过
	  * @param request
	  */
	 boolean checkForgetPasswordIntoService(HttpServletRequest request);
	 
	 /**
	  * 找回密码 进行短信验证码校验
	  * @param request
	  * @return
	  */
	 String valresetPwdIntoService(HttpServletRequest request);
	
	 /**
	  * 短信验证码发送公共方法
	  * @param ip
	  * @param usId
	  * @param mobliePhone
	  * @param messageType
	  * @param model
	  * @param frequency
	  * @return
	  */
	 String sendPublicCode(String ip,String  usId,String mobliePhone,String messageType,String model,int frequency);
	 
	 /**
	  * 公共短信验证码校验方法
	  * @param ip
	  * @param usId
	  * @param mobilePhone
	  * @param authCode
	  * @param messageType
	  * @return
	  */
	 String checkPublicCode(String ip,String usId,String mobilePhone,String authCode,String messageType);
	 
	 
	 /**
	  * 快捷支付保存验证码
	  * @param request
	  * @param usId
	  * @param mobliePhone
	  * @param messageType
	  * @param fkOrderInfoId
	  * @return
	  */
	 String savePhoneQuick(HttpServletRequest request,String usId,String mobliePhone,String messageType,String fkOrderInfoId);
	 
}
