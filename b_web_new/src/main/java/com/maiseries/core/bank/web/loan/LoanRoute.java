package com.maiseries.core.bank.web.loan;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.loan.controller.LoanController;

public class LoanRoute extends Routes{

	@Override
	public void config() {
		setBaseViewPath("/WEB-INF/views");
		this.add("/loan",LoanController.class,"/loan");
	}

}
