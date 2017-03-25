package com.maiseries.core.bank.web.common.base.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.maiseries.core.bank.web.common.model.domain.Page;
import com.maiseries.core.bank.web.common.model.domain.Pagex;


public interface CommonDao<T, ID extends Serializable> {
	static final Integer STATE_ENABLE = 0;

	/*
	 * modify by jimhan 20141206 返回生成的记录主键
	 */
	public ID add(T entity);

	public Serializable addReturn(T entity);

	public void delete(T entity);

	public void update(T entity);

	public void saveOrUpdate(T entity);

	@SuppressWarnings("rawtypes")
	public T get(Class c, Serializable id);

	@SuppressWarnings("rawtypes")
	public T load(Class c, Serializable id);

	/**
	 * 逻辑删除实体对象
	 * 
	 * @param entityClassName
	 *            实体对象类名
	 * @param ids
	 *            对象主键集合
	 */
	public void deleteLogic(String entityClassName, String ids);

	public T findObject(final String hql, final Object... params);

	public List<T> findList(final String hql, final Object... params);

	public Page findPage(final String hql, final Integer pageNumber,
			final Integer pageSize, final Object... params);

	public Page findPage(String hql, Object... params);

	/**
	 * 
	 * 方法说明：查询全部对象记录
	 *
	 * @param hql
	 * @param params
	 * @return
	 */
	public List<T> findAllDataListBy(String hql, Object[] params);
	/**
	 * 支持分页查询
	 * @param hql
	 * @param params
	 * @param start
	 * @param limit
	 * @return
	 */
	public Page findPapeList(String hql, Object[] params,int start, int limit);

	public Page findExtPage(final String hql, final Integer start,
			final Integer limit, final Object... params);

	public Page findExtPage(final String hql, final Object... params);

	public Pagex findPagex(final String hql, String start, String limit,
			final Object... params);

	public Integer count(final String hql, final Object... params);

	public void doHql(final String hql, final Object... params);
	
	public void doBatchSql(final List sqlGroup);

	public void doHql(final String hql);

	public void doSql(final String hql);

	public List<Map<?, ?>> findListBySql(final String sql,
			final Object... params);

	/**
	 * 
	 * 方法说明：sql查询返回Map结果集合
	 *
	 * @param sql
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> findMapListBySql(final String sql,
			final String[] altas, final Object... params);

	public List<Map<?, ?>> findListBySqlUser7(final String sql,
			final Object... params);

	public void doSql(final String sql, final Object... params);

	@SuppressWarnings("rawtypes")
	public List executeSqlQuery(final String sql);
    
	@SuppressWarnings("rawtypes")
	public List executeSqlQuery(final String sql,Object... params);
	
	public int executeSqlCount(final String sql);

	public Page findExtPageBySql(final String sql, Object... params);

	public Page findExtPageBySql(final String sql, final Integer pageNumber,
			final Integer limit, final Object... params);


	public void jdbcInsert(final String sql);

	@SuppressWarnings("rawtypes")
	public List jdbcQuery(final String sql, final Object... objects);

	/**
	 * 复杂sql分页接口
	 */
	public Page findExtPageByComplexSql(final String sql, final Integer pageNumber,
			final Integer limit, final Object... params);
	
	public int jdbcFindCount(String sql, final Object... object);

	public List<?> pageList(final String hql, int start, int limit,
			final Object... params);

	public Long pageCount(String hql, final Object[] objects);

	public List<T> findObjectsBySql(final String sql);

	public Object findByHql(final String hql, final Object... params);

	public void flush();
}
