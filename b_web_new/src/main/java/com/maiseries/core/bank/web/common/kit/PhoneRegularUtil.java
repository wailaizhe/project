package com.maiseries.core.bank.web.common.kit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class PhoneRegularUtil {
 
	
	public static Boolean  phoneCheck(String phone) throws Exception {
		Pattern p = Pattern.compile("^0{0,1}(1[0-9])[0-9]{9}$");     
		Matcher m = p.matcher(phone);
	    //System.err.println(m.matches());
		return m.matches();
	}
 
	
//	public static void main(String[] args) throws Exception {
//	 PhoneRegularUtil PhoneRegular = new PhoneRegularUtil();
//	 System.err.println(PhoneRegular.phoneCheck("12345678912"));
//	}
	
}