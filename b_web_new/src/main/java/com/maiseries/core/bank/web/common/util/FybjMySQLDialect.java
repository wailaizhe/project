package com.maiseries.core.bank.web.common.util;

import org.hibernate.Hibernate;
import org.hibernate.dialect.MySQLDialect;
import org.hibernate.dialect.function.SQLFunctionTemplate;
/**
 * 注册HQL中的MySQL函数
 * HQL不能支持的MySQL函数，可以在这里进行注册
 * @author 牛智红
 *
 */
public 	class FybjMySQLDialect extends MySQLDialect {

	   public FybjMySQLDialect() {
	      super();
	      registerFunction( "date_add_inteval", new SQLFunctionTemplate( Hibernate.DATE, "date_add(?1, INTERVAL ?2 ?3)" ));
	      registerFunction( "date_sub_inteval", new SQLFunctionTemplate( Hibernate.DATE, "date_sub(?1, INTERVAL ?2 ?3)" ));
	   }	   
	}
