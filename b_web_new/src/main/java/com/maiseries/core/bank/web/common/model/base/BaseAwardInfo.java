package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseAwardInfo<M extends BaseAwardInfo<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setFkBaseInfoId(java.lang.String fkBaseInfoId) {
		set("fk_base_info_id", fkBaseInfoId);
		return (M)this;
	}

	public java.lang.String getFkBaseInfoId() {
		return get("fk_base_info_id");
	}

	public M setRank(java.lang.String rank) {
		set("rank", rank);
		return (M)this;
	}

	public java.lang.String getRank() {
		return get("rank");
	}

	public M setTotalCoinNum(java.lang.String totalCoinNum) {
		set("total_coin_num", totalCoinNum);
		return (M)this;
	}

	public java.lang.String getTotalCoinNum() {
		return get("total_coin_num");
	}

	public M setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
		return (M)this;
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

	public M setInvalidTime(java.util.Date invalidTime) {
		set("invalid_time", invalidTime);
		return (M)this;
	}

	public java.util.Date getInvalidTime() {
		return get("invalid_time");
	}

	public M setClientType(java.lang.String clientType) {
		set("client_type", clientType);
		return (M)this;
	}

	public java.lang.String getClientType() {
		return get("client_type");
	}

	public M setRandomMath(java.lang.String randomMath) {
		set("random_math", randomMath);
		return (M)this;
	}

	public java.lang.String getRandomMath() {
		return get("random_math");
	}

	public M setMoblicPhone(java.lang.String moblicPhone) {
		set("moblic_phone", moblicPhone);
		return (M)this;
	}

	public java.lang.String getMoblicPhone() {
		return get("moblic_phone");
	}

}
