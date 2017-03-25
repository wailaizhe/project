package com.maiseries.core.bank.web.activity.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import code.main.base.entity.DicRegion;

public interface DicRegionService {

	@SuppressWarnings("rawtypes")
	Map add(DicRegion org);

	@SuppressWarnings("rawtypes")
	List findTree(String pcode);

	@SuppressWarnings("rawtypes")
	List findArray(String pcode);

	@SuppressWarnings("rawtypes")
	List findDicArray(String cond);

	@SuppressWarnings("rawtypes")
	List findCheckboxTree(String pcode);

	String findAddress(String code, String result);

	String findChildIds(String code, String result);

	DicRegion find(Integer id, boolean lazy);

	DicRegion findByCode(String code);

	DicRegion findRegion(int id1, int id2, int id3, int id4, int id5);

	@SuppressWarnings("rawtypes")
	Map delete(String id, String code);

	@SuppressWarnings("rawtypes")
	Map update(DicRegion org);

	List<DicRegion> getTopLevelRegion();

	List<DicRegion> findRegions(String code);

	@SuppressWarnings("rawtypes")
	List getSubUnitArray(String rcode);

	
	public Map getRegionByCode(HttpServletRequest request);
	
	public Map<String, Object> uploadData(InputStream inputStream);

}