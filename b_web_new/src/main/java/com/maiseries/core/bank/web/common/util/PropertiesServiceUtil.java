package com.maiseries.core.bank.web.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesServiceUtil {

	public static Properties props = new Properties();

	// private static Logger logger = Logger.getLogger(PropertiesUtil.class);

	public static void load(String path) {
		InputStream in = PropertiesServiceUtil.class.getClassLoader()
				.getResourceAsStream(path);
		try {
			props.load(in);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public static String getValue(String key) {
		// 根据指定key值获取value
		load("system_config.properties");
		return props.getProperty(key);
	}
}
