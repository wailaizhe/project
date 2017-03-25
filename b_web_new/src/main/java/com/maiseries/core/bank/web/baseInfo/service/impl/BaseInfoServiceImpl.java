package com.maiseries.core.bank.web.baseInfo.service.impl;
import java.util.List;

import com.jfinal.kit.StrKit;
import com.maiseries.core.bank.web.baseInfo.service.BaseInfoService;
import com.maiseries.core.bank.web.common.dao.BaseInfoDao;
import com.maiseries.core.bank.web.common.dao.DicSystemDao;
import com.maiseries.core.bank.web.common.dao.MessageContentDao;
import com.maiseries.core.bank.web.common.dao.PersonAccountInfoDao;
import com.maiseries.core.bank.web.common.dao.SmsInfoDao;
import com.maiseries.core.bank.web.common.dao.impl.BaseInfoDaoImpl;
import com.maiseries.core.bank.web.common.dao.impl.DicSystemDaoImpl;
import com.maiseries.core.bank.web.common.dao.impl.MessageContentDaoImpl;
import com.maiseries.core.bank.web.common.dao.impl.PersonAccountInfoDaoImpl;
import com.maiseries.core.bank.web.common.dao.impl.SmsInfoDaoImpl;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.DicSystem;
import com.maiseries.core.bank.web.common.model.MessageContent;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;
import com.maiseries.core.bank.web.common.model.SmsInfo;

public class BaseInfoServiceImpl implements BaseInfoService {
    private  BaseInfoDao baseInfoDao=new BaseInfoDaoImpl();
    private  PersonAccountInfoDao personAccountInfoDao=new PersonAccountInfoDaoImpl();
    private MessageContentDao messageContentDao=new MessageContentDaoImpl();
    private SmsInfoDao smsInfoDao=new SmsInfoDaoImpl();
    private DicSystemDao dicSystemDao=new DicSystemDaoImpl();
    private final boolean TRUE=true ;
    private final boolean FALSE=false ;
    private BaseInfo baseInfo ;
	public BaseInfo checkBaseInfo(String phone, String password) {
		baseInfo=baseInfoDao.checkBaseInfo(phone, password);
		return baseInfo;
	}
	public boolean findBaseInfoByPhone(String phone)  {
		baseInfo=baseInfoDao.findBaseInfoByPhone(phone);
		if(baseInfo!=null){
			return  FALSE;
		}
		return TRUE;
	}
	public void addBaseInfo(BaseInfo baseInfo) {
		baseInfoDao.addBaseInfo(baseInfo);
	}
	public BaseInfo queryBaseInfoById(String baseInfoId) {
		return baseInfoDao.queryBaseInfoById(baseInfoId);
	}
	public boolean addBankAccount(PersonAccountInfo personAccountInfo) {
		return personAccountInfoDao.addPersonAccountInfo(personAccountInfo);
	}
	public boolean deleteBankAccount(String id) {
		return personAccountInfoDao.deletePersonAccountInfo(id);
	}
	
	public boolean addMessageContent(MessageContent messageContent) {
		return messageContentDao.addMessageContent(messageContent);
	}
	public List<MessageContent> queryMessageContents(String baseInfoId) {
		String sql="select * from t_message_content  where baseinfo_id = ? and  state='1' order by creat_date desc";
		
		return messageContentDao.queryMessageContents(sql,baseInfoId);
	}
	public PersonAccountInfo queryBank(String id, String baseInfoId) {
		return personAccountInfoDao.queryPersonAccountInfo(id, baseInfoId);
	}
	public List<PersonAccountInfo> queryAllPersonAccountInfos(String baseInfoId) {
		return personAccountInfoDao.queryAllPersonAccountInfos(baseInfoId);
	}
	public boolean addSmsInfo(SmsInfo smsInfo) {
		return smsInfoDao.addSmsInfo(smsInfo);
	}
	public SmsInfo querySmsInfo(String smsInfoId) {
		
		return smsInfoDao.querySmsInfo(smsInfoId);
	}
	
	public boolean updateBaseInfo(BaseInfo baseInfo) {
		return baseInfoDao.updateBaseInfo(baseInfo);
	}
	
	public List<DicSystem> queryBank() {
		
		return dicSystemDao.queryBanks();
	}
	

}
