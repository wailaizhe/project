package com.maiseries.core.bank.web.activity.service;

import java.util.List;

import code.main.base.entity.ContactNumber;
 

public interface ContactNumberService {
    
	@SuppressWarnings("rawtypes")
	List<ContactNumber> queryContactNumber(String locationCity,String accountType);
}