package com.maiseries.core.bank.web.invest.controller;

import com.maiseries.core.bank.web.common.controller.BaseController;

/**
 * 
 * @author shiyaning 投资业务类
 *
 */
public class InvestController extends BaseController {
	/*
	 * 投资页面
	 * */
	public void touzi(){
		renderJsp("touzi_list.jsp");
	}
	/**
	 * 跳转到惠生活
	 */
	public void eShop() {
		renderJsp("eShop.jsp");
	}
}
