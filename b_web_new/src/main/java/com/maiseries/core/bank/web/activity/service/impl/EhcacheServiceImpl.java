package com.maiseries.core.bank.web.activity.service.impl;


import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.maiseries.core.bank.web.activity.service.EhcacheService;


public class EhcacheServiceImpl implements EhcacheService{

	private static Logger log = LoggerFactory.getLogger(EhcacheServiceImpl.class);
	
	static CacheManager manager ;
	
	static final String cacheName= "objectCache";
	
	static{
		manager = CacheManager.create("ehcache.xml");
	}

	
	public Object findCacheByKey(String key) {
		Cache cache=manager.getCache(cacheName);
		Element element = cache.get(key); 
		if(null == element)
			return null;
		else
			return element.getObjectValue();
	}

	
	public void addToEhcache(String key, Object data) {

		Cache cache=manager.getCache(cacheName);
		cache.put(new Element(key,data));
	
	}

	
	public void delAllCache() {
		Cache cache=manager.getCache(cacheName);
		cache.removeAll();
		log.info("remove all key  success!");
	}

	
	public void delCacheByKey(String key) {
		Cache cache=manager.getCache(cacheName);
		cache.remove(key);
		log.info("remove key : "+key +" success!");
	}
	
	
}
