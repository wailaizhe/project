package com.maiseries.core.bank.web.loan.controller;

import com.maiseries.core.bank.web.common.controller.BaseController;
/**
 * 
 * @author shiyaning 
 * 贷款业务操作类
 *
 */

public class LoanController extends BaseController {
	/**
	 * 跳转到贷款页
	 */
	public void gotoLoan(){
		System.out.println("我要借款");
		renderJsp("loanIndex.jsp");
	}

}
