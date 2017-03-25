package com.maiseries.core.bank.web.activity.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import code.main.base.dao.ContactNumberDao;
import code.main.base.entity.ContactNumber;
import code.main.base.service.ContactNumberService;

@Service("contactNumberService")
@Transactional
public class ContactNumberServiceImpl implements ContactNumberService {

	@Resource(name = "contactNumberDao")
	private ContactNumberDao contactNumberDao;
	
	@Override
	public List<ContactNumber> queryContactNumber(String locationCity,String accountType) {
	       String hql="from ContactNumber where locationCity=? and accountType=? order by id ";
		   return contactNumberDao.findList(hql, locationCity,accountType);
	}
	
	
}
