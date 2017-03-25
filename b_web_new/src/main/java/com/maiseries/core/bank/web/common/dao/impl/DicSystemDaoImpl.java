package com.maiseries.core.bank.web.common.dao.impl;

import java.util.List;

import com.maiseries.core.bank.web.common.dao.DicSystemDao;
import com.maiseries.core.bank.web.common.model.DicSystem;

public class DicSystemDaoImpl implements DicSystemDao{
	private DicSystem dao=new DicSystem().dao();

	@Override
	public List<DicSystem> queryBanks() {
		 String sql="select * from t_dic_system where  big_type='banks' and type='bankName' and (remark is null or remark='')  ORDER BY statue desc  ";
		return dao.find(sql);
	}

}
