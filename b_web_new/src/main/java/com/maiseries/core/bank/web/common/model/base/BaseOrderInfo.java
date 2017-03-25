package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseOrderInfo<M extends BaseOrderInfo<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setFkItemId(java.lang.String fkItemId) {
		set("fk_item_id", fkItemId);
		return (M)this;
	}

	public java.lang.String getFkItemId() {
		return get("fk_item_id");
	}

	public M setItemNumber(java.lang.String itemNumber) {
		set("item_number", itemNumber);
		return (M)this;
	}

	public java.lang.String getItemNumber() {
		return get("item_number");
	}

	public M setOrderNumber(java.lang.String orderNumber) {
		set("order_number", orderNumber);
		return (M)this;
	}

	public java.lang.String getOrderNumber() {
		return get("order_number");
	}

	public M setSerialNumber(java.lang.String serialNumber) {
		set("serial_number", serialNumber);
		return (M)this;
	}

	public java.lang.String getSerialNumber() {
		return get("serial_number");
	}

	public M setFkBaseInfoId(java.lang.String fkBaseInfoId) {
		set("fk_base_info_id", fkBaseInfoId);
		return (M)this;
	}

	public java.lang.String getFkBaseInfoId() {
		return get("fk_base_info_id");
	}

	public M setFkAccountInfoId(java.lang.String fkAccountInfoId) {
		set("fk_account_info_id", fkAccountInfoId);
		return (M)this;
	}

	public java.lang.String getFkAccountInfoId() {
		return get("fk_account_info_id");
	}

	public M setCardId(java.lang.String cardId) {
		set("card_id", cardId);
		return (M)this;
	}

	public java.lang.String getCardId() {
		return get("card_id");
	}

	public M setMobilePhone(java.lang.String mobilePhone) {
		set("mobile_phone", mobilePhone);
		return (M)this;
	}

	public java.lang.String getMobilePhone() {
		return get("mobile_phone");
	}

	public M setCapital(java.lang.String capital) {
		set("capital", capital);
		return (M)this;
	}

	public java.lang.String getCapital() {
		return get("capital");
	}

	public M setIncome(java.lang.String income) {
		set("income", income);
		return (M)this;
	}

	public java.lang.String getIncome() {
		return get("income");
	}

	public M setCapitalIncome(java.lang.String capitalIncome) {
		set("capital_income", capitalIncome);
		return (M)this;
	}

	public java.lang.String getCapitalIncome() {
		return get("capital_income");
	}

	public M setPayStatus(java.lang.String payStatus) {
		set("pay_status", payStatus);
		return (M)this;
	}

	public java.lang.String getPayStatus() {
		return get("pay_status");
	}

	public M setIp(java.lang.String ip) {
		set("ip", ip);
		return (M)this;
	}

	public java.lang.String getIp() {
		return get("ip");
	}

	public M setCreateDate(java.util.Date createDate) {
		set("create_date", createDate);
		return (M)this;
	}

	public java.util.Date getCreateDate() {
		return get("create_date");
	}

	public M setPayDate(java.lang.String payDate) {
		set("pay_date", payDate);
		return (M)this;
	}

	public java.lang.String getPayDate() {
		return get("pay_date");
	}

	public M setOrderCompleteDate(java.lang.String orderCompleteDate) {
		set("order_complete_date", orderCompleteDate);
		return (M)this;
	}

	public java.lang.String getOrderCompleteDate() {
		return get("order_complete_date");
	}

	public M setPayType(java.lang.String payType) {
		set("pay_type", payType);
		return (M)this;
	}

	public java.lang.String getPayType() {
		return get("pay_type");
	}

	public M setErrMessage(java.lang.String errMessage) {
		set("err_message", errMessage);
		return (M)this;
	}

	public java.lang.String getErrMessage() {
		return get("err_message");
	}

	public M setDeductionFee(java.lang.String deductionFee) {
		set("deduction_fee", deductionFee);
		return (M)this;
	}

	public java.lang.String getDeductionFee() {
		return get("deduction_fee");
	}

	public M setClientType(java.lang.String clientType) {
		set("client_type", clientType);
		return (M)this;
	}

	public java.lang.String getClientType() {
		return get("client_type");
	}

	public M setPayMobiePhone(java.lang.String payMobiePhone) {
		set("pay_mobie_phone", payMobiePhone);
		return (M)this;
	}

	public java.lang.String getPayMobiePhone() {
		return get("pay_mobie_phone");
	}

}
