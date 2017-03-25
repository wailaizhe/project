package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.InvestDao;
import com.maiseries.core.bank.web.common.model.InvestIntentInfo;

@Repository("InvestDao")
public class InvestDaoImpl extends CommonDaoImpl<InvestIntentInfo, Integer> implements InvestDao {

}
