package com.maiseries.core.bank.web.order.service.impl;

import com.maiseries.core.bank.web.common.dao.OrderDao;
import com.maiseries.core.bank.web.common.dao.impl.OrderDaoImpl;
import com.maiseries.core.bank.web.common.model.OrderInfo;
import com.maiseries.core.bank.web.order.service.OrderService;

public class OrderServiceImpl implements OrderService{
  
	private OrderDao orderDao=new OrderDaoImpl();
	
	public String successed(String itemId) {
		return orderDao.successed(itemId);
	}

	public boolean placeOrder(OrderInfo orderInfo) {
		return orderDao.placeOrder(orderInfo);
	}

	public OrderInfo queryOrderInfo(String sql, Object... params) {
		return null;
	}

}
