package com.maiseries.core.bank.web.common.dao.impl;


import java.util.List;

import com.jfinal.kit.StrKit;
import com.maiseries.core.bank.web.common.dao.BaseInfoDao;
import com.maiseries.core.bank.web.common.model.BaseInfo;
public class BaseInfoDaoImpl  implements BaseInfoDao {
	private BaseInfo dao =new BaseInfo().dao();
	private List<BaseInfo> list;
	private String TABLE="t_base_info";
	private boolean result;
	public BaseInfo checkBaseInfo(String phone, String password) {
		//dao=new BaseInfo().dao();
		String sql="select * from "+TABLE+"  where mobile_phone=? and password=?";
		BaseInfo baseInfo =dao.findFirst(sql,phone,password);
		return baseInfo;
	}


	public boolean addBaseInfo(BaseInfo baseInfo) {
		result=baseInfo.save();
		return result;
	}


	public BaseInfo findBaseInfoByPhone(String phone) {
		String sql="select * from  "+TABLE+"  where mobile_phone=?";
		BaseInfo baseInfo= dao.findFirst(sql,phone);
		return baseInfo;
	}

	public BaseInfo queryBaseInfoById(String id) {
		return dao.findById(id);
	}

	public List<BaseInfo> queryBaseInfos() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<BaseInfo> queryBaseInfosByParams(String sql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}


	public boolean updateBaseInfo(BaseInfo baseInfo) {
		//dao.update();
		
		return baseInfo.update();
	}


	

	
}
