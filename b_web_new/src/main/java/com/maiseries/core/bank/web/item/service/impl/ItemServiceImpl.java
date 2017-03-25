package com.maiseries.core.bank.web.item.service.impl;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.maiseries.core.bank.web.common.dao.ItemDao;
import com.maiseries.core.bank.web.common.dao.impl.ItemDaoImpl;
import com.maiseries.core.bank.web.common.model.ItemInfo;
import com.maiseries.core.bank.web.item.service.ItemService;

public class ItemServiceImpl implements ItemService{
	private ItemDao itemDao=new ItemDaoImpl();

	public List<ItemInfo> queryIndexItem(JSONObject jsonObj) {
		return itemDao.queryIndexItem(jsonObj);
	}

	public ItemInfo queryItem(String itemId) {
		return itemDao.queryItemById(itemId);
	}

	public ItemInfo queryItemById(String itemId) {
		
		return itemDao.queryItemById(itemId);
	}

	public List<ItemInfo> queryItems() {
		return itemDao.queryItems();
	}

	public List queryItemsByParams(String sql, Object... params) {
		return itemDao.queryItemsByParams(sql, params);
	}

	public boolean addItem(ItemInfo itemInfo) {
		return itemDao.addItem(itemInfo);
	}

	public boolean updateItem(ItemInfo itemInfo) {
		return itemDao.updateItem(itemInfo);
	}

	public Record queryCaptiaAndIncome(String id) {
		 String sql="SELECT SUM(CAST(e.capital AS decimal(20,2))) capital , SUM(CAST(e.income AS decimal(20,2))) income  FROM t_order_info e, t_item_info t WHERE e.fk_item_id = t.id AND e.fk_base_info_id = ? AND  e.pay_status = '01' ";
		//and  t.finance_end_date > NOW()  and round((UNIX_TIMESTAMP(NOW())-UNIX_TIMESTAMP(e.pay_date))/60)>30
		//30分钟以后的订单SELECT SUM(CAST(e.capital AS decimal(20,2))) capital, SUM(CAST(e.income AS decimal(20,2))) income FROM t_order_info e, t_item_info t WHERE e.fk_item_id = t.id AND e.fk_base_info_id = '51fad8958222449e8b67fc2f4a3ff3f2' AND  e.pay_status = '01' ;
		//and  t.finance_end_date > NOW() and round((UNIX_TIMESTAMP(NOW())-UNIX_TIMESTAMP(e.pay_date))/60)>30;
		List<Record> list=Db.find(sql,id);
		System.out.println(list.toString());
		Record re=list.get(0);
		return re;
	}

	@Override
	public int getIncome(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getCaptia(String id) {
		// TODO Auto-generated method stub
		return 0;
	}


}
