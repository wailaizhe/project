package com.maiseries.core.bank.web.common.dao.impl;

import java.util.List;

import org.omg.CORBA.BAD_INV_ORDER;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.maiseries.core.bank.web.common.dao.OrderDao;
import com.maiseries.core.bank.web.common.model.OrderInfo;


public class OrderDaoImpl  implements OrderDao {
	private static Logger logger = LoggerFactory.getLogger(ItemDaoImpl.class);
	private OrderInfo dao =new OrderInfo().dao();
	private final String TABLE="t_order_info";
	public String successed(String itemId) {
		String total = "";
		String hql = "select sum(ao.capital) from "+TABLE+" ao where ao.fkItemId=? and ao.payStatus=?";
		try{
			String  temp=dao.find(hql, new Object []{itemId,"01"}).toString();
			if(temp==null||"".equals(temp)){
				total = "0.00";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			logger.error(OrderDaoImpl.class.toString(),ex);
		}
		return total;
	}
	public boolean placeOrder(OrderInfo orderInfo) {
		return orderInfo.save();
	}
	public OrderInfo queryOrderInfo(String sql, Object... params) {
		return dao.findFirst(sql,params);
	}
	public List<OrderInfo> queryAllOrderInfos(String baseInfoId) {
		String sql="select * from "+TABLE+" where fk_base_info_id=?";
		return dao.find(sql,baseInfoId);
	}
	public List<OrderInfo> queryAllOrderInfosByParams(String sql, Object... params) {
		return dao.find(sql,params);
	}
}
