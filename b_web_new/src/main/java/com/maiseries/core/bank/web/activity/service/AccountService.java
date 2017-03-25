package com.maiseries.core.bank.web.activity.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;
import com.maiseries.core.bank.web.common.model.domain.Page;

import payment.api.tx.cmb.Tx7201Response;



public interface AccountService {
	/**
	 * 根据用户id查询 用户的详细信息
	 * 
	 * @param id
	 * @return
	 */
	BaseInfo getBaseInfoById(String id);

	/**
	 * 根据手机号查询 好友
	 * 
	 * @param mobilePhone
	 * @return
	 */
	List<BaseInfo> getFriendByPhone(String mobilePhone, String lk, String state);

	/**
	 * 根据主键ID修改信息
	 */
	String updateIdcode(BaseInfo baseInfo);

	/**
	 * 保存用户银行卡信息 中金支付有限公司绑定卡
	 */
	//石亚宁修改
//	String savePersonAccountInfo(HttpServletRequest request,BaseInfo bInfo,Tx7201Response tx7201r);
	String savePersonAccountInfo(HttpServletRequest request,BaseInfo bInfo);

	/**
	 * 根据用户信息查询银行卡
	 */
	List<PersonAccountInfo> mybankcard(String id);

	/**
	 * 查询订单银行卡
	 */
	List<PersonAccountInfo> mybankcardOrder(String cardId, String baseId);

	/**
	 * 查询订单详情
	 */
	List investment_Detaillist(String id, String itemId, String orderId);

	/**
	 * 删除银行卡信息
	 */
	String delFriden(String id);

	/**
	 * 根据用户ID查询订单表和投资记录 进行页面展示
	 */
	List queryInvestmentRecords(String id, String state, String startDate,
			String endDate);

	/**
	 * *根据用户ID查询投资收益 进行页面展示
	 */
	List queryProfit(String id,String payStatus);

	/**
	 * 查询用户的订单记录
	 */
	String queryOrder(String id);

	/**
	 * 根据用户id查询消息
	 * 
	 * @param id
	 * @return
	 */
	List queryMessageContent(String id);

	/**
	 * 消息中心 删除消息
	 * 
	 * @param id
	 * @return
	 */
	String delMessage(String id);

	/**
	 * 根据手机号查询个人信息
	 */
	BaseInfo queryInfoByPhone(HttpServletRequest request);
     /**
      * 查询绑定银行卡的张数和号码
      */
	String querySizeBank(HttpServletRequest request,BaseInfo bInfo);
	/**
	 * 查询投资列表
	 */
	Page investment_list(JSONObject jsonObj);

	/**
	 * 查询好友列表
	 */
	Page to_myFridenList(JSONObject jsonObj);

	/**
	 * 邮件激活
	 */
	void updateMail(String id, String state, String mailDate,String mainSerialNumber);
	/**
	 * 邮件激活状态修改
	 */
	void updateMailSerialNumber(String state, String mailDate,String mainSerialNumber);
	/**
	 * 邮件发送
	 */
	Boolean sendmMail(String ip, String phone, String id, String mail);

	/**
	 * 修改密码
	 */
	void updatePassWord(String id, String passWord, String passWordFlag,
			String lockPass);

	/**
	 * 找回密码
	 */
	void findPassWord(String code, String passWord, String passWordFlag);

	/**
	 * 根据手机号修改借款状态
	 */
	boolean updateInfoByPhone(String mobilePhone);
	
	/**
	 * 查询 所有相关的银行卡 模糊查询
	 */
	List queryBank(String autValue);
	
	/**
	 * 实名认证查询（重复校验）
	 */
    BaseInfo queryIndentify(String identityCard);
	/**
	 * 实名认证修改真实信息
	 */
	void updateRealName(BaseInfo baseInfo);
	/**
	 * 查询与当前用户关联的银行
	 */
	int queryBankById(String baseId,String bankId);
	/**
	 * 银行卡解绑
	 */
	void  delBank(String baseId,String bankId,String time);
	
	/**
	 * 查询所有可上架且有图标的银行列表
	 */
	List queryBankIcon();
	
	/**
	 *判断当前用户是否首次绑卡 01首次绑卡 02多次绑卡
	 */
	String firstBindBnak(String userId);
	
	/**
	 * 查询当前用户的推荐人
	 */
	String queryTuiPerson(String userId);
	
	/**
	 * 判断用户有没有投资
	 */
	public boolean isInvest(String baseId);

	/**
	 * 查询用户是否在白名单
	 * @param request
	 * @return
	 */
	public boolean queryUserisInWhiteList(String phoneNo,String itemId);

	/**
	 * 查询用户剩余的限额
	 * @param request
	 * @return
	 */
	String queryWhiteUserLimit(HttpServletRequest request,String itemId);
}
