package com.maiseries.core.bank.web.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

public class IPUtil {

	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (ip.equals("0:0:0:0:0:0:0:1")) {
			InetAddress inet;
			try {
				inet = InetAddress.getLocalHost();
				ip = inet.getHostAddress();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
		}
		return ip;
	}
    // 运行速度【快】  
	  public static String getMAC() {  
	      String mac = null;  
	      try {  
	          Process pro = Runtime.getRuntime().exec("cmd.exe /c ipconfig/all");  

	          InputStream is = pro.getInputStream();  
	          BufferedReader br = new BufferedReader(new InputStreamReader(is));  
	          String message = br.readLine();  

	          int index = -1;  
	          while (message != null) {  
//	              if ((index = message.indexOf("Physical Address")) > 0) {  
//	                  mac = message.substring(index + 36).trim();  
//	                  break;  
//	              }  
	        	  System.out.println(message);
	              message = br.readLine();  
	          }  
	          br.close();  
	          pro.destroy();  
	      } catch (IOException e) {  
	          System.out.println("Can't get mac address!");  
	          return null;  
	      }  
	      return mac;  
	  }  
	// 运行速度【慢】  
	   public static String getMAC(String ip) {  
	       String str = null;  
	       String macAddress = null;  
	       try {  
	           Process p = Runtime.getRuntime().exec("nbtstat -A " + ip);  
	           InputStreamReader ir = new InputStreamReader(p.getInputStream());  
	           LineNumberReader input = new LineNumberReader(ir);  
	           for (; true;) {  
	               str = input.readLine();  
	               if (str != null) {  
	                   if (str.indexOf("MAC Address") > 1) {  
	                       macAddress = str  
	                               .substring(str.indexOf("MAC Address") + 14);  
	                       break;  
	                   }  
	               }  
	           }  
	       } catch (IOException e) {  
	           e.printStackTrace(System.out);  
	           return null;  
	       }  
	       return macAddress;  
	   }  
	public static void main(String[] args) {
		getMAC();
	}
}
