package com.maiseries.core.bank.web.common.dao.impl;

import java.util.List;

import com.maiseries.core.bank.web.common.dao.DicRegionDao;
import com.maiseries.core.bank.web.common.model.DicRegion;
public class DicRegionDaoImpl  implements DicRegionDao{
	private DicRegion dao=new DicRegion().dao();
	/**
	 * 查询省市和直辖市
	 * 
	 * @return
	 */
	public List<DicRegion> getTopLevelRegion() {
		String sql = "select * from t_dic_region t where t.statue= 0 and t.level = 1 order by t.code";
		return dao.find(sql);
	}
	@Override
	public List<DicRegion> getCitys(String pcode) {
		String sql = "select * from t_dic_region t where statue=0";
		if (pcode != null && !pcode.isEmpty()) {
			sql += " and t.pcode='" + pcode + "'";
		}
		sql += " order by t.code asc,t.id desc";
		return dao.find(sql);
	}
}
