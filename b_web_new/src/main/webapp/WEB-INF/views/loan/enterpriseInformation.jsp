<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>惠贷款-晋城农商银行蒲公英金融服务平台</title>
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/loan.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/demo.css">
	<link rel="stylesheet" href="${resource_dir}/css/easydialog.css" type="text/css"/>
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
	
	<script src="${resource_dir}/js/jquery.easydropdown.js"></script>
	<script type="text/javascript">
		function save(){
			var loanId = $("#loanId").val();//ID
			var enterpriseName = $("#enterpriseName").val();// 企业名称
			var registrationNumber = $("#registrationNumber").val();// 注册号
			var phoneNumber = $("#phoneNumber").val();// 联系方式
			var email = $("#email").val();// 邮箱
			var legalPersonName = $("#legalPersonName").val(); // 法人代表姓名
			var companyActualAddres = $("#companyActualAddres").val();// 公司地址
			var name = $("#name").val();// 代理人姓名
			var enterpriseType = $("#enterpriseType").val();// 企业类型
			var registrationAddres = $("#registrationAddres").val();// 注册地址
			var legalIdentityCard = $("#legalIdentityCard").val();// 法人代表身份证号
			var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			if(enterpriseName==null||enterpriseName==""){
				warnMsg("企业名称不能为空！","关闭");
		 		return;
			}else if(enterpriseType==null||enterpriseType==""){
				warnMsg("企业类型不能为空！","关闭");
		 		return;
			}else if(registrationNumber==null||registrationNumber==""){
				warnMsg("注册号不能为空！","关闭");
		 		return;
			}else if(registrationAddres==null||registrationAddres==""){
				warnMsg("注册地址不能为空！","关闭");
		 		return;
			}else if(legalPersonName==null||legalPersonName==""){
				warnMsg("法人代表姓名不能为空！","关闭");
		 		return;
			}else if(legalIdentityCard==null||legalIdentityCard==""){
				warnMsg("法人代表身份证号不能为空！","关闭");
		 		return;
			}else if(companyActualAddres==null||companyActualAddres==""){
				warnMsg("公司地址不能为空！","关闭");
		 		return;
			}else if(email==null||email==""){
				warnMsg("企业邮箱不能为空！","关闭");
		 		return;
			}else if(name==null||name==""){
				warnMsg("代理人姓名不能为空！","关闭");
		 		return;
			}else if(phoneNumber==null||phoneNumber==""){
				warnMsg("联系方式不能为空！","关闭");
		 		return;
			}else{
				 var iphoneReg = /^0{0,1}(1[0-9])[0-9]{9}$/;
				 var ko = isCnNewID(legalIdentityCard);
		         if(!ko){
		            warnMsg("您的身份证号码输入错误,请重新输入！","关闭");
		            return;
		         }
				if(!emailreg.test(email)){
					warnMsg("邮箱格式不正确！","关闭");
			 		return;
				}
				if(!iphoneReg.test(phoneNumber)){
					warnMsg("请输入正确手机号！","关闭");
			 		return;
				}else{
					confirmMsg("确认保存？","确定",function saveLoanXml(){
						document.saveLoanForm.action = "${ctx}/invest/saveInformation?loanId="+loanId;
						document.saveLoanForm.submit();
					});
				}
			}
		}
		
		//返回
		function back(){
			var loanId = $("#loanId").val();
			window.location.href="${ctx}/invest/gotoloanApplyInfo?loanId="+loanId;
		}
	</script>
</head>
<body>
<!--头部开始-->
<%@ include file="../header.jsp"%>
<!--头部结束-->
<input type="hidden" id="loanId" value="${loan.id }">
<div class="loan2section">
	<div class="lifetop">
    	<img src="${resource_dir}/images/002.png"/>
    </div>
    <form name="saveLoanForm" id="saveLoanForm" method="post">
    <div class="loan2main">
    	<div class="loan2left">
        	<span style="margin-left:32px;"><em style="color:red;">*</em> 企业名称：<input type="text" name="enterpriseName" maxlength="25" id="enterpriseName"/></span>
        	<span style="margin-left:39px;"><em style="color:red;">*</em> 注 册 号：<input type="text" name="registrationNumber" maxlength="20" id="registrationNumber"/></span>
        	<span><em style="color:red;">*</em> 法人代表姓名：<input type="text" name="legalPersonName" id="legalPersonName" maxlength="20"/></span>
            <span style="margin-left:32px;"><em style="color:red;">*</em> 公司地址：<input type="text" name="companyActualAddres" id="companyActualAddres" maxlength="20"/></span>
            <span style="margin-left:16px;"><em style="color:red;">*</em> 代理人姓名：<input type="text" name="name" id="name" maxlength="20"/></span>
        </div>
    	<div class="loan2right">
    		<span style="margin-left:61px;"><i style="float:left;"><em style="color:red;">*</em> 企业类型：</i>
                <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="enterpriseType" name="enterpriseType">
                    <option value="01">国有企业</option>
                    <option value="02">集体所有制</option>
                    <option value="03">私营企业</option>
                    <option value="04">股份制企业</option>
                    <option value="05">联营企业</option>
                    <option value="06">外商投资企业</option>
                    <option value="07">股份合作企业</option>
                </select>
            </span>
            <span style="margin-left:64px;"><em style="color:red;">*</em> 注册地址：<input type="text" name="registrationAddres" id="registrationAddres" maxlength="20"/></span>
        	<span><em style="color:red;">*</em> 法人代表身份证号：<input type="text" name="legalIdentityCard" id="legalIdentityCard" maxlength="18"/></span>
        	<span style="margin-left:64px;"><em style="color:red;">*</em> 企业邮箱：<input type="text" name="email" id="email" maxlength="40"/></span>
        	<span style="margin-left:64px;"><em style="color:red;">*</em> 联系方式：<input type="text" name="phoneNumber" id="phoneNumber" maxlength="11"/></span>
        </div>
        <div class="loan2btn">
            <div class="lifebtn">
                <a onclick="back()">返回到上一步</a>
            </div>
            <div class="rightbtn">
                <a onclick="save()">确认到下一步</a>
            </div>
        </div>
    </div>
    </form>
</div>
<%@ include file="../foot.jsp"%>
</body>
</html>
