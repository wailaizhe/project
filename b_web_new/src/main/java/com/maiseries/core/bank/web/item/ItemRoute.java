package com.maiseries.core.bank.web.item;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.item.controller.ItemController;

public class ItemRoute extends Routes{

	@Override
	public void config() {
		setBaseViewPath("/WEB-INF/views");
		this.add("/item",ItemController.class,"/item");
	}

}
