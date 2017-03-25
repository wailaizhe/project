<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
	<script src="${resource_dir}/js/jquery.easydropdown.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
  </head>
  <body>
  <form method="post" id="ctl00">
  <input type="hidden" id="loanId" value="${loan.id}" />
	<!--头部开始-->
	<%@ include file="../index/header.jsp"%>
	<!--头部结束-->
	<!--banner开始-->
	<div class="banner_section">
		<div class="banner">
	    	<img src="${resource_dir}/images/life_banner.jpg"/>
	    	<div class="life">
	        	<div class="life_head">
	            	在线申请
	            </div>
	            <div class="life_main">
	                <span>
	                    姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 名：
	                    <input id="name" value="${loan.name}" maxlength="10"/>
	                </span>
	              <span>
	                    <em style="margin-right:2px;">手&nbsp; 机 号</em>：<input style="margin-left:2px;" id="phoneNumber" value="${loan.phoneNumber}" maxlength="11"/>
	              </span>
	              <span>
	                <em style="float:left;">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 别：</em>
	                <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="sex">
	                    <option value="01" ${loan.sex=='01'?'selected="selected"':''}>先生</option>
	                    <option value="02" ${loan.sex=='02'?'selected="selected"':''}>女士</option>
	                </select>
	              </span>
	              <span>
	                    真实年龄：<input style="margin-left:2px;width:115px " id="age" value="${loan.age}" maxlength="2"/>&nbsp;&nbsp;周岁
	              </span>
	              <span>
	                <em style="float:left;">客户类别：</em>
	                <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="type">
	                    <option value="01" ${loan.type=='01'?'selected="selected"':''}>个人</option>
	                    <option value="02" ${loan.type=='02'?'selected="selected"':''}>企业</option>
	                </select>
	              </span>
	              <span>
	                <em style="float:left;">居住城市：</em>
	                <input style="margin-left:2px;" id="liveCity" value="${loan.liveCity}" maxlength="15"/>
	              </span>
	              <span>
	                <em style="float:left;">居住时间：</em>
	                <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="liveTime">
	                    <option value="01" ${loan.liveTime=='01'?'selected="selected"':''}>一年以内</option>
	                    <option value="02" ${loan.liveTime=='02'?'selected="selected"':''}>一至三年</option>
	                    <option value="03" ${loan.liveTime=='03'?'selected="selected"':''}>四年及以上</option>
	                </select>
	              </span>
	              <p class="imp">您提交的资料完全保密,请放心填写</p>
	              <div class="loan_btn">
	              <span id="button">
	              
	              	</span>
	              </div>
	            </div>
	        </div>
	    </div>
	</div>
	<%@ include file="../index/foot.jsp"%>
</form>
<!-- 数据表单 -->
		<form name="itemDataForm" method="post" action="">
			<input type="hidden" id="loanData" name="loanData" />
		</form>
</body>
	<script type="text/javascript">
		$(function(){
	  		$.ajax({
		        url: '${ctx}/account/isLand?now='+new Date(),
		        async:false,
		        success: function(data) {
		             data1 =data;
		        }
			 });
		     if(data1=="03"||data1.length>20){
		          $("#button").html('<a href="javascript:login()">登录立即申请</a>');
		      }else{
		      	  $("#button").html('<a href="javascript:chick()">立即申请</a>');
		      }
		 })
		function chick() {
			$.ajax({
		        url: '${ctx}/invest/isLoan?now='+new Date(),
		        async:false,
		        success: function(data) {
		             if(data == '01'){
		             	warnMsg("已提交申请","关闭");
						return;
		             }
		        }
			 });
			if($("#name").val() == ''){
				$("#name").focus();
				warnMsg("请填写姓名","关闭");
				return;
			}
			if($("#phoneNumber").val() == ''){
				$("#phoneNumber").focus();
				warnMsg("请填写手机号","关闭");
				return;
			}
			if($("#sex").val() == ''){
				$("#sex").focus();
				warnMsg("请选择性别","关闭");
				return;
			}
			if($("#age").val() == ''){
				$("#age").focus();
				warnMsg("请填写真实年龄","关闭");
				return;
			}
			if($("#type").val() == ''){
				$("#type").focus();
				warnMsg("请选择客户类别","关闭");
				return;
			}
			if($("#liveCity").val() == ''){
				$("#liveCity").focus();
				warnMsg("请填写居住城市","关闭");
				return;
			}
			if($("#liveTime").val() == ''){
				$("#liveTime").focus();
				warnMsg("请选择居住时间","关闭");
				return;
			}else{
				var shuzi = new RegExp("^[0-9]*$"); //只能为数字
				//var iphoneReg= /^0{0,1}(13[0-9]|17[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;//验证手机号
				 var iphoneReg = /^0{0,1}(1[0-9])[0-9]{9}$/;
				if(!shuzi.test($("#phoneNumber").val())){
					$("#phoneNumber").focus();
					warnMsg("请输入正确手机号！","关闭");
			 		return;
				}
				if(!shuzi.test($("#age").val())){
					$("#age").focus();
					warnMsg("年龄只能为数字","关闭");
			 		return;
				}
				if(!/[\u4E00-\u9FA5]/i.test($("#name").val()))
				{
					warnMsg("请填写中文姓名","关闭");
					return;
				}
				if(!/[\u4E00-\u9FA5]/i.test($("#liveCity").val()))
				{
					warnMsg("请填写中文城市","关闭");
					return;
				}
			}
				var loanBo = {
						id : $("#loanId").val(),//菜单id
		            	name : $("#name").val(),//姓名
						phoneNumber : $("#phoneNumber").val(),//手机号码
						sex : $("#sex").val(), //性别
						age : $("#age").val(), //真实年龄
						type : $("#type").val(), //申请人类型
						liveCity : $("#liveCity").val(), //居住城市
						liveTime : $("#liveTime").val(),//自定义URL
						status:$("#status").val()
				};
				var menuId = $("#loanId").val();
				if($("#loanId").val() == ''){
					document.itemDataForm.action = '${ctx}/invest/saveLoanInfo';
				}else{
					document.itemDataForm.action = '${ctx}/invest/modifyLoanInfo';
				}
				$("#loanData").val(JSON.stringify(loanBo));
				document.itemDataForm.method="post";
				document.itemDataForm.submit();
				
		}
		
		function login() {
			window.location.href="${ctx}/baseInfo/login";
		}
		
	</script>
</html>
