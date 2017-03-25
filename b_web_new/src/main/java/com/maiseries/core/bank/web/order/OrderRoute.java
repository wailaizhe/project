package com.maiseries.core.bank.web.order;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.order.controller.OrderController;

public class OrderRoute extends Routes{

	@Override
	public void config() {
		setBaseViewPath("/WEB-INF/views");
		this.add("/order",OrderController.class,"/order");
	}

}
