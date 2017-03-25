package com.maiseries.core.bank.web.baseInfo;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.baseInfo.controller.BaseInfoController;
/**
 * 
 * @author shiyaning 
 * 首页的路由
 *
 */
public class BaseInfoRoute extends Routes{

	@Override
	public void config() {
		 setBaseViewPath("/WEB-INF/views");
		 this.add("/",BaseInfoController.class,"/index");
		
	}

	

}
