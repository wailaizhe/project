package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.UsedAwardDao;
import com.maiseries.core.bank.web.common.model.UsedAwardInfo;


@Repository("usedAwardDao")
public class UsedAwardDaoImpl extends CommonDaoImpl<UsedAwardInfo,Integer> implements UsedAwardDao {

}
