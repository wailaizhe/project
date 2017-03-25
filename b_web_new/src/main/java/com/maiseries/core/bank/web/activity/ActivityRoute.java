package com.maiseries.core.bank.web.activity;

import com.jfinal.config.Routes;
import com.maiseries.core.bank.web.activity.controller.ActivityController;

/**
 * Created by shiyanign on 2017/2/24.
 */
public class ActivityRoute extends Routes {

	@Override
	public void config() {
		 setBaseViewPath("/WEB-INF/views");
		 this.add("/activity",ActivityController.class,"/activity");
		 // /WEB-INF/views/activity
		 // renderjsp("activity/index.jsp");
		 // renderjsp("index.jsp");
		 // localhost/activity/index  /login  /testtt  
		 // /WEB-INF/views/activity/index.jsp
	}
   
}
