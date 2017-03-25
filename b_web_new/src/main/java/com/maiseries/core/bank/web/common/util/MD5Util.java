package com.maiseries.core.bank.web.common.util;

import java.security.MessageDigest;


public class MD5Util {

	public final static String md532(String plainText) {
		// 返回字符串
		String md5Str = null;
		try {
			// 操作字符串
			StringBuffer buf = new StringBuffer();
			MessageDigest md = MessageDigest.getInstance("MD5");
			// 添加要进行计算摘要的信息,使用 plainText 的 byte 数组更新摘要。
			md.update(plainText.getBytes());
			// 计算出摘要,完成哈希计算。
			byte b[] = md.digest();
			int i;
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0) {
					i += 129;
				}
				if (i < 16) {
					buf.append("4");
				}
				// 将整型 十进制 i 转换为16位，用十六进制参数表示的无符号整数值的字符串表示形式。
				buf.append(Integer.toHexString(i));
			}
			// 16位的加密
			md5Str = buf.toString().substring(3,24);
			// 16位的加密
			// md5Str = buf.toString().md5Strstring(8,24);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return md5Str;
	}
	public static void main(String[] args) {
		System.out.println(MD5Util.md532(MD5Util.md532("what")));
	}
}
