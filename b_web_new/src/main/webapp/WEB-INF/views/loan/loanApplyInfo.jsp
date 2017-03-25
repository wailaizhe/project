<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>惠贷款-晋城农商银行蒲公英金融服务平台</title>
	<meta name="description" content="晋城农商银行晋城农村信用社蒲公英金融服务平台p2p投融资平台"/>
	<meta name="keyword" content="晋城农商银行,晋城农村信用社,蒲公英金融服务平台,p2p投融资平台"/>
	
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/loan.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/demo.css">
	<link rel="stylesheet" href="${resource_dir}/css/easydialog.css" type="text/css"/>
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
	<script src="${resource_dir}/js/jquery.easydropdown.js"></script>
	<script type="text/javascript" src="${resource_dir}/My97DatePicker/WdatePicker.js" ></script>
	
  </head>
  
  <body>
 
   <form id="formID" action="" method="post">
<!--头部开始--><%@ include file="../header.jsp"%>
<input type="hidden" id=loanId name="loanId" type="text" readonly="readonly" value="${loan.id}">
<!--头部结束-->
<div class="lifesection">
	<div class="lifetop">
    	<img src="${resource_dir}/images/001.png"/>
    </div>
    <div class="lifemain">
    	<div class="lifecenter">
    			<input type="hidden" id="loanObject" name="loanObject" value="${loanObject}">
    			<input type="hidden" id="hiddenType" value="${loan.loanObject}">
    			<input type="hidden" id="Money" value="${ReqLoanMoney }">
    		<span id="reqNumber"  class="marginleft">客户类别：
    			<input style="height: 15px;width: 15px;vertical-align:middle;" name="type" type="radio" value="01" ${loan.type=='01'?'checked="checked"':'' }>个人</input>
    			<input style="height: 15px;width: 15px;vertical-align:middle;margin-left:20px;"  name="type" type="radio" value="02" ${loan.type=='02'?'checked="checked"':''}>企业</input>
    		</span>
        	<span id="reqNumber"  class="marginleft">申请编号：${loan.reqNumber }（作为贷款申请的唯一标识）</span>
              <!-- 票据贷 -->
            <span name='billLoanSpan' style="margin-left:30px;">
	            <i style="float:left;"><em style="color:red;">*</em>资产类型：</i>
	            <select id="assetType" name="assetType"  class="dropdown" data-settings='{"wrapperClass":"flat"}'>
	                    <option value="">请选择</option>
	                    <option value="1" ${loan.assetType==1?'selected="selected"':''}>商业承兑票据</option>
	                    <option value="2" ${loan.assetType==2?'selected="selected"':''}>银行承兑票据</option>
	                </select>
            </span>
            <span name='billLoanSpan' style="margin-left:30px;">
            	<i style="float:left;"><em style="color:red;">*</em>出票日期：</i>
                <input type='text' id="issueDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${issueDate}" name="issueDate" maxlength="10" class="dropdown" data-settings='{"wrapperClass":"flat"}'>
            </span>
             <span name='billLoanSpan' style="margin-left:30px;">
            	 <i style="float:left;"><em style="color:red;">*</em>到票日期：</i>
                <input type='text' id="ticketDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${ticketDate}" name="ticketDate" maxlength="10" class="dropdown" data-settings='{"wrapperClass":"flat"}'>
            </span>
             <span name='billLoanSpan' style="margin-left:30px;">
             	<i style="float:left;"><em style="color:red;">*</em>出票金额：</i>
                <input type='text' id="issueAmount" value="${loan.issueAmount}" name="issueAmount" maxlength="8" class="dropdown" data-settings='{"wrapperClass":"flat"}'> 万元
            </span>
            <span id="moneySpan"><i style="float:left;"><em style="color:red;">*</em>申请贷款金额：</i>
            	<input id="reqLoanMoney" name="reqLoanMoney" value="${ReqLoanMoney}" class="dropdown" data-settings={"wrapperClass":"flat"} maxlength="8"> 万元
            </span>
            <span><i style="float:left;"><em style="color:red;">*</em>申请贷款期限：</i>
                <input id="reqLoanTime" maxlength="2" value="${loan.reqLoanTime}" name="reqLoanTime"  class="dropdown" data-settings='{"wrapperClass":"flat"}'> 月
            </span>
            <span style="margin-left:30px;"><i style="float:left;"><em style="color:red;">*</em>还款方式：</i>
            <select id="RepaymentMethod" name="RepaymentMethod"  class="dropdown" data-settings='{"wrapperClass":"flat"}'>
                    <option value="">请选择</option>
                    <option value="1" ${loan.repaymentMethod==1?'selected="selected"':''}>一次性还本付息</option>
                    <option value="2" ${loan.repaymentMethod==2?'selected="selected"':''}>按月（季）付息，到期还本</option>
                </select>
            </span>
            <span><i style="float:left;"><em style="color:red;">*</em>申请贷款用途：</i>
                <input type='text' id="reqLoanUse" value="${loan.reqLoanUse}" name="reqLoanUse" maxlength="10" class="dropdown" data-settings='{"wrapperClass":"flat"}'>
                    
            </span>
          
            <div class="loanbtn">
            	<div class="lifebtn">
                	<a onclick="goBack();">返回上一步</a>
                </div>
            	<div class="rightbtn" >
                	<a   onclick="submitForm();" >确认到下一步</a>
                </div>
            </div>
        </div>
    </div>
</div>
</form> 
<%@ include file="../foot.jsp"%>
  </body>
  <script type="text/javascript">
  		var Type=$("#loanObject").val();
  		var Money=$("#Money").val();
		$(function()
		{
			if(Type!='01')
			{
				$("span[name='billLoanSpan']").hide();
				var flag=false;
				var inputArr=$("input[name=type]");
				for(var i=0;i<inputArr.length;i++)
				{
					if(inputArr[i].checked==true)
					{
						flag=true;
						return;
					}
				} 
				if(flag==false)
				{
					$("input[name=type]:eq(0)").attr("checked",'checked'); 
				}
			}	
			else
			{		
					$("#reqNumber").html("");
					$("#reqNumber").html('客户类别：<input style="height: 15px;width: 15px;vertical-align:middle;" name="type" type="radio" value="02" checked="checked" readonly="readonly" }>企业</input>');
					// $("#moneySpan").html('<i style="float:left;"><em style="color:red;">*</em>申请贷款金额：</i><input id="reqLoanMoney" name="reqLoanMoney" maxlength="8 " value="'+Money +'" class="dropdown" data-settings={"wrapperClass":"flat"}>万元');
			}		
			
		})
		
		//提交表单之前  验证表单信息 (验证数字和长度)
		function submitForm()
		{
			var	reqLoanMoney=$("#reqLoanMoney").val();
			var type=$("input[name='type']:checked").val(); 
			var	reqLoanTime= $("#reqLoanTime").val();
			var RepaymentMethod=$("#RepaymentMethod").val();
			if(Type=='01')
			{
				var billFlag=	checkedBill();
				if(billFlag== false)
				{
					return ;
				}
			}
			//校验是否为数字
  			if(!new RegExp("^[0-9]*$").test(reqLoanMoney)&&!new RegExp("^[0-9]+(.[0-9]{1})?$").test(reqLoanMoney))
  			{
  			warnMsg("贷款金额请输入数字!","关闭");
       			return ;
  			}
			if(/^[0]\d+\.?\d{0,1}$/.test(reqLoanMoney)){  
       		warnMsg("贷款金额不可以0开始!","关闭");
       			return false;
  				 }
			  if(reqLoanMoney<=0)
			  {
			  	warnMsg("贷款金额，需大于零!","关闭");
        			return ;
			  }
			  else
			  {
			  	var regex1 = /^\d+\.?\d{0,1}$/;
			 	if(!regex1.test(reqLoanMoney)||reqLoanMoney==0||reqLoanMoney==0.0){  
        		warnMsg("贷款金额，最多保留一位小数!","关闭");
        			return ;
   				 }  
			  }
			if(reqLoanTime=="")
			{
			 warnMsg("请填写贷款期限！","关闭");
			return ;
			}
			if(reqLoanTime<=0)
			{
				warnMsg("贷款期限，需大于零!","关闭");
	        			return ;
			}
			else
			{
				var regex2 =/^\+?[1-9][0-9]*$/;
			 	if(!regex2.test(reqLoanTime)){  
        		warnMsg("贷款期限，请输入整数!","关闭");
       			return ;
   				 }
			}
			
			if(RepaymentMethod=="")
			{
				warnMsg("请选择还款方式!","关闭");
       			return ;
			}
			
			var reqLoanUse=$("#reqLoanUse").val();
			if(reqLoanUse=="")
			{
				warnMsg("请填写贷款用途！","关闭");
					return ;
			}
			else
			{
				if(!/^[\u4e00-\u9fa5]*$/.test(reqLoanUse))
				{
					warnMsg("贷款用途请填写汉字！","关闭");
						return ;
				}
			}
			
			//提交表单 
			var form=$("#formID");
			form.attr("action", "${ctx}/invest/saveLoanAndToInfoFill").submit();  
			
		}	
		
		function goBack()
		{
		  	var idVal=$("#loanId").val();
			window.location.href="${ctx}/invest/gotoloanApplyModify?loanId="+idVal;
		}
		//验证票据贷数据
		function checkedBill()
		{
			var assetType=$("#assetType").val();
			var issueDate=$("#issueDate").val();
			var ticketDate=$("#ticketDate").val();
			var issueAmount=$("#issueAmount").val();
			if(assetType=="")
			{
				warnMsg("请选择资产类型！","关闭");
						return false;
			}
			if(issueDate=="")
			{
				warnMsg("请选择出票日期！","关闭");
						return false;
			}
			if(ticketDate=="")
			{
				warnMsg("请选择到票日期！","关闭");
						return false;
			}
			else
			{
				if(ticketDate<=issueDate)
				{
					warnMsg("到票日期应大于出票日期！","关闭");
							return false;
				}
			}
			if(issueAmount=="")
			{
				warnMsg("请填写出票金额！","关闭");
						return false;
			}
			else
			{
				if(!new RegExp("^[0-9]*$").test(issueAmount)&&!new RegExp("^[0-9]+(.[0-9]{1})?$").test(issueAmount))
	  			{
	  			warnMsg("出票金额请输入数字!","关闭");
	       			return false ;
	  			} 
		 	if(/^[0]\d+\.?\d{0,1}$/.test(issueAmount)){  
       		warnMsg("出票金额不可以0开始!","关闭");
       			return false;
  				 }
				 if(issueAmount<=0)
			  {
			  	warnMsg("出票金额，需大于零!","关闭");
        			return false;
			  }
			  else
			  {
			  	var regex1 = /^\d+\.?\d{0,1}$/;
			 	if(!regex1.test(issueAmount)||issueAmount==0||issueAmount==0.0){  
        		warnMsg("出票金额，最多保留一位小数!","关闭");
        			return false;
   				 }  
			  }
			}
		}
		
  </script>
</html>
