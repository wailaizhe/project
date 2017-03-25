package com.maiseries.core.bank.web.common.model.domain;

import java.util.List;

@SuppressWarnings("rawtypes")
public class Pagex {

	/**
	 * 是否执行成功
	 */
	private Boolean success = new Boolean(false);

	/**
	 * 总记录数
	 */
	private Integer results = 0;

	/**
	 * 当前页
	 */
	private Integer pageNumber = 1;

	/**
	 * 每页显示记录数
	 */
	private Integer pageSize = 10;

	/**
	 * 总页数
	 */
	@SuppressWarnings("unused")
	private Integer totalPage = 0;

	/**
	 * 数据
	 */
	private List rows = null;

	/**
	 * 提示信息
	 */
	private String msg;

	public Boolean getSuccess() {
		return this.success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public Integer getResults() {
		return results;
	}

	public void setResults(Integer results) {
		this.results = results;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getTotalPage() {
		return results % pageSize == 0 ? results / pageSize : results
				/ pageSize + 1;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

	public Integer getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}
