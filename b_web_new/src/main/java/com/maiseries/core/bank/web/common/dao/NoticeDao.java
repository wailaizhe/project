package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.maiseries.core.bank.web.common.base.dao.CommonDao;
import com.maiseries.core.bank.web.common.model.SysNotice;

public interface NoticeDao extends CommonDao<SysNotice, Integer>{
	List queryIndexList();
}
