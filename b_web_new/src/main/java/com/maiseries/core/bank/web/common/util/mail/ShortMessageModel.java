package com.maiseries.core.bank.web.common.util.mail;

import java.util.HashMap;
import java.util.Map;

public class ShortMessageModel {
	
    public static String send001="尊敬的用户， 您本次获取的验证码为：";
    public static String send0011="，请勿转发！";
      
      
      
    public static  String send002="尊敬的用户， 您本次获取的验证码为：";
    public  static  String send0021="，请勿转发！";
      
      
    public static  String send003="尊敬的用户， 您本次获取的验证码为：";
    public static  String send0031="，请勿转发！";
     
      
    public  static  String  send004="尊敬的客户，您的账号";
    public  static  String  send0041="本日连续5次登录失败，已被冻结，将于次日解冻。如非本人操作，请尽快联系我们，客服热线：400-6688-997。";
    
    public static String sen005="尊敬的用户， 您本次获取的验证码为：";
    public static String sen0051="，请勿转发！";
    
    public static String send007="尊敬的用户， 您本次获取的验证码为：";
    public static String send0071="，请勿转发！";
    
    public static String send009="尊敬的用户， 欢迎您登录晋城农商银行";
    public static String send0091="，此短信仅用于登录提示！";
    
    public static String send010="尊敬的客户，您尾号";
    public static String send0101="卡已绑定成功（请不要轻易注销本卡，建议保持此手机号码畅通）。此短信仅用于绑卡成功提示！";
    
    
    public  String  bankCodeErr(String key){
//    	Map<String,String> map = new HashMap<String,String>();
//    	map.put("BANK_CHANNEL_00009900:手机号码校验失败!", "手机号码校验失败!");
//    	map.put("BANK_CHANNEL_00009900:证件号码错误", "身份证号码错误!");
//    	map.put("BANK_CHANNEL_00009900:卡公用档记录不存在", "您输入的银行卡号不存在!");
//    	map.put("CUST_CHANNEL_00002005:户名不符", "您的银行卡号与身份证信息不匹配!");
//    	map.put("BANK_CHANNEL_00009900:证件类型不一致", "证件类型不一致!");
//    	map.put("BANK_CHANNEL_00009900:帐号未识别，请确认是否为旧帐号", "帐号未识别，请确认是否为旧帐号!");
//    	map.put("BANK_CHANNEL_00009900:Y6L0012 不支持验证类型为4账户类型为X的619报文", "不支持信用卡账户!");
//    	map.put("BANK_CHANNEL_00009900:Y6L0013 银行返回代码FSBR6046", "不支持信用卡账户!");
//    	map.put("BANK_CHANNEL_00009900:Y6L0045 手机号码不一致", "手机号码不一致!");
//    	map.put("返回失败", "您输入的信息有误，确认后请重新输入");  
//    	if(map.get(key)!=null){
//    		return map.get(key).toString();
//    	}else{
//    		return "4";	
//    	}
    	if(!"".equals(key)&&key!=null){
    		String[] meassage = key.split(":");
    		if(meassage.length>0){
    			return meassage[meassage.length-1];
    		}else{
    			return key;
    		}
    	}else{
    		return "4";	
    	}
    	
    }
}
