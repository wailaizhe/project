package com.maiseries.core.bank.web.activity.service;

import java.util.List;
import java.util.Map;

import code.main.base.domain.Page;
import code.main.base.entity.DicSystem;

public interface DicSystemService {

	@SuppressWarnings("rawtypes")
	Map add(DicSystem temp);

	@SuppressWarnings("rawtypes")
	List findDic(String type,String bigType);
	
	@SuppressWarnings("rawtypes")
	List findAllDic(String type,String bigType);
	
	String findDicText(String type,String bigType,String code);
	
	List findDicList(String type,String bigType,String code);
	
	@SuppressWarnings("rawtypes")
	List findTree(String type);
	
	Page findPage(String bigType,String type,String text,int start,int limit);
	
	DicSystem find(Integer id, boolean lazy);
	
	@SuppressWarnings("rawtypes")
	Map delete(String ids);
	
	@SuppressWarnings("rawtypes")
	Map update(DicSystem temp);
 
	List findAllDicNew(String type, String bigType);
	
	String findDicEncoding(String type,String bigType,String code);

	List findDicNullAtFirst(String type, String bigType);
	
	void saveDicSystem(DicSystem dicSystem);
}