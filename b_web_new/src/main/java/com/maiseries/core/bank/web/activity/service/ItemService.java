package com.maiseries.core.bank.web.activity.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONObject;
import code.main.base.domain.Page;
import code.main.item.entity.Item;

public interface ItemService {
	
	/**
	 * 查询总交易金额和为投资人赚取的利益
	 */
	Map getTotalAndBenifit();
	
	/**
	 * 用户登录时查询交易金额和收益
	 */
	Map getPersonTatalBenefit(String phoneNo);
	
	/**
	 * 查询并修改总交易金额（定时）
	 */
	String queryTotalTradeMount();
	
	/**
	 * 查询并插入首页投资记录所需要的数据（定时）
	 */
	void queryAndInsertInvestRecord();
	
	/**
	 *查询首页滚动投资记录 
	 */
	List queryIndexInvestRecScroll();
	
	/**
	 * 查询首页项目列表
	 */
	Page queryIndexItem(JSONObject jsonObj);
	
	/**
	 * 查询所有项目信息
	 */
	Page queryItemByTmpl(JSONObject jsonObj);
	
	/**
	 * 为投资人赚取的收益
	 */
	String queryTotalBenefit();
	
	/**
	 * 查询登录用户总的交易金额
	 * @param userId
	 * @return
	 */
	String queryUserTotalInvestMoney(String userId);
	
	/**
	 * 查询登录用户总的收益
	 * @param userId
	 * @return
	 */
	String queryUserTotalBenefitMoney(String userId);
	
	/**
	 * 查询项目的当前投资额度
	 * @return
	 */
	String queryCrrentIteminvestMount(String itemId);
	
	/**
	 * 计算日期来判断项目的状态
	 * @return
	 */
	Map<String,String> caculateItemStatus(String itemId);
	
	/**
	 * 利率计算公式
	 * @param days  投资天数
	 * @param mount 投资金额
	 * @param rate  年化利率
	 * @return
	 */
	BigDecimal formulaBenifit(long days,BigDecimal investMount,BigDecimal rate);
	
	/**
	 * 查询单个项目
	 */
	public Item queryItem(String itemId);

	/**
	 * 保存意见反馈
	 * @param suggCon 意见
	 * @param suggEmail 邮箱
	 * @param date 日期
	 * @param subIP 提交IP
	 * @return
	 */
	String saveSugg(String suggCon, String suggEmail,String  date,String subIP);
}
