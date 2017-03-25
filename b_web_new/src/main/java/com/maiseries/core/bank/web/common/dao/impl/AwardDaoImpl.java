package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.AwardDao;
import com.maiseries.core.bank.web.common.model.AwardInfo;

@Repository("awardDao")
public class AwardDaoImpl extends CommonDaoImpl<AwardInfo,Integer> implements AwardDao {

}
