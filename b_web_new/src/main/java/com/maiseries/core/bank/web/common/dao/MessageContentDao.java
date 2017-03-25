package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.maiseries.core.bank.web.common.model.MessageContent;

public interface MessageContentDao {
	/**
	 * 查询需要的消息
	 */
	List<MessageContent> queryMessageContents(String sql,String baseInfoId);
	/**
	 * 添加消息
	 */
	boolean addMessageContent(MessageContent messageContent);
}
