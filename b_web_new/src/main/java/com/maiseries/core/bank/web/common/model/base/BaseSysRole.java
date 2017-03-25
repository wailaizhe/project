package com.maiseries.core.bank.web.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseSysRole<M extends BaseSysRole<M>> extends Model<M> implements IBean {

	public M setID(java.lang.String ID) {
		set("ID", ID);
		return (M)this;
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public M setRoleName(java.lang.String roleName) {
		set("role_name", roleName);
		return (M)this;
	}

	public java.lang.String getRoleName() {
		return get("role_name");
	}

	public M setRoleCode(java.lang.String roleCode) {
		set("role_code", roleCode);
		return (M)this;
	}

	public java.lang.String getRoleCode() {
		return get("role_code");
	}

	public M setRemark(java.lang.String remark) {
		set("remark", remark);
		return (M)this;
	}

	public java.lang.String getRemark() {
		return get("remark");
	}

}
