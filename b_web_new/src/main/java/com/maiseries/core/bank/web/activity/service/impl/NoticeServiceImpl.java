package com.maiseries.core.bank.web.activity.service.impl;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.alibaba.fastjson.JSONObject;
import com.maiseries.core.bank.web.activity.service.NoticeService;
import com.maiseries.core.bank.web.common.dao.NoticeDao;
import com.maiseries.core.bank.web.common.model.SysNotice;
import com.maiseries.core.bank.web.common.model.domain.Page;

public class NoticeServiceImpl implements NoticeService{
	private static Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);
	private NoticeDao noticeDao;
	
	/**
	 * 查询首页公告列表
	 */
	public List queryIndexList() {
		String hql = " from SysNotice as n where n.isDel=? order by n.createDate desc ";
		List resultList = null;
		Page page = null;
		try{
			page = noticeDao.findExtPage(hql, 0, 5, "02");
			if(null != page){
				resultList = page.getDatas();
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(NoticeServiceImpl.class.toString(),e);
		}
		return resultList;
	}
	
	/**
	 * 根据id查询某一公告具体内容
	 */
	public SysNotice queryNoticeById(String id) {
		SysNotice n = null;
		try{
			n = noticeDao.findObject("from Notice where id=?", id);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(NoticeServiceImpl.class.toString(),e);
		}
		return n;
	}

	/**
	 * 查询公告页公告列表
	 */
	public Page queryNoticeList(JSONObject jsonObj) {
		StringBuffer hql = new StringBuffer("from Notice n where isDel=? order by createDate desc ");
		Object[] queryParams = {"02"};
		Page page = null;
		try {
			//分页信息
			int pageIndex = jsonObj.getInteger("PageIndex");
			int pageSize = jsonObj.getInteger("PageSize");
			page = noticeDao.findPapeList(hql.toString(),queryParams,pageIndex,pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(NoticeServiceImpl.class.toString(),e);
		}
		return page;
	}

	

}
