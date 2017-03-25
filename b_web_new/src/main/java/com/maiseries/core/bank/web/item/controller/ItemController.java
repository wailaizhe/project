package com.maiseries.core.bank.web.item.controller;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.ehcache.CacheKit;
import com.maiseries.core.bank.web.common.controller.BaseController;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.ItemInfo;
import com.maiseries.core.bank.web.item.service.ItemService;
import com.maiseries.core.bank.web.item.service.impl.ItemServiceImpl;


/**
 * 
 * @author shiyaning 投资业务类
 *
 */
public class ItemController extends BaseController {
	private ItemService itemService=new ItemServiceImpl();
	private List<ItemInfo> list ;
	private Page page ;
	private BaseInfo baseInfo;
	/*
	 * 查询所有投资项目
	 * */
	public void queryItem(){
		
		renderJsp("touzi_list.jsp");
	}
	/**
	 * 跳转到惠生活
	 */
	public void eShop() {
		renderJsp("eShop.jsp");
	}
	/**
	 * 查询首页项目列表 自定义格式
	 */
	public void queryItemIndex(){
		System.out.println("123");
		
		String jsonStr="{\"PageIndex\":1,\"PageSize\":3,\"interest\":\"\",\"duration\":\"\",\"projectType\":\"\"}";
		JSONObject jsonObj = JSONObject.parseObject(jsonStr);
		list = itemService.queryIndexItem(jsonObj);
		setAttr("totalCount", list.size());
		List list2=new ArrayList<>();
		for(int i=0;i<list.size();i++){
			list2.add(list.get(i));
		}
		
		setAttr("datas", list2);
		//首页项目
		renderJson();
		}
}
