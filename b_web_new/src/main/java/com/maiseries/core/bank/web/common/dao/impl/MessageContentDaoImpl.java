package com.maiseries.core.bank.web.common.dao.impl;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.MessageContentDao;
import com.maiseries.core.bank.web.common.model.MessageContent;

public class MessageContentDaoImpl implements MessageContentDao{
    private MessageContent messageContent=new MessageContent().dao();
	public List<MessageContent> queryMessageContents(String sql,String baseInfoId) {
		return messageContent.find(sql,baseInfoId);
	}

	public boolean addMessageContent(MessageContent messageContent) {
		return messageContent.save();
	}
	
}
