package com.maiseries.core.bank.web.activity.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;
import code.main.account.entity.PersonAccountInfo;
import code.main.archive.entity.BaseInfo;
import code.main.base.domain.Page;
import code.main.item.entity.Item;
import code.main.order.entity.ArcOrder;

public interface ArcOrderService {
	/*
	 * 单条项目查询
	 */
	//Map fingDetail(String itemId);
	Item fingDetail(String itemId);
	
	/**
	 * 保存新订单
	 */
	void addOrder(ArcOrder order);
	/*
	 * 剩余可投金额、当前进度
	 */
	String succe(String itemId);
	
	/*
	 * 关联银行账户
	 */
	List bankAccount(String userId);
	
	/*
	 * 添加银行账户
	 */
	Map addAccount(PersonAccountInfo personInfo);
	
	/*
	 * 添加订单成功
	 */
	void saveOrder(ArcOrder order);
	
	/*
	 * 查询订单表流水号
	 */
	List SerialNumber();

	/**
	 * 查询该项目投资记录
	 * @param jsonObj
	 * @return
	 */
	Page getPayList(JSONObject jsonObj);
	
	/**
	 * 创建订单流水号
	 */
//	void saveSnEntiy(SerialNumberEntiy sne);
    /**
     * 查询订单
     */
    ArcOrder  findArcOrder(String orderNumber);
    /**
     * 根据流水号查询订单
     */
    ArcOrder findSerial(String sailId); 
    /**
     * 修改订单状态  已支付 、 未支付、已超募、
     */
    void updateOrder(String orderNumber,String orderType);
    
	/**
	 * 修改流水号的支付状态
	 */
	void updateSerialNumberr(String payStatus,String serialId,String payDate,String orderCompleteDate,String errMessage);
	/**
	 * 查询当前融资进度是否完成融资
	 */
	String therRaised(HttpServletRequest request,String fire);
	/**
	 * 保存用户支付成功订单消息 
	 */
	void saveMessage(ArcOrder order,BaseInfo baseInfo,Item item,String state);
	/**
	 * 剩余可投金额、当前进度
	 */
//	String fnancyProgress(String itemId);
	/**
	 *银行卡账户 中金支付 银行卡中金支付 快捷支付校验 
	 */
	String  isBank(HttpServletRequest request,BaseInfo mobilePhone);
	/**
	 * 身份证实名校验  中金支付 实名校验
	 */
	String  isIndentify(HttpServletRequest request);
	/**
	 * 查询当前用户提交订单的次数
	 */
	String querOrderTime(String mobiePhone);
	/**
	 * 项目完成修改项目状态 01 
	 */
	void  updateItemState(String itemId);
	/**
	 * 获取当前用户支付完成的次数
	 */
	String queryPayCount(String mobilePhone);
	/**
	 * 订单修改银行卡
	 */
	void updateOrderBank(String serialNumber,String bankCode);
	
	String orderState(final String serNumbner,final String itemId,final int captions,final String bankNotificationTime);
	
	// 查询订是否超募 或满标  01:已满标  02:项目已满标 03:加上这笔钱 超募
	String  checkItemInvestStatus(HttpServletRequest request,String itemId,BigDecimal capital);
	
	String gatewayPay(HttpServletRequest request,HttpServletResponse response);
	
	/**
	 * 快捷保存订单
	 */
	String saveGoldQuickPay(HttpServletRequest request,HttpServletResponse response);
	
	/**
	 * 中金快捷支付支付主方法(内部调用)
	 */
	String  goldQuickPay(HttpServletRequest request,HttpServletResponse response);
	
	/**
	 * 调用中金接口拼接加密数据  调用中金支付接口(网关支付)
	 */
	Map<String,String>  orderTransmission(HttpServletRequest request);
}