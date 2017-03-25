package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.ArcAddaccountDao;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;

@Repository("arcAddaccountDao")
public class ArcAddaccountDaoImpl extends CommonDaoImpl<PersonAccountInfo, Integer> implements ArcAddaccountDao{

}


