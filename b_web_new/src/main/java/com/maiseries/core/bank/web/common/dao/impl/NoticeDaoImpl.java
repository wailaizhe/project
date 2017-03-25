package com.maiseries.core.bank.web.common.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.NoticeDao;
import com.maiseries.core.bank.web.common.model.SysNotice;


@Repository("noticeDao")
public class NoticeDaoImpl extends CommonDaoImpl<SysNotice, Integer> implements NoticeDao {

	public List queryIndexList() {
		return null;
	}



	
}
