package com.maiseries.core.bank.web.account.controller;



import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Record;
import com.maiseries.core.bank.web.account.service.AccountService;
import com.maiseries.core.bank.web.account.service.impl.AccountServiceImpl;
import com.maiseries.core.bank.web.baseInfo.service.BaseInfoService;
import com.maiseries.core.bank.web.baseInfo.service.impl.BaseInfoServiceImpl;
import com.maiseries.core.bank.web.common.controller.BaseController;
import com.maiseries.core.bank.web.common.interceptor.LoginInterceptor;
import com.maiseries.core.bank.web.common.kit.DesUtil;
import com.maiseries.core.bank.web.common.kit.FxStringUtil;
import com.maiseries.core.bank.web.common.model.BaseInfo;
import com.maiseries.core.bank.web.common.model.DicRegion;
import com.maiseries.core.bank.web.common.model.DicSystem;
import com.maiseries.core.bank.web.common.model.OrderInfo;
import com.maiseries.core.bank.web.common.model.PersonAccountInfo;
import com.maiseries.core.bank.web.common.util.DateTimeUtils;
import com.maiseries.core.bank.web.item.service.ItemService;
import com.maiseries.core.bank.web.item.service.impl.ItemServiceImpl;

/**
 * 
 * @author shiyaning
 * 关于我的账户的业务类
 *
 */
@Before(LoginInterceptor.class)
public class AccountController extends BaseController{
	private ItemService itemService = new ItemServiceImpl();
	private BaseInfo baseInfo=new BaseInfo() ;
	private BaseInfoService baseInfoService=new BaseInfoServiceImpl();
	private AccountService accountService=new AccountServiceImpl();
	private boolean result ;
	/**
	 * 我的账户页
	 */
	
	public void myassets(){
		baseInfo=getSessionAttr("baseInfo");
		String capital="";
		String income  ="";
		if(null==baseInfo){
			render("/index/login");
		}else{
			Record re=itemService.queryCaptiaAndIncome(baseInfo.getID());
			if(re.get("capital")==null){
				capital="0.00";
			}else {
				capital=re.get("capital").toString();
			}
			if(re.get("income")  == null){
				income="0.00";
			}else{
				income=re.get("income").toString();
			}
			setSessionAttr("capital", capital);
			setSessionAttr("income", income);
			String mobile=baseInfo.getMobilePhone();
			setSessionAttr("mobile", mobile.substring(0, 4)+"***"
			+mobile.substring(mobile.length()-4, mobile.length()));
			renderJsp("myassets.jsp");
		}
		
	}
	/**
	 * 查询当前账户的所有银行卡
	 */
	public void getAllBannks(){
		String baseInfoId=getSessionAttr("baseInfoId");
		List<PersonAccountInfo> list=baseInfoService.queryAllPersonAccountInfos(baseInfoId);
		List<PersonAccountInfo> list2=new ArrayList<>();
		if(list.size()>0){
			String cardNumber="";
			String accountCode="";
			for (PersonAccountInfo personAccountInfo : list) {
				cardNumber=personAccountInfo.getCardNumber();
				accountCode=personAccountInfo.getAccountCode();
				personAccountInfo.setCardNumber(cardNumber.substring(0, 4)+"***"
				    +cardNumber.substring(cardNumber.length()-4,cardNumber.length()));
				
				personAccountInfo.setAccountCode(accountCode.substring(0, 4)+"***"
					+accountCode.substring(accountCode.length()-4,accountCode.length()));
			}
		}
		setAttr("personAcc", list);
		System.out.println(list.toString());
		renderJsp("mybankcard.jsp");
	}
	/**
	 * 添加银行卡
	 */
	public void addBank(){
		BaseInfo baseInfo=getSessionAttr("baseInfo");
		String BankAccountName=getPara("BankAccountName");
		String BankAccountNo=getPara("BankAccountNo");
		String BankCode=getPara("BankCode");
		String BankName=getPara("BankName");
		String cardSubBank=getPara("cardSubBank");
		String BankCity=getPara("BankCity");
		String BankCityCode=getPara("BankCityCode");
		String ageData=getPara("ageData");
		String cityName=getPara("cityName");
		String provinceName=getPara("provinceName");
		String identity=getPara("identity");
		String realName=getPara("realName");
		baseInfo.setRealName(realName);
    	baseInfo.setIdentityCard(identity);
    	baseInfo.setUserBirthday(DateTimeUtils.parseDate(ageData));
    	result=baseInfoService.updateBaseInfo(baseInfo);
    	//result=baseInfoId.update();
    	if(result){
    		//将银行卡保存到数据库
    		PersonAccountInfo personAccountInfo=new PersonAccountInfo();
    		personAccountInfo.setBankName(BankName).setCardNumber(BankAccountName).setCityName(cityName)
    		.setProvinceName(provinceName).setBindingMobiePhone(BankAccountNo).setCardSubBank(cardSubBank)
    		.setCardProvince(BankCity).setAccountCode(identity).setCardCity(BankCityCode).setCardBank(BankCode)
    		.setAccountName(realName).setFkBaseInfoId(baseInfo.getID()).setCreateDate(DateTimeUtils.getCurrentDateTime());
    		baseInfoService.addBankAccount(personAccountInfo);
            renderJson("1");    	
         }
    	renderJson("error");
	}
	/**
	 * 获得所有银行名称
	 */
	public void queryBank(){
		List<DicSystem> list=baseInfoService.queryBank();
		renderJson(list);
	}
	/**
	 * 获得所有的省
	 */
    public void getTopLevelRegion(){
    	List<DicRegion> list=accountService.getTopLevelRegion();
		renderJson(list);
    }
    /**
     * 获得省下的所有市
     */
    public void getcitys(){
    	String pcode=getPara("pcode");
    	List<DicRegion> list=accountService.getCitys(pcode);
    	renderJson(list);
    }
    /**
     * 查询当前的用户
     */
    public void baseInfo(){
    	BaseInfo baseInfo=getSessionAttr("baseInfo");
    	List<String> list=new ArrayList<>();
    	setAttr("identityCard", baseInfo.getIdentityCard());
    	setAttr("realName", baseInfo.getRealName());
    	renderJson();
    }
    public void investment_newList(){
    	renderJsp("investment_newList.jsp");
    }
    public void investment_Data(){
    	String jsonStr=getPara("jsonStr");
    	BaseInfo bInfo = getSessionAttr("baseInfo");
		JSONObject jsonObj = JSONObject.parseObject(jsonStr);
		jsonObj.put("id", bInfo.getID());
		jsonObj.put("now", "2");
		
		String state = jsonObj.getString("state");
		String id = jsonObj.getString("id");
		String now = jsonObj.getString("now");
		
		List queryParams = new ArrayList();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT k.ID ,k.fk_item_id ,k.capital, k.income, k.pay_status, t.item_name, DATE_FORMAT( t.interest_start_date, '%Y-%m-%d' ) startDate,"
						+ " DATE_FORMAT( t.finance_end_date, '%Y-%m-%d' ) endDate,DATE_FORMAT(k.create_date,'%Y-%m-%d %H:%i:%s') creatDate, " +
							"t.item_prefix,DATE_FORMAT( t.interest_start_date, '%Y-%m-%d' ) interestStartDate, " +
							"DATE_FORMAT( t.finance_end_date, '%Y-%m-%d' ) repayClearDate,k.capital_income, t.invester_year_rate, t.finance_period,t.special_flag,k.pay_date,t.is_new_exclusive,t.white_flag "
						+ " FROM t_order_info k, t_item_info t WHERE k.fk_item_id = t.id "
						+ " AND k.fk_base_info_id = ?  ");
		queryParams.add(id);
		//if (!"".equals(state)&& !"02".equals(state)&&state!=null&&!"06".equals(state)) {
		if (!FxStringUtil.isNullOrEmpty(state)&& !"02".equals(state)&&!"06".equals(state)) {
			if("002".equals(state)){        // 投资记录 未支付
				sql.append("and (k.pay_status ='07' or k.pay_status = '02' or k.pay_status = '08') ");
			}else if("003".equals(state)){  // 支付成功，投标失败
				sql.append("and (k.pay_status ='03' or k.pay_status = '04' or k.pay_status = '05'  or k.pay_status = '09') ");
			}else if("011".equals(state)){  // 投标成功，待回款
				sql.append("and (k.pay_status ='01' or k.pay_status = '10') ");
			}else{
				sql.append("AND k.pay_status = ? ");
				queryParams.add(state);
			}
		}
		if ("01".equals(state)) {
			sql.append("and t.finance_end_date > now() and round((UNIX_TIMESTAMP(NOW())-UNIX_TIMESTAMP(k.pay_date))/60)>30");   //支付成功后，订单30分钟内不显示在资产里
		}
		
		if ("02".equals(state)) {
			sql.append("and (k.pay_status is null or k.pay_status = '02') ");
		}
	    if("06".equals(now)&&"06".equals(state)){    // 历史资产
	    	sql.append("AND t.finance_end_date < NOW() and  (k.pay_status = '01' or k.pay_status = '06' or k.pay_status = '10')  ");
		}
	    if("".equals(state)&&"2".equals(now)){ // 投资记录显示 未支付 已支付 超募 处理中 已退款 支付失败的信息
	    	sql.append(" and (k.pay_status ='01' or  k.pay_status ='05' or  k.pay_status ='09' or  k.pay_status ='10' or k.pay_status = '02' or k.pay_status = '03' or k.pay_status = '07' or k.pay_status = '08' or k.pay_status='04' or k.pay_status='06' ) ");
	    }
	    if("06".equals(now)&&"06".equals(state)){
	    	sql.append(" ORDER BY t.finance_end_date desc,k.create_date desc");
	    }else{
	    	sql.append(" ORDER BY k.create_date DESC");
	    }
		
		int pageIndex = jsonObj.getInteger("PageIndex");
		int pageSize = jsonObj.getInteger("PageSize");
		OrderInfo dao = new OrderInfo();
		List list=dao.find(sql.toString(),  queryParams.toArray());
		setAttr("totalCount",1 );
	    setAttr("datas", list);
	    renderJson();
		
		
    }
}
