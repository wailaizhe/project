package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.maiseries.core.bank.web.common.model.OrderInfo;
/**
 * 订单的业务操作
 * @author shiyaning
 *
 */
public interface OrderDao{
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
	 * 查询单个订单
	 */
	public OrderInfo queryOrderInfo(String sql,Object...params);
	/**
	 * 根据用户的ID 查出所有订单信息
	 * @param baseInfoId
	 * @return
	 */
	public List<OrderInfo> queryAllOrderInfos(String baseInfoId);
	/**
	 * 根据用户的ID 查出符合条件的所有订单信息(自己定义参数)
	 * @param baseInfoId
	 * @return
	 */
	public List<OrderInfo> queryAllOrderInfosByParams(String sql,Object...params);
}
