package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseInvestIntentInfo<M extends BaseInvestIntentInfo<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setAmount(java.lang.String amount) {
		set("amount", amount);
		return (M)this;
	}

	public java.lang.String getAmount() {
		return get("amount");
	}

	public M setAnnualYield(java.lang.String annualYield) {
		set("annual_yield", annualYield);
		return (M)this;
	}

	public java.lang.String getAnnualYield() {
		return get("annual_yield");
	}

	public M setInvestDeadline(java.lang.String investDeadline) {
		set("invest_deadline", investDeadline);
		return (M)this;
	}

	public java.lang.String getInvestDeadline() {
		return get("invest_deadline");
	}

	public M setInvestor(java.lang.String investor) {
		set("investor", investor);
		return (M)this;
	}

	public java.lang.String getInvestor() {
		return get("investor");
	}

	public M setMobilePhone(java.lang.String mobilePhone) {
		set("mobile_phone", mobilePhone);
		return (M)this;
	}

	public java.lang.String getMobilePhone() {
		return get("mobile_phone");
	}

	public M setEmail(java.lang.String email) {
		set("email", email);
		return (M)this;
	}

	public java.lang.String getEmail() {
		return get("email");
	}

	public M setUserCode(java.lang.String userCode) {
		set("user_code", userCode);
		return (M)this;
	}

	public java.lang.String getUserCode() {
		return get("user_code");
	}

	public M setUserName(java.lang.String userName) {
		set("user_name", userName);
		return (M)this;
	}

	public java.lang.String getUserName() {
		return get("user_name");
	}

	public M setStatus(java.lang.String status) {
		set("status", status);
		return (M)this;
	}

	public java.lang.String getStatus() {
		return get("status");
	}

	public M setCreateDate(java.util.Date createDate) {
		set("create_date", createDate);
		return (M)this;
	}

	public java.util.Date getCreateDate() {
		return get("create_date");
	}

}
