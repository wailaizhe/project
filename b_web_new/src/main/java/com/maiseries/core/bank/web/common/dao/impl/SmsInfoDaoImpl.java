package com.maiseries.core.bank.web.common.dao.impl;
import com.jfinal.kit.StrKit;
import com.maiseries.core.bank.web.common.dao.SmsInfoDao;
import com.maiseries.core.bank.web.common.model.SmsInfo;
public class SmsInfoDaoImpl  implements SmsInfoDao {
    private SmsInfo dao=new SmsInfo().dao();
	public boolean addSmsInfo(SmsInfo smsInfo) {
		return smsInfo.setSmsId(StrKit.getRandomUUID()).save();
	}
	/**
	 * 删除或修改操作
	 */
	public boolean updateSmsInfo(SmsInfo smsInfo) {
		
		return smsInfo.update();
	}
	
	public SmsInfo querySmsInfo(String smsInfoId) {
		
		return dao.findById(smsInfoId);
	}
}
