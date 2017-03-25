package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BasePersonPrize<M extends BasePersonPrize<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setPrizeName(java.lang.String prizeName) {
		set("prize_name", prizeName);
		return (M)this;
	}

	public java.lang.String getPrizeName() {
		return get("prize_name");
	}

	public M setPrizeAmount(java.math.BigDecimal prizeAmount) {
		set("prize_amount", prizeAmount);
		return (M)this;
	}

	public java.math.BigDecimal getPrizeAmount() {
		return get("prize_amount");
	}

	public M setPrizeGrade(java.lang.String prizeGrade) {
		set("prize_grade", prizeGrade);
		return (M)this;
	}

	public java.lang.String getPrizeGrade() {
		return get("prize_grade");
	}

	public M setPrizeType(java.lang.String prizeType) {
		set("prize_type", prizeType);
		return (M)this;
	}

	public java.lang.String getPrizeType() {
		return get("prize_type");
	}

	public M setStartUseTime(java.util.Date startUseTime) {
		set("start_use_time", startUseTime);
		return (M)this;
	}

	public java.util.Date getStartUseTime() {
		return get("start_use_time");
	}

	public M setEndUseTime(java.util.Date endUseTime) {
		set("end_use_time", endUseTime);
		return (M)this;
	}

	public java.util.Date getEndUseTime() {
		return get("end_use_time");
	}

	public M setUseTime(java.util.Date useTime) {
		set("use_time", useTime);
		return (M)this;
	}

	public java.util.Date getUseTime() {
		return get("use_time");
	}

	public M setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
		return (M)this;
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

	public M setFkBaseInfoId(java.lang.String fkBaseInfoId) {
		set("fk_base_info_id", fkBaseInfoId);
		return (M)this;
	}

	public java.lang.String getFkBaseInfoId() {
		return get("fk_base_info_id");
	}

	public M setActivityType(java.lang.String activityType) {
		set("activity_type", activityType);
		return (M)this;
	}

	public java.lang.String getActivityType() {
		return get("activity_type");
	}

	public M setStatus(java.lang.String status) {
		set("status", status);
		return (M)this;
	}

	public java.lang.String getStatus() {
		return get("status");
	}

}
