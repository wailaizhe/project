package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.ArcPersonDao;
import com.maiseries.core.bank.web.common.model.ArcPerson;


@Repository("arcPersonDao")
public class ArcPersonDaoImpl extends CommonDaoImpl<ArcPerson, Integer> implements ArcPersonDao{

}
