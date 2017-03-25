package com.maiseries.core.bank.web.activity.service;

public interface EhcacheService {

	/**
	 *  根据KEY 查询 ehcache缓存
	 * @param key
	 * @return
	 */
	
	public Object findCacheByKey(String key);
	
	/**
	 * 保存数据到ehcache中
	 * @param key  保存的key
	 * @param data  数据
	 */
	public void addToEhcache(String key,Object data);
	
	/**
	 * 通过key删除缓存
	 * @param key
	 */
	public void delCacheByKey(String key);
	
	/**
	 * 删除所有的key
	 * 
	 * @param key
	 */
	
	public void delAllCache();
	
	
}
