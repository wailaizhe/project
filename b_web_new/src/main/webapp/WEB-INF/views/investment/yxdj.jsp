<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>首页-晋城农商银行蒲公英金融服务平台</title>
<meta name="description" content="晋城农商银行晋城农村信用社蒲公英金融服务平台p2p投融资平台"/>
<meta name="keyword" content="晋城农商银行,晋城农村信用社,蒲公英金融服务平台,p2p投融资平台"/>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
<link rel="stylesheet" href="${resource_dir}/css/easydialog.css" type="text/css"/>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
<script type="text/javascript">
function fillPhoneNo(){
	if(isLand()){
		$("#mobilePhone").val(landFlag);
	}
}
var landFlag="03";
function isLand(){
	$.ajax({
			async: false,
			type: "post",
			url: "${ctx}/account/indexIsLand?t="+Math.random(),
			success: function (msg) {
				landFlag = msg;
			}
	});
	if(landFlag=="03"||landFlag.length>20){//未登录
	    return false;  
	}else{
		return true;
	}
}

function checkCoder(){    
	    var checkCode = $("#checkCodek");    
	    var src = "${ctx}/authimg?codeType=checkCode&now="+Math.random();   
	    checkCode.attr("src",src);    
}  
function gotoMyBenefit(){
	window.location.href='${ctx}/account/myassets';
}
function gotoRegist(){
	window.location.href='${ctx}/baseInfo/register';
}
function amountFun(){
	$("#amount").focus();
}
function annualYieldFun(){
	$("#annualYield").focus();
}
function investDeadlineFun(){
	$("#investDeadline").focus();
}
function investorFun(){
	$("#investor").focus();
}
function mobilePhoneFun(){
	$("#mobilePhone").focus();
}
function emailFun(){
	$("#email").focus();
}
function checkCoderFun(){
	$("#checkCoder").focus();
}
function Send_Submit(){
	var amount = $("#amount").val();
	var annualYield = $("#annualYield").val();
	var investDeadline = $("#investDeadline").val();
	var investor = $("#investor").val();
	var mobilePhone = $("#mobilePhone").val();
	var email = $("#email").val();
	
	if(amount == "最低一万"){
		warnMsg("请输入投资金额!","确定",amountFun);
	 	return;
	}else if(amount <= 0){
		warnMsg("可投金额低于一万","确定",amountFun);
	 	return;
	}else if(annualYield == "最高20"){
		warnMsg("请填写期望年化收益率","确定",annualYieldFun);
	 	return;
	}else if(annualYield > 20){
		warnMsg("期望年化收益率超过20%","确定",annualYieldFun);
	 	return;
	}else if(investor == "请输入联系人"){
		warnMsg("请填写联系人","确定",investorFun);
	 	return;
	}else if(mobilePhone == "请输入手机号"){
		warnMsg("请填写手机号","确定",mobilePhoneFun);
	 	return;
	}else if(email == "请输入邮箱地址"){
		warnMsg("请填写邮箱地址","确定",emailFun);
	 	return;
	}
		var investreg = /^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,1})?$/;
		var investreg2 = /^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/;
		if (!investreg.test(amount)) {
            warnMsg("可投资金额格式错误，只保留一位小数！","确定",amountFun);         
            return false;
        }
        if (!investreg2.test(annualYield)) {
            warnMsg("期望年化收益率格式错误，只保留两位小数！","确定",annualYieldFun);  
            return false;
        }
		var reg = /^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
	        if (!reg.test(mobilePhone)) {
	            warnMsg("请输入正确的手机号","确定",mobilePhoneFun);  
	            return false;
	        }
	    var regu = /^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$/;
	    	if (!regu.test(email)) {
	            warnMsg("请输入正确的电子邮箱","确定",emailFun); 
	            return false;
	        }
	var model = {};
    model.amount = amount;
    model.annualYield = annualYield;
    model.investDeadline = investDeadline;
    model.investor = investor;
    model.mobilePhone = mobilePhone;
    model.email = email;
    
    var coder = $("#checkCoder").attr("value");
	if(coder.length<4||coder=="请输入图片验证码"){
	    warnMsg("请输入4位图片验证码!","确定",checkCoderFun); 
	    checkCoder();
	    return;
	}
    coder = "c=" + coder+"&codeType=checkCode";
    $.ajax({
			type: "post",
			url: '${ctx}/authcode/validate',
			data: coder,
			success: function (msg) {
				 if(msg == "OK"){
					    var url = "${ctx}/invest/saveInvestInfo";
					    $.ajax({
					        url: url,
					        async: false,
							type: "post",
					        data: "investJson="+JSON.stringify(model),
					        error: function (msg) { alert("网络链接异常，请稍后再试！"); },
					        success: function (msg) {
					               $(".tan_main").html("");
					               $(".tan_main").append("<h3><i class='suc_icon'></i>提交成功！</h3><span>我们将根据您的意向，筛选合适的项目并通知您，敬请留意。</span>");
					        }
					    });
    		    }else{
				   warnMsg(msg,"确定",checkCoderFun);
				   checkCoder();
				  $("#loginCode").focus(); 
			}
		}
	});
}
</script>
</head>
<body>
<!--头部开始-->
<%@ include file="../header.jsp"%>
		<form name="submitForm" method="post" action="">
			<input type="hidden" name="hiddenData" id="hiddenData">
		</form>
		<!--投资意向登记弹出层开始-->
		<div id="popupLayer" class="popup-layer" style="text-align:center;">
			<div id="popupLayerBox" class="popup-layer-box">
				<div class="yx_tan">
					<h3 class="yx_top"><i class="yx_icon"></i> 投资意向登记</h3>
					<div class="tan_main">
						<ul>
							<li class="five">
								<font style="color: red">* </font>可投资金额 :
								<input id="amount" value="最低一万" onkeyup="value=value.replace(/[^\d.]/g,'') "  onfocus="if (value =='最低一万'){value =''}"onblur="if (value ==''){value='最低一万'}"/>万元
							</li>
							<li class="seven">
								<font style="color: red">* </font>期望年化收益率 :
								<input id="annualYield" value="最高20" onkeyup="value=value.replace(/[^\d.]/g,'') "  onfocus="if (value =='最高20'){value =''}"onblur="if (value ==''){value='最高20'}"/>%以上
							</li>
							<li class="four">
								<font style="color: red">* </font>投资期限 :
								<select id="investDeadline">
									<option value="3">
										3个月
									</option>
									<option value="6">
										6个月
									</option>
									<option value="12">
										12个月
									</option>
								</select>
							</li>
							<li class="three">
								<font style="color: red">* </font>联系人 :
								<input id="investor" value="请输入联系人" onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'')" onfocus="if (value =='请输入联系人'){value =''}"onblur="if (value ==''){value='请输入联系人'}"/>(请输入中文名)
							</li>
							<li class="four">
								<font style="color: red">* </font>手机号码 :
								<input id="mobilePhone" value="请输入手机号" maxlength="11" onkeyup="value=value.replace(/[^\d]/g,'') " onfocus="if (value =='请输入手机号'){value =''}"onblur="if (value ==''){value='请输入手机号'}"/>
							</li>
							<li class="three">
								<font style="color: red">* </font>E-mail :
								<input id="email" value="请输入邮箱地址" onfocus="if (value =='请输入邮箱地址'){value =''}"onblur="if (value ==''){value='请输入邮箱地址'}"/>
							</li>
							<li class="three">
								<font style="color: red">* </font>验证码 :
								<input style="width: 120px;" id="checkCoder" value="请输入图片验证码" onfocus="if (value =='请输入图片验证码'){value =''}"onblur="if (value ==''){value='请输入图片验证码'}"/>
							     <img id="checkCodek" src="${ctx}/authimg?codeType=checkCode"/>      
				                 <a href="javascript:void(0);" onclick="checkCoder()">换一张</a>    
							</li>
						</ul>
						<p>
							<i class="imp"></i> 登记意向后，若有符合需求的项目，我们将第一时间通知您。
						</p>
						<div class="tan_btn" style="cursor:pointer;">
							<a onclick="Send_Submit()">提交</a>
						</div>
					</div>
				</div>
			</div>
		</div>
<!--投资意向结束-->
<!--底部开始--> 
<%@ include file="../foot.jsp"%>
<!--底部结束-->
</body>
</html>