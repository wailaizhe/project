package com.maiseries.core.bank.web.common.util;

public class NumberUtils {

	/**
	 * float值，如果小数为0，则不显示小数
	 * @param old
	 * @return
	 */
	public static String removeSmallNumber(float old){
		String oldNum=String.valueOf(old);
		if(!oldNum.contains("."))
			return old+"";
//		if(0==(int)old){
//			return "";
//		}
		String smallNum = oldNum.substring(oldNum.indexOf(".")+1);
		char[] charArray = smallNum.toCharArray();
		boolean isShowSmallNum=true;
		for(int x=0;x<charArray.length;x++){
			char temp = charArray[x];
			if(temp!='0')
				isShowSmallNum=false;
		}
		if(!isShowSmallNum){
			return old+"";
		}else{
			String newNum = oldNum.substring(0,oldNum.indexOf("."));
			return newNum+"";
		}
	}

}
