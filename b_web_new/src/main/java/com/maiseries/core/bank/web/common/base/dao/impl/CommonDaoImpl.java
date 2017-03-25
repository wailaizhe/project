package com.maiseries.core.bank.web.common.base.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.math.BigInteger;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.eclipse.jetty.server.session.JDBCSessionManager.Session;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.util.CollectionUtils;

import com.maiseries.core.bank.web.common.base.dao.CommonDao;
import com.maiseries.core.bank.web.common.model.domain.Page;
import com.maiseries.core.bank.web.common.model.domain.PagerContext;
import com.maiseries.core.bank.web.common.model.domain.Pagex;


public class CommonDaoImpl<T, ID extends Serializable> implements CommonDao<T, ID> {
    
	public ID add(T entity) {
		// TODO Auto-generated method stub
		return null;
	}

	public Serializable addReturn(T entity) {
		// TODO Auto-generated method stub
		return null;
	}

	public void delete(T entity) {
		// TODO Auto-generated method stub
		
	}

	public void update(T entity) {
		// TODO Auto-generated method stub
		
	}

	public void saveOrUpdate(T entity) {
		// TODO Auto-generated method stub
		
	}

	public T get(Class c, Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	public T load(Class c, Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	public void deleteLogic(String entityClassName, String ids) {
		// TODO Auto-generated method stub
		
	}

	public T findObject(String hql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<T> findList(String hql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page findPage(String hql, Integer pageNumber, Integer pageSize, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page findPage(String hql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<T> findAllDataListBy(String hql, Object[] params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page findPapeList(String hql, Object[] params, int start, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page findExtPage(String hql, Integer start, Integer limit, Object... params) {
		return null;
	}

	public Page findExtPage(String hql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Pagex findPagex(String hql, String start, String limit, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Integer count(String hql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public void doHql(String hql, Object... params) {
		// TODO Auto-generated method stub
		
	}

	public void doBatchSql(List sqlGroup) {
		// TODO Auto-generated method stub
		
	}

	public void doHql(String hql) {
		// TODO Auto-generated method stub
		
	}

	public void doSql(String hql) {
		// TODO Auto-generated method stub
		
	}

	public List<Map<?, ?>> findListBySql(String sql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Map<String, Object>> findMapListBySql(String sql, String[] altas, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Map<?, ?>> findListBySqlUser7(String sql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public void doSql(String sql, Object... params) {
		// TODO Auto-generated method stub
		
	}

	public List executeSqlQuery(String sql) {
		// TODO Auto-generated method stub
		return null;
	}

	public List executeSqlQuery(String sql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public int executeSqlCount(String sql) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Page findExtPageBySql(String sql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page findExtPageBySql(String sql, Integer pageNumber, Integer limit, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public void jdbcInsert(String sql) {
		// TODO Auto-generated method stub
		
	}

	public List jdbcQuery(String sql, Object... objects) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page findExtPageByComplexSql(String sql, Integer pageNumber, Integer limit, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public int jdbcFindCount(String sql, Object... object) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<?> pageList(String hql, int start, int limit, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public Long pageCount(String hql, Object[] objects) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<T> findObjectsBySql(String sql) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object findByHql(String hql, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	public void flush() {
		// TODO Auto-generated method stub
		
	}
	
}
