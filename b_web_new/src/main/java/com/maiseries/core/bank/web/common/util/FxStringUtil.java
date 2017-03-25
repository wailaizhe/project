package com.maiseries.core.bank.web.common.util;

/**
 * 判断字符串是否为空的公共类
 * @author zhangwei
 */
public class FxStringUtil {
	public static boolean isNullOrEmpty(String str){
		 if(null == str || "".equals(str.trim()) || "null".equals(str.trim().toLowerCase())){
			 return true;
	     }else{
	    	 return false;
	     }
	}
}
