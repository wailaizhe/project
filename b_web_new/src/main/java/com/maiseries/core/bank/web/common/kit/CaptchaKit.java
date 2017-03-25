package com.maiseries.core.bank.web.common.kit;

import com.jfinal.captcha.Captcha;
import com.jfinal.captcha.CaptchaManager;
import com.jfinal.captcha.ICaptchaCache;
import com.jfinal.core.Controller;

public class CaptchaKit {
	public static boolean validateCatchakit(String str,Controller controller){
		boolean result=false;
		if(str==null){
			return false;
		}else{
			String captchaName = "_jfinal_captcha";
			String captchaKey = controller.getCookie(captchaName);
			ICaptchaCache captchaCache = CaptchaManager.me().getCaptchaCache();
			Captcha captcha = captchaCache.get(captchaKey);
			String captchaCode = captcha.getValue();
			String newStr=str.trim().toString().toUpperCase();
			result=captchaCode.equals(newStr);
			
		}
		
		return result;
	}

}
