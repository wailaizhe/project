package com.maiseries.core.bank.web.baseInfo.service;

import java.util.List;

import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.DicSystem;
import com.maiseries.core.bank.web.common.model.MessageContent;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;
import com.maiseries.core.bank.web.common.model.SmsInfo;

public interface BaseInfoService {
	/*
	 * 登录验证
	 * */
	 BaseInfo checkBaseInfo(String phone,String password);
	/**
	 * 根据手机查找是否注册
	 */
	 boolean findBaseInfoByPhone(String phone);
	/**
	 * 根据手机查找用户
	 */
	 BaseInfo queryBaseInfoById(String baseInfoId);
	 /**
	  * 修改用户
	  * @return
	  */
	 boolean updateBaseInfo(BaseInfo baseInfo);
	/**
	 * 新用户注册
	 */
	 void addBaseInfo(BaseInfo baseInfo) ;
	/**
	 * 用户添加银行卡号
	 */

	 boolean addBankAccount(PersonAccountInfo personAccountInfo);
	/**
	 * 用户删除银行卡号
	 */

	 boolean deleteBankAccount(String  id);
	/**
	 * 根据用户ID银行卡ID查询单个银行卡
	 * @param id
	 * @return
	 */
	 PersonAccountInfo queryBank(String id,String baseInfoId);
	
	/**
	 * 查询用户的所有银行卡
	 * @param baseInfoId
	 * @return
	 */
	 List<PersonAccountInfo> queryAllPersonAccountInfos(String baseInfoId);
	/**
	 * 我的消息
	 */
	 boolean addMessageContent(MessageContent messageContent);
	/**
	 * 查询我的消息
	 */
	 List<MessageContent> queryMessageContents(String baseInfoId);
	/**
	 * 保存发送的短息信息
	 * @param smsInfo
	 * @return
	 */
	 boolean addSmsInfo(SmsInfo smsInfo);
	/**
	 * 保存发送的短息信息
	 * @param smsInfo
	 * @return
	 */
	 SmsInfo querySmsInfo(String smsInfoId);
	 /**
	  * 查询所有的银行
	  * @return
	  */
	 List<DicSystem> queryBank();
}
