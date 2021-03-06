package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseWhitelistsInfo<M extends BaseWhitelistsInfo<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setWhiteName(java.lang.String whiteName) {
		set("white_name", whiteName);
		return (M)this;
	}

	public java.lang.String getWhiteName() {
		return get("white_name");
	}

	public M setCreateDate(java.util.Date createDate) {
		set("create_date", createDate);
		return (M)this;
	}

	public java.util.Date getCreateDate() {
		return get("create_date");
	}

	public M setWtItemId(java.lang.String wtItemId) {
		set("wt_item_id", wtItemId);
		return (M)this;
	}

	public java.lang.String getWtItemId() {
		return get("wt_item_id");
	}

	public M setWhiteList(java.lang.String whiteList) {
		set("white_list", whiteList);
		return (M)this;
	}

	public java.lang.String getWhiteList() {
		return get("white_list");
	}

	public M setIp(java.lang.String ip) {
		set("ip", ip);
		return (M)this;
	}

	public java.lang.String getIp() {
		return get("ip");
	}

	public M setNote1(java.lang.String note1) {
		set("note1", note1);
		return (M)this;
	}

	public java.lang.String getNote1() {
		return get("note1");
	}

	public M setNote2(java.lang.String note2) {
		set("note2", note2);
		return (M)this;
	}

	public java.lang.String getNote2() {
		return get("note2");
	}

	public M setNote3(java.lang.String note3) {
		set("note3", note3);
		return (M)this;
	}

	public java.lang.String getNote3() {
		return get("note3");
	}

	public M setMaxLimit(java.lang.String maxLimit) {
		set("max_limit", maxLimit);
		return (M)this;
	}

	public java.lang.String getMaxLimit() {
		return get("max_limit");
	}

}
