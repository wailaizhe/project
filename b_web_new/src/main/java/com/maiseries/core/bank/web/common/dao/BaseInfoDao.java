package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.jfinal.plugin.activerecord.Record;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.BaseInfo;
/**
 * 
 * @author shiyaning
 *
 *关于用户的登录注册。信息业务类
 */
public interface BaseInfoDao {	 
	public BaseInfo checkBaseInfo(String phone, String password) ;
	/**
	 * 根据手机查找是否注册
	 */
	public BaseInfo findBaseInfoByPhone(String phone);
	/**
	 * 根据用户ID查找用户
	 * @return
	 */
	public BaseInfo  queryBaseInfoById(String id);
	/**
	 * 查询所有用户
	 */
	public List<BaseInfo> queryBaseInfos();
	/**
	 * 
	 * @param params根据条件查询用户
	 * @return
	 */
	public List<BaseInfo> queryBaseInfosByParams(String sql,Object...params);
	/**
	 * 新用户注册
	 */
	public boolean addBaseInfo(BaseInfo baseInfo);
	/**
	 * 更新用户
	 * @return
	 */
	public boolean updateBaseInfo(BaseInfo baseInfo);
	

}
