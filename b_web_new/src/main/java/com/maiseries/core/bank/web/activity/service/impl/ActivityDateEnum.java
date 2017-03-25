package com.maiseries.core.bank.web.activity.service.impl;

public enum ActivityDateEnum {
		
		START("活动开始时间","2016-09-15 00:00:00"),
		END("活动结束时间","2016-10-15 00:00:00");
		
		
		String name_cn;
		String value;
		
		
		ActivityDateEnum(String name_cn,String code) {
			this.name_cn = name_cn;
			this.value = code;
		}
		
		public String getName() {
			return name_cn;
		}


		public String getValue() {
			return value;
		}
}
