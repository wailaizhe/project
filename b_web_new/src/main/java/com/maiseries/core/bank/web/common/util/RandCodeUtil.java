package com.maiseries.core.bank.web.common.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RandCodeUtil {
	private static Logger log = LoggerFactory.getLogger(RandCodeUtil.class);
	
	public static void verifyCode(HttpServletRequest request, HttpServletResponse response) {
		int width = 195;//验证码图片的宽度。
		int height = 26;//验证码图片的高度。
		int codeCount = 4;//验证码字符个数
		int xx = 0;
		int fontHeight;//字体高度
		int codeY;
		char[] codeSequence = { 
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K',  
				'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
				'W', 'X', 'Y', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 
				'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't',
				'u', 'v', 'w', 'x', 'y', '3', '4', '5', '6', '7',
				'8', '9' };
        xx = width / (codeCount+1);  
        fontHeight = height - 2;  
        codeY = height - 5;  
        
       // 定义图像buffer  
        BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);  
        Graphics2D gd = buffImg.createGraphics();  
 
        // 创建一个随机数生成器类  
        Random random = new Random();  
 
        // 将图像填充为白色  
        gd.setColor(Color.WHITE);  
        gd.fillRect(0, 0, width, height);  
 
        // 创建字体，字体的大小应该根据图片的高度来定。  
        //备选字体   
        String[] fontTypes = {"tahoma","Atlantic Inline","fantasy","Times New Roman","Georgia","Arial", "Helvetica", "sans-serif","System"};   
        int fontTypesLength = fontTypes.length;  
        Font font = new Font(fontTypes[random.nextInt(fontTypesLength)],Font.BOLD,fontHeight);  
        // 设置字体。  
        gd.setFont(font);  
 
        // 画边框。  
        //gd.setColor(Color.gray);  
        //gd.drawRect(0, 0, width - 1, height - 1);  
 
        // 随机产生160条干扰线，使图象中的认证码不易被其它程序探测到。  
//        gd.setColor(Color.black);  
//        for (int i = 0; i <10; i++) {  
//            int x = random.nextInt(width);  
//            int y = random.nextInt(height);  
//            int xl = random.nextInt(12);  
//            int yl = random.nextInt(12);  
//            gd.drawLine(x, y, x + xl, y + yl);  
//        }  
        
        // 随机产生5条干扰线
//        gd.setColor(Color.BLUE);
//        for (int i = 0; i < 5; i++) {
//          int x = random.nextInt(width);
//          int y = random.nextInt(height);
//          gd.drawOval(x, y, width, height);
//        }
        //随即产生100个干扰点，是图象中的验证码不易被其他分析程序探测到
        gd.setColor(Color.red);
        for (int i = 0; i < 100; i++) {
          int x = random.nextInt(width);
          int y = random.nextInt(height);
          gd.drawOval(x, y, 0, 0);
        }
 
        // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。  
        StringBuffer randomCode = new StringBuffer();  
        int red = 0, green = 0, blue = 0;  
 
        // 随机产生codeCount数字的验证码。  
        for (int i = 0; i < codeCount; i++) {  
            // 得到随机产生的验证码数字。  
            String strRand = String.valueOf(codeSequence[random.nextInt(52)]);  
            // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。  
            red = random.nextInt(255);  
            green = random.nextInt(255);  
            blue = random.nextInt(255);  
 
            // 用随机产生的颜色将验证码绘制到图像中。  
            gd.setColor(new Color(red, green, blue));  
            gd.drawString(strRand, (i + 1) * xx, codeY);  
 
            // 将产生的四个随机数组合在一起。  
            randomCode.append(strRand);  
        }  
        // 将四位数字的验证码保存到Session中。  
        HttpSession session = request.getSession();  
        log.info("验证码："+randomCode.toString());
        session.setAttribute("randCode", randomCode.toString());  
 
        // 禁止图像缓存。  
        response.setHeader("Pragma", "no-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);  
        response.setContentType("image/jpeg");  
 
        // 将图像输出到Servlet输出流中。  
        ServletOutputStream sos;
		try {
			sos = response.getOutputStream();
			ImageIO.write(buffImg, "jpeg", sos);  
			sos.close();  
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
