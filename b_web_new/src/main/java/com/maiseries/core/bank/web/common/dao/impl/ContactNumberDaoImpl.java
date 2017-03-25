package com.maiseries.core.bank.web.common.dao.impl;

import org.springframework.stereotype.Repository;

import com.maiseries.core.bank.web.common.base.dao.impl.CommonDaoImpl;
import com.maiseries.core.bank.web.common.dao.ContactNumberDao;
import com.maiseries.core.bank.web.common.model.ContactNumber;

@Repository("contactNumberDao")
public class ContactNumberDaoImpl extends CommonDaoImpl<ContactNumber, Integer> implements ContactNumberDao{

}
