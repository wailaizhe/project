package com.maiseries.core.bank.web.activity.service.impl;

import java.math.BigDecimal;
import java.util.List;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import code.main.archive.entity.BaseInfo;
import code.main.base.dao.DicSystemDao;
import code.main.base.entity.DicSystem;
import code.main.base.util.DateTimeUtils;
import code.main.base.util.PropertiesServiceUtil;
import code.main.base.util.FxStringUtil;
import code.main.base.util.LuckDrawClass;
import code.main.item.entity.Item;
import code.main.item.service.ItemService;
import code.main.order.dao.ArcOrderDao;
import code.main.order.service.ArcOrderService;
import code.main.reward.ctl.AwardCtl;
import code.main.reward.dao.AwardChanceDao;
import code.main.reward.dao.AwardDao;
import code.main.reward.dao.UsedAwardDao;
import code.main.reward.entity.Award;
import code.main.reward.entity.AwardChance;
import code.main.reward.entity.UsedAward;
import code.main.reward.service.RewardService;

@Transactional
@Service("rewardService")
public class RewardServiceImpl implements RewardService{
	
	@Resource
	private OrderDao arcOrderDao;
	@Resource
	protected AwardChanceDao awardChanceDao;
	@Resource
	protected AwardDao awardDao;
	@Resource
	protected UsedAwardDao usedAwardDao;
	
	@Resource
	private DicSystemDao dicSystemDao;
	@Resource
	private ItemService itemService;
	
	private static Logger log = (Logger) LoggerFactory.getLogger(RewardServiceImpl.class);
    
	
	/**
	 * 获得抽奖机会
	 */
	@Override
	public Map addAwardChance(String baseInfoId, String itemId,String isUsed) {
		Map map = new HashMap();
		try {
			AwardChance ac = new AwardChance();
			ac.setFkBaseInfoId(baseInfoId);
			ac.setFkItemId(itemId);
			ac.setCreateTime(DateTimeUtils.getCurrentDateTime());
			ac.setClientType("PC");
			ac.setIsUsed(isUsed);
			awardChanceDao.saveOrUpdate(ac);
			map.put("chance", "ok");
		} catch (Exception e) {
			map.put("chance", "err");
			e.printStackTrace();
			log.error(RewardServiceImpl.class.toString(), e);
		}
		return map;
	}
	
	
	/**
     * 查询当前用户的投资额度从而判断用户可以抽取的奖项等级
     */
	public String queryUserGrade(String userId){
		// 01 一等奖 特等奖（支付金额累计大于5万元） 02 二等奖 支付金额大于等于3万元小于5万元  03 三等奖  小于三万元可抽 04四等奖没有进行过投资行为
		String grade = "04";
		try{
			StringBuffer sql = new StringBuffer("SELECT IFNULL( SUM( CAST(K.CAPITAL AS DECIMAL(20, 2))), 0.00 ) CAPITAL FROM t_order_info K WHERE K.FK_BASE_INFO_ID =?  AND ( K.PAY_STATUS = '01' OR K.PAY_STATUS = '06' OR K.PAY_STATUS = '10')");
			String sql2="SELECT  COUNT(RANK) FROM t_award_info WHERE DATE(CREATE_TIME) = CURDATE() AND  FK_BASE_INFO_ID='"+userId+"' AND RANK <>'5' ";
			int goSm  =awardDao.executeSqlCount(sql2); //查询当前用户今天是否抽中奖项
			List list = arcOrderDao.jdbcQuery(sql.toString(),userId);
			Map map =(Map) list.get(0);
			BigDecimal big= new BigDecimal(map.get("capital").toString());
			BigDecimal jibie5 = new BigDecimal(50000);
			BigDecimal jibie3 = new BigDecimal(30000);
			if(goSm<=0){
				if(big.compareTo(jibie5)>=0){ // 一等奖或特等奖
					grade="01";
				}else if(big.compareTo(jibie5)==-1&&big.compareTo(jibie3)==1){  //二等奖
					grade="02";
				}else if(big.compareTo(new BigDecimal(0))>1&&big.compareTo(jibie3)==-1){ // 三等奖
					grade="03";
				}else{
					grade="04";
				}
			}else{
				grade="05";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return grade;
	}

	
	/**
	 * @author yangdongxu
	 * @date Feb 17, 2016 3:12:06 PM
	 * @version 版本号码
	 * @TODO 查询该用户的可抽奖次数
	 */
	public int queryUserAwardChance(String userId){
		int result=0;
		try{
			
			String startTimeID=PropertiesServiceUtil.getValue("startTimeID");//		
			String endTimeID=PropertiesServiceUtil.getValue("endTimeID");//
			//开始时间   石亚宁不明白startTimeID与endTimeID这两个值为什么是定值
			DicSystem startTimeDicSystem=dicSystemDao.load(DicSystem.class, startTimeID);
			DicSystem endTimeDicSystem=dicSystemDao.load(DicSystem.class, endTimeID);
			
			String goldenEggStart=startTimeDicSystem.getText();
			String goldenEggEnd=endTimeDicSystem.getText();
			//查询的拥有的所有抽奖机会
			StringBuffer haveSql = new StringBuffer("select  IFNULL(FORMAT(COUNT(is_used), 0),0) as num,is_used from t_award_chance_info t ");
			haveSql.append(" where t.fk_base_info_id=? AND t.is_used='02' AND t.create_time>=? AND t.create_time<=? ");
			List<Map> haveList = arcOrderDao.jdbcQuery(haveSql.toString(),userId,goldenEggStart,goldenEggEnd);
			int haveChange=Integer.parseInt(haveList.get(0).get("num").toString().replace(",", ""));
			
			//查询使用过的抽奖机会
			StringBuffer usedSql = new StringBuffer("select IFNULL(FORMAT(COUNT(is_used), 0),0) as num,is_used from t_award_chance_info t ");
			usedSql.append(" where t.fk_base_info_id=? AND t.is_used='01' AND t.create_time>=? AND t.create_time<=?  ");
			List<Map> usedList = arcOrderDao.jdbcQuery(usedSql.toString(),userId,goldenEggStart,goldenEggEnd);
			int usedChange=Integer.parseInt(usedList.get(0).get("num").toString().replace(",", ""));
			
			result=haveChange-usedChange;
			result = (result<=0)?0:result;
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return result;
	}
	

	
	/**
	 *查询当前项目投资时判断抽奖次数表中有没有增加一条记录 01已有记录 02没有记录
	 */
	public String queryIsInvest(String userId,String itemId){
		String isInvest = "02";
		try{
			String sql="select id from t_award_chance_info k where k.fk_base_info_id=? and fk_item_id=? ";
			List list =awardChanceDao.executeSqlQuery(sql, userId,itemId);
			if(list.size()>=0){
				isInvest="01";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return isInvest;
	};
	
	
	/**
	 * 使用抽奖机会进行抽奖 将抽奖数据保存至抽奖表
	 * isOK 02数据插入失败 01数据插入成功
	 */
	public String saveAwardInfo(String baseInfoId,String rank,String totalCoinNum,String randomMath,String moblicPhone) {
		String isOK="02";
		try{
			Award award = new Award();
		    award.setClientType("PC"); //客户端类型
		    award.setCreateTime(DateTimeUtils.getCurrentDateTime()); //创建时间
		    award.setFkBaseInfoId(baseInfoId); //用户ID
		    award.setRank(rank); //中奖等级
		    award.setTotalCoinNum(totalCoinNum); //随机金币数
		    award.setInvalidTime(DateTimeUtils.parseDate2(DateTimeUtils.timeToString2(new Date(DateTimeUtils.getCurrentDateTime().getTime()+60000*60*24*90L)))); //过期时间 90+
		    award.setRandomMath(randomMath); //随机数字
		    award.setMoblicPhone(moblicPhone);
		    awardDao.add(award);
		    isOK="01";
		}catch(Exception ex){
			isOK="02";
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
	    return isOK;
	};
	
	/**
	 * 查询今天抽取的所有类型奖项的个数
	 */
	public Map queryPrizeCount() {
		Map map = new HashMap();
		try {
			 String sql="SELECT RANK,COUNT(RANK) SIZE FROM t_award_info WHERE DATE(CREATE_TIME) = CURDATE() GROUP BY RANK ";
			 List list = awardDao.findListBySql(sql);
			 if(list.size()>0){
				   Map map2 = null;
				   for(int i=0,l=list.size();i<l;i++){
					   map2=(Map) list.get(i);
					   map.put(map2.get("rank"), map2.get("SIZE"));
				   }
			 }
		}catch (Exception e) {
			e.printStackTrace();
			log.error(RewardServiceImpl.class.toString(), e);
		}
		return map;
	}
   
	
	
	/**
	 * 砸蛋 抽奖
	 */
	public  String smashingEggs(BaseInfo baseInfo){
		String random=null;
		try{
			
			int grandPrize=0;
			int onePrize=0;
			int twoPrize=0;
			int threePrize=0;
			int fourPrize=0;
			int frequency  =this.queryUserAwardChance(baseInfo.getId());
			if(frequency>=1&&baseInfo!=null){  //该用户还有可用的抽奖机会
					Map numberAwards = this.queryPrizeCount(); // 查询当天已被抽取奖项个数
					String grade = this.queryUserGrade(baseInfo.getId()); //查询当前用户可抽取的等级
					
					if(numberAwards.get("0")!=null&&!FxStringUtil.isNullOrEmpty(numberAwards.get("0").toString())){ //获取特等奖已抽取的个数
						grandPrize=Integer.valueOf(numberAwards.get("0").toString());
					}
					if(numberAwards.get("1")!=null&&!FxStringUtil.isNullOrEmpty(numberAwards.get("1").toString())){//获取一等奖已抽取的个数
						onePrize=Integer.valueOf(numberAwards.get("1").toString());
					}
					if(numberAwards.get("2")!=null&&!FxStringUtil.isNullOrEmpty(numberAwards.get("2").toString())){//获取二等奖已抽取的个数
						twoPrize=Integer.valueOf(numberAwards.get("2").toString());
					}
					if(numberAwards.get("3")!=null&&!FxStringUtil.isNullOrEmpty(numberAwards.get("3").toString())){//获取三等奖已抽取的个数
						threePrize=Integer.valueOf(numberAwards.get("3").toString());
					}
					if(numberAwards.get("4")!=null&&!FxStringUtil.isNullOrEmpty(numberAwards.get("4").toString())){//获取四等奖已抽取的个数
						fourPrize=Integer.valueOf(numberAwards.get("4").toString());
					}
					String llk = LuckDrawClass.luckDraw(grandPrize, onePrize, twoPrize, threePrize, fourPrize, grade); // 开始抽奖
					String[] aa = llk.split("_");//切割字符串
					this.saveAwardInfo(baseInfo.getId(), aa[0], aa[1], aa[2],baseInfo.getMobilePhone()); // 抽取奖项保存抽奖数据
					this.addAwardChance(baseInfo.getId(), "", "01"); // 使用抽奖机会增加一条记录
					random=aa[0]+"_"+aa[1];
			}else{
				random="-1_-1";  //该用户的抽奖机会已用完
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(AwardCtl.class.toString(), ex);
		}
		return random;
	}
	
	/**
	 * @author yangdongxu
	 * @date Feb 17, 2016 4:17:18 PM
	 * @version 版本号码
	 * @TODO 查询用户当前可用金币
	 */
	public int queryUserCoin(String userId,String serialNumber){
		int result=0;
		try{
			//得到有效期内可用金币
			StringBuffer sumSql = new StringBuffer("SELECT IFNULL(SUM(T.total_coin_num),0) NUM FROM t_award_info T ");
			sumSql.append(" WHERE T.fk_base_info_id=? AND T.invalid_time>=NOW() ");
			int sumCoin = arcOrderDao.jdbcFindCount(sumSql.toString(),userId);
			
			//得到有效期内抵用金币
			StringBuffer usedSql = new StringBuffer("SELECT IFNULL(SUM(T.used_coin_num),0) NUM FROM t_used_award_info T");
			usedSql.append(" WHERE T.fk_base_info_id=? AND T.invalid_time>=NOW() AND is_valid='02' ");
			int usedCoin = arcOrderDao.jdbcFindCount(usedSql.toString(),userId);
			
			//得到冻结金币数
			int freezeCoin=queryUserFreezeCoin(userId,serialNumber);
			
			result=sumCoin-usedCoin-freezeCoin;
			result = result<=0?0:result;
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return result;
	}
	
	/**
	 * 查询前20条抽取的金币数
	 */
	public List queryGoldSize(){
		List<Award> award = new ArrayList<Award>();
		try{
			String sql=" from Award where rank <>'5' and  totalCoinNum <>'0' order by createTime desc";
			List<Award> list = (List<Award>) awardDao.pageList(sql, 0, 20);
			Award award1= null;
			for(Award a:list){
				award1= new Award();
				String mB=a.getMoblicPhone();
				award1.setMoblicPhone(mB.substring(0,3)+"****"+ mB.substring(9,mB.length()));
				award1.setTotalCoinNum(a.getTotalCoinNum());
				award1.setCreateDate(DateTimeUtils.timeToString2(a.getCreateTime()));
				award.add(award1);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return  award;
	}
	
	/**
	 * 查询金蛋被砸开次数
	 */
	public int queryEggsSize(){
		int aa=0;
		try{
			String sql="select count(1) from t_award_info";
			aa  =awardDao.executeSqlCount(sql);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return  aa;
	}
	
	
	/**
	 * 查询当前用户投资的项目是否已经增加抽奖机会 01未增加 02已增加
	 */
	public String queryItemLuckyDraw(String userId,String itemId){
		String isDraw="01";
		try{
			String sql="select count(1) from t_award_chance_info where fk_base_info_id='"+userId+"' and fk_item_id='"+itemId+"' ";
			int aa = awardDao.executeSqlCount(sql);
			if(aa>0){
			   isDraw="02";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return  isDraw;
	}
	
	/**
	 * 查询有效期内可以抵用的金币数和插入投资抵扣金币
	 */
	public String queryAndSaveGold(String userId,String orderId,int diKou){
		String isDraw="01";
		try{
			String hql="SELECT id,invalid_time,total_coin_num from t_award_info where id NOT in (select t.id from t_used_award_info k ,t_award_info t where k.fk_base_info_id=? and k.fk_award_id=t.id  and total_coin_num=used_coin_num) and invalid_time>=NOW() and rank<>'5' and total_coin_num<>'0' and fk_base_info_id=? order by create_time asc ";
			String hql2="SELECT sum(used_coin_num) as used_coin_num from t_used_award_info k where fk_award_id=? and fk_base_info_id=? "; // 查询当前抽奖金币使用的和
			List list = awardDao.findListBySql(hql, userId,userId);
			int dikou =diKou; // 抵扣金币数
			for(int j=0,l=list.size();j<l;j++){
				Map map =(Map) list.get(j);
				List ls = usedAwardDao.findListBySql(hql2, map.get("id"),userId);
				Map map44= (Map) ls.get(0);
				String used_coin_num =null;
				if(null==map44.get("used_coin_num")||""==map44.get("used_coin_num")){
					used_coin_num="0";
				}else{
					used_coin_num=String.valueOf(Double.valueOf(map44.get("used_coin_num").toString()).intValue()); //已经抵扣金币数
				}
				if("0".equals(used_coin_num)){ // 判断使用金币数是否等于单条获取金币数
					int coinNum = Integer.valueOf(map.get("total_coin_num").toString()); // 单条抽奖金币数
					if(dikou-coinNum>0){
						this.addUsedAward(userId, DateTimeUtils.parseDate2(map.get("invalid_time").toString()), String.valueOf(coinNum), orderId, map.get("id").toString());
						dikou=dikou-coinNum;    // 进行下一个循环
						continue;
					}else if(dikou-coinNum==0){ // 终止循环
						this.addUsedAward(userId, DateTimeUtils.parseDate2(map.get("invalid_time").toString()), String.valueOf(coinNum), orderId, map.get("id").toString());
						break;
					}else if(dikou-coinNum<0){  // 如果抵扣金币大于存量金币
						this.addUsedAward(userId, DateTimeUtils.parseDate2(map.get("invalid_time").toString()), String.valueOf(dikou), orderId, map.get("id").toString());
						break;
					}
				}else if(!map.get("total_coin_num").toString().equals(used_coin_num)){
					int coinNum = Integer.valueOf(map.get("total_coin_num").toString()); //抽中最大金币 47 - 14（33） - 54  21
					int usedCoin = Integer.valueOf(used_coin_num);    //已抵扣最大金币 111
					if(coinNum-usedCoin-dikou>=0){ //12
						this.addUsedAward(userId, DateTimeUtils.parseDate2(map.get("invalid_time").toString()), String.valueOf(dikou), orderId, map.get("id").toString());
						// dikou=dikou-(coinNum-usedCoin);    // 进行下一个循环
						break;
					}else if(coinNum-usedCoin<dikou){
						this.addUsedAward(userId, DateTimeUtils.parseDate2(map.get("invalid_time").toString()), String.valueOf(coinNum-usedCoin), orderId, map.get("id").toString());
						dikou=dikou-(coinNum-usedCoin);    // 进行下一个循环
						continue;
					}
					// System.out.print(dikou);
				}else if(map.get("total_coin_num").toString()==used_coin_num){
					continue;
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return  isDraw;
	}
	
	/**
	 * 保存已抵扣的金币奖励
	 */
	public Map addUsedAward(String baseInfoId, Date invalidTime,String usedCoinNum,String orderId,String fkAwardId) {
		Map map = new HashMap();
		try {
			UsedAward ua =new UsedAward();
			ua.setCreateTime(DateTimeUtils.getCurrentDateTime()); //创建时间
			ua.setFkBaseInfoId(baseInfoId); //用户iD
            ua.setFkOrderId(orderId); //订单ID
            ua.setFkAwardId(fkAwardId);//关联金币id
            ua.setIsValid("02"); // 使用状态
            ua.setUsedCoinNum(usedCoinNum); //使用金币数
            ua.setInvalidTime(invalidTime); //过期时间
            ua.setClientType("PC");
            usedAwardDao.saveOrUpdate(ua);
            usedAwardDao.flush();
            map.put("chance", "ok");
		} catch (Exception e) {
			map.put("chance", "err");
			e.printStackTrace();
			log.error(RewardServiceImpl.class.toString(), e);
		}
		return map;
	}
	
	public static void main(String[] args) {
		String aa="4.0";
		System.err.println(Double.valueOf(aa).intValue());
	}
	
	
	/**
	 * @author yangdongxu
	 * @date Feb 17, 2016 4:17:18 PM
	 * @version 版本号码
	 * @TODO 查询用户冻结金币数
	 */
	public int queryUserFreezeCoin(String userId,String serialNumber){
		int result=0;
		try{
			//得到冻结金币数 未支付订单抵用金币为冻结 未支付订单 5.5分钟之内为冻结
			StringBuffer sumSql = new StringBuffer(" SELECT IFNULL(FORMAT(SUM(O.DEDUCTION_FEE),0),0) NUM FROM t_order_info O, t_sms_info S ");
			sumSql.append(" WHERE S.FK_ORDER_INFO_SERIAL_NUMBER = O.SERIAL_NUMBER AND O.FK_BASE_INFO_ID = ?  AND ((TO_SECONDS(NOW()) - TO_SECONDS(S.SEND_TIME) < 330 AND O.PAY_STATUS='02') OR O.PAY_STATUS='07')");
			if(!FxStringUtil.isNullOrEmpty(serialNumber)){
				sumSql.append(" AND O.SERIAL_NUMBER <> ?");
				result = arcOrderDao.jdbcFindCount(sumSql.toString(),userId,serialNumber);
			}else{
				result = arcOrderDao.jdbcFindCount(sumSql.toString(),userId);
			}
			
			//StringBuffer sqlBuffer=new StringBuffer(" SELECT IFNULL( FORMAT(SUM(O.DEDUCTION_FEE), 0), 0 ) NUM FROM t_order_info O WHERE O.FK_BASE_INFO_ID =? AND O.pay_type = '01' AND TO_SECONDS(NOW()) - TO_SECONDS(O.create_date) < 600 ");
			
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),ex);
		}
		return result;
	}
	
	
	
	public  String isOnGoldenEgg(){
		String  result="false";
	try{
		String startTimeID=PropertiesServiceUtil.getValue("startTimeID");//		
		String endTimeID=PropertiesServiceUtil.getValue("endTimeID");//
		//开始时间
		DicSystem startTimeDicSystem=dicSystemDao.load(DicSystem.class, startTimeID);
		DicSystem endTimeDicSystem=dicSystemDao.load(DicSystem.class, endTimeID);
		
		String goldenEggStart=startTimeDicSystem.getText().replace("/", "-");
		String goldenEggEnd=endTimeDicSystem.getText().replace("/", "-");
		//活动开始时间
		Date startTime=DateTimeUtils.parseDate2(goldenEggStart);
		//活动结束时间
		Date endTime=DateTimeUtils.parseDate2(goldenEggEnd);
		Date nowTime=new Date();
		Long startL=startTime.getTime();
		Long endL=endTime.getTime();
		Long nowL=nowTime.getTime();
		if(startL<=nowL&&nowL<=endL){
			result= "true";
		}else if(startL>nowL){
			result= "before";//活动未开始
		}else if(nowL>endL){
			result= "after";//活动已经结束
		}
	}catch(Exception ex){
		ex.printStackTrace();
		log.error(RewardServiceImpl.class.toString(),ex);
	}
	return result;

	}

	/**
	 * 根据项目id和投资金额计算金币数
	 * @param itemId  项目id
	 * @param capital 投资金额
	 * @return
	 */
	@Override
	public int calCoinCount(String itemId, String capital) {
		int coinCount = 0;
		try{
			Item item = itemService.queryItem(itemId);
			BigDecimal subBankYearRate = item.getSubBankYearRate();
			BigDecimal days = item.getFinancePeriod();
			BigDecimal income = itemService.formulaBenifit(days.longValue(), new BigDecimal(capital), subBankYearRate);
			double temp = income.doubleValue()*10;
			//income = income.setScale(0, BigDecimal.ROUND_DOWN);
			BigDecimal big = new BigDecimal(temp);
			big = big.setScale(0, BigDecimal.ROUND_DOWN);
			coinCount = big.intValue();
			//coinCount = incomeI*10;
		}catch(Exception e){
			e.printStackTrace();
			log.error(RewardServiceImpl.class.toString(),e);
		}
		return coinCount;
	}
	
}
