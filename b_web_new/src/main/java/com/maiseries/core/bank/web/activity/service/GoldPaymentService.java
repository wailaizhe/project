package com.maiseries.core.bank.web.activity.service;

import javax.servlet.http.HttpServletRequest;
import code.main.archive.entity.BaseInfo;
import code.main.order.entity.ArcOrder;
import payment.api.tx.cmb.Tx7201Response;
import payment.api.tx.cmb.Tx7202Response;
import payment.api.tx.cmb.Tx7211Request;
import payment.api.tx.cmb.Tx7213Response;
import payment.api.tx.cmb.Tx7220Response;
import payment.api.tx.cmb.Tx7223Response;

public interface GoldPaymentService {
	
	 /**
	  * 建立绑定关系 调用中金接口
	  */
	Tx7201Response bindingBnak(HttpServletRequest reques,BaseInfo bInfo);
	
	/**
	 * 查询绑定关系
	 */
	Tx7202Response querybindingBnak(String txSNBinding);
	
	/**
	 * 中金快捷支付
	 */
	Tx7213Response goldQuickpayment(String bankNumber,String userName,int capital,String bindingNumber,String serialNumber,String orderNumber);
	
	/**
	 * 订单查询 处理中的订单再处理
	 */
	Tx7223Response queryQuickPay(String serialNumber);
	
	/**
	 * 中金支付订单查询(网关)
	 */
	Tx7220Response completePay(String paymentNo);
	
	
	/**
	 * 中金支付网关调用网银
	 */
	Tx7211Request orderTransmission(HttpServletRequest reques,ArcOrder orderBo,BaseInfo baseInfo);
	
	
	/**
	 * 网关订单查询
	 */
	
	Tx7220Response queryGatewayPay(String paymentNo);
}