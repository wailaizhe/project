package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseBatchSendSms<M extends BaseBatchSendSms<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setReceiver(java.lang.String receiver) {
		set("receiver", receiver);
		return (M)this;
	}

	public java.lang.String getReceiver() {
		return get("receiver");
	}

	public M setContent(java.lang.String content) {
		set("content", content);
		return (M)this;
	}

	public java.lang.String getContent() {
		return get("content");
	}

	public M setStatus(java.lang.String status) {
		set("status", status);
		return (M)this;
	}

	public java.lang.String getStatus() {
		return get("status");
	}

	public M setOperator(java.lang.String operator) {
		set("operator", operator);
		return (M)this;
	}

	public java.lang.String getOperator() {
		return get("operator");
	}

	public M setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
		return (M)this;
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

	public M setSendTime(java.util.Date sendTime) {
		set("send_time", sendTime);
		return (M)this;
	}

	public java.util.Date getSendTime() {
		return get("send_time");
	}

	public M setCompleteTime(java.util.Date completeTime) {
		set("complete_time", completeTime);
		return (M)this;
	}

	public java.util.Date getCompleteTime() {
		return get("complete_time");
	}

}