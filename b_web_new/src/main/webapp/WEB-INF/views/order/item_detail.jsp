	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<title>项目详情-晋城农商银行蒲公英金融服务平台</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
<link href="${resource_dir}/css/public.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/header_footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/jc_easydialog.css"/>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.extend.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>
<script type="text/javascript" src="${resource_dir}/js/share.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>
<script type="text/javascript">
	$(function(){
		$("#Navi_tab2 li").click(function(){
			$(this).addClass("tab_on").siblings().removeClass("tab_on");
			if($(this).attr("id")=="Navi_tab2_0"){
				$(".tab-list").hide();
				$("#Navi_box2_0").show();
			}
			if($(this).attr("id")=="Navi_tab2_1"){
				$(".tab-list").hide();
				$("#Navi_box2_1").show();
			}
			if($(this).attr("id")=="Navi_tab2_2"){
				$(".tab-list").hide();
				$("#Navi_box2_2").show();
			}
		});
	});
</script>
<script language="javascript" type="text/javascript"> 
//处理结果
function ToDigits2(floatVal) {
    var strResult = parseFloat(floatVal).toFixed(4).toString();
    return parseFloat(strResult.substr(0, strResult.length - 2));
}
    
//利息计算
function CalculateInterest(amount, rate, daysCount) {
    var interest = (amount * rate / 360) * daysCount;
    return ToDigits2(interest);
}

//加号
    function add(obj) {
    	var investUnitFee =  parseInt($("#investUnitFee").html());//获取最小投资单位
	    var surplus = parseInt($("#surplus").html());
        var inputInvestFee = parseInt($.trim(parseInt(obj.val())));
		var isNewUserItem = $("#isNewUserItem").val();
		var newUserQuota = parseInt($("#newUserQuota").val());
       // var reminMount = Math.floor(surplus/investUnitFee) ;
       if(inputInvestFee != ""){
	       	if(inputInvestFee>=surplus){//当加的金额大于等于剩余金额
	       		obj.val(surplus);
	       	}else{
	       		if(isNewUserItem == "01"){//新用户专享
	       			if(inputInvestFee >= newUserQuota){
	       				obj.val(newUserQuota);
	       				alert("限额为"+newUserQuota+"元");
	       			}else{
	       				obj.val(inputInvestFee+investUnitFee);
	       			}
	       		}else{
		       		obj.val(inputInvestFee+investUnitFee);
	       		}
	       	}
       		//$("#leftTotalMoney").text(FormatDigital(surplus - parseInt($.trim(obj.val()))));
       }
	    /**
	    if(reminMount<=10){
	    	reminMount =reminMount-1;
        	reminMount = reminMount < 0 ? 0 : reminMount;
	    	$("#reminMount").html("目前该项目您最多可投"+reminMount+"份");
		    $("#reminMount").show();
	    }else{
	    	$("#reminMount").hide();
	    }
	    */
  		//利息计算
        $("#currentIncome").html(CalculateInterest(parseFloat(obj.val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
        //抵扣金额计算
        if($("#coincheckbox").attr("checked")==true){
        	var deFeeAndUsedCoin = calDeductionFee(parseFloat($("#FinanCount").val()),parseFloat($("#bankRate").val()),parseInt($("#currentDay").text()),parseInt($("#coinCountHidden").val()));
	    	var deFee = deFeeAndUsedCoin.split("-")[0];
	    	var usedCoin = deFeeAndUsedCoin.split("-")[1];
	    	insertVal(usedCoin,deFee);
        }else{
	        $("#realFinanCount").text(FormatDigital($("#FinanCount").val()));
        }
   }
   
   //减号
   function del(obj){
   		var investUnitFee =  parseInt($("#investUnitFee").html());//获取最小投资单位
   		var minInvest = parseInt($("#minInvestAmount").text());//起投金额
   		var reminTotalFee  = parseInt($.trim($("#surplus").html()));
        var inputInvestFee = $.trim(parseInt(obj.val()));
        //var reminMount = Math.floor(reminTotalFee/investUnitFee) ;
   		//var finanCount = parseInt(obj.val());
   		/**
	    if(reminMount<=10){
	    	$("#reminMount").html("目前该项目您最多可投"+reminMount+"份");
		    $("#reminMount").show();
	    }else{
	    	$("#reminMount").hide();
	    }
	    */
	    if($.trim(inputInvestFee) != "" &&  inputInvestFee > minInvest){
	    	obj.val(inputInvestFee-investUnitFee);
	    	//$("#leftTotalMoney").text(FormatDigital(reminTotalFee - parseInt($.trim(obj.val()))));
	    	$("#hiddenleftTotalMoney").val(reminTotalFee - parseInt($.trim(obj.val())));
	    	var str=parseInt(obj.val());
	    	
	    	//利息计算
        	$("#currentIncome").html(CalculateInterest(parseFloat(obj.val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    }
	    if($.trim(inputInvestFee) != "" &&  inputInvestFee < minInvest){
	   	 	obj.val(minInvest);
	   	 	//$("#leftTotalMoney").text(reminTotalFee - parseInt($.trim(obj.val())));
	   	 	$("#hiddenleftTotalMoney").val(reminTotalFee - parseInt($.trim(obj.val())));
	    }
	    //抵扣金额计算
        if($("#coincheckbox").attr("checked")==true){
	        var deFeeAndUsedCoin = calDeductionFee(parseFloat($("#FinanCount").val()),parseFloat($("#bankRate").val()),parseInt($("#currentDay").text()),parseInt($("#coinCountHidden").val()));
	    	var deFee = deFeeAndUsedCoin.split("-")[0];
	    	var usedCoin = deFeeAndUsedCoin.split("-")[1];
	    	insertVal(usedCoin,deFee);
	    }else{
	    	 $("#realFinanCount").text(FormatDigital($("#FinanCount").val()));
	    }
    }
    
    //手动输入
    function PartsCountChange(obj){
        var investUnitFee =  parseInt($("#investUnitFee").html());
        var minInvest = parseInt($("#minInvestAmount").text());//起投金额
        var reminTotalFee  = parseInt($.trim($("#surplus").html()));
        var inputValue = parseInt($.trim(obj.val()));
        var inputValueStr = $.trim(obj.val());
        var inputValueStr = obj.val();
        var isNewUserItem = $("#isNewUserItem").val();
		var newUserQuota = parseInt($("#newUserQuota").val());
    	var numreg = /^-?\d+$/;
		if(numreg.test(inputValueStr)){
			if(inputValue != "" && inputValue>=reminTotalFee){
				if(isNewUserItem == "01"){//是新用户专项
					if(inputValue > newUserQuota){//输入金额大于新用户专属项目限额
						alert("限额为"+newUserQuota+"元");
						obj.val(newUserQuota);
					}
				}else{//不是新用户专项
					obj.val(reminTotalFee);
				}
			}
			if(inputValueStr != "" && inputValue<minInvest){
				obj.val(minInvest);
				//$("#leftTotalMoney").text(FormatDigital(reminTotalFee - parseInt($.trim(obj.val()))));
			}
			if(inputValue != "" && inputValue>minInvest && inputValue<reminTotalFee){
				var temp = Math.floor(inputValue/investUnitFee);
				if(isNewUserItem == "01"){//是新用户专项
					if(inputValue > newUserQuota){//输入金额大于新用户专属项目限额
						alert("限额为"+newUserQuota+"元");
						obj.val(newUserQuota);
					}else{
						obj.val(inputValue);
					}
				}else{//不是新用户专项
					obj.val(temp*investUnitFee);
				}
			}
			 /**
			 var currentVal = parseInt($.trim(obj.val()));
			 var reminMount = Math.floor((reminTotalFee-currentVal)/investUnitFee) ;
		    
		    if(reminMount<=10){
		    	//alert("还剩最后 "+reminMount+" 份可投标了!");
		    	$("#reminMount").html("目前该项目您最多可投"+reminMount+"份");
		    	$("#reminMount").show();
		    }else{
	    		$("#reminMount").hide();
	    	}
	    	*/
	    	$("#hiddenleftTotalMoney").val(reminTotalFee - parseInt($.trim(obj.val())));
	    	//最后10条时提示
  			//$("#remain").html(Remain(parseInt($("#surplus").html()),parseInt($("#FinanCount").val())));
			//利息计算
        	$("#currentIncome").html(CalculateInterest(parseFloat(obj.val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
			
	    }else{
		    alert("金额格式错误，请输入整数！");
		    obj.val(minInvest);
		    $("#hiddenleftTotalMoney").val(reminTotalFee - parseInt($.trim(obj.val())));
		    //$("#leftTotalMoney").text(FormatDigital(reminTotalFee - parseInt($.trim(obj.val()))));
		    $("#currentIncome").html(CalculateInterest(parseFloat(obj.val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
		}
		//抵扣金额计算
		if($("#coincheckbox").attr("checked")==true){
			var deFeeAndUsedCoin = calDeductionFee(parseFloat($("#FinanCount").val()),parseFloat($("#bankRate").val()),parseInt($("#currentDay").text()),parseInt($("#coinCountHidden").val()));
	    	var deFee = deFeeAndUsedCoin.split("-")[0];
	    	var usedCoin = deFeeAndUsedCoin.split("-")[1];
	    	insertVal(usedCoin,deFee);
		}else{
			 $("#realFinanCount").text(FormatDigital($("#FinanCount").val()));
		}
    }
    
    //计算抵扣的金额和使用的金币数量
    function calDeductionFee(_finanCount,_bankRate,_period,_coinCount){
    	var deductionFee = 0;//抵扣的费用
    	var usedCoinCount = 0;//抵扣费用所用的金币数
    	//计算此投资金额可以花去多少金币
    	var bankIncome = CalculateInterest(parseFloat(_finanCount), parseFloat(_bankRate) / 100, parseInt(_period)).toFixed(2);
    	var bankCoinCount = bankIncome*10;
    	bankCoinCount = Math.floor(bankCoinCount);//获取可使用的最大金币数（用银行的收益倒推出来）
    	var maxdeductionFee = bankCoinCount/10;//计算最大可抵用的金额
    	if(_coinCount>=bankCoinCount){//用户的金币数大于等于 银行的收益倒推出来的金币数
    		deductionFee = maxdeductionFee;
    		usedCoinCount = bankCoinCount;
    	}else{
    		deductionFee = _coinCount/10;
    		usedCoinCount = _coinCount;
    	}
    	return deductionFee+"-"+usedCoinCount;
    }
    
    //给抵用的金额赋值
    function insertVal(_coinCount,_deductionFee){
    	$("#coinCount").text(_coinCount);
    	$("#deductionFee").text(FormatDigital(_deductionFee));
    	$("#realFinanCount").text(FormatDigital($("#FinanCount").val()-_deductionFee));
    }
    
    //金币复选框切换
    function toggleCoinCheckBox(){
    	if($("#coincheckbox").attr("checked")==true){
    		var deFeeAndUsedCoin = calDeductionFee(parseFloat($("#FinanCount").val()),parseFloat($("#bankRate").val()),parseInt($("#currentDay").text()),parseInt($("#coinCountHidden").val()));
	    	var deFee = deFeeAndUsedCoin.split("-")[0];
	    	var usedCoin = deFeeAndUsedCoin.split("-")[1];
	    	insertVal(usedCoin,deFee);
    	}else{
    		insertVal(0,0);
    	}
    }

function bidCommit(_button){
		var specialFlag = $.trim($("#specialFlagId").val());//专属
		var openFlag =  $.trim($("#openFlagId").val());//公开(不需要识别码)
		var whiteFlag = $("#whiteItem").val();
		var inputValue = $("#FinanCount").val();
		var numreg = /^-?\d+$/;
		if(!numreg.test(inputValue)){
			alert("金额格式错误，请输入整数！");
			return;
		}
		var registerType = $("#registerTypeId").val();
		if(registerType != "" && $("#registerTypeId").val() == '02'){
			alert("您是企业用户不可以投标");
			return false;
		}
		var identificationCode;
		var itemId = $("#itemId").val();
		var isNewUserItem = $("#isNewUserItem").val();
		if(specialFlag == "01"){//是专属项目 
			if(openFlag == "01"){// 不需要要输入验证码
				identificationCode = "1";
			}else{// 需验证码
				identificationCode = $.trim($("#identificationCode").val());//获取验证码
			}
		}else{//非专属项目
			identificationCode = "1";
		}
		var yzmFlag = ""; //验证码
		var newUser = ""; //是不是新用户
		var whiteItemLimit = ""; // 白名单还剩的限额
		var isWhiteUser = "";//是不是白名单用户
		$.ajax({
		    type:"post",
		    data:"itemId="+itemId+"&investorCode="+identificationCode,
		    async:false,
			url:"${ctx}/arcOrder/valInvestorCode",
			success:function(result){
				yzmFlag = result.yzm;
				newUser = result.newUserFlag;
				isWhiteUser = result.whiteFlag;
				whiteItemLimit = parseInt(result.limit);
			}
		});
		if(specialFlag == "01" && openFlag != "01" && whiteFlag != "01"){//白名单项目是专属但不用填验证码
			if($.trim($("#identificationCode").val()) == ""){
				alert("请输入识别码");
				return;
			}
			if(yzmFlag == "no"){
				alert("识别码错误");
				return;
			}
		}
		
		if(whiteFlag == "01"){// 白名单项目
			if(isWhiteUser == "no"){// 不在白名单内
				alert("项目是白名单项目，请选择其他项目进行投资");
				return;
			}else{
				if(inputValue > whiteItemLimit){// 输入金额大于限额
					alert("您的剩余限额为"+whiteItemLimit+"元");
					return;
				}
			}
		}
		
		if(isNewUserItem == "01"){
			if(newUser == "no"){
				alert("您是资深用户，新手专享标仅供新用户投资");
				return;
			}
		}
  		//通过location方式提交，是为了避免下个页面刷新时弹出重试消息框 --add by zhangwei
  		var benjin = parseInt($.trim($("#FinanCount").val())).toString();
  		window.location.href = "${ctx}/arcOrder/orderConfirm?fkItemId="+$("#itemId").val()+"&invCode="+identificationCode+"&capital="+strEnc(benjin,'${key}')+"&income="+strEnc($("#currentIncome").text(),'${key}')+"&realFinanCount="+strEnc($("#realFinanCount").text(),'${key}')+"&usedCoin="+strEnc($("#coinCount").text(),'${key}');
  	}
    
$(function () {
	 	var investUnitFee =  parseInt($("#investUnitFee").html());
	 	var minInvest = parseInt($("#minInvestAmount").text());//起投金额
        var reminTotalFee  = parseInt($.trim($("#surplus").html()));
        var inputMoney = parseInt($.trim($("#FinanCount").val()));
        var reminMount = Math.floor(reminTotalFee/investUnitFee) ;
        //$("#hiddenleftTotalMoney").val(reminTotalFee - inputMoney);
        var itemStatus = $("#itemStatusTemp").val();
        var isNewUserItem = $("#isNewUserItem").val();
        var newUserQuota = $("#newUserQuota").val();
        var whiteItem = $("#whiteItem").val();
        
	    if(itemStatus == "01"){
	    	$("#leftTotalMoney").text(FormatDigital(reminTotalFee));
	    	$("#currentIncome").html(CalculateInterest(parseFloat(minInvest), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    }
	    if(itemStatus == "02"){
	    	$("#leftTotalMoney").text(FormatDigital(reminTotalFee));
	    	if(reminTotalFee<minInvest){
	    		$("#fillIn-Input-box").find("a").removeAttr("onclick");
	    		//$("#leftTotalMoney").text(reminTotalFee);
	    		$("#currentIncome").html(CalculateInterest(reminTotalFee, parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    		$("#fillIn-Input-box").find("a").css({"background-color":"#ededed","cursor":"default"});
	    		$("#fillIn-Input-box").find(".del").css("background-position","-331px -339px")	
	    		$("#fillIn-Input-box").find(".add").css("background-position","-360px -339px")
	    	}else{
	    		$("#currentIncome").html(CalculateInterest(parseFloat(minInvest), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    	}
	    	if(reminMount<=10){
	    		if(isNewUserItem =="01"){// 新手项目
	    			if(newUserQuota < reminTotalFee){// 如果限额小于剩余金额
	    				$("#reminMount").html("目前该项目您最多可投"+Math.floor(newUserQuota/investUnitFee)+"份");
	    				$("#reminMount").show();
	    			}else {
	    				$("#reminMount").html("目前该项目您最多可投"+reminMount+"份");
	    				$("#reminMount").show();
	    			}
	    		} else if (isNewUserItem =="01"){// 新手项目
	    			$("#reminMount").hide();
	    		}else{
	    			$("#reminMount").html("目前该项目您最多可投"+reminMount+"份");
	    			$("#reminMount").show();
	    		}
	    		
	    	}
	    	var deFeeAndUsedCoin = calDeductionFee(parseFloat($("#FinanCount").val()),parseFloat($("#bankRate").val()),parseInt($("#currentDay").text()),parseInt($("#coinCountHidden").val()));
	    	var deFee = deFeeAndUsedCoin.split("-")[0];
	    	var usedCoin = deFeeAndUsedCoin.split("-")[1];
	    	insertVal(usedCoin,deFee);
	    }
	    if(itemStatus == "03"){
	    	$("#leftTotalMoney").text("0.00");
		    $("#currentIncome").html(CalculateInterest(parseFloat(minInvest), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    }
	    
	     //借款协议弹框
		$('#jkxy').click(function(){
	        var chks = $('#tan').html();
	        easyDialog.open({
	            container : {
	                header : ' ',
	                content :chks
	            },
	            fixed : false
	        });
	    });
	    
	    toggleCoinCheckBox();
});
	
	function GetRTime(){
		var endDate = $("#backwardsDate").val();
		if(endDate== null || endDate == undefined){
			return;
		}
        var EndTime= new Date(endDate); 
        var t =EndTime.getTime() - fwqSjSecMill;//fwqSjSecMill是全局变量，在页面底部定义的
        var d=Math.floor(t/1000/60/60/24);
        var h=Math.floor(t/1000/60/60%24);
        var m=Math.floor(t/1000/60%60);
        var s=Math.floor(t/1000%60);
        var itemStatus = $("#itemStatusTemp").val();
        if(d<=0&&h<=0&&m<=0&&s<=0){
        	if(itemStatus=="01"){
	        	//$("#djsText").text("预热已结束，请刷新页面！");
	        	location.reload();
        	}
        	if(itemStatus=="02"){
        		//$("#djsText").text("投标已结束，请刷新页面！");
        		location.reload();
        	}
        	$("#t_d").text("");
        	$("#t_h").text("");
        	$("#t_m").text("");
        	$("#t_s").text("");
        }else{
        	$("#t_d").html(d + "天");
	        $("#t_h").html(h + "小时");
	        $("#t_m").html(m + "分");
	        $("#t_s").html(s + "秒");
	        fwqSjSecMill+=1000;
        }
    }
    setInterval(GetRTime,1000); 
</script>
		<script type="text/javascript">
	//初始化
	$(function () {
	<c:forEach items="${repaysourceMap}" var="repaysource">
		$("#${repaysource.key}").html("${repaysource.value}");
	</c:forEach>
	});
	
</script>
<script type="text/javascript">
  	$(function(){
  		<!--alt解释标签-->
		$(".jieshi").mousemove(function (e) {
			var postX = e.pageX;
			var postY = e.pageY;
			var myText = $(this).attr("alt");
			$(".mouseTips").css({ "left": postX - 10, "top": postY - 40, "display": "block" })
			$(".mouseTips").html(myText + "<i></i>");
		})
		$(".jieshi").mouseout(function () {
			var myText = $(this).attr("alt");
			$(".mouseTips").hide()
			$(".mouseTips").html(myText + "<i></i>");
		})
  	});
</script>
	</head>

	<body>
		<%@ include file="../header.jsp"%>
		<!--解释标签-->
		<DIV class=blackBg></DIV>
		<P class=mouseTips><I></I></P>
		<input id="registerTypeId" type="hidden" value="${registerType }" />
		<form name="submitbidForm" method="post" action="">
		
			<input type="hidden" name="income" id="income" value=""/>
		    <input type="hidden" name="capital" id="capital" value=""/>
			<input type="hidden" name="InviteCode" id="txt_InviteCode" value=""/>
			<input type="hidden" id="hidIsAgree" value="-1"/>
			<input id="isLand" type="hidden" value="${isLand }" />
			<input type="hidden" id="bankRate" value="${itemInfo.subBankYearRate }"/>
			<input type="hidden" id="coinCountHidden" value="${coinCount }"/>
			<input id="specialFlagId" type="hidden" value="${itemInfo.specialFlag}" />
			<input id="openFlagId" type="hidden" value="${itemInfo.openFlag}" />
			<input type="hidden" id="isNewUserItem" value="${itemInfo.isNewExclusive }"/>
			<input type="hidden" id="newUserQuota" value="${itemInfo.newUserQuota }"/>
			<input type="hidden" id="whiteItem" value="${itemInfo.whiteFlag }"/>
			<div class="warp" style="position:relative;min-height:0;">
				<div class="newbanner" style="width:1406px;left:50%;margin-left:-733px;position:absolute;z-index:1;text-align:center;">
					<img src="${resource_dir}/images/newbanner.jpg"/>
				</div>
				<div class="container">
					<div class="ui-content detail-margin">
						<div class="breadcrumb breadcrumb-other" style="color:#fff;margin:0 auto;padding:15px 0;">
							<a href="${ctx}/item/index" style="color:#fff;">首页</a>&nbsp;&gt;&nbsp;
							<a href="${ctx}/item/gotoInvestmentList" style="color:#fff;">惠赚钱</a>&nbsp;&gt;&nbsp;
							<span style="color: #fff">项目详情</span>
						</div>
						<div class="module">
							<div class="mod-wrap mod-project-detailed">
								<h3 class="pro-title">
									<span style="display:inline-block;vertical-align:middle;"><img src="${resource_dir}/images/h_icon.png"/></span>
									<span class="pro-name">${itemInfo.itemPrefix}${itemInfo.itemName}</span>
									<i class="xin jieshi" alt="晋城农商银行作为项目见证机构，已对融资方信息进行审核。项目融资方具有晋城农商银行的授信额度"></i>
									<i class="kong jieshi" alt="项目委托第三方支付公司——中金支付有限公司进行资金监管及清算服务。晋城农商银行对融资方还款环节中到期应收款项的兑付过程进行控制"></i>
									<c:if test="${itemInfo.specialFlag == '01'}">
										<i class="zhuan jieshi" style="margin-left:9px;" alt="专属项目"></i>
										<c:if test="${itemInfo.whiteFlag == '01'}">
											<i class="ding jieshi" style="margin-left:11px;" alt="白名单专享"></i>
										</c:if>
										
									</c:if>
									<c:if test="${itemInfo.isNewExclusive == '01'}">
										<i class="xszx jieshi" style="width:80px;" alt="新手专享"></i>
									</c:if>
									<input id="itemId" type="hidden" value="${itemInfo.id}" />
								</h3>
								<div class="help-share">
									<div class="ui-share">
										<ul>
										<!-- 
											<li>分享到：</li>
											<li><a class="sharebutton fx_2" id="share_sina" href="javascript:shareto('sina', '分享');" title="分享到新浪微博"></a></li>
											<li><a class="sharebutton fx_9" id="share_qq" href="javascript:shareto('qq', '分享');" title="分享到腾讯微博"></a></li>
											<li><a class="sharebutton fx_4" id="share_douban" href="javascript:shareto('douban', '分享');" title="分享到豆瓣"></a></li>
											<li><a class="sharebutton fx_1" id="share_qzone" href="javascript:shareto('qzone', '分享');" title="分享到QQ空间"></a></li>
											<li><a class="sharebutton fx_3" id="share_renren" href="javascript:shareto('renren', '分享');" title="分享到人人网"></a></li>
											 -->
										</ul>
									</div>
								</div>
								<div class="mod-content">
									<div class="pro_content">
										<div class="ui-pro-trr f-left">
											<table border="0" cellspacing="0" cellpadding="0"
												class="table_3">
												<tbody>
													<tr>
														<td width="33%">
															<p class="pro-lable">预期年化收益率</p>
															<p><span class="fz-40 red" id="currentYint">${itemInfo.investerYearRate}</span><span class="fz-24 red">%</span></p>
														</td>
														<td width="33%">
															<p class="pro-lable">期限</p>
															<p><span class="fz-40" id="currentDay">${itemInfo.financePeriod}</span><span class="fz-18">天</span></p>
														</td>
														<input id="itemProgressId" type="hidden" value="${itemInfo.itemProgress}" />
														<td width="33%">
															<p class="pro-lable">融资规模</p>
															<p>
																<span class="fz-40" id="lbleveryDay" style="font-size: 17px;font-weight:bold;"><fmt:formatNumber value="${itemInfo.maxFinanceMoney}" pattern="#,#00.00#"/></span>
																<span class="fz-18">元</span>
															</p>
														</td>
														<td width="26%"></td>
													</tr>
												</tbody>
											</table>
											<div class="lit_jd">融资进度<span class="jdnews"><em style="width:${itemInfo.itemProgress}%;"></em></span><span>&nbsp;${itemInfo.itemProgress}%</span></div>
											<input type="hidden" id="fwqNowTime" value='<fmt:formatDate value="${nowTime }" pattern="yyyy/MM/dd HH:mm:ss" />'/>
											<div class="ui-other" style="width: 100%;">
												<div class="ui-lable" style="width: 100%; margin-top: 10px;">
			                                             项目起息日：<span style="color: #333;padding-right:20px;"><fmt:formatDate value="${itemInfo.interestStartDate}" pattern="yyyy-MM-dd" /></span>
			                                        <span style="width:170px;">项目到期日：<em style="color: #333;font-style:normal;"><fmt:formatDate value="${itemInfo.financeEndDate}" pattern="yyyy-MM-dd" /></em></span>
													<span style="background-position:left 5px" class="pro-safe jieshi" alt="指平台将项目产生的利息和本金在项目到期日向出资人清算">一次性还本付息</span>
			                                    </div>
												<div class="ui-lable" style="width: 100%; margin-top: 10px;">
													见证银行：
													<span> <img src="${resource_dir}/images/bank_hr.png" alt="晋城农商银行" title="晋城农商银行" align="absmiddle">
													</span>
												</div>
											</div>
										</div>
										<div class="ui-pro-date f-right">
											<div class="item">
												剩余可投金额：
												<span id="surplus" style="display: none;">${itemInfo.maxFinanceMoney-total}</span>
												<strong id="leftTotalMoney"></strong> 元
											</div>
											<div class="item">
												起投金额：
												<strong id="minInvestAmount1"><fmt:formatNumber value="${itemInfo.investUnitFee*itemInfo.minInvestAmount}" pattern="#,#00.00#" /></strong>元
												<span id="minInvestAmount" style="display:none;">${itemInfo.investUnitFee*itemInfo.minInvestAmount}</span>
												<span style="display:none;" id="investUnitFee">${itemInfo.investUnitFee}</span>
												<input type="hidden" id="remain" />
												<input type="hidden" id="minInvestAmountHidden" value="${itemInfo.minInvestAmount }">
											</div>
											<c:if test="${itemInfo.itemStatusTemp == '01'}">
												<div class="item">预期收益：<b id="currentIncome"></b>元</div>
											</c:if>
											<c:if test="${itemInfo.itemStatusTemp == '02'}">
												<div class="fillIn-Input-box" id="fillIn-Input-box">
													<div class="fillIn-Input">
														<span class="tt">金&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;额：</span>
														<c:if test="${(itemInfo.maxFinanceMoney-total) <= (itemInfo.investUnitFee*itemInfo.minInvestAmount) }">
															<a href="javascript:void(0)" onclick="del($('#FinanCount'))" class="del" disabled="disabled"></a>
															<input type="text" class="textFild" id="FinanCount" name="PartsCount" disabled="disabled" 
																onblur="PartsCountChange($('#FinanCount'))" value="<fmt:formatNumber value='${itemInfo.maxFinanceMoney-total}' pattern="#00" />">
															<a href="javascript:void(0)" onclick="add($('#FinanCount'))" class="add" disabled="disabled"></a><span class="tt">元</span>&nbsp;
														</c:if>
														<c:if test="${(itemInfo.maxFinanceMoney-total) > (itemInfo.investUnitFee*itemInfo.minInvestAmount) }">
															<a href="javascript:void(0)" onclick="del($('#FinanCount'))" class="del"></a>
															<input type="text" class="textFild" id="FinanCount" name="PartsCount1"
																onblur="PartsCountChange($('#FinanCount'))" value="${itemInfo.investUnitFee*itemInfo.minInvestAmount}">
															<a href="javascript:void(0)" onclick="add($('#FinanCount'))" class="add"></a><span class="tt">元</span>&nbsp;
														</c:if>
														<!-- txt_InvestAmount 份额转金额显示 -->
														<input id="currentAmount" type="hidden" class="textFild textFild-2" value="${itemInfo.maxFinanceMoney-total}" />
														<span> 
															<img src="${resource_dir}/images/account_img_10.png" align="absmiddle" style="margin-top: 4px;" class="jieshi" alt="投资金额为${itemInfo.investUnitFee}元的整数倍"></img>
														</span>
													</div>
													<div class="item">预期收益：<b id="currentIncome"></b>元</div>
													<div class="warning-text" style="display: none;">
													</div>
												</div>
												<div class="fillIn-Input-box" id="specialandOpenId" style="margin-bottom:10px;">
													<c:if test="${itemInfo.specialFlag == '01'}">
														<c:if test="${itemInfo.openFlag != '01'}">
															识 别 码：<input type="text" id="identificationCode" maxlength="6" style="height: 30px;line-height:30px;width:140px;margin-left:3px;font-size:16px;color:#000;font-weight:700;" />
														</c:if>
													</c:if>
												</div>
												<c:if test="${isLand == 'land'}">
													<div style="width:100%;height:45px;">
														<input id="coincheckbox" name="coincheckbox" type="checkbox" onclick="toggleCoinCheckBox()" />
														<span>可用<em id="coinCount" style="font-weight:700;"></em>金币抵用<em id="deductionFee" style="font-weight:700;"></em>元</span><br />
														<span style="display:block;padding-left:18px;margin-top:5px;">共支付<em id="realFinanCount" style="color:#f00;font-weight:700;font-size:16px;"></em>元</span>
													</div>
												</c:if>
											</c:if>
											<div id="reminMount"  class="ts_list" style="display: none;margin-top:5px;"></div>
											<div class="item btn-box" id="valButton">
												<!--按钮  -->
												<input id="itemStatusTemp" type="hidden" value="${itemInfo.itemStatusTemp}" />
												<c:if test="${itemInfo.itemStatusTemp == '01'}">
													<input type='button' value='预热中' href='javascript:void(0)' onclick="alert('产品正在预热中，您可抢购其他产品');"  class='bid-button bid-button-5 wytz'  />
													<div class="item">
														<input type="hidden" id="backwardsDate" value='<fmt:formatDate value="${itemInfo.investStartDate}" pattern="yyyy/MM/dd HH:mm:ss" />' />
														<span id="djsText">投标开始倒计时:</span>
														<span style="color: #333" id="t_d"></span><span style="color: #333" id="t_h"></span>
														<span style="color: #333" id="t_m"></span><span style="color: #333" id="t_s"></span>
													</div>
												</c:if>
												<c:if test="${itemInfo.itemStatusTemp == '02'}">
													<c:if test="${isLand == 'land'}">
														<input type='button' value='马上投标' onclick='bidCommit(this);' href='javascript:void(0)' class='bid-button bid-button-1 wytz' />
													</c:if>
													<c:if test="${isLand == 'noLand'}">
														<a class='bid-button bid-button-1 wytz' href='${ctx}/arcOrder/orderConfirm'>马上 <b class='b-1'>登录</b>投标 </a>
													</c:if>
													<div class="item">
														<input type="hidden" id="backwardsDate" value='<fmt:formatDate value="${itemInfo.investEndDate}" pattern="yyyy/MM/dd HH:mm:ss" />' />
														<span id="djsText">投标结束倒计时：</span>
														<span style="color: #333" id="t_d"></span><span style="color: #333" id="t_h"></span>
														<span style="color: #333" id="t_m"></span><span style="color: #333" id="t_s"></span>
													</div>
												</c:if>
												<c:if test="${itemInfo.itemStatusTemp == '03'}">
													<input type='button' value='已售罄' href='javascript:void(0)' onclick="alert('产品已售罄，您可抢购其他产品');" class='bid-button bid-button-4 wytz' />
													<div class="item"></div>
												</c:if>

											</div>
										</div>
										<div class="clear">
										</div>
									</div>
								</div>
							</div>
							<a name="none"></a>
							<div id="tab2" class="mod-wrap mod-detail">
								<ul id="Navi_tab2" class="mod-detail-tab">
									<li class="tab_on" id="Navi_tab2_0"><a href="javascript:void(0)">项目简介</a></li>
									<li class="" id="Navi_tab2_1"><a href="javascript:void(0)">项目说明书</a></li>
									<li class="" id="Navi_tab2_2"><a href="javascript:void(0)">成交记录</a></li>
								</ul>
								<!--详细-->
								<div id="Navi_box2" class="tab-list-wrap">
									<c:if test="${repaySourceType == '03' || repaySourceType == '05'}">
									<!--票据项目简介开始-->
									<div class="tab-list" id="Navi_box2_0" style="display: block;">
										<div class="ad-3">
											<h3>还款来源:</h3>
											<c:if test="${itemInfo.repaySourceType == '03'}">
												<div class="adnum">
				                                	<p>1、融资方持有未到期商业承兑汇票</p>
				                                	<p>2、该票据已经过银行检验，并代为保管</p>
			                                	</div>
				                                <div class="adz"><p>商业承兑汇票</p></div>
			                                </c:if>
			                                <c:if test="${itemInfo.repaySourceType == '05'}">
												<div class="adnum">
				                                	<p>1、融资方持有未到期银行承兑汇票</p>
				                                	<p>2、该票据已经过银行检验，并代为保管</p>
			                                	</div>
				                                <div class="adz"><p>银行承兑汇票</p></div>
			                                </c:if>
										</div>
										
										 <div class="pro-content mod-border ieyj">
	                           				 <h2 class="mod-title"><span>融资用途</span></h2>
	                           				 <c:if test="${!empty itemInfo.itemDtlInfo}" >
	                            			 <div class="txt pro-detail-text">${itemInfo.itemDtlInfo }</div>
	                            			 </c:if>
	                            			 <c:if test="${empty itemInfo.itemDtlInfo}" >
	                            			 	<div class="txt pro-detail-text">当前暂无融资信息</div>
	                            			 </c:if>
                        				 </div>
										 <div class="pro-content pro-content1 mod-border ieyj">
				                            <h2 class="mod-title">
												<span>银行见证信息</span>
											</h2>
											<div class="h_icon">
												<ul>
													<c:if test="${fn:length(requestScope.mapKey)>0}">
													<c:forEach items="${mapKey}" var="mapKey">
														<c:if test="${mapKey.key == 'YYZZ'}">
															<li><div class="li_main z1"></div><p>营业执照审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'ZZJGDMZ'}">
															<li><div class="li_main z2"></div><p>组织机构代码证审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'SWDJZ'}">
															<li><div class="li_main z3"></div><p>税务登记证审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'JBZHKHXKZ'}">
															<li><div class="li_main z4"></div><p>基本账户开启许可证审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'CLNX'}">
															<li><div class="li_main z5"></div><p>融资方成立年限审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'CYNX'}">
															 <li><div class="li_main z6"></div><p>融资方从业年限审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'SDRZ'}">
															<li><div class="li_main z7"></div><p>融资方经营场所实地认证审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'CWBB'}">
															 <li><div class="li_main z8"></div><p>审核融资方近年财务报表的真实性审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'WBLXYJL'}">
															<li><div class="li_main z9"></div><p>无不良信用记录审核通过</p></li>
														</c:if>
														<c:if test="${mapKey.key == 'cbxYYSSFS1'}">
															<li><div class="li_main z10 "></div><p>融资方在银行有授信审核通过</p></li>
														</c:if>
													</c:forEach>
													</c:if>
													<c:if test="${fn:length(requestScope.mapKey)==0}">
														<div style="font-size:14px;padding:0 30px;">无银行见证信息</div>
													</c:if>
												</ul>
											</div>
				                          </div>
				                        <div class="pro-content mod-border ieyj">
				                            <h2 class="mod-title"><span>融资说明</span></h2>
				                            <div class="detail-con-p">
				                            <p>1、融资人持有未到期汇票【编号：<span id="uu41">${repaysourceMap.billNo }</span>】做为本笔融资的还款来源。</p>
				                            <p>2、融资人持有的汇票，已通过了晋城农商银行真实性审验，并办理相关质押协议,进行汇票托管。</p>
											<div class="myVoucher">
												<div class="inner">
													<h3 class="vou-title">
														晋城农商银行汇票质押/托管信息查询结果
													</h3>
													<table border="0" cellspacing="0" cellpadding="0"
														class="ui-table-6">
														<tbody>
															<tr>
																<th width="18%">汇票编号：</th>
																<td width="32%"><span id="uuu41">${repaysourceMap.billNo }</span></td>
																<th width="18%">汇票类型：</th>
																<td width="32%">
																<span id="u42">
																	<c:if test="${itemInfo.repaySourceType == '03' }">商业承兑票据</c:if>
																	<c:if test="${itemInfo.repaySourceType == '05' }">银行承兑票据</c:if>
																</span>
																</td>
															</tr>
															<tr>
																<th>出票金额：</th>
																<td>人民币<span id="u43"><fmt:formatNumber value="${repaysourceMap.billMoney }" pattern="#,#00.00#" /></span>元</td>
																<th>&nbsp;</th>
																<td class="no-border">&nbsp;</td>
															</tr>
															<tr>
																<th>出票日期：</th>
																<td><span id="u41" style="display:none;"></span><span id="u44">${repaysourceMap.billOutDate }</span></td>
																<th>到期日期：</th>
																<td><span id="u45">${repaysourceMap.billEndDate }</span></td>
															</tr>
														</tbody>
													</table>
													<div class="note">
														<span class="red f-left">质押管理机构：晋城农商银行负责票据真实性审验并办理相关质押手续</span><span class="f-right">票据质押日期：<span id="u46">${repaysourceMap.pledgeDate }</span></span>
													</div>
													<div class="seal"></div>
												</div>
											</div>
				                            </div>
                        				</div>
									</div>
									<!-- 票据项目简介结束 -->
									</c:if>
									
									<!-- 小贷项目简介开始 -->
									<c:if test="${repaySourceType == '04' || repaySourceType == '06' || repaySourceType == '07'}">
									<div class="tab-list" id="Navi_box2_0" style="display: block;">
										<!-- <div class="ad-3">
											<img src="" alt="">
										</div> -->
										<div class="pro-content mod-border ieyj">
											<h2 class="mod-title">
												<span>融资用途</span>
											</h2>
											<div class="txt pro-detail-text">
												${itemInfo.itemDtlInfo }
											</div>
										</div>
										<div class="pro-content pro-content1 mod-border ieyj">
											<h2 class="mod-title">
												<span>银行见证信息</span>
											</h2>
											<div class="h_icon">
												<ul>
													<c:if test="${fn:length(requestScope.mapKey)>0}">
													<c:forEach items="${mapKey}" var="mapKey">
														<c:if test="${mapKey.key == 'YYZZ'}">
															<li>
						                                        <div class="li_main z1"></div>
						                                        <p>营业执照审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'ZZJGDMZ'}">
															<li>
						                                        <div class="li_main z2"></div>
						                                        <p>组织机构代码证审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'SWDJZ'}">
															<li>
						                                        <div class="li_main z3"></div>
						                                        <p>税务登记证审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'JBZHKHXKZ'}">
															<li>
						                                        <div class="li_main z4"></div>
						                                        <p>基本账户开启许可证审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'CLNX'}">
															<li>
						                                        <div class="li_main z5"></div>
						                                        <p>融资方成立年限审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'CYNX'}">
															 <li>
						                                        <div class="li_main z6"></div>
						                                        <p>融资方从业年限审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'SDRZ'}">
															<li>
						                                        <div class="li_main z7"></div>
						                                        <p>融资方经营场所实地认证审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'CWBB'}">
															 <li>
						                                        <div class="li_main z8"></div>
						                                        <p>审核融资方近年财务报表的真实性审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'WBLXYJL'}">
															<li>
						                                        <div class="li_main z9"></div>
						                                        <p>无不良信用记录审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'cbxYYSSFS1'}">
															<li>
						                                        <div class="li_main z10 "></div>
						                                        <p>融资方在银行有授信审核通过</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'RMYH'}">
															<li>
						                                        <div class="li_main z11 "></div>
						                                        <p>融资方人民银行征信记录</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'CHINA'}">
															<li>
						                                        <div class="li_main z12 "></div>
						                                        <p>中华人民共和国公民</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'WDSR'}">
															<li>
						                                        <div class="li_main z13 "></div>
						                                        <p>稳定收入认证</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'GDZS'}">
															<li>
						                                        <div class="li_main z14 "></div>
						                                        <p>固定住所认证</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'RHZX'}">
															<li>
						                                        <div class="li_main z16 "></div>
						                                        <p>人行征信记录</p>
						                                    </li>
														</c:if>
														<c:if test="${mapKey.key == 'AQMS'}">
															<li>
						                                        <div class="li_main z15 "></div>
						                                        <p>完全民事行为能力的自然人认证</p>
						                                    </li>
														</c:if>
													</c:forEach>
													</c:if>
													<c:if test="${fn:length(requestScope.mapKey)==0}">
														<div style="font-size:14px;padding:0 30px;">无银行见证信息</div>
													</c:if>
												</ul>
											</div>
										</div>
										<div class="pro-content mod-border ieyj">
											<h2 class="mod-title">
												<span>预期投资收益</span>
											</h2>
											<table cellpadding="0" cellspacing="0" class="ui-table-3"
												width="80%">
												<tbody>
													<tr>
														<th height="39">&nbsp;</th>
														<th>金额（元）</th>
														<th>还款日期</th>
													</tr>
													<tr>
														<td height="39" align="center" style="border-left: solid 1px #ccc;">预期收益</td>
														<td align="center">
															<b class="red" id="totalRate">${totoRate }</b>
															<input type="hidden" id="totalRateHidden" value="${totoRate }"/>
														</td>
														<td align="center">
															<fmt:formatDate value="${itemInfo.financeEndDate }" pattern="yyyy-MM-dd" />
														</td>
													</tr>
													<tr>
														<td height="39" align="center" style="border-left: solid 1px #ccc;">本金</td>
														<td align="center">
															<b class="red" id="benJin">${itemInfo.maxFinanceMoney }</b>
															<input id="benJinHidden" type="hidden" value="${itemInfo.maxFinanceMoney }"/>
														</td>
														<td align="center">
															<fmt:formatDate value="${itemInfo.financeEndDate }" pattern="yyyy-MM-dd" />
														</td>
													</tr>
												</tbody>
											</table>
											<p class="gray">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;免责声明：投资预期收益仅供参考，具体以实际收益为准
											</p>
										</div>
										<div class="pro-content mod-border ieyj">
											<h2 class="mod-title">
												<span>重要说明及风险提示</span>
											</h2>
											<div class="detail-con-p">
												<p>&nbsp;&nbsp;<strong>本项目为非银行存款和银行发售的理财计划，请认真阅读本重要说明及风险提示。 </strong></p>
												<p><strong>本平台郑重提示：在投资本项目前，投资人应确保自己完全明白该项投资的性质和所涉及的风险，详细了解和审慎评估该项目的资金投资方向、风险类型及预期收益等基本情况，在慎重考虑后自行决定购买与自身风险承受能力和资产管理需求匹配的产品。</strong></p>
												<p>1.本项目为
													<c:if test="${repaySourceType == '04' || repaySourceType == '06'}">
														网络借贷/资产收益权转让
													</c:if>
													<c:if test="${repaySourceType == '07'}">
														房产抵押
													</c:if>
													类产品，募集资金主要用于融资人的融资需要，如出现前述融资人未按时足额支付融资本金及收益等不利情况，则本项目将有收益为零甚至本金损失的可能。本平台不对融资人归还融资本金及收益提供任何形式的担保。</p>
												<p>2.晋城农村商业银行作为项目见证机构，仅对融资人在本平台上的披露信息进行形式审核，不对其现在及将来的资信状况、还款能力进行任何审核或评估；平台委托第三方支付机构进行资金监管及本金、收益清算。</p>
												<p>3.除本《项目说明书》中明确规定的收益及收益分配方式外，任何预计收益、测算收益或类似表述均属不具有法律约束力的用语，不代表投资人可能获得的实际收益，亦不构成本平台和项目见证机构对本项目的任何收益承诺。投资人所能获得的最终收益以本《项目说明书》所规定形式实际支付的款项为准， 且不超过根据《项目说明书》预期投资收益率计算所得的金额。</p>
												<p>4.在本项目存续期内，如因国家法律法规、监管规定发生变化，在最大可能不损害投资人利益的前提下，本平台有权单方对本项目《项目说明书》进行修订并通知投资人。有关修订将产生合同变更的法律效力。</p>
												<p>5.本平台有权依法对本《项目说明书》进行解释。 投资人若对本项目有任何疑问，可向项目见证机构咨询（咨询电话为[0356-2210820]）。</p>
											</div>
										</div>
									</div>
									</c:if>
									<!-- 小贷项目简介结束 -->
									
									<!-- 项目说明 -->
									<div class="tab-list" id="Navi_box2_1" style="display: none;">
										<div class="mod-content">
											<table class="obj-book" cellspacing="3">
												<tbody>
													<tr>
														<th>项目名称</th>
														<td><b class="red">${itemInfo.itemPrefix}${itemInfo.itemName}</b></td>
													</tr>
													<c:if test="${repaySourceType == '07'}">
														<tr>
															<th>目标客户</th>
															<td>经网站风险评估，评定为保守型、稳健型、平衡型、成长型、进取型的个人客户</td>
														</tr>
													</c:if>
													<tr>
														<th>项目融资期限</th>
														<td><b class="red">${itemInfo.financePeriod}</b> 天</td>
													</tr>
													<tr>
														<th>投资及收益币种</th>
														<td>人民币</td>
													</tr>
													<tr>
														<th>产品类型</th>
														<c:if test="${repaySourceType == '03' || repaySourceType == '05'}">
															<td>票据收益权<a id="jkxy">《借款协议》</a></td>
														</c:if>
														<c:if test="${repaySourceType == '04' || repaySourceType == '06'}">
															<td>固定期限网络借贷产品<a id="jkxy">《借款协议》</a></td>
														</c:if>
														<c:if test="${repaySourceType == '07'}">
															<td>房产抵押类产品<a href="${ctx}/help/helpCenter/houseDyXieyiImple.jsp?itemId=${itemInfo.id}" target="_blank">《借款协议》</a></td>
														</c:if>
													</tr>
													<tr>
														<th>预期年化收益率</th>
														<td><b class="red">${itemInfo.investerYearRate}%</b></td>
													</tr>
													<tr>
														<th>融资总额</th>
														<td><b class="red"><fmt:formatNumber value="${itemInfo.maxFinanceMoney }" pattern="#,#00.00#" />元</b></td>
													</tr>
													<tr>
														<th>募集期</th>
														<td>
															<b><fmt:formatDate value="${itemInfo.investStartDate}" pattern="yyyy" /></b>年
															<b><fmt:formatDate value="${itemInfo.investStartDate}" pattern="MM" /> </b>月
															<b><fmt:formatDate value="${itemInfo.investStartDate}" pattern="dd" /> </b>日～
															<b><fmt:formatDate value="${itemInfo.investEndDate}" pattern="yyyy" /> </b>年
															<b><fmt:formatDate value="${itemInfo.investEndDate}" pattern="MM" /> </b>月
															<b><fmt:formatDate value="${itemInfo.investEndDate}" pattern="dd" /> </b>日
														</td>
													</tr>
													<c:if test="${repaySourceType == '07'}">
														<tr>
															<th>收益起算日</th>
															<td>
																<b><fmt:formatDate value="${itemInfo.interestStartDate}" pattern="yyyy" /></b>年
																<b><fmt:formatDate value="${itemInfo.interestStartDate}" pattern="MM" /></b>月
																<b><fmt:formatDate value="${itemInfo.interestStartDate}" pattern="dd" /></b>日，本项目自起息日起计算收益。资金在起息日前不计算收益
															</td>
														</tr>
													</c:if>
													<tr>
														<th>到期日</th>
														<td>
															<b id="year"><fmt:formatDate value="${itemInfo.financeEndDate}" pattern="yyyy" /> </b>年
															<b><fmt:formatDate value="${itemInfo.financeEndDate}" pattern="MM" /> </b>月
															<b><fmt:formatDate value="${itemInfo.financeEndDate}" pattern="dd" /> </b>日，投资资金在项目到期日当天不计算利息
														</td>
													</tr>
													<tr>
														<th>资金到账日</th>
														<td>到期日后1-3个工作日，到期日至实际到账日之间，资金不计收益</td>
													</tr>
													<c:if test="${repaySourceType == '07'}">
														<tr>
															<th>出资范围</th>
															<td>最小出资金额<b class="red"><fmt:formatNumber value="${itemInfo.investUnitFee*itemInfo.minInvestAmount}" pattern="#,#00.00#" /></b>元，以<b class="red"><fmt:formatNumber value="${itemInfo.investUnitFee}" pattern="#,#00.00#" /></b> 元递增</td>
														</tr>
														<tr>
															<th>投资方式</th>
															<td>募集期间，投资人可登录平台，选择投资份额并通过个人网银办理个人借记卡项下资金的支付实行投资。</td>
														</tr>
													</c:if>
													<tr>
														<th>超募</th>
														<td>如多个投资人在募集期间进行的投资导致项目实际募集资金超过项目融资规模（即产生超募），平台将根据投资人的投资时间顺序将顺序在后的投资资金/部分投资资金（即超募资金）于所投项目募集期结束日的T+1日（均为工作日，非工作日将延后至下一个工作日），通过第三方支付机构向投资人指定回款账户退款</td>
													</tr>
													<tr>
														<th>节假日</th>
														<td>本项目在中国法定节假日期间亦可投标</td>
													</tr>
													<tr>
														<th>税款</th>
														<td>投资收益的应纳税款由投资人自行申报及缴纳</td>
													</tr>
													<tr>
														<th>收益计算方法</th>
														<td>期末收益＝投资本金×预期年化收益率×项目融资期限/360</td>
													</tr>
													<tr>
														<th>提前终止权</th>
														<td>投资人无权提前终止该产品或要求提前收取本金或收益</td>
													</tr>
													<tr>
														<th>其他规定</th>
														<td>到期日至实际到账日之间，投资人资金（含本金、收益、罚息等）不计收益</td>
													</tr>
													<c:if test="${repaySourceType == '07'}">
														<tr>
															<th>承保机构</th>
															<td>华安财产保险公司本息承保</td>
														</tr>
													</c:if>
													<tr>
														<th>见证机构</th>
														<td>晋城农村商业银行股份有限公司</td>
													</tr>
													<tr>
														<th>平台服务商</th>
														<td>北京蜂向信息科技有限公司</td>
													</tr>
													<tr>
														<th>第三方支付机构</th>
														<td>中金支付有限公司</td>
													</tr>
													<tr>
														<th>工作日</th>
														<td>晋城农村商业银行业务工作日</td>
													</tr>
													<tr>
														<td colspan="2" class="nobg">
															<div style="border-bottom: 1px dashed #ccc; margin-bottom: 25px;"></div>
															<div class="pro-content mod-border ieyj">
																<h2 class="mod-title" style="width:100%;">
																	<span>重要说明及风险提示</span>
																</h2>
																<p>&nbsp;&nbsp;<strong>本项目为非银行存款和银行发售的理财计划，请认真阅读本重要说明及风险提示。 </strong></p>
																<p><strong>本平台郑重提示：在投资本项目前，投资人应确保自己完全明白该项投资的性质和所涉及的风险，详细了解和审慎评估该项目的资金投资方向、风险类型及预期收益等基本情况，在慎重考虑后自行决定购买与自身风险承受能力和资产管理需求匹配的产品。</strong></p>
																<p>1.本项目为
																<c:if test="${repaySourceType == '03' || repaySourceType == '05'}">
																	票据收益权
																</c:if>
																<c:if test="${repaySourceType == '04' || repaySourceType == '06'}">
																	固定期限网络借贷
																</c:if>
																<c:if test="${repaySourceType == '07'}">
																	房产抵押
																</c:if>
																类产品，募集资金主要用于融资人的融资需要，如出现前述融资人未按时足额支付融资本金及收益等不利情况，则本项目将有收益为零甚至本金损失的可能。本平台不对融资人归还融资本金及收益提供任何形式的担保。</p>
																<p>2.晋城农村商业银行作为项目见证机构，仅对融资人在本平台上的披露信息进行形式审核，不对其现在及将来的资信状况、还款能力进行任何审核或评估；平台委托第三方支付机构进行资金监管及本金、收益清算。</p>
																<p>3.除本《项目说明书》中明确规定的收益及收益分配方式外，任何预计收益、测算收益或类似表述均属不具有法律约束力的用语，不代表投资人可能获得的实际收益，亦不构成本平台和项目见证机构对本项目的任何收益承诺。投资人所能获得的最终收益以本《项目说明书》所规定形式实际支付的款项为准， 且不超过根据《项目说明书》预期投资收益率计算所得的金额。</p>
																<p>4.在本项目存续期内，如因国家法律法规、监管规定发生变化，在最大可能不损害投资人利益的前提下，本平台有权单方对本项目《项目说明书》进行修订并通知投资人。有关修订将产生合同变更的法律效力。</p>
																<p>5.本平台有权依法对本《项目说明书》进行解释。 投资人若对本项目有任何疑问，可向项目见证机构咨询（咨询电话为[0356-2210820]）。</p>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<!--项目说明结束-->
									
									<!--成交记录-->
									<div class="tab-list" id="Navi_box2_2" style="display: none;">
										<div class="mod-content">
											<table class="ui-table-9" cellspacing="1" id="pltendpage">
												<thead>
													<tr class="tr-1">
														<th>投资人</th>
														<th>投资金额</th>
														<th>状态</th>
														<th>投资时间</th>
													</tr>
												</thead>
												<tbody id="idData">
												</tbody>
											</table>
											<!--分页-->
											<div class="mod-page" id="pagerHolder"></div>
											<!--分页结束-->
											<script id="tmpl_paylist" type="text/x-jquery-tmpl">
                                   					 {{each(i,v) Data.ResultList}}
                                        				<tr  class="tr-2">
                                           					<td>&nbsp;{{= v.mobilePhone}}</td>
                                            				<td>{{= FormatDigital(v.capital)}}元</td>
															{{if v.clientType=='MobliePhone'}} 
																<td align='center'><img src="${resource_dir}/images/icon_correct.png" alt="" />支付成功(手机)</td>
																{{else}}
																<td align='center'><img src="${resource_dir}/images/icon_correct.png" alt="" />支付成功</td>
															{{/if}}
                                            				<td>{{= v.payDate}}</td>
                                        				</tr>
                                   					 {{/each}}
                                				</script>
											<script type="text/javascript">
				                                    var payListItemId = "";
													var Data={};
				                                    $(function () {
				                                   		payListItemId = $("#itemId").val();	
				                                    	GoSearch(false, 1); 
				                                    });
				                                    function GoSearch(showpage, pi) {
				                                    	var submitData = {};
				                                    	submitData.targetUrl = "${ctx}/arcOrder/getPayList";
				                                    	submitData.condition={};
				                                    	submitData.condition.PageIndex = pi;//控制第几页
														submitData.condition.PageSize = 10;//控制每页显示条数
				                                        submitData.condition.itemId = payListItemId;//项目id
													    RenderTmpl({
													            Data: submitData,
													            TmplSource: "#tmpl_paylist",
													            TmplTarget: "#idData",
													            AfterFn:function (result) {
													                if (result.totalCount < 1) {
													                    $("#idData").html('<tr><th align="center" style="color: Red" colspan="4">暂无记录</th></tr>');
													                     //$("#pltendpage").hide();
				                                                    	 $("#pagerHolder").html("");
													                }else if(result.totalCount < submitData.condition.PageSize) {
													                    $("#pagerHolder").html("");
													                    //$(".table_head").show();
													                }else{
													                    $("#pagerHolder").html(GetPagerHtmlSpan({
													                        index: submitData.condition.PageIndex,
													                        size:  submitData.condition.PageSize,
													                        total: result.totalCount,
													                        fnName: "GoSearch"
													                    }));
													                    //$(".table_head").show();
													                 }
													            }
													        });
				                                    }
                                				</script>
										</div>
									</div>
									<!--详细结束-->
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--主体-->
			</div>
		</form>
		<div id="tan" class="buy_tan" style="display:none;background-color:#fff;">
        	 <h3>借款协议</h3>
                        <p style="display:block;text-align:right;margin:40px 10px 10px 0;">协议编号：${oredr[0].contract_number}</p>
                        <p>借出人：${realNa}</p>
                        <p>身份证号码：${identityCard}</p>
                        <p class="margin">投资申请号：${oredr[0].order_number }</p>
                        <p>借入人：${finaceName}</p>
                        <p>身份证号码（组织机构代码）：${orgNameNumber}</p>
                        <p class="margin">借款申请号：${oredr[0].loan_apply_number}</p>
                        <p class="margin">经互联网金融综合服务平台（下称“平台”）的撮合，借出人同意向借入人提供借款，借入人同意向借出人借款。经各方协商一致，现就上述借款事宜订立如下协议，以期共同遵守：</p>
                        <p>一、定义</p>
                        <p>除非缔约方另有约定，本协议下列术语定义如下：</p>
                        <p>1.1	平台：指[       ]互联网金融综合服务平台（网址为：[              ]），向借出人和借入人提供投融资信息发布与管理、投融资交易管理、交易资金结算（由平台指定的第三方支付机构提供）等服务的金融信息中介服务平台。 </p>
                        <p>1.2	借出人：指经平台撮合，向在平台发布融资需求的借入人提供借款的自然人。</p>
                        <p>1.3	借入人：指直接或间接在平台发布融资需求、并在满足本协议约定条件时获得募资的自然人或法人。</p>
                        <p>1.4	第三方支付机构：指由平台指定、为平台用户提供交易资金结算等服务的机构。本协议项下提供前述服务的机构为[中金支付有限公司]。</p>
                        <p>1.5	指定银行账户：指借出人和借入人分别在银行开立的、以接受第三方支付机构提供的查询、划转本协议项下款项等交易资金结算服务的账户。</p>
                        <p>1.6	第三方支付平台账户：指第三方支付机构在银行开立且资金独立于第三方支付机构、用于借出人和借入人之间的资金划转、结算的账户。</p>
                        <p>1.7	借款总额：是指借入人直接或间接在平台发布借款需求时所设定的所有借款金额。借款总额以平台具体展示及记录为准。借款总额包括但可能不仅限于本协议项下的借款金额。</p>
                        <p>1.8	最小借款单位：由借入人所设置的借出人的最低借款金额，借出人可按照该限额的整数倍增加借款金额。</p>
                        <p>1.9	募集期：是指借入人直接或间接在平台发布借款需求时所设定的筹资期限，该期限以平台具体展示及记录为准。募集期可由平台根据具体情况延长1-3日。</p>
                        <p>1.10	平台服务费：指借入人使用平台服务而向蜂向公司支付的费用。</p>
                        <p>二、	借款基本信息</p>
                        <div class="mes">
                        	<table>
                            	<tbody>
                                	<tr>
                                    	<td class="tit">借款总额</td>
                                    	<td>${itemInfo.maxFinanceMoney}元人民币</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">最小借款单位</td>
                                    	<td>${itemInfo.investUnitFee}元人民币</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款期限</td>
                                    	<td>${itemInfo.financePeriod}天</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款期间</td>
                                    	<td><fmt:formatDate value="${itemInfo.interestStartDate}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${itemInfo.financeEndDate}" pattern="yyyy-MM-dd" /></td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">起息日</td>
                                    	<td><fmt:formatDate value="${itemInfo.interestStartDate}" pattern="yyyy-MM-dd" /></td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款利率</td>
                                    	<td>${itemInfo.investerYearRate}%</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款用途</td>
                                    	<td>${itemInfo.itemDtlInfo}</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">还款方式</td>
                                    	<td>到期一次性还本付息</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">到期还款日</td>
                                    	<td>到期还款日如遇法定节假日，则顺延至节假日后的第一个工作日。资金实际到账时间为到期还款日后的1-3个工作日。</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p>三、	各方权利义务</p>
                        <p>3.1	借出人的权利义务</p>
                        <p>3.1.1	借出人承诺向第三方支付机构及平台提供的信息及时、合法、真实、有效，用于出借的资金来源合法且符合平台的要求。</p>
                        <p>3.1.2	借出人同意以网络页面点击确认的方式签订本协议，并不以此为由拒绝履行本协议项下的义务。借出人确认，在其指定银行账户中有足够资金且其以网络页面点击确认后即视为对借入人通过平台发出的要约的全部内容（认购的借款金额除外，可以仅认购其中不低于[   ]元的一部分）进行了承诺，即本借款协议成立。借出人同意以前述方式签订本协议后即视为不可撤销及变更地授权平台根据最终撮合结果自主生成前述信息，形成最终的本借款协议。借出人进一步确认并同意，在本协议成立后，未经平台及借入人的同意，借出人不得否认本协议项下债权债务关系或以任何方式撤回、撤销本协议。 </p>
                        <p>3.1.3	借出人理解并同意，自第三方支付机构将借款金额从其指定银行账户划转至第三方支付平台账户之日起至起息日（不含）的期间内不产生任何收益（包括但不限于利息）。借出人有权从借入人处获得借款期间内基于借款金额的约定利息收益。</p>
                        <p>3.1.4	借出人同意并授权第三方支付机构根据本协议约定从其指定银行账户中划转借款金额至第三方支付平台账户，并最终划转至借入人的指定银行账户以履行放款义务。借出人应确保在其以网络页面点击确认的方式签订本协议之时其指定银行账户中有足够的资金转入第三方支付平台账户以完成放款，否则，借出人按照本协议第3.1.2条的约定进行的承诺为无效承诺，本借款协议不成立。</p>
                        <p>3.1.5	借出人同意并授权第三方支付机构于借款到期后根据本协议约定将借入人偿还的借款本金及利息通过第三方支付平台账户划转至其指定银行账户，划转完成即视为借入人已履行还款义务。</p>
                        <p>3.1.6	借出人应保证其指定银行账户状态正常，确保资金划入、划出交易的完成。</p>
                        <p>3.1.7	借出人理解并同意，平台不承担本协议项下借出人的任何资金损失风险，但因平台及第三方支付机构原因导致借出人资金损失的除外。 </p>
                        <p>3.2	借入人的权利义务 </p>
                        <p>3.2.1	借入人承诺向平台及第三方支付机构提供的信息及时、合法、真实、有效。</p>
                        <p>3.2.2	借入人应保证借款用途合法合规。借入人未经平台、借出人同意，擅自改变借款用途的，借入人应自挪用借款之日起按照挪用借款金额每日向借出人额外支付相当于本协议第二条约定的借款利率100%的罚息。</p>
                        <p>3.2.3	借入人同意以线下签字或签章确认的方式签订本协议，即便在签订时本协议并没有借出人的信息、签订日期信息等，借入人同意将其单方签订的本协议的内容（协议编号：[         ]，包括本协议以及相应的《项目说明书》）作为通过平台向潜在借出人发出的要约。借入人同意以上述方式发出要约后即视为不可撤销及变更地授权平台为借入人寻找符合条件的一个或多个借出人并进行撮合，且借入人同意在任一借出人对借入人发出的要约进行承诺（即该借出人按照本协议第3.1.2条约定签署本协议）后，即视为不可撤销及变更地授权平台根据最终撮合结果自主生成前述信息，形成最终的本借款协议。借入人进一步确认并同意，未经平台的同意，借入人不得随意撤销该等要约，且在本借款协议成立后，未经平台及借出人的同意，借入人不得否认本协议项下债权债务关系或以任何方式撤回、撤销本协议。 </p>
                        <p>3.2.4	借入人同意并授权第三方支付机构根据本协议约定将借款金额通过第三方支付平台账户划转至借入人的指定银行账户即视为借出人履行完毕放款义务。</p>
                        <p>3.2.5	借入人应保证其指定银行账户状态正常，确保资金划入、划出交易的完成。如因前述指定银行账户不正常导致的所有损失（如借款资金无法及时入账、还款资金无法划转等）应由其自行承担。</p>
                        <p>3.2.6	借入人应按照本协议的约定到期还款并按约支付利息。</p>
                        <p>3.2.7	借入人应按照本协议第4.2条的约定向蜂向公司支付平台服务费。</p>
                        <p>3.2.8	当借入人的资信状况及还款能力出现重大不利影响时，借入人应及时通知平台、借出人或其受托人。</p>
                        <p>四、	借款发放、还款方式及逾期还款责任 </p>
                        <p>4.1	在借出人以网络页面点击确认的方式签订本协议的同时，即授权第三方支付机构自借出人指定银行账户中划转相当于本协议项下借款金额的款项至第三方支付机构的第三方支付平台账户，第三方支付机构将根据平台的指令于起息日前将本协议对应的借款金额从第三方支付平台账户划转至借入人的指定银行账户。</p>
                        <p>4.2	自第三方支付机构将本协议项下借款金额自第三方支付平台账户划转至借入人的指定银行账户时即视为借出人履行了放款义务。 借入人理解并同意在借款发放时，借入人委托第三方支付机构从前述借款金额中将借入人平台服务费直接扣除并划转至蜂向公司指定银行账户。即便存在前述平台服务费的扣除安排，借入人仍应按照本协议的借款金额到期偿还本金和支付利息。</p>
                        <p>4.3	未经平台及借出人书面同意，借入人不得提前归还借款。为避免歧义，借入人在还款日前将款项支付给平台指定的第三方支付机构的行为不视为提前归还借款的行为。</p>
                        <p>4.4	借入人按约在到期还款日14:00时前将还款金额划转至借入人的指定银行账户并不可撤销地授权见证机构或第三方支付机构代为完成还款。
借出人理解并同意，第三方支付机构最终将本协议项下的借款本息或受偿款项划转至借出人的指定银行账户需要一定的时间，前述时间一般为到期还款日后的1-3个工作日，前述期间内不产生任何投资收益（包括但不限于利息）。</p>
						<p>4.5	借入人未按本协议约定归还借款的，除应按本协议第二条的约定支付利息外，借入人应自借款逾期之日起在逾期未付款项（包括逾期未付的本金和利息）金额上每日向借出人额外支付相当于本协议第二条约定的借款利率100%的罚息，直至清偿为止。</p>
                        <p>4.6	除上述约定外，借入人还需承担因未按约还款所产生的一切费用，包括但不限于诉讼费、财产保全费、执行费、仲裁费、律师代理费、差旅费、评估费、拍卖费、催收费用等。</p>
                        <p>五、	还款保障条款 </p>
                        <p>5.1	本协议项下的还款保障方式为：</p>
                        <p>5.1.1	由[      ]提供保证担保（担保函编号为[         ]）保障，具体为[                        ]；</p>
                        <p>5.1.2	由[      ]提供抵押担保（合同编号为[         ]）保障，具体为[                        ]；</p>
                        <p>5.1.3	由[      ]提供质押担保（合同编号为[         ]）保障，具体为[                        ]。</p>
                        <p>5.2	为确保上述保障措施得以充分有效履行，借出人无条件、不可撤销及变更地授权平台以其自己的名义行使上述担保权利。</p>
                        <p>六、	违约条款</p>
                        <p>6.1	发生下列任何一项或几项情形的，视为借入人违约：</p>
                        <p>6.1.1	借入人提供的资料虚假、故意隐瞒重要事实或未经平台、借出人同意擅自转让本协议项下借款债务；</p>
                        <p>6.1.2	借入人未经平台同意，擅自撤销与平台的委托关系；</p>
                        <p>6.1.3	借入人擅自改变借款资金用途；</p>
                        <p>6.1.4	借入人提供的担保资产（如有）遭受查封或其他可能影响其履约能力的不利事件，且借入人不能及时提供有效补救措施的；</p>
                        <p>6.1.5	借入人的财务状况发生巨大恶劣变化或出现其他情形且影响其履约能力，并其不能及时提供有效补救措施的。</p>
                        <p>6.2	借入人发生上述第6.1条的违约事件，或根据借出人合理判断借入人可能发生第6.1条所述违约事件的，借出人不可撤销地委托平台采取下列任何一项或多项措施：</p>
                        <p>6.2.1	宣布已发放借款全部提前到期；</p>
                        <p>6.2.2	要求借入人在甲方宣布提前到期后的3日内，偿还所有借款金额、利息、逾期利息（如有）及其他相关费用（如有）；</p>
                        <p>6.2.3	按照约定实现本协议项下的担保权利。</p>
                        <p>6.3	借出人保留将借入人违约失信的相关信息在平台或其他媒体披露的权利。</p>
                        <p>七、	协议的签订、成立、生效及终止</p>
                        <p>7.1	借出人和借入人应按照本协议第3.1.2条及第3.2.3条的约定方式签订本协议。</p>
                        <p>7.2	本协议自借出人按照本协议第3.1.2条的约定签订本协议之日成立。</p>
                        <p>7.3	本协议为附条件生效协议，协议生效需同时满足如下条件：</p>
                        <p>7.3.1	本协议已成立；</p>
                        <p>7.3.2	借入人设定的借款总额在募集期已至少完成[    %]部分的募集且完成了该等借款的发放；</p>
                        <p>7.3.3	平台根据最终撮合结果生成借出人与借入人信息、第二条与第五条信息及协议签订日期信息等要素，且本协议可在平台查询。</p>
                        <p>若在募集期内，平台为借入人所募集的资金低于借入人所设定的借款总额但达到上述最低比例要求的，则借款金额以实际募集的金额为准；若平台为借入人所募集的资金低于上述最低比例要求的，则本协议不生效；若在募集期内，平台为借入人所募集的资金超过借入人所设定的借款总额的，则平台将根据包括本协议项下借出人在内的所有借出人的签订本协议的时间顺序，将顺序在后的借款金额/部分借款金额（即超募资金）于募集期结束日的T+1日（均为工作日，非工作日将延后至下一个工作日），通过第三方支付机构向借出人指定银行账户退款。双方确认，若本协议项下借出人的借款金额/部分借款金额根据上述约定被退款的，则本协议不发生效力或者仅在实际借款金额范围内发生效力。</p>
                        <p>7.4	资金募集完成后，平台将通知第三方支付机构进行借款金额的划转。若未能按约完成资金募集的，平台将不会通知第三方支付机构进行借款金额划转。</p>
                        <p>7.5	借出人与借入人同意以留存在平台的协议为准。</p>
                        <p>7.6	本协议期限届满，或者本协议根据法律规定或双方约定被提前终止，或者借出人在本协议项下的借款金额、利息、逾期利息（如有）及其他相关费用（如有）被全部清偿完毕的，本协议终止。本协议终止后，不影响本协议项下的结算和清理条款以及保密条款的效力。</p>
                        <p>八、	其他事项 </p>
                        <p>8.1	到期还款日如遇法定节假日，则顺延至节假日后的第一个工作日。</p>
                        <p>8.2	借入人须确保到期足额偿还包括本协议借款金额在内的借款总额项下所有协议项下的借款本息及其他应付款项，否则不视为还款完成，由此引起的法律后果及违约责任由借入人承担。</p>
                        <p>8.3	借出人及借入人必须通过本协议约定的方式或平台认可的其他方式进行放款及还款,否则由此引起的法律后果及违约责任由借出人或借入人自行承担。</p>
                        <p>8.4	本协议项下借款记录等信息均以平台生成并公布的内容为准。借出人、借入人可以通过指定银行账户登录平台查询上述信息。</p>
                        <p>8.5	本协议项下的债权债务未经平台书面同意不得转让。经平台书面同意后，借出人有权在平台上进行债权转让，借出人进行债权的，应及时委托平台向借入人进行通知，否则由此产生的法律后果由借出人自行承担。</p>
                        <p>8.6	本协议双方应对其他方提供的信息及本协议内容保密，未经其他方同意，任何一方不得向本协议主体之外的任何人披露，但法律、行政法规另有强制性规定，或监管、审计等有权机关另有强制性要求的除外。</p>
                        <p>8.7	本协议各方知悉并遵守《互联网金融综合服务平台服务协议（投资人版）》、《互联网金融综合服务平台服务协议（融资人版）》、《用户注册服务协议》、《项目说明书》、《快捷支付用户协议》以及平台和第三方支付机构制定的相关规则的规定，该等协议及规定中关于借入人与借出人双方之间的法律关系的内容构成本协议不可分割的一部分，但若该等内容与本协议的约定存在不一致的，以本协议的约定为准。</p>
                        <p>8.8	如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，则应认为该条款可与本协议相分割，并可被尽可能接近各方意图的、能够保留本协议要求的经济目的的、有效的新条款所取代，而且在此情况下，本协议的其他条款仍然完全有效并具有约束力。</p>
                        <p>8.9	协议各方应按法律法规及相关规定各自承担与本协议相关的税费。</p>
                        <p>九、	法律的适用和争议的解决 </p>
                        <p>本协议受中华人民共和国法律管辖并按中华人民共和国法律解释。本协议履行中发生争议，可由各方协商解决，协商不成可向本协议签订地有管辖权的人民法院起诉。本协议签订地为[ 晋城农村商业银行股份有限公司 ]。</p>
                        <p class="align">借出人签订日期：XXX</p>
                        <p class="align">借入人签订日期：XXX</p>          
        </div>
		<%@ include file="../foot.jsp"%>
	</body>
	<script>
		var fwqNowTime = $("#fwqNowTime").val();//获取服务器时间
		var NowTime = new Date(fwqNowTime);
        var fwqSjSecMill = NowTime.getTime();
	</script>
</html>
