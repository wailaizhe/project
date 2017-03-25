package com.maiseries.core.bank.web.invest;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.invest.controller.InvestController;

public class InvestRoute extends Routes{

	@Override
	public void config() {
		setBaseViewPath("/WEB-INF/views");
		this.add("/investment",InvestController.class,"/investment");
	}

}
