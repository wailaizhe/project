package com.maiseries.core.bank.web.activity.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.maiseries.core.bank.web.common.model.SysNotice;
import com.maiseries.core.bank.web.common.model.domain.Page;

public interface NoticeService {
	
	/**
	 * 查询首页公告
	 * @return
	 */
	List queryIndexList();
	
	/**
	 * 查询公告列表
	 */
	Page queryNoticeList(JSONObject jsonObj);
	
	/**
	 * 根据id查询某一公告具体内容
	 * @return
	 */
	SysNotice queryNoticeById(String id);
}
