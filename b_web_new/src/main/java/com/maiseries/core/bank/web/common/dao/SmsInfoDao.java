package com.maiseries.core.bank.web.common.dao;

import com.maiseries.core.bank.web.common.model.SmsInfo;

public interface SmsInfoDao  {
	/**
	 * 将发送的消息保存到数据库
	 */
	public boolean addSmsInfo(SmsInfo smsInfo);
	/**
	 * 修改消息状态
	 */
	public boolean updateSmsInfo(SmsInfo smsInfo);
	/**
	 * 根据ID查询单条消息
	 */
	public SmsInfo querySmsInfo(String smsInfoId);
}
