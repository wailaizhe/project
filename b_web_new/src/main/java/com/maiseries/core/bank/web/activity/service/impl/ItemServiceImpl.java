package com.maiseries.core.bank.web.activity.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.annotation.Resource;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import code.main.base.domain.Page;
import code.main.base.util.DateTimeUtils;
import code.main.item.dao.ItemDao;
import code.main.item.entity.Item;
import code.main.item.service.ItemService;
import code.main.order.dao.ArcOrderDao;
import code.main.order.service.ArcOrderService;

@Transactional
@Service("ItemService")
public class ItemServiceImpl implements ItemService{
	private static Logger logger = LoggerFactory.getLogger(ItemServiceImpl.class);
	@Resource(name="ItemDao")
	private ItemDao itemDao;
	@Resource(name = "arcOrderDao")
	private OrderDao arcOrderDao;
	@Resource(name = "arcOrderService")
	private ArcOrderService arcOrderService;
	/**
	 * 查询并修改总交易金额（定时）
	 * @return
	 */
	@Override
	public String queryTotalTradeMount() {
		String total = "0.00";
		try{
			total = (String)arcOrderDao.findByHql("select sum(ao.capital) From ArcOrder ao where payStatus=?","01");
			total = total == null ? "0.00" : total;
			String benifit = this.queryTotalBenefit();
			String delSql = "delete from t_money_summary ";
			arcOrderDao.doSql(delSql);
			UUID uuid = UUID.randomUUID();
			String uuidStr = uuid.toString().replaceAll("-", "");
			String insertSql = "insert into t_money_summary(id,count_total_money,count_total_benifit) value(?,?,?)";
			itemDao.doSql(insertSql,uuidStr,total,benifit);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return total;
	}

	/**
	 * 为投资人赚取的收益
	 */
	@Override
	public String queryTotalBenefit() {
		String shouyi = "0.00";
		try{
			String hql = "select sum(ao.income) as shouyi from ArcOrder ao where ao.payStatus=? ";
			shouyi = (String)arcOrderDao.findByHql(hql,"01");
			shouyi = shouyi == null ? "0.00" : shouyi;
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return shouyi;
	}
	
	/**
	 * 查询并插入首页投资记录所需要的数据（定时）
	 */
	@Override
	public void queryAndInsertInvestRecord() {
		try{
			String delSql = "delete from t_index_order; ";
			itemDao.doSql(delSql);
			String selSql = "select id,mobile_phone,capital,create_date,SYSDATE() from t_order_info where pay_status=? order by create_date desc ";
			Page page = itemDao.findExtPageBySql(selSql, 1, 20, "01");
			String sql1 = "insert into t_index_order (id,user_name,invest_amount,invest_date,create_date) value(?,?,?,?,?)";
			List list = page.getDatas();
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					Object[] temp = (Object[])list.get(i);
					itemDao.doSql(sql1, temp[0],temp[1],temp[2],temp[3],temp[4]);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
	}
	
	/**
	 * 查询总交易金额和为投资人赚取的利益
	 */
	@Override
	public Map getTotalAndBenifit(){
		Map<String,String> map = new HashMap<String,String>();
		String sql = "select count_total_money,count_total_benifit from t_money_summary";
		try{
			List list = itemDao.executeSqlQuery(sql);
			if(list != null && list.size()>0){
				Object[] temp = (Object[])list.get(0);
				String totalMoney = (String)temp[0];
				String totalBenefit = (String)temp[1];;
				if("".equals(totalMoney) || ""==totalMoney || null==totalMoney){
					totalMoney = "0.00";
					map.put("count_total_money", totalMoney);
				}else{
					map.put("count_total_money", totalMoney);
				}
				if("".equals(totalBenefit) || ""==totalBenefit || null==totalBenefit){
					totalBenefit = "0.00";
					map.put("count_total_benifit", totalBenefit);
				}else{
					map.put("count_total_benifit", totalBenefit);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return map;
	}
	
	/**
	 * 用户登录时查询交易金额和收益
	 */
	@Override
	public Map getPersonTatalBenefit(String phoneNo) {
		Map map = new HashMap();
		String total = "0.00";
		String shoyi = "0.00";
		Object[] obj = null;
		String hql = "select sum(ao.capital) as total,sum(income) as shouyi  from ArcOrder ao where ao.mobilePhone=? and ao.payStatus=?" ;
		try{
			obj = (Object[])arcOrderDao.findByHql(hql,phoneNo,"01");
			if(null!=obj){
				if(null==obj[0]){
					obj[0]="0.00";
				}
				if(null==obj[1]){
					obj[1]="0.00";
				}
				map.put("total", obj[0]);
				map.put("shouyi", obj[1]);
			}else{
				map.put("total", "0.00");
				map.put("shouyi", "0.00");
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
			map.put("total", "0.00");
			map.put("shouyi", "0.00");
		}
		return map;
	}
	
	/**
	 * 查询首页投资记录滚动信息
	 */
	@Override
	public List queryIndexInvestRecScroll() {
		String sql = "select user_name,invest_amount,invest_date from t_index_order";
		List list = null;
		try{
			list = itemDao.executeSqlQuery(sql);
			if(list!=null && list.size()>0){
				for(int i=0,l=list.size();i<l;i++){
					Object[] temp = (Object[])list.get(i);
					String phone = (String)temp[0];
					String phone1 = phone.substring(0, 3);
					String phone2 = phone.substring(7, 11);
					phone = phone1+"****"+phone2;
					temp[0] = phone;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return list;
	}
	
	/**
	 * 查询首页项目列表
	 */
	@Override
	public Page queryIndexItem(JSONObject jsonObj) {
		Page page = null;
		try {
			//分页信息
			page = this.queryItemByTmpl(jsonObj);
			List list = page.getDatas();
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					Object[] temp = (Object[])list.get(i);
					String itemId = (String)temp[0];
					Map m = caculateItemStatus(itemId);//计算项目状态
					String flag = (String)m.get("front");
					temp[10]=flag.split("-")[0];//状态
					temp[11]=flag.split("-")[1];//进度
					//temp[12]=DateTimeUtils.getCurrentDateTime();//服务器时间
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return page;
	}

	/**
	 *查询项目列表
	 */
	@Override
	public Page queryItemByTmpl(JSONObject jsonObj){
		Page page = null;
		try {
			//搜索条件
			String inter1 = "";
			String inter2 = "";
			String interest = jsonObj.getString("interest");
			if(!interest.isEmpty()){
				String[] interestArr = interest.split(",");
				inter1 = interestArr[0];
				inter2 = interestArr[1];
			}
			String duration = jsonObj.getString("duration");
			String dura1 = "";
			String dura2 = "";
			if(!duration.isEmpty()){
				String[] durationArr = duration.split(",");
				dura1 = durationArr[0];
				dura2 = durationArr[1];
			}
			
			String projectType = jsonObj.getString("projectType");
			//分页信息
			int pageIndex = jsonObj.getInt("PageIndex");
			int pageSize = jsonObj.getInt("PageSize"); 
			List params = new ArrayList();
			StringBuffer sql = new StringBuffer("SELECT * from (select " );	
			sql.append(" t1.id,t1.invest_start_date,t1.invest_end_date,t1.interest_start_date,t1.finance_end_date,t1.finance_period,t1.max_finance_money,");	
			sql.append("t1.invester_year_rate,t1.item_prefix,t1.item_name,t1.credit_card_end_date,t1.company_name,t1.special_flag,t1.min_invest_amount*t1.invest_unit_fee,");
			//sql.append("t1.create_prj_date,IFNULL(t1.is_new_exclusive,'02'),IFNULL(t1.white_flag,'02') FROM v_item_order t1 WHERE t1.item_approve_status = ?");
			sql.append("t1.create_prj_date,IFNULL(t1.is_new_exclusive,'02'),IFNULL(t1.white_flag,'02') FROM t_item_info t1 WHERE t1.item_approve_status = ?");
			sql.append(" AND t1.item_type= ? AND (NOW() BETWEEN t1.invest_start_date AND t1.invest_end_date) AND t1.full_flag <> ?");
			 params.add("07");
			 params.add("02");
			 params.add("01");
			 if(!interest.isEmpty()){
				 sql.append(" AND (t1.invester_year_rate BETWEEN ? AND ?) ");
				 params.add(inter1);
				 params.add(inter2);
			 }
			 if(!duration.isEmpty()){
				 sql.append(" AND t1.finance_period BETWEEN ? AND ? ");
				 params.add(dura1);
				 params.add(dura2);
			 }
			 if(!projectType.isEmpty()){
				 sql.append(" AND t1.special_flag = ? ");
				 params.add(projectType);
			 }
			 sql.append(" order by t1.invester_year_rate desc, t1.invest_start_date asc) as s1");
			 sql.append(" UNION select * from  (SELECT");
			 sql.append(" t2.id, t2.invest_start_date, t2.invest_end_date, t2.interest_start_date, t2.finance_end_date, t2.finance_period, t2.max_finance_money,");
			 sql.append(" t2.invester_year_rate, t2.item_prefix, t2.item_name, t2.credit_card_end_date, t2.company_name, t2.special_flag, t2.min_invest_amount*t2.invest_unit_fee,");
			// sql.append(" t2.create_prj_date, IFNULL(t2.is_new_exclusive,'02'), IFNULL(t2.white_flag,'02') FROM v_item_order t2 WHERE t2.item_approve_status = ? ");
			 sql.append(" t2.create_prj_date, IFNULL(t2.is_new_exclusive,'02'), IFNULL(t2.white_flag,'02') FROM t_item_info t2 WHERE t2.item_approve_status = ? ");
			 sql.append(" AND t2.item_type= ? AND NOW() < t2.invest_start_date");
			 params.add("07");
			 params.add("02");
			 if(!interest.isEmpty()){
				 sql.append(" AND (t2.invester_year_rate BETWEEN ? AND ?) ");
				 params.add(inter1);
				 params.add(inter2);
			 }
			 if(!duration.isEmpty()){
				 sql.append(" AND t2.finance_period BETWEEN ? AND ? ");
				 params.add(dura1);
				 params.add(dura2);
			 }
			 if(!projectType.isEmpty()){
				 sql.append(" AND t2.special_flag = ? ");
				 params.add(projectType);
			 }
			 sql.append(" order by t2.invest_start_date asc) as s2 ");
			 sql.append(" UNION select * from (SELECT");
			 sql.append(" t3.id, t3.invest_start_date, t3.invest_end_date, t3.interest_start_date, t3.finance_end_date, t3.finance_period, t3.max_finance_money,");
			 sql.append(" t3.invester_year_rate, t3.item_prefix, t3.item_name, t3.credit_card_end_date, t3.company_name, t3.special_flag, t3.min_invest_amount*t3.invest_unit_fee,");
//			 sql.append(" t3.create_prj_date, IFNULL(t3.is_new_exclusive,'02'), IFNULL(t3.white_flag,'02') FROM v_item_order t3 WHERE t3.item_approve_status = ?");
			 sql.append(" t3.create_prj_date, IFNULL(t3.is_new_exclusive,'02'), IFNULL(t3.white_flag,'02') FROM t_item_info t3 WHERE t3.item_approve_status = ?");
			 sql.append(" AND t3.item_type= ?  AND (( t3.full_flag = ? AND NOW() < t3.invest_end_date) OR ( NOW() BETWEEN t3.invest_end_date AND t3.interest_start_date))");
			 params.add("07");
			 params.add("02");
			 params.add("01");
			 if(!interest.isEmpty()){
				 sql.append(" AND (t3.invester_year_rate BETWEEN ? AND ?) ");
				 params.add(inter1);
				 params.add(inter2);
			 }
			 if(!duration.isEmpty()){
				 sql.append(" AND t3.finance_period BETWEEN ? AND ? ");
				 params.add(dura1);
				 params.add(dura2);
			 }
			 if(!projectType.isEmpty()){
				 sql.append(" AND t3.special_flag = ? ");
				 params.add(projectType);
			 }
			 sql.append(" order by t3.invest_end_date desc) as s3 ");
			 sql.append(" UNION select * from (SELECT");
			 sql.append(" t4.id, t4.invest_start_date, t4.invest_end_date, t4.interest_start_date, t4.finance_end_date, t4.finance_period, t4.max_finance_money,");
			 sql.append(" t4.invester_year_rate, t4.item_prefix, t4.item_name, t4.credit_card_end_date, t4.company_name, t4.special_flag, t4.min_invest_amount*t4.invest_unit_fee,");
			 //sql.append(" t4.create_prj_date, IFNULL(t4.is_new_exclusive,'02'), IFNULL(t4.white_flag,'02') FROM v_item_order t4 WHERE t4.item_approve_status = ? ");
			 sql.append(" t4.create_prj_date, IFNULL(t4.is_new_exclusive,'02'), IFNULL(t4.white_flag,'02') FROM t_item_info t4 WHERE t4.item_approve_status = ? ");
			 sql.append(" AND t4.item_type= ?  AND NOW() >= t4.interest_start_date");
			 params.add("07");
			 params.add("02");
			 if(!interest.isEmpty()){
				 sql.append(" AND (t4.invester_year_rate BETWEEN ? AND ?) ");
				 params.add(inter1);
				 params.add(inter2);
			 }
			 if(!duration.isEmpty()){
				 sql.append(" AND t4.finance_period BETWEEN ? AND ? ");
				 params.add(dura1);
				 params.add(dura2);
			 }
			 if(!projectType.isEmpty()){
				 sql.append(" AND t4.special_flag = ? ");
				 params.add(projectType);
			 }
			 sql.append(" order by t4.create_prj_date desc) as s4");
			 page = itemDao.findExtPageByComplexSql(sql.toString(), pageIndex, pageSize, params.toArray());
			 List list = page.getDatas();
			 if(list != null || list.size()>0){
				 for(int i=0;i<list.size();i++){
					 Object[] temp = (Object[])list.get(i);
					 String itemId = (String)temp[0];
					 Map m = caculateItemStatus(itemId);//计算项目状态
					 String flag = (String)m.get("front");
					 temp[10]=flag.split("-")[0];//状态
					 temp[11]=flag.split("-")[1];//进度
				 }
			 }
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return page;
	}

	/**
	 * 查询项目的当前投资额度
	 * @return
	 */
	@Override
	public String queryCrrentIteminvestMount(String itemId){
		String currentTatalMoney = "0.00";
		try {
			currentTatalMoney = arcOrderService.succe(itemId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return currentTatalMoney;
	}
	
	/**
	 * 查询单个项目
	 */
	@Override
	public Item queryItem(String itemId){
		String hql = " from Item where id= ? ";
		Item item = null;
		try{
			item = itemDao.findObject(hql, itemId);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return item;
	}
	
	/**
	 * @return
	 * 计算日期来判断项目的状态
	 * 返回一个Map 取key  前台map.get("front"),后台map.get("back")后：
	 * 值为一个字符串格式："01-50"  减号前的为项目状态，减号后的为融资进度的百分比
	 */
	private static BigDecimal one = new BigDecimal("1");
	private static BigDecimal bai = new BigDecimal("100");
	@Override
	public Map<String,String> caculateItemStatus(String itemId){
		Map<String, String> resultMap = new HashMap<String, String>();
		String itemStatus = "";// 项目状态
		String progressFront = "";// 项目进度百分比
		try {
			Long currentDateMill = System.currentTimeMillis();
			String currentInvestStr = this.queryCrrentIteminvestMount(itemId);// 查询项目当前投资额度
			BigDecimal currentInvest = new BigDecimal(currentInvestStr);
			Item item = queryItem(itemId);
			BigDecimal totalFinance = item.getMaxFinanceMoney();// 最大融资额度
			totalFinance = totalFinance == null ? one : totalFinance;// 总融资额度若为空，则为one，防止除数为0
			BigDecimal tempBigDecimal = currentInvest.divide(totalFinance, 10, BigDecimal.ROUND_HALF_DOWN);// 计算百分比

			Date date2 = item.getInvestStartDate();
			Long investStartDateMill = date2.getTime();
			Date date3 = item.getInvestEndDate();
			Long investEndDateMill = date3.getTime();
			Date date5 = item.getInterestStartDate();
			Long interestStartDateMill = date5.getTime();
			Date date6 = item.getFinanceEndDate();
			//Long financeEndDateMill = date6.getTime();

			if (currentDateMill < investStartDateMill) {// 预热
				itemStatus = "01";
				progressFront = "0";
			}
			if (currentDateMill >= investStartDateMill && currentDateMill < investEndDateMill) {// 投标期内
				// 比较当前融资额度和总融资额度的大小
				int compareInt = currentInvest.compareTo(totalFinance);
				if (compareInt == -1) {// 当前融资额度小于总融资额度
					if ((tempBigDecimal.multiply(bai).compareTo(one) == -1)) {// 当前融资额度小于百分之1
						if (tempBigDecimal.compareTo(BigDecimal.ZERO) == 0) {// 当前融资额度为0
							itemStatus = "02";
							progressFront = "0";
						} else {// 当前融资额度比值为0到1之间，置为1
							itemStatus = "02";
							progressFront = "1";
						}
					} else {// 已经超过百分一，不到百分之百
						progressFront = tempBigDecimal.multiply(bai).setScale(0, BigDecimal.ROUND_DOWN).toString();
						itemStatus = "02";
					}
				}
				if (compareInt == 0) {// 满标(已售磬)
					itemStatus = "03";
					progressFront = "100";
				}
				if (compareInt == 1) {// 超募
					itemStatus = "03";
					progressFront = "100";
				}
			}
			if (currentDateMill >= investEndDateMill && currentDateMill < interestStartDateMill) {// 投标期结束，起息之前，将状态改为满标（已售磬）
				itemStatus = "03";
				progressFront = "100";
			}
			if (currentDateMill >= interestStartDateMill) {// 已起息，是完成状态
				itemStatus = "04";
				progressFront = "100";
			}
			resultMap.put("front", itemStatus + "-" + progressFront);
		} catch (Exception e) {
			resultMap.put("front", "err-0");// 错误状态
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return resultMap;
	}
	
	/**
	 * 查询登录用户在首页的交易
	 * @param userId
	 * @return
	 */
	@Override
	public String queryUserTotalInvestMoney(String userId) {
		String personInvestTotalHql = "select sum(ao.capital) from ArcOrder ao where fkBaseInfoId = ? and payStatus=?";
		String total = "0.00";
		try{
			total = (String)arcOrderDao.findByHql(personInvestTotalHql, userId,"01");
			total = total == null ? "0.00" : total;
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return total;
		
	}
	
	/**
	 * 查询登录用户总的收益
	 * @param userId
	 * @return
	 */
	@Override
	public String queryUserTotalBenefitMoney(String userId) {
		String personBenefitTotalHql = "select sum(ao.income) from ArcOrder ao where fkBaseInfoId = ? and payStatus=?";
		String benefit = "0.00";
		try{
			benefit = (String)arcOrderDao.findByHql(personBenefitTotalHql, userId,"01");
			benefit = benefit == null ? "0.00" : benefit;
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return benefit;
	}
	
	/**
	 * 利率计算公式
	 * @param days  投资天数
	 * @param mount 投资金额
	 * @param rate  年化利率
	 * @return
	 */
	@Override
	public BigDecimal formulaBenifit(long days, BigDecimal investMount, BigDecimal rate) {
		BigDecimal result = new BigDecimal("0");
		BigDecimal big = new BigDecimal("1");
		if (investMount != null && days != 0 && rate != null) {
			big = big.multiply(investMount);
			big = big.multiply(rate);
			big = big.multiply(new BigDecimal(days));
			big = big.divide(new BigDecimal(360 * 100), 10,BigDecimal.ROUND_HALF_DOWN);
			result = big.setScale(2, BigDecimal.ROUND_DOWN);
		}
		return result;
	}

	/**
	 * 判断并保存意见
	 */
	@Override
	public String saveSugg(String suggCon, String suggEmail, String  date, String subIP) {
		String flag="err";
		String uuidStr  = UUID.randomUUID().toString().replaceAll("-", "");
		String query ="select subIP from t_suggest where SUBSTR(createDate,1,10) = ?";
		String sql = "insert into t_suggest(id,context,email,createDate,subIP) values (?,?,?,?,?)";
		Object[] param = {uuidStr,suggCon,suggEmail,date,subIP};
		try{
			List list = itemDao.jdbcQuery(query, date.substring(0,10));
			if(null!=list&&list.size()>=1){
				return "more";
			}
			itemDao.doSql(sql, param);
			flag ="ok";
		}catch(Exception e){
			flag ="err";
			e.printStackTrace();
			logger.error(ItemServiceImpl.class.toString(),e);
		}
		return flag;
	}
}
