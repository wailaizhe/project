package com.maiseries.core.bank.web.common.dao.impl;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.maiseries.core.bank.web.common.dao.ItemDao;
import com.maiseries.core.bank.web.common.dao.OrderDao;
import com.maiseries.core.bank.web.common.model.ItemInfo;
public class ItemDaoImpl implements ItemDao{
	private static Logger logger = LoggerFactory.getLogger(ItemDaoImpl.class);
	private static BigDecimal one = new BigDecimal("1");
	private static BigDecimal bai = new BigDecimal("100");
	private static OrderDao orderDao=new OrderDaoImpl();
	private static final String TABLE="t_info";
	private boolean result ;
	private List<ItemInfo> list;
	private ItemInfo dao=new ItemInfo().dao();
	private ItemInfo itemInfo ;
	public List<ItemInfo> queryIndexItem(JSONObject jsonObj) {
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
			int pageIndex = jsonObj.getInteger("PageIndex");
			int pageSize = jsonObj.getInteger("PageSize"); 
			List params = new ArrayList();
			StringBuffer sql = new StringBuffer("SELECT *  from (select " );	
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
			 //from (select  t1.id,t1.invest_start_date,t1.invest_end_date,t1.interest_start_date,t1.finance_end_date,t1.finance_period,t1.max_finance_money,t1.invester_year_rate,t1.item_prefix,t1.item_name,t1.credit_card_end_date,t1.company_name,t1.special_flag,t1.min_invest_amount*t1.invest_unit_fee,t1.create_prj_date,IFNULL(t1.is_new_exclusive,'02'),IFNULL(t1.white_flag,'02') FROM t_item_info t1 WHERE t1.item_approve_status = ? AND t1.item_type= ? AND (NOW() BETWEEN t1.invest_start_date AND t1.invest_end_date) AND t1.full_flag <> ? order by t1.invester_year_rate desc, t1.invest_start_date asc) as s1 UNION select * from  (SELECT t2.id, t2.invest_start_date, t2.invest_end_date, t2.interest_start_date, t2.finance_end_date, t2.finance_period, t2.max_finance_money, t2.invester_year_rate, t2.item_prefix, t2.item_name, t2.credit_card_end_date, t2.company_name, t2.special_flag, t2.min_invest_amount*t2.invest_unit_fee, t2.create_prj_date, IFNULL(t2.is_new_exclusive,'02'), IFNULL(t2.white_flag,'02') FROM t_item_info t2 WHERE t2.item_approve_status = ?  AND t2.item_type= ? AND NOW() < t2.invest_start_date order by t2.invest_start_date asc) as s2  UNION select * from (SELECT t3.id, t3.invest_start_date, t3.invest_end_date, t3.interest_start_date, t3.finance_end_date, t3.finance_period, t3.max_finance_money, t3.invester_year_rate, t3.item_prefix, t3.item_name, t3.credit_card_end_date, t3.company_name, t3.special_flag, t3.min_invest_amount*t3.invest_unit_fee, t3.create_prj_date, IFNULL(t3.is_new_exclusive,'02'), IFNULL(t3.white_flag,'02') FROM t_item_info t3 WHERE t3.item_approve_status = ? AND t3.item_type= ?  AND (( t3.full_flag = ? AND NOW() < t3.invest_end_date) OR ( NOW() BETWEEN t3.invest_end_date AND t3.interest_start_date)) order by t3.invest_end_date desc) as s3  UNION select * from (SELECT t4.id, t4.invest_start_date, t4.invest_end_date, t4.interest_start_date, t4.finance_end_date, t4.finance_period, t4.max_finance_money, t4.invester_year_rate, t4.item_prefix, t4.item_name, t4.credit_card_end_date, t4.company_name, t4.special_flag, t4.min_invest_amount*t4.invest_unit_fee, t4.create_prj_date, IFNULL(t4.is_new_exclusive,'02'), IFNULL(t4.white_flag,'02') FROM t_item_info t4 WHERE t4.item_approve_status = ?  AND t4.item_type= ?  AND NOW() >= t4.interest_start_date
			 list=dao.find(sql.toString(),params.toArray());
			//page= itemInfo.paginate(pageIndex,  pageSize, sql.toString(),"",params.toArray());
			//Db.paginate(pageNumber, pageSize, select, sqlExceptSelect, paras);
			//page = itemDao.findExtPageByComplexSql(sql.toString(), pageIndex, pageSize, params.toArray());
			//07, 02, 01, ----07, 02, ---07, 02, 01, ---07, 02
			//List list = page.getList();
			/* if(list != null || list.size()>0){
				 for(int i=0;i<list.size();i++){
					 ItemInfo temp = (ItemInfo)list.get(i);
					 String itemId = temp.getId();
					 Map m = caculateItemStatus(itemId);//计算项目状态
					 String flag = (String)m.get("front");
					 temp.setItemStatusTemp(flag.split("-")[0]);//状态
					 temp.setItemProgress(flag.split("-")[1]);//进度
				 }
			 }*/
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemDaoImpl.class.toString(),e);
		}
		return list;
	
	}
	public Map<String,String> caculateItemStatus(String itemId){
		Map<String, String> resultMap = new HashMap<String, String>();
		String itemStatus = "";// 项目状态
		String progressFront = "";// 项目进度百分比
		try {
			Long currentDateMill = System.currentTimeMillis();
			String currentInvestStr = this.queryCrrentIteminvestMount(itemId);// 查询项目当前投资额度
			BigDecimal currentInvest = new BigDecimal(currentInvestStr);
			ItemInfo item = queryItem(itemId);
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
			logger.error(ItemDaoImpl.class.toString(),e);
		}
		return resultMap;
	}
	public String queryCrrentIteminvestMount(String itemId){
		String currentTatalMoney = "0.00";
		try {
			currentTatalMoney = orderDao.successed(itemId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(ItemDaoImpl.class.toString(),e);
		}
		return currentTatalMoney;
	}
	public ItemInfo  queryItem(String itemId){
		String hql = "select * from "+TABLE+"   where id= ? ";
		try{
			itemInfo=(ItemInfo) dao.find(hql, itemId);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(ItemDaoImpl.class.toString(),e);
		}
		return itemInfo;
	}
	public ItemInfo queryItemById(String itemId) {
		itemInfo=dao.findById(TABLE, itemId);
		return itemInfo;
	}
	public List<ItemInfo> queryItems() {
		
        list=dao.find("select * from"+TABLE);
		return list;
	}
	public List queryItemsByParams(String sql,Object... params) {
	    //List<Record>	list=new ArrayList<Record>();
		//list=Db.find(sql,params);
		return list;
	}
	public boolean addItem(ItemInfo itemInfo) {
		result=dao.save();
		return result;
	}
	public boolean updateItem(ItemInfo itemInfo) {
		result=dao.update();
		return result;
	}
	@Override
	public int getIncome(String id) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int getCaptia(String id) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
