package com.maiseries.core.bank.web.activity.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import payment.api.system.CMBEnvironment;
import payment.api.system.TxMessenger;
import payment.api.tx.cmb.Tx7201Request;
import payment.api.tx.cmb.Tx7201Response;
import payment.api.tx.cmb.Tx7202Request;
import payment.api.tx.cmb.Tx7202Response;
import payment.api.tx.cmb.Tx7211Request;
import payment.api.tx.cmb.Tx7213Request;
import payment.api.tx.cmb.Tx7213Response;
import payment.api.tx.cmb.Tx7220Request;
import payment.api.tx.cmb.Tx7220Response;
import payment.api.tx.cmb.Tx7223Request;
import payment.api.tx.cmb.Tx7223Response;
import code.main.archive.entity.BaseInfo;
import code.main.base.util.DesUtil;
import code.main.base.util.PropertiesServiceUtil;
import code.main.order.entity.ArcOrder;
import code.main.order.service.GoldPaymentService;
import fengx.com.AesDataTools;

@Service("goldPaymentService")
@Transactional
public class GoldPaymentServiceImpl implements GoldPaymentService {

	
	private static Logger log = (Logger) LoggerFactory.getLogger(GoldPaymentServiceImpl.class);
	
	
	/**
	 * 中金快捷支付 绑定关系
	 */
	@Override
	public Tx7201Response bindingBnak(HttpServletRequest request,BaseInfo bInfo) {
		// 1.获取参数
		Tx7201Response txResponse = null;
		try{
			DesUtil desUtil = new DesUtil(); // 解密
			Date nowdate = new Date();
		   	DateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSSS"); 
		   	int numN = (int) (Math.random()*9000+1000);     //生成4位随机数
		   	String txSN = numN+format.format(nowdate)+numN; // 27 位
	        String bankID = desUtil.strDec(request.getParameter("BankCode"));
	        String BankAccountName = desUtil.strDec(request.getParameter("BankAccountName"));
	        String mobiePhone = desUtil.strDec(request.getParameter("BankAccountNo"));      // 添加账户的手机号码
	        String identity=null;
	        String realName=null;
	        if(!"".equals(bInfo.getRealName())&&!"".equals(bInfo.getIdentityCard())&&bInfo.getRealName()!=null){
	        	AesDataTools tools = new AesDataTools();
	        	identity = tools.decode(bInfo.getIdentityCard());
	        	realName = tools.decode(bInfo.getRealName());
	        }else{
	        	 identity = desUtil.strDec(request.getParameter("identity"));      //  身份证号
	             realName = desUtil.strDec(request.getParameter("realName"));      //  真实姓名
	        }
	        
	        // 创建交易请求对象
	        Tx7201Request tx7201Request = new Tx7201Request();
	        tx7201Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID")); // 机构编码
	        tx7201Request.setTxCode("7201");
	        tx7201Request.setTxSNBinding(txSN); // 交易流水号 
	        
	        if("700".equals(PropertiesServiceUtil.getValue("bankID"))){ // 动态配置银行ID
	        	tx7201Request.setBankID("700");      // 银行编码 测试使用 700
            }else{
        	   tx7201Request.setBankID(bankID);       //  付款银行
            }
	        
	        tx7201Request.setAccountName(realName); // 账户名称
	        tx7201Request.setAccountNumber(BankAccountName);  // 账户号码 银行卡号
	        tx7201Request.setIdentificationNumber(identity);  // 身份证号
	        tx7201Request.setIdentificationType("0");  // 开户证件类型 默认为身份证
	        tx7201Request.setPhoneNumber(mobiePhone);
	        tx7201Request.setCardType("10"); // 个人借记卡 个人贷记卡  平台暂不支持贷记卡（信用卡）
	        // tx7201Request.setValidDate(validDate); // 绑定信用卡该项必填
	        // tx7201Request.setCVN2(cvn2);
	        // 3.执行报文处理
	        tx7201Request.process();
	        TxMessenger txMessenger = new TxMessenger();
            String[] respMsg  = txMessenger.send(tx7201Request.getRequestMessage(), tx7201Request.getRequestSignature(),CMBEnvironment.cmbtxURL);
            txResponse = new Tx7201Response(respMsg[0], respMsg[1]);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(GoldPaymentServiceImpl.class.toString(),ex);
		}
		return txResponse;
	}
	
	
	/**
	 * 查询绑定关系
	 */
	@Override
	public Tx7202Response querybindingBnak(String txSNBinding){
			
		    // 1.获取参数
	        // String institutionID = request.getParameter("InstitutionID");
	        // String txCode = request.getParameter("TxCode");
	        // String txSNBinding = request.getParameter("txSNBinding");
	       
		   Tx7202Response txResponse = null;
	        try{
		        // 创建交易请求对象
		        Tx7202Request tx7202Request = new Tx7202Request();
		        tx7202Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));
		        tx7202Request.setTxCode("7202");
		        tx7202Request.setTxSNBinding(txSNBinding);
		        // 3.执行报文处理
		        tx7202Request.process();
			    
		        TxMessenger txMessenger = new TxMessenger();
	            String[] respMsg  = txMessenger.send(tx7202Request.getRequestMessage(), tx7202Request.getRequestSignature());
	            txResponse = new Tx7202Response(respMsg[0], respMsg[1]);
	        
	        }catch(Exception ex){
	        	ex.printStackTrace();
	        	log.error(GoldPaymentServiceImpl.class.toString(),ex);
	        }
		return txResponse;
	}
	
	/**
	 * 中金快捷支付
	 */
	
	public Tx7213Response goldQuickpayment(String bankNumber,String userName,int capital,String bindingNumber,String serialNumber,String orderNumber){
	     
		   Tx7213Response txResponse = null;
		   try{
		        // 2.创建交易请求对象
		        Tx7213Request tx7213Request = new Tx7213Request();
		        tx7213Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));
		        tx7213Request.setOrderNo(orderNumber);         // 订单号
		        tx7213Request.setQuickPaymentNo(serialNumber); // 支付交易流水号（唯一）
		        tx7213Request.setAmount(capital);              // 支付金额
		        tx7213Request.setTxSNBinding(bindingNumber);   // 绑定流水号（银行卡）
		        tx7213Request.setAccountName(userName);        // 账户名称
		        tx7213Request.setAccountNumber(bankNumber);    // 账户号码
		        tx7213Request.setRemark("晋城农商银行");      // 备注
		        tx7213Request.process();
		        TxMessenger txMessenger = new TxMessenger();
	            String[] respMsg  = txMessenger.send(tx7213Request.getRequestMessage(), tx7213Request.getRequestSignature(),CMBEnvironment.cmbtxURL);
	            txResponse = new Tx7213Response(respMsg[0], respMsg[1]);
	            
		   }catch(Exception ex){
			   ex.printStackTrace();
			   log.error(GoldPaymentServiceImpl.class.toString(),ex);
		   }
		 return txResponse;
	}
	
	/**
	 * 订单查询 处理中的订单再处理
	 */
	@Override
	public Tx7223Response queryQuickPay(String serialNumber) {
		Tx7223Response txResponse = null;
		try{
			  Tx7223Request tx7223Request = new Tx7223Request();
			  tx7223Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));
			  tx7223Request.setQuickPaymentNo(serialNumber);
			  tx7223Request.process();
			  TxMessenger txMessenger = new TxMessenger();
	          String[] respMsg  = txMessenger.send(tx7223Request.getRequestMessage(), tx7223Request.getRequestSignature(),CMBEnvironment.cmbtxURL);
	          txResponse = new Tx7223Response(respMsg[0], respMsg[1]);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(GoldPaymentServiceImpl.class.toString(),ex);
		}
        return txResponse;
	}
	
	
	/**
	 * 中金支付订单查询(网关)
	 */
	@Override
	public Tx7220Response completePay(String paymentNo){
		Tx7220Response txResponse=null;
		try{
			Tx7220Request tx7220Request = new Tx7220Request();
	        tx7220Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));
	        tx7220Request.setPaymentNo(paymentNo);
	        tx7220Request.process(); //执行报文处理
            TxMessenger txMessenger = new TxMessenger();
            String[] respMsg  = txMessenger.send(tx7220Request.getRequestMessage(), tx7220Request.getRequestSignature(),CMBEnvironment.cmbtxURL);
            txResponse = new Tx7220Response(respMsg[0], respMsg[1]);
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(GoldPaymentServiceImpl.class.toString(),ex);
		}
		return txResponse;
	}
	
	
	/**
	 * 中金支付网关调用网银 数据生成
	 */
	@Override
	public Tx7211Request orderTransmission(HttpServletRequest request,ArcOrder orderBo,BaseInfo baseInfo){
		Tx7211Request tx7211Request = new Tx7211Request();
		try{
			String bankID = request.getParameter("bankCode");   // 银行Code  
			int captio =  Integer.parseInt(orderBo.getCapital().replace(".", ""))-Integer.valueOf(orderBo.getDeductionFee())*10; // 实际支付金额（投标金额-抵扣金额）
			//long amount = Long.valueOf(orderBo.getCapital().replace(".", "")); //将金额装换为分
            int accountType = Integer.parseInt("11");      // 付款账户类型  默认个人账户
            String usrNbr = baseInfo.getId();              // 用户编号
            String accSeq = baseInfo.getAccSeq();          // 账户序号
            // 创建交易对象
	        tx7211Request.setOrderNo(orderBo.getItemNumber()); //订单编号 itemNo
	        tx7211Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));     // 机构编码
	        tx7211Request.setPaymentNo(orderBo.getSerialNumber());     // 流水号
	        tx7211Request.setAmount(captio);              // 交易金额
	        tx7211Request.setRemark("晋城农商银行");        // 备注
	        tx7211Request.setNotificationURL(PropertiesServiceUtil.getValue("goldPaySuccUrl")); // 机构接收支付通知的URL
	        if("700".equals(PropertiesServiceUtil.getValue("bankID"))){ // 动态配置银行ID
	        	tx7211Request.setBankID("700");               //  付款银行
	        }else{
	        	tx7211Request.setBankID(bankID);               //  付款银行
	        }
	        tx7211Request.setAccountType(accountType);    //  用户账户类型  默认个人账户 11
	        tx7211Request.setUsrNbr(usrNbr);              //  用户编号
	        tx7211Request.setAccSeq(accSeq);              //  账户序号
	        tx7211Request.process();  // 执行报文
		}catch(Exception ex){
			ex.printStackTrace();
		}
        return tx7211Request;
	}
	
	
	/**
	 * 网关订单查询
	 */
	@Override
	public Tx7220Response queryGatewayPay(String paymentNo){
		Tx7220Response txResponse =null;
		try{
			Tx7220Request tx7220Request = new Tx7220Request();
	        tx7220Request.setInstitutionID(PropertiesServiceUtil.getValue("institutionID"));
	        tx7220Request.setPaymentNo(paymentNo);
	        tx7220Request.process(); //执行报文处理
            TxMessenger txMessenger = new TxMessenger();
            String[] respMsg  = txMessenger.send(tx7220Request.getRequestMessage(), tx7220Request.getRequestSignature(),CMBEnvironment.cmbtxURL);
            txResponse = new Tx7220Response(respMsg[0], respMsg[1]);
		}catch(Exception ex){
			ex.printStackTrace();
		}
        return txResponse;
	}
}