package com.maiseries.core.bank.web.common.kit;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;



/**
 * Created by shiyaning on 2017/2/25.
 */
public class CookieKit {
	
    public static String get(HttpServletRequest request,String key){
    	
    		for (Cookie cookie : request.getCookies()){
                if (key.equals(cookie.getName())){
                    return cookie.getValue();
                }
            }
		
        return null;
    }
    public static boolean remove(HttpServletRequest request,String key){
    	for (Cookie cookie : request.getCookies()){
            if (key.equals(cookie.getName())){
            	cookie.setMaxAge(0);
                return true;
            }
        }
    	return false;
    }
}
