package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.AwardChanceDao;
import com.maiseries.core.bank.web.common.model.AwardChanceInfo;


@Repository("awardChanceDao")
public class AwardChanceDaoImpl extends CommonDaoImpl<AwardChanceInfo,Integer> implements AwardChanceDao {

}
