package com.maiseries.core.bank.web.common.util;

import java.math.BigDecimal;

public class ParamsFilter {
	/**
	 * 如果传进来数据能够转换成int类型，则返回转换后的数据类型，否则返回0
	 */
	public static int converterToInt(String number) {
		try {
			if(number!=null){
				return Integer.parseInt(number);
			}else{
				return 0;
			}
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 如果传进来数据能够转换成int类型，则返回转换后的数据类型，否则返回ret
	 */
	public static int converterToInt(String number, int ret) {
		try {
			if(number!=null){
				return Integer.parseInt(number);
			}else{
				return ret;
			}
		} catch (Exception e) {
			return ret;
		}
	}
	
	/**
	 * 如果传进来数据能够转换成int类型，则返回转换后的数据类型，否则返回0
	 */
	public static float converterToFloat(String number) {
		try {
			if(number!=null){
				return Float.parseFloat(number);
			}else{
				return 0;
			}
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 把字符串中的空格删除以后，重新组成一个新的字符串
	 */
	public static String deleterBlank(String str){
		String s = "";
		for (int i = 0; i < str.length(); i++) {
			if(!(str.charAt(i)+"").equals(" ")){
				s += str.charAt(i);
			}
		}
		return s;
	}
	/**
	 * 四舍五入，直接截取小数位数
	 */
	public static float getScale(float num,int scale){
		BigDecimal  bDec = new BigDecimal(num);
		return bDec.setScale(scale,BigDecimal.ROUND_HALF_EVEN).floatValue();
	}
}
