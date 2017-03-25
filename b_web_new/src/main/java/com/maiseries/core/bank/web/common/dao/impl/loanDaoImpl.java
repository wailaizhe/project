package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.loanDao;
import com.maiseries.core.bank.web.common.model.LoanIntentInfo;

@Repository("loanDao")
public class loanDaoImpl extends CommonDaoImpl<LoanIntentInfo, Integer> implements loanDao {

}
