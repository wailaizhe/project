package com.maiseries.core.bank.web.activity.controller;

import java.util.List;

import org.hibernate.pretty.Printer;

import com.jfinal.core.Controller;
import com.maiseries.core.bank.web.activity.service.EhcacheService;
import com.maiseries.core.bank.web.activity.service.NoticeService;
import com.maiseries.core.bank.web.activity.service.impl.EhcacheServiceImpl;
import com.maiseries.core.bank.web.activity.service.impl.NoticeServiceImpl;


/**
 * Created by shiyaning on 2017/2/24.
 */

public class ActivityController extends Controller {
	 EhcacheService ehcacheService=new EhcacheServiceImpl();
     NoticeService noticeService=new NoticeServiceImpl();
    public void index(){
       renderJsp("index.jsp");
    }
   
	public void jumpToLoginaPager() {
		
			
    	renderJsp( "/resister_login/login");
		
	}
	public  void queryIndexList1(){
		/*String name=getPara("name");
		System.out.println(name);//("{\"message\":\"Please input password!\"}");
*/       
		renderJson("message", "Please input password!");
		
		
	}
	

}
