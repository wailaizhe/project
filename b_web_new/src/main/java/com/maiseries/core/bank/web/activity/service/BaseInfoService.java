package com.maiseries.core.bank.web.activity.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import code.main.archive.entity.BaseInfo;
import code.main.base.domain.Page;

public interface BaseInfoService {
	 
	/**
	 * 验证手机号是否被占用
	 * @param loginName
	 * @return
	 */
	BaseInfo isPhone(String phone);
	 
	
	Map addUser(BaseInfo base); 
 
	BaseInfo isLogin(String phone,String pass);
	 
	
	/**
	 * 根据用户名查找企业信息
	 * @return
	 */
	BaseInfo findObjByUserName(String userName);
	/**
	 * 登陆接口
	 */
	Map<String, String> registerIsLogin(HttpServletResponse response,
			HttpServletRequest request, String userName, String password);
	
	/**
	 * 验证码校验
	 */
	String checkYzm(HttpServletRequest request);
	/**
	 * 退出系统
	 */
	void loginOut(HttpServletResponse response,HttpServletRequest request);
	
	/**
	 * @author yangdongxu
	 * @date Oct 23, 2015 2:30:24 PM
	 * @version 版本号码
	 * @TODO 修改 用户表
	 */
	 void update(BaseInfo baseInfo);
	 
	 public Map insertBaseInfo(String sql,Object[] params);

	 /**
	  * 注册
	  * @param request
	  * @param response
	  * @return
	  */
	Map<String, String> userRegisterIntoService(HttpServletRequest request, HttpServletResponse response);
	
	/**
	 * @author yangdongxu
	 * @date Feb 18, 2016 10:42:25 AM
	 * @version 版本号码
	 * @TODO 查询我所邀请的人员
	 */
	public Page queryInvited(JSONObject jsonObj);
	
	
	/**
	 * @author yangdongxu
	 * @date Feb 18, 2016 10:42:25 AM
	 * @version 版本号码
	 * @TODO 查询我的金币详情
	 */
	public Page queryGoldDetail(JSONObject jsonObj);


	
	 
	
	 /**
	 * 查询活动期间我所邀请的人员
	 * @Method:queryInvitedActivity
	 * @param jsonObj
	 * @return
	 */
	 
	Page queryInvitedActivity(JSONObject jsonObj);
	
	
}
