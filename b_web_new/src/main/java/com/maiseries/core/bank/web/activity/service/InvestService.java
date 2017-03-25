package com.maiseries.core.bank.web.activity.service;

import java.util.Map;

import code.main.invest.entity.Invest;
import code.main.invest.entity.Loan;

public interface InvestService {
	/*
	 * 添加投资意向成功
	 */
	void saveInvestInfo(Invest invest);
	
	/***
	 * @TODO 根据id查询出对象 并转成json格式
	 * @author yangdongxu
	 * @date Aug 4, 2015 12:02:10 PM
	 * @version 版本号码
	 */
	public Loan queryLoanToLoan2(String id);
	
	/**
	 * @TODO 修改数据
	 * @author yangdongxu
	 * @date Aug 4, 2015 12:21:10 PM
	 * @version 版本号码
	 */
	public void updateLoan(Loan loan);
	//根据ID查找贷款
	Loan queryLoanById(String loanId);
	//保存loan对象
	Map saveLoanInfo(Loan loan);
	
	//保存申请人基本信息
	void saveInformation(Loan loan);
	
	//修改loan对象
	public Map modifyLoanInfo(Loan loan);

	//得到编号
	public String  queryReqNumber();

	
	public Loan queryLoanByUser(String userId);
	
	/**
	 * @author yangdongxu
	 * @date Dec 14, 2015 10:18:28 AM
	 * @version 版本号码
	 * @TODO 根据前台传入数据 修改
	 */
	public void updateInformationByLoan(Loan oldLoan,Loan newLoan);
	
	/**
	 * @author yangdongxu
	 * @date Dec 14, 2015 11:06:09 AM
	 * @version 版本号码
	 * @TODO 设置贷款编号
	 */
	public Loan setLoanReqNumber(Loan oldLoan);

}