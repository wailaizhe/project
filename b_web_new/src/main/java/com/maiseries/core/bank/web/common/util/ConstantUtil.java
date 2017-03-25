package com.maiseries.core.bank.web.common.util;

import java.util.HashMap;
import java.util.Map;


public class ConstantUtil {
	//打开检查日期更新
	public static boolean checkDataUpdate = true;
	//异构系统登录对象
	public static Map<String,Object> otherLogin=new HashMap<String,Object>();
	//易购系统登录超时集合 
	@SuppressWarnings("rawtypes")
	public static Map<String,Map> overTime=new HashMap<String,Map>();
	//异构系统登录超时次数
	public static final int overTimeNum=5;
	//用户禁用时间,单位，分钟
	public static final int banTime=30;
	//用户登录超时时间，分钟
	public static final int failureTime=30;
	
}
