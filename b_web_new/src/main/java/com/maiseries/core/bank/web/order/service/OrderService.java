package com.maiseries.core.bank.web.order.service;

import com.maiseries.core.bank.web.common.model.OrderInfo;

public interface OrderService {
	/**
	 * 成功购买的总金额
	 * @param itemId
	 * @return
	 */
	public String successed(String itemId) ;
	/**
	 * 下单
	 * @param orderInfo
	 * @return
	 */
	public boolean placeOrder(OrderInfo orderInfo);
	/**
	 * 查询订单
	 */
	public OrderInfo queryOrderInfo(String sql,Object...params);

}
