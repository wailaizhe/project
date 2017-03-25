package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseMessagePush<M extends BaseMessagePush<M>> extends Model<M> implements IBean {

	public M setId(java.lang.String id) {
		set("id", id);
		return (M)this;
	}

	public java.lang.String getId() {
		return get("id");
	}

	public M setTicker(java.lang.String ticker) {
		set("ticker", ticker);
		return (M)this;
	}

	public java.lang.String getTicker() {
		return get("ticker");
	}

	public M setTitle(java.lang.String title) {
		set("title", title);
		return (M)this;
	}

	public java.lang.String getTitle() {
		return get("title");
	}

	public M setText(java.lang.String text) {
		set("text", text);
		return (M)this;
	}

	public java.lang.String getText() {
		return get("text");
	}

	public M setCreateDate(java.util.Date createDate) {
		set("create_date", createDate);
		return (M)this;
	}

	public java.util.Date getCreateDate() {
		return get("create_date");
	}

	public M setCreateUser(java.lang.String createUser) {
		set("create_user", createUser);
		return (M)this;
	}

	public java.lang.String getCreateUser() {
		return get("create_user");
	}

	public M setUpdateDate(java.util.Date updateDate) {
		set("update_date", updateDate);
		return (M)this;
	}

	public java.util.Date getUpdateDate() {
		return get("update_date");
	}

	public M setUpdateUser(java.lang.String updateUser) {
		set("update_user", updateUser);
		return (M)this;
	}

	public java.lang.String getUpdateUser() {
		return get("update_user");
	}

	public M setPublishDate(java.util.Date publishDate) {
		set("publish_date", publishDate);
		return (M)this;
	}

	public java.util.Date getPublishDate() {
		return get("publish_date");
	}

	public M setIsDel(java.lang.String isDel) {
		set("is_del", isDel);
		return (M)this;
	}

	public java.lang.String getIsDel() {
		return get("is_del");
	}

	public M setStatus(java.lang.String status) {
		set("status", status);
		return (M)this;
	}

	public java.lang.String getStatus() {
		return get("status");
	}

}