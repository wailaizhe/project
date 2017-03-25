package com.maiseries.core.bank.web.common.dao;

import java.util.List;

import com.maiseries.core.bank.web.common.model.PersonAccountInfo;

public interface PersonAccountInfoDao {
	/**
	 * 添加银行卡
	 */
	 boolean addPersonAccountInfo (PersonAccountInfo personAccountInfo);
	 /**
	  * 删除银行卡
	  * @param id
	  * @return
	  */
	 boolean deletePersonAccountInfo(String id);
	 /**
	  * 根据用户的ID与银行卡ID查询绑定的银行卡
	  * @param id
	  * @return
	  */
	 PersonAccountInfo queryPersonAccountInfo(String id,String baseInfoId);
	 /**
	  * 查询用户绑定的所有银行卡号
	  * @param baseInfoId
	  * @return
	  */
	 public List<PersonAccountInfo> queryAllPersonAccountInfos(String baseInfoId);
	
}
