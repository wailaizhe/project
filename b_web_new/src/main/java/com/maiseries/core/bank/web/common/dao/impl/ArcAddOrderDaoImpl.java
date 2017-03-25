package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.ArcAddOrderDao;
import com.maiseries.core.bank.web.common.model.OrderInfo;

@Repository("arcAddOrderDao")
public class ArcAddOrderDaoImpl extends CommonDaoImpl<OrderInfo, Integer>
		implements ArcAddOrderDao {
}
