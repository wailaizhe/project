package com.maiseries.core.bank.web.account.service.impl;

import java.util.List;

import com.maiseries.core.bank.web.account.service.AccountService;
import com.maiseries.core.bank.web.common.dao.AccountDao;
import com.maiseries.core.bank.web.common.dao.DicRegionDao;
import com.maiseries.core.bank.web.common.dao.impl.AccountDaoImpl;
import com.maiseries.core.bank.web.common.dao.impl.DicRegionDaoImpl;
import com.maiseries.core.bank.web.common.model.DicRegion;

public class AccountServiceImpl implements AccountService{
	private AccountDao accountDao=new AccountDaoImpl();
	private DicRegionDao dicReginDao=new DicRegionDaoImpl();

	@Override
	public List<DicRegion> getTopLevelRegion() {
		
		return dicReginDao.getTopLevelRegion();
	}

	@Override
	public List<DicRegion> getCitys(String pcode) {
		return dicReginDao.getCitys(pcode);
	}

	

	

}
