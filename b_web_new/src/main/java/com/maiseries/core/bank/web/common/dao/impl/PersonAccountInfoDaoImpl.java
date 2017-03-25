package com.maiseries.core.bank.web.common.dao.impl;
import java.util.List;

import com.jfinal.kit.StrKit;
import com.maiseries.core.bank.web.common.dao.PersonAccountInfoDao;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;

public class PersonAccountInfoDaoImpl  implements PersonAccountInfoDao{

	private PersonAccountInfo dao=new PersonAccountInfo().dao();
	private final String TABLE="t_person_account_info";
	public boolean addPersonAccountInfo(PersonAccountInfo personAccountInfo) {
		
		return personAccountInfo.setID(StrKit.getRandomUUID()).save();
	}

	public boolean deletePersonAccountInfo(String id) {
		return dao.deleteById(id);
	}
    /*
     * (non-Javadoc)未测试
     * @see com.maiseries.core.bank.web.common.dao.PersonAccountInfoDao#queryPersonAccountInfo(java.lang.String, java.lang.String)
     */
	public PersonAccountInfo queryPersonAccountInfo(String id, String baseInfoId) {
		return dao.findById(TABLE,"id","fk_base_info_id",id,baseInfoId);
	}

	public List<PersonAccountInfo> queryAllPersonAccountInfos(String baseInfoId) {
        String sql="select * from "+TABLE+" where fk_base_info_id=?  order by binding_time desc";
		return dao.find(sql,baseInfoId);
	}
	
}
