package com.maiseries.core.bank.web.common.dao.impl;
import org.springframework.stereotype.Repository;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.AccountDao;

@Repository("AccountDao")
public class AccountDaoImpl extends CommonDaoImpl<BaseInfo,Integer> implements AccountDao{
	
}
