package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseSendFailInfo<M extends BaseSendFailInfo<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setFkBatchSendSmsId(java.lang.String fkBatchSendSmsId) {
		set("fk_batch_send_sms_id", fkBatchSendSmsId);
		return (M)this;
	}

	public java.lang.String getFkBatchSendSmsId() {
		return get("fk_batch_send_sms_id");
	}

	public M setMobile(java.lang.String mobile) {
		set("mobile", mobile);
		return (M)this;
	}

	public java.lang.String getMobile() {
		return get("mobile");
	}

	public M setFailReason(java.lang.String failReason) {
		set("fail_reason", failReason);
		return (M)this;
	}

	public java.lang.String getFailReason() {
		return get("fail_reason");
	}

	public M setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
		return (M)this;
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

}
