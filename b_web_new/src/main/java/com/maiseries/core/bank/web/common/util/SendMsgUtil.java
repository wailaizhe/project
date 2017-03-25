package com.maiseries.core.bank.web.common.util;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import com.maiseries.core.bank.web.common.util.mail.ShortMessageModel;

public class SendMsgUtil {
	 /**
     * 发送短信消息
      * 方法说明
      * @Discription:扩展说明
      * @param phones
      * @param content
      * @return
      * @return String
      * @Author: feizi
      * @ModifyUser：shiyaning
      * @ModifyDate:20170303
     */
    @SuppressWarnings("deprecation")
    public static String  sendMsg(String phones,String contentType){
    	String message="";
    	String code=createRandomVcode();
    	
    	switch (contentType) {
		case "001":
			message=ShortMessageModel.send001+code+ShortMessageModel.send0011;
			break;
		case "002":
			message=ShortMessageModel.send002+code+ShortMessageModel.send0021;
			break;
		case "003":
			message=ShortMessageModel.send003+code+ShortMessageModel.send0031;
			break;
		case "004":
			message=ShortMessageModel.send004+code+ShortMessageModel.send0041;
			break;	

		case "007":
			message=ShortMessageModel.send007+code+ShortMessageModel.send0071;
			break;
		case "009":
			message=ShortMessageModel.send009+code+ShortMessageModel.send0091;
			break;
		case "010":
			message=ShortMessageModel.send010+code+ShortMessageModel.send0101;
			break;
		default:
			code="erro";
			break;
		}
        //短信接口URL提交地址
        String url = "短信接口URL提交地址";
 
        Map<String, String> params = new HashMap<String, String>();
 
        params.put("zh", "用户账号");
        params.put("mm", "用户密码");
        params.put("dxlbid", "短信类别编号");
        params.put("extno", "扩展编号");
 
        //手机号码，多个号码使用英文逗号进行分割
        params.put("hm", phones);
        //将短信内容进行URLEncoder编码
        params.put("nr", URLEncoder.encode(message));
       
        return code;
    }
 
    /**
     * 随机生成6位随机验证码
      * 方法说明
      * @Discription:扩展说明
      * @return
      * @return String
      * @Author: feizi
      * @Date: 2015年4月17日 下午7:19:02
      * @ModifyUser：feizi
      * @ModifyDate: 2015年4月17日 下午7:19:02
     */
    public static String createRandomVcode(){
        //验证码
        String vcode = "";
        for (int i = 0; i < 6; i++) {
            vcode = vcode + (int)(Math.random() * 9);
        }
        System.out.println("您的验证码位"+vcode);
        return vcode;
    }
    
    
 
    /**
     * 测试
      * 方法说明
      * @Discription:扩展说明
      * @param args
      * @return void
      * @Author: feizi
      * @Date: 2015年4月17日 下午7:26:36
      * @ModifyUser：feizi
      * @ModifyDate: 2015年4月17日 下午7:26:36
     */
    public static void main(String[] args) {
    // System.out.println(SendMsgUtil.createRandomVcode());
     //System.out.println(&ecb=12.substring(1));
    	int aa=Integer.parseInt("001");
    	System.out.println(aa);
        System.out.println("尊敬的用户，您的验证码为 "+ SendMsgUtil.createRandomVcode() + "有效期为60秒，如有疑虑请详询400-069-2886（客服电话）【XXX中心】");
    }
	
	
}
