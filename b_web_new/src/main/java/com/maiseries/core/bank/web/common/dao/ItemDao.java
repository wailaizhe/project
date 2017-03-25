package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.maiseries.core.bank.web.common.model.ItemInfo;
import com.maiseries.core.bank.web.common.model.domain.Page;

public interface ItemDao{
	/**
	 * 查询首页项目列表
	 * @param jsonObj 查询条件
	 * @return
	 */
	 List<ItemInfo> queryIndexItem(JSONObject jsonObj);
	/**
	 * 根据ItemID查询项目
	 * @param itemId
	 * @return
	 */
	 ItemInfo  queryItemById(String itemId);
	/**
	 * 查询所有项目
	 */
	 List<ItemInfo> queryItems();
	/**
	 * 
	 * @param params根据条件查询项目
	 * @return
	 */
	 List queryItemsByParams(String sql,Object...params);
	/**
	 * 添加项目
	 * @return
	 */
	 boolean addItem(ItemInfo itemInfo);
	/**
	 * 更新项目
	 * @return
	 */
	 boolean updateItem(ItemInfo itemInfo);
	 /**
		 * 根据用户的ID 查询出总的收益
		 * @param id
		 * @return
		 */
	 int  getIncome(String id);
	 /**
		 * 根据用户的ID 查询出总的持有资产
		 * @param id
		 * @return
		 */
	 int  getCaptia(String id);

}
