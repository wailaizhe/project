package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.maiseries.core.bank.web.common.model.DicRegion;

public interface DicRegionDao  {
	/**
	 * 查询省
	 * @return
	 */
	List<DicRegion> getTopLevelRegion();
	List<DicRegion> getCitys(String pcode);
}
