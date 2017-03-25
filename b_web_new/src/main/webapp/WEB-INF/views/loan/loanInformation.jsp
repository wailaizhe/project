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
	
	
	<script type="text/javascript">
		function save(){
			var loanId = $("#loanId").val();//ID
			var name = $("#name").val();// 申请人姓名
			var sex = $("#sex").val();// 申请人姓别 /01男 02女
			var phoneNumber = $("#phoneNumber").val();// 申请人手机号
			var email = $("#email").val();// 电子邮箱
			var idNumber = $("#idNumber").val(); // 申请人身份证件号
			var education = $("#education").val();// 文化程度 /01 02 03。。。
			var liveAddress = $("#liveAddress").val();// 居住地址
			var maritalStatus = $("#maritalStatus").val();// 婚姻状况 /01未婚 02已婚
			var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			// var iphoneReg= /^0{0,1}(13[0-9]|17[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;//验证手机号
			 var iphoneReg = /^0{0,1}(1[0-9])[0-9]{9}$/;
			if(name==null||name==""){
				warnMsg("申请人姓名不能为空！","关闭");
		 		return;
			}else if(sex==null||sex==""){
				warnMsg("性别不能为空！","关闭");
		 		return;
			}else if(phoneNumber==null||phoneNumber==""){
				warnMsg("手机号不能为空！","关闭");
		 		return;
			}else if(email==null||email==""){
				warnMsg("电子邮箱不能为空！","关闭");
		 		return;
			}else if(idNumber==null||idNumber==""){
				warnMsg("身份证件号不能为空！","关闭");
		 		return;
			}else if(education==null||education==""){
				warnMsg("文化程度不能为空！","关闭");
		 		return;
			}else if(liveAddress==null||liveAddress==""){
				warnMsg("居住地址不能为空！","关闭");
		 		return;
			}else if(maritalStatus==null||maritalStatus==""){
				warnMsg("婚姻状况不能为空！","关闭");
		 		return;
			}else{
				//var shuzi = new RegExp("^[0-9]*$"); //只能为数字
				///^[0-9a-zA-Z]*$/g
				var shuzi = new RegExp("^[0-9a-zA-Z]*$"); //只能为数字、字母
				if(!shuzi.test(idNumber)){
					warnMsg("身份证件号只能为数字或字母！","关闭");
			 		return;
				}if(!iphoneReg.test(phoneNumber)){
					warnMsg("请输入正确手机号！","关闭");
			 		return;
				}
				if(!emailreg.test(email))
				{
					warnMsg("邮箱格式不正确！","关闭");
			 		return;
				}
				else{
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
    <div class="loan2 clearfix" style="overflow:hidden;">
    	<div class="loan2left">
        	<span><em style="color:red;">*</em>申请人姓名：<input type="text" name="name" id="name" maxlength="20"/></span>
        	<span><em style="color:red;">*</em>身份证件号：<input type="text" name="idNumber" id="idNumber" maxlength="18"/></span>
            <span style="margin-left:47px;"><i style="float:left;"><em style="color:red;">*</em>国籍：</i>
               <input class="dropdown" data-settings='{"wrapperClass":"flat"}' disabled="disabled" type="text" id="nationality" name="nationality" value="中华人民共和国"/>
            </span>
            <span style="margin-left:16px;"><i style="float:left;"><em style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</em>性别：</i>
               
                <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="sex" name="sex">
                    <option value="01" ${loan.sex=='01'?'selected="selected"':''}>男</option>
                    <option value="02" ${loan.sex=='02'?'selected="selected"':''}>女</option>
                </select>
            </span>
        	<span style="margin-left:2px;"><em style="color:red;">*</em>现居住地址：<input type="text" name="liveAddress" id="liveAddress" maxlength="20"/></span>
        </div>
    	<div class="loan2right">
        	<span><i style="float:left;"><em style="color:red;">*</em>文化程度：</i>
                 <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="education" name="education">
                    <option value="">请选择</option>
                    <option value="01">博士</option>
                    <option value="02">硕士及以上</option>
                    <option value="03">本科</option>
                    <option value="04">专科</option>
                    <option value="05">高中及以下</option>
                    <option value="06">初中及以下</option>
                    <option value="07">无</option>
                </select>
            </span>
            <span><i style="float:left;"><em style="color:red;">*</em>证件类型：</i>
            	<input class="dropdown" data-settings='{"wrapperClass":"flat"}' disabled="disabled" type="text" id="idType" name="idType" value="身份证"/>
            </span>
            <span><i style="float:left;"><em style="color:red;">*</em>婚姻状况：</i>
                <select class="dropdown" data-settings='{"wrapperClass":"flat"}' id="maritalStatus" name="maritalStatus">
                    <option value="01">未婚</option>
                    <option value="02">已婚</option>
                </select>
            </span>
        	<span><em style="color:red;">*</em>电子邮箱： <input type="text" name="email" id="email" maxlength="40"/></span>
        	<span><em style="color:red;">*</em>手机号码： <input type="text" name="phoneNumber" id="phoneNumber" maxlength="11"/></span>
        </div>
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
<script src="${resource_dir}/js/jquery.easydropdown.js"></script>
</body>
</html>
