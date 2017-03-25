package com.maiseries.core.bank.web.account;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.account.controller.AccountController;

public class AccountRoute extends Routes{

	@Override
	public void config() {
		setBaseViewPath("/WEB-INF/views");
		this.add("/account", AccountController.class,"/account");
		
	}
	

}
