package com.maiseries.core.bank.web.activity.service;

import java.util.List;
import java.util.Map;

import code.main.archive.entity.BaseInfo;

public interface RewardService {
	
	/**
     * 查询当前用户的投资额度从而判断用户可以抽取的奖项等级
     */
	String queryUserGrade(String userId);
	/**
	 * 获得抽奖机会
	 */
	Map addAwardChance(String baseInfoId,String itemId,String isUsed);

	
	/**
	 * @author yangdongxu
	 * @date Feb 17, 2016 3:12:06 PM
	 * @version 版本号码
	 * @TODO 查询该用户的可抽奖次数
	 */
	public int queryUserAwardChance(String userId);

	
	/**
	 * 查询当前项目投资时判断抽奖次数表中有没有增加一条记录
	 */
	String queryIsInvest(String userId,String itemId);
	
	/**
	 * 使用抽奖机会进行抽奖 将抽奖数据保存至抽奖表
	 */
	String saveAwardInfo(String baseInfoId,String rank,String totalCoinNum,String randomMath,String moblicPhone);
	
	/**
	 * 查询今天抽取的所有类型奖项的个数
	 */
	Map queryPrizeCount();
	
	
	/**
	 * 砸蛋 抽奖
	 */
	 String smashingEggs(BaseInfo baseInfo);
	
	/**
	 * @author yangdongxu
	 * @date Feb 17, 2016 4:17:18 PM
	 * @version 版本号码
	 * @TODO 查询用户当前可用金币
	 */
	 int queryUserCoin(String userId,String serialNumber);
    
	
	/**
	 * 查询前20条抽取的金币数
	 */
	List queryGoldSize();
	
	/**
	 * 查询金蛋被砸开次数
	 */
	int queryEggsSize();
	
	
	/**
	 * 查询当前用户投资的项目是否已经增加抽奖机会
	 */
	String queryItemLuckyDraw(String userId,String itemId);
	
	/**
	 * 查询有效期内可以抵用的金币数和插入投资抵扣金币
	 */
	String queryAndSaveGold(String userId,String orderId,int diKou);
	
	/**
	 * 查询砸金蛋活动是否开启
	 */
	public  String isOnGoldenEgg();
	
	/**
	 * 根据项目id和投资金额计算金币数
	 * @param itemId
	 * @param capital
	 * @return
	 */
	public int calCoinCount(String itemId,String capital);
	
}

