package com.maiseries.core.bank.web.common.interceptor;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.log.Log;
import com.maiseries.core.bank.web.common.exception.ValidateException;
import com.maiseries.core.bank.web.common.kit.ValidatorKit;


/**
 * Created by shiyaning on 2017/2/24.
 * 没有登录不可以进入账户中心
 */
public class LoginInterceptor implements Interceptor {

    private static Log log = Log.getLog(LoginInterceptor.class);

    public void intercept(Invocation invocation) {
    	String role = invocation.getController().getSessionAttr("status");
        if (role!=null) {
        	   invocation.invoke();
		}else{
			invocation.getController().redirect("/loginOut");
		}
        
    }

}
