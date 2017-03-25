package com.maiseries.core.bank.web.account.service;

import java.util.List;

import com.maiseries.core.bank.web.common.model.DicRegion;

public interface AccountService {
	 List<DicRegion> getTopLevelRegion();
	 List<DicRegion> getCitys(String pcode);
	 

}
