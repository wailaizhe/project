package com.maiseries.core.bank.web.activity.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import code.main.base.util.FxStringUtil;
import code.main.base.util.JsonUtil;
import code.main.invest.dao.InvestDao;
import code.main.invest.dao.loanDao;
import code.main.invest.entity.Invest;
import code.main.invest.entity.Loan;
import code.main.invest.service.InvestService;
import code.main.item.service.impl.ItemServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fengx.com.AesDataTools;

@Service("InvestService")
@Transactional
public class InvestServiceImpl implements InvestService {
	private static Logger logger = LoggerFactory.getLogger(InvestServiceImpl.class);
	@Resource(name = "InvestDao")
	private InvestDao investDao;
	
	@Resource(name = "loanDao")
	private loanDao loanDao;

	@Override
	public void saveInvestInfo(Invest invest) {
		try {
			investDao.saveOrUpdate(invest);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}

	}

	
	@Override
	public Loan queryLoanToLoan2(String id) {
		String hql="   from   Loan t where  t.id=? ";
		Loan loan=null;
		try {
		 loan= (Loan)loanDao.findByHql(hql, id);
		 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
		return loan;
	//	return jsonUtil.objToJsonStr(loan);
	
	}


	@Override
	public void updateLoan(Loan loan) {

		try {
			loanDao.saveOrUpdate(loan);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}

	
	}
	
	
	
	@Override
	public Map saveLoanInfo(Loan loan) {
		Map map = new  HashMap();
		try {
			loanDao.saveOrUpdate(loan);
			map.put("msg", "ok");
			map.put("loanId",loan.getId());
		}catch(Exception e){
			map.put("msg", "err");
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
		return map;
	}
	
	@Override
	public Loan queryLoanById(String loanId) {
		Loan loan = null;
		try{
			String hql = " from Loan where 1=1 and id=? ";
			List queryParams = new ArrayList();
			queryParams.add(loanId);
			loan = loanDao.findObject(hql.toString(), queryParams.toArray());
		}catch(Exception e){
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
		return loan;
	}
	
	/**
	 * 保存申请人基本信息
	 * @param bookID
	 * @return
	 */
	@Override
	public void saveInformation(Loan loan) {
		try {
			loanDao.saveOrUpdate(loan);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
	}
	/**
	 * @author yangdongxu
	 * @date Dec 14, 2015 10:18:28 AM
	 * @version 版本号码
	 * @TODO 根据前台传入数据 修改
	 */
	public void updateInformationByLoan(Loan oldLoan,Loan loan) {
		try {
			AesDataTools tools = new AesDataTools();
			oldLoan.setName(loan.getName());
			oldLoan.setSex(loan.getSex());
			oldLoan.setPhoneNumber(loan.getPhoneNumber());
			oldLoan.setEmail(loan.getEmail());
			oldLoan.setIdNumber(loan.getIdNumber());
			oldLoan.setNationality("01");//国籍--默认中国
			oldLoan.setEducation(loan.getEducation());
			oldLoan.setLiveAddress(loan.getLiveAddress());
			oldLoan.setIdType("01");//证件--默认身份证
			oldLoan.setMaritalStatus(loan.getMaritalStatus());
			oldLoan.setStatus("01");
			oldLoan.setEnterpriseName(loan.getEnterpriseName());
			if(FxStringUtil.isNullOrEmpty(loan.getRegistrationNumber())==false ){
				oldLoan.setRegistrationNumber(tools.encode(loan.getRegistrationNumber()));
			}
			oldLoan.setLegalPersonName(loan.getLegalPersonName());
			oldLoan.setCompanyActualAddres(loan.getCompanyActualAddres());
			oldLoan.setEnterpriseType(loan.getEnterpriseType());
			oldLoan.setRegistrationAddres(loan.getRegistrationAddres());
			if(FxStringUtil.isNullOrEmpty(loan.getLegalIdentityCard())==false){
				oldLoan.setLegalIdentityCard(tools.encode(loan.getLegalIdentityCard()));
			}
			loanDao.saveOrUpdate(oldLoan);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
	}
	
	@Override
	public Map modifyLoanInfo(Loan loan) {
		Map map = new HashMap();
		String loanId = loan.getId();
		try{
			Loan m_loan = loanDao.findObject("from Loan where id=?", loanId);
			m_loan.setName(loan.getName());
			m_loan.setPhoneNumber(loan.getPhoneNumber());
			m_loan.setSex(loan.getSex());
			m_loan.setAge(loan.getAge());
			m_loan.setType(loan.getType());
			m_loan.setLiveCity(loan.getLiveCity());
			m_loan.setLiveTime(loan.getLiveTime());
			map.put("msg", "ok");
			map.put("loanId",m_loan.getId());
		}catch(Exception e){
			map.put("msg", "err");
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
		return map;
	}

	
	public String  queryReqNumber() {
		Date nowdate = new Date();
		DateFormat format = new SimpleDateFormat("yyyy");
		String nowYear = format.format(nowdate);
		List itemList = null;
		try {
			//String hql = "select t.reqNumber from Loan  t where t.reqNumber like '%'||?||'%'  ORDER BY t.reqNumber DESC";
			//String hql="select  t.reqNumber from Loan  t where t.reqNumber like '%'||?||'%'  ORDER BY SUBSTR(replace(t.reqNumber,?,'')  FROM 5 )+0 DESC ";
			List paramsList=new ArrayList();
			paramsList.add("DK");
			paramsList.add("DK");
			String sql="select  t.req_number from t_loan_intent_info  t where t.req_number like '%'||?||'%'  ORDER BY SUBSTR(replace(t.req_number,?,'')  FROM 1 )+0 DESC ";
			itemList=loanDao.findListBySql(sql,paramsList.toArray());
			//itemList = loanDao.findList(hql, paramsList.toArray());
			if (itemList != null && itemList.size() > 0) {
				Map map=(Map)itemList.get(0);
				String itemName = map.get("req_number").toString();
				itemName=itemName.replace("DK", "");
				//截取出最大编号
				String code = itemName.substring(4);
				String oldYear = itemName.substring(0,4);//取年份出来跟当前年份比较
				int newCode = Integer.parseInt(code) +1 ;
				if(nowYear.equals(oldYear)){
					if (newCode < 10) {
						return "DK" + nowYear + "0000" + newCode;
					} else if (newCode > 9 && newCode < 100) {
						return "DK" + nowYear + "000" + newCode;
					} else if (newCode > 99 && newCode < 1000) {
						return  "DK" +nowYear+ "00" + newCode;
					}else if(newCode > 999 && newCode < 10000)
					{
						return  "DK" +nowYear+ "0" + newCode;
					}
					else {
						return  "DK" + nowYear + newCode;
					}
				}else{
					return  "DK" + nowYear + "0001";
				}
			} else {
				return "DK" + nowYear + "0001";
			}
		} catch (Exception e) {
			logger.error(InvestServiceImpl.class.toString(),e);
			e.printStackTrace();
		}
		return "";
	}

	
	@Override
	public Loan queryLoanByUser(String userId) {
		Loan loan = null;
		try{
			String hql = " from Loan where 1=1 and createUser=? and status = '01' ";
			List queryParams = new ArrayList();
			queryParams.add(userId);
			loan = loanDao.findObject(hql.toString(), queryParams.toArray());
		}catch(Exception e){
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
		return loan;
	}

	/**
	 * @author yangdongxu
	 * @date Dec 14, 2015 11:06:09 AM
	 * @version 版本号码
	 * @TODO 设置贷款编号
	 */
	@Override
	public Loan setLoanReqNumber(Loan loan){
		try {
			//生成申请编号
			if(FxStringUtil.isNullOrEmpty(loan.getReqNumber())==true){
				String number=this.queryReqNumber();
				if(FxStringUtil.isNullOrEmpty(number)==true){
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					loan.setReqNumber("DK"+c.get(Calendar.YEAR)+"00001");
					this.updateLoan(loan);
				}else{
					loan.setReqNumber(number);
					this.updateLoan(loan);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(InvestServiceImpl.class.toString(),e);
		}
		return loan;
	}
	
}