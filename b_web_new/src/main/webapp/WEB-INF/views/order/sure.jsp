<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>蒲公英金融服务平台——确认支付添加银行卡</title>
<link href="${resource_dir}/css/header_footer.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/public.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
<title>JS实现倒计时(时、分，秒)</title>
<script  type="text/javascript">
    var steTime=1000;
	function GetRTime(){
	    var date = document.getElementById("investEndDate").value;
        var EndTime= new Date(date);
        var systemDate = $("#systemDate").val();
	    var NowTime = new Date(systemDate);
	    var systemDate1 = NowTime.getTime();
        var t =EndTime.getTime() - NowTime.getTime()-steTime;
        if(t>0){
	        var d=Math.floor(t/1000/60/60/24);
	        var h=Math.floor(t/1000/60/60%24);
	        var m=Math.floor(t/1000/60%60);
	        var s=Math.floor(t/1000%60);
	        $("#t_d").html(d + "天");
	        $("#t_h").html(h + "小时");
	        $("#t_m").html(m + "分");
	        $("#t_s").html(s + "秒");
        }else{
            $("#t_d").html("0天");
	        $("#t_h").html("0小时");
	        $("#t_m").html("0分");
	        $("#t_s").html("0秒");
        }
        steTime+=1000;
    }
    setInterval(GetRTime,1000); 
</script>
<script type="text/javascript">
    var tDate;
	var isRais;
	var statek;
	function saveOrderCommit(){
	
	    var date = document.getElementById("investEndDate").value;
        var EndTime= new Date(date); 
        var systemDate = $("#systemDate").val();
	    var NowTime = new Date(systemDate);
        tDate =EndTime.getTime() - NowTime.getTime();
	    if(tDate<=0){
	       warnMsg("您当前投资的项目已经没结束，请选择其他项目进行投资！","关闭");
	  	   return;
	    }
	    var bankCode = $(".cash_model .focus").children("span").attr("code");
	    if(undefined==bankCode){
	        warnMsg("请选择您需要支付订单的银行卡！","关闭");
	       return;
	    }
	    
	    var orderNumber = $("#orderNumber").html();
        var totalMoney = $("#txt_InvestAmount").html();
        var orderId = $("#orderId").val();
        var itemId = $("#itemId").val();
        var fkItemId=$("#fkItemId").val();
        $.ajax({
             type: "post",
             async: false,
             url: '${ctx}/arcOrder/orderPayment',
		     data: "itemID="+fkItemId+"&bankCode="+bankCode+"&orderId="+orderId+"&totalMoney="+totalMoney+"&orderNumber="+orderNumber+"&itemId="+itemId,
             success: function (result) {
                  if("err" ==result.state){
                     isRais ="err";
                     warnMsg("您当前投资的项目已经没有剩余的份额了,请选择其他项目进行投资！","关闭");
                  }else if("err" ==result.err){
                     statek="err";
                     warnMsg("网络错误，请稍后再试！","关闭");
                  }else{
                     $("#message").val(result.message);
	                 $("#signature").val(result.signature);
	                 $("#paymentNo").val(result.paymentNo);
	                 document.orderPay.action=result.url;
	  		         document.orderPay.submit();  
                  }
	      }});

  	}
  	
   function updateBank(){
	  var  paymentNo = $("#paymentNo").val();
	  $.ajax({
             type: "post",
             url: '${ctx}/arcOrder/completePay',
		     data: "paymentNo="+paymentNo,
             success: function (result) {
               if(result=="err"||result=="no"){
                    location.reload(true);
               }else{
                  window.location.href="${ctx}/arcOrder/succPage?paymentNo="+paymentNo;
                }
	         }
	   });
 }
  
   function completePay(arg){
      var  paymentNo = $("#paymentNo").val();
	  $.ajax({
             type: "post",
             async: false,
             url: '${ctx}/arcOrder/completePay',
		     data: "paymentNo="+paymentNo,
             success: function (result) {
               if(result=="err"||result=="no"){
                    if(arg=="1"){
                      $("#bank-add").hide();
                    }else if(result=="err"){
                      $("#pay").hide();
                      $("#succ").show();
                    }else if(result=="no"){
                      $("#pay").hide();
                      $("#failure").show();
                    }
               }else{
                  window.location.href="${ctx}/arcOrder/succPage?paymentNo="+paymentNo;
                }
	         }
	   });
   }
  
  	function closeWin(){
	    $(".prompt_box").hide()
		$(".blackBg").hide()
	}
  	
</script>
<script type="text/javascript">
	$(function() {
		$('.bank-info h3').hide();
		$('.bank-info table').hide();
		$(".cash_model ul li label").bind("click", function() {
			var kk = $(this).children().attr("title");
			$('.bank-info h3').hide();
			$('.bank-info h3').next().hide();
			var s =$('.bank-info h3:contains('+kk+')');
			$(".cash_model ul li label").removeClass("focus");
		    $(this).addClass("focus");
			s.show();
			s.next().show();
			$("#submitBtn").show();	
		});
	});
</script>

<script type="text/javascript">
$(document).ready(function(){
	//获取屏幕宽度，更改页面宽度
	var _windowW=$(window).width()
	function setWH(){
		_windowW=$(window).width()
		if(_windowW <1024){
			$(".topbar-wrap,.container,.header-wrap,.banner,.footer-wrap,.main").css({width:"980px"})

		}else{
			$(".topbar-wrap,.container,.header-wrap,.banner,.footer-wrap,.main").css({width:""})
		}
	}
	setWH()
	$(window).resize(function(){
		setWH()
	});
	//标签切换
	 $(".ui-tab li").click(function() {
            $(this).siblings("li").removeClass("current");
            $(this).addClass("current");
            $(this).closest(".ui-tab").siblings(".labelContent").hide();
            $(this).closest(".ui-tab").siblings(".labelContent").eq($(this).attr("value") - 1).show();
     });
	 //选择银行
	 $(".radioBox").click(function(){
		$(this).addClass("focus")
		$(this).siblings("label").removeClass("focus")
	 })
	 //弹窗
	 $(".openWindow").click(function(){
	    
	    $("#pay").show();
        $("#succ").hide();
        $("#failure").hide();
	    
	    var bankCode = $(".cash_model .focus").children("span").attr("code");
	    if(undefined==bankCode){
	       return;
	    }
	  	if("err"==isRais){ // 项目已满
	  	  return;
	  	}
	    if(tDate<=0){      // 项目结束
	      return;
	    }
	    if("err"==statek){
	      return;
	    }
		var _top
		var parameters=$(this).attr("action-data");
		if(""==parameters||"undefined"==parameters){
		   return;
		}
		var paraArr=[]
		paraArr=parameters.split("||")
		$(".blackBg").show()
		$("#"+paraArr[0]).show()
		if($.inArray("canDrag",paraArr)!= -1){
			DrawNow($("#"+paraArr[0]).find(".prompt_inner"))
		}
		if($.inArray("inIframe",paraArr)!= -1){
			_top=$(this).offset().top-80;
		}else{
			_top=$(window).scrollTop();	
		}
		if($.inArray("absolute",paraArr)!= -1){
			$("#"+paraArr[0]).css({position:"absolute",top:_top+80})
			$("#"+paraArr[0]).find(".prompt_inner").css({width:paraArr[2],height:paraArr[3],left:-paraArr[2]/2})
		}else{
			$("#"+paraArr[0]).find(".prompt_inner").css({width:paraArr[2],height:paraArr[3],top:-paraArr[3]/2,left:-paraArr[2]/2})
		}
		$("#"+paraArr[0]).find(".prompt_inner").addClass(paraArr[1]);
		//IE6兼容
		if (!-[1,]&&!window.XMLHttpRequest) {
			$("#"+paraArr[0]).css({position:"absolute",top:_top+380})
		} 
	 })
	 //关闭弹窗
	$(".prompt_box .close").click(function(){
		$(".prompt_box").hide()
		$(".blackBg").hide()
	})
	$("#txt_InvestAmo").html(FormatDigital($("#txt_InvestAmount").html()));
})
</script>
	</head>
	<body>
	<%@ include file="../header.jsp" %>
        <input id="systemDate" name="systemDate" type="hidden" value="${systemDate}" />
        <form name="orderPay" method="post" action="" target="_blank">
			<input id="message" name="message" type="hidden" />
			<input id="signature" name="signature" type="hidden" />
		</form>
        <input id="investEndDate" name="investEndDate" value="<fmt:formatDate value="${itemInfo.investEndDate}" pattern="yyyy/MM/dd HH:mm:ss" />" type="hidden" />
		<div class="warp">
			<div class="container">
				<div class="ui-content">
					<div class="breadcrumb">
						<a href="${ctx}/item/index">首&nbsp;页</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="${ctx}/item/gotoInvestmentList">惠赚钱</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="${ctx}/arcOrder/findDetail?itemId=${itemInfo.id}">项目详情</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="javascript:history.go(-1);">确认投标金额</a>&nbsp;
						<span>&gt;</span>&nbsp;确认支付
					</div>
					<h2 class="mod-object-title"><div id="sflex03" class="stepflex ">
								<dl class="first doing">
									<dt class="s-num">1</dt>
									<dd class="s-text">确认投标金额<s></s><b></b></dd>
									<dd></dd>
								</dl>
								<dl class="normal doing">
									<dt class="s-num">2</dt>
									<dd class="s-text">确认支付<s></s><b></b></dd>
								</dl>
								<dl class="normal">
									<dt class="s-num">3</dt>
									<dd class="s-text">投资结果<s></s><b></b></dd>
								</dl>
							</div></h2>
			   <input type="hidden" value="${paymentNo}" id="paymentNo" name="paymentNo" >
				<div class="module">
					<div class="mod-wrap mod-bid-box">		
							<h2 class="mod-title" >
								<span  >选择银行卡支付 >></span>
							</h2>
							<div class="mod-content">
								<div class="bank-form confirm_bank">
									 
									<div class="cash_model">
										<ul>
										    <li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-icbc" code="102" title="中国工商银行"></span>
												</label>
											</li>
											<li class="openWindow">
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-abc" code="103" title="农业银行"></span>
												</label>
											</li>
											<li class="openWindow">
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-ccb" code="105" title="建设银行"></span>
												</label>
											</li>
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-comm" code="301" title="交通银行"></span>
												</label>
											</li>
											<li>
												<input type="radio" id="" />
												<label class="radioBox">
													<span class="bank-card bank-cmmb" code="308" title="招商银行"></span>
												</label>
											</li>
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-zgb" code="104" title="中国银行"></span>
												</label>
											</li>
											<li class="openWindow">
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-psbc" code="100" title="中国邮政储蓄银行"></span>
												</label>
											</li>
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-ecitic" code="302" title="中信银行"></span>
												</label>
											</li>
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-cebbank" code="303" title="光大银行"></span>
												</label>
											</li>
											
											<li class="openWindow">
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-cmbc" code="305" title="民生银行"></span>
												</label>
											</li>
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-qdccb" code="450" title="青岛银行"></span>
												</label>
											</li>
											
											<!--  <li class="openWindow">
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-cgbchina" code="306" title="广发银行"></span>
												</label>
											</li>  -->
											<li class="openWindow">
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-shbc" code="401" title="上海银行"></span>
												</label>
											</li>
											<li class="openWindow">
												<input type="radio" onclick="beijingbank()" />
												<label class="radioBox" id="">
													<span class="bank-card bank-bankofbeijing" code="403" title="北京银行"></span>
												</label>
											</li>
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-spdb" code="310" title="浦发银行"></span>
												</label>
											</li>
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-hxb" code="304" title="华夏银行"></span>
												</label>
											</li>
											
											<!-- 开始   -->
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-pab" code="307" title="平安银行"></span>
												</label>
											</li>
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-hssb" code="440" title="徽商银行"></span>
												</label>
											</li>
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-lzzb" code="447" title="兰州银行"></span>
												</label>
											</li>
											
											<li>
												<input type="radio" />
												<label class="radioBox" id="">
													<span class="bank-card bank-nnbb" code="408" title="宁波银行"></span>
												</label>
											</li>
											<li>
												<input type="radio" />
												<label class="radioBox" id="" >
												  <span class="bank-card bank-yhb" code="1565" title="颍淮农村商业银行"></span>
											    </label>
											</li>
											<!-- 结束  
											
											<li>
												<a href="">更多银行</a>
											</li> -->
										</ul>
										<div class="ui-button-lorange clear" id="submitBtn" style="display: none">
											<input type="button" value="确认支付"
												onclick="saveOrderCommit();"
												class="ui-button-text ui-button-2 openWindow"
												action-data="bank-add||bank-add-box||750||250">
										</div>
										<div class="clear"></div>
									</div>
									<div class="bank-info">
										<h3>
											您选择的是青岛银行：
										</h3>
										<table width="595" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<th height="35" align="left">
													银行卡种类
												</th>
												<th align="left">
													单笔限额(元)
												</th>
												<th align="left">
													每日限额(元)
												</th>
												<th align="left"></th>
											</tr>
											<tr>
												<td height="35" align="left">
													银联卡
												</td>
												<td align="left">
													10000
												</td>
												<td align="left">
													10000
												</td>
												<td></td>
											</tr>
											<tr>
												<td height="35" align="left">
													网银大众版
												</td>
												<td align="left">
													1000
												</td>
												<td align="left">
													1000
												</td>
												<td></td>
											</tr>
											<tr>
												<td height="35" align="left">
													网银专用版
												</td>
												<td align="left">
													500万
												</td>
												<td align="left">
													500万
												</td>
												<td></td>
											</tr>
											<tr>
												<td height="32" colspan="4">
													注：如您在银行设置的限额低于此限额，请以银行限额为准。
												</td>
											</tr>
										</table>
										<h3>
											您选择的是中国工商银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td height="35" align="left">
														储蓄卡
													</td>
													<td align="left">
														<b>1000</b>
													</td>
													<td align="left">
														1000
													</td>
													<td>
														充值与支付共用日限额
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是农业银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="3">
														所有卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														1000
													</td>
													<td>
														<p>
															动态口令
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														<b>50万</b>
													</td>
													<td align="left">
														100万
													</td>
													<td>
														<p>
															移动证书（一代K宝）
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														<b>500万</b>
													</td>
													<td>
														移动证书（二代K宝）
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是中国银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center">
														储蓄卡
													</td>
													<td height="35" align="left">
														<b>1万</b>
													</td>
													<td align="left">
														20万
													</td>
													<td>
														<p>
															USBKey证书认证、
															<br>
															令牌+动态口令
														</p>
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是建设银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="3">
														储蓄卡
													</td>
													<td height="35" align="left">
														<b>5000</b>
													</td>
													<td align="left">
														5000
													</td>
													<td>
														<p>
															动态口令
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														<b>5万</b>
													</td>
													<td align="left">
														10万
													</td>
													<td>
														<p>
															网银盾1代
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														50万
													</td>
													<td align="left">
														<b>50万</b>
													</td>
													<td>
														网银盾2代
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是中国邮政储蓄银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="3">
														所有卡
													</td>
													<td height="35" align="left">
														<b>1万</b>
													</td>
													<td align="left">
														1万
													</td>
													<td>
														<p>
															手机短信客户
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														<b>20万</b>
													</td>
													<td align="left">
														20万
													</td>
													<td>
														<p>
															电子令牌+短信客户
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														200万
													</td>
													<td align="left">
														<b>200万</b>
													</td>
													<td>
														Ukey+短信客户
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是中国民生银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="3">
														所有卡
													</td>
													<td height="35" align="left">
														<b>300</b>
													</td>
													<td align="left">
														300
													</td>
													<td>
														<p>
															大众版
														</p>
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														<b>5000</b>
													</td>
													<td align="left">
														5000
													</td>
													<td>
														贵宾版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														50万
													</td>
													<td align="left">
														<b>50万</b>
													</td>
													<td>
														U宝用户
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是广发银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="3">
														所有卡
													</td>
													<td height="35" align="left">
														<b>5000</b>
													</td>
													<td align="left">
														5000
													</td>
													<td>
														手机动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														<b>100万</b>
													</td>
													<td align="left">
														<b>100万</b>
													</td>
													<td>
														key盾
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														5万
													</td>
													<td align="left">
														<b>5万</b>
													</td>
													<td>
														key令
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是上海银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														储蓄卡
													</td>
													<td height="35" align="left">
														<b>50万</b>
													</td>
													<td align="left">
														100万
													</td>
													<td>
														办理E盾证书版个人网银，开通网上支付功能
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														<b>6000</b>
													</td>
													<td align="left">
														<b>1万</b>
													</td>
													<td>
														办理动态密码版个人网银（含文件证书）,开通网上支付功能
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是北京银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是招商银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是交通银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是中信银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是光大银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是浦发银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
										<h3>
											您选择的是华夏银行：
										</h3>
										<table width="495" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<th height="35" align="left">
														银行卡种类
													</th>
													<th align="left">
														单笔限额(元)
													</th>
													<th align="left">
														每日限额(元)
													</th>
													<th align="left">
														需要满足条件
													</th>
												</tr>
												<tr>
													<td valign="middle" align="center" rowspan="2">
														借记卡
													</td>
													<td height="35" align="left">
														<b>1000</b>
													</td>
													<td align="left">
														<b>5000</b>
													</td>
													<td>
														动态密码版
													</td>
												</tr>
												<tr>
													<td height="35" align="left">
														100万
													</td>
													<td align="left">
														100万
													</td>
													<td>
														证书版
													</td>
												</tr>
												<tr>
													<td height="32" colspan="4">
														注：如您在银行设置的限额低于此限额，请以银行限额为准。
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="otherInfo confirm_bank_text">
										<p class="red">
											提 示：
										</p>
										<p class="red">
											1、根据有关法规及监管要求，出资人不允许使用信用卡、贷记卡等透支进行项目出资，
											<br />
											&nbsp;&nbsp;&nbsp;否则投标无效。
										</p>
										<p>
											2、平台托管中金支付通过银联在线支付渠道进行资金结算，因此商户名称为：中国银联。
										</p>
										<p>
											3、建议选择使用IE或者带IE内核的浏览器进行投资支付。
										</p>
									</div>
									<!--<div class="ui-button ui-button-lorange" id="submitBtn">
                <input type="button" value="确认支付" class="ui-button-text ui-button-2">
              </div>-->
								</div>
								<!--右侧票据-->
								
								<input type="hidden" id="orderId" name="orderId" value="${order.id}" />
								<input type="hidden" id="itemId" name="itemId" value="${itemInfo.itemNo}" />
								
								<div class="ui-receipt f-right confirm-receipt">
									<div class="receipt">
										<h4 class="receipt-title-1">
											银行投资项目信息
										</h4>
										<div class="date">
											 

										</div>
										<ul>
											<li>
												项目名称：
												<span>${itemInfo.itemPrefix}${itemInfo.itemName}</span>
												<input type="hidden" id="fkItemId" name="fkItemId"
													value="${order.fkItemId}" />
											</li>
											<li>
												 订单号：
												<span id="orderNumber" name="orderNumber">${order.orderNumber}</span>
											</li>
											<li>
												投资金额：<span><b class="red"></b><b style="display: none;" id="txt_InvestAmount" name="txt_InvestAmount">${order.capital}</b>
													<b class="red"	id="txt_InvestAmo" name="txt_InvestAmo"> </b> <em class="red">元</em></span>
											</li>
										</ul>
										<ul class="fz-12">
											<li style="display: none;">
												<b>预期回收资金：</b><b class="red"></b><b class="red"
													id="backcapital" name="backcapital">${order.income+order.capital}</b>
											</li>
											<li>
												<b>预期收益：</b><b class="red"></b><b class="red" name="yield"
													id="lblFullInterest">${order.income} 元</b> 
											</li>
										</ul>
										<div class="receipt-ts"><!--
											本金和收益将于 ${itemInfo.repayClearDate} 开始发放
										--></div>
									</div>
									<div class="shadow"></div>
									<div class="clock confirm-clock">
										<i></i>倒计时
										<span style="color: #333" id="t_d"></span><span
											style="color: #333" id="t_h"></span><span style="color: #333"
											id="t_m"></span><span style="color: #333" id="t_s"></span>
										<input type="hidden" id="financeEndDate"
											value='<fmt:formatDate value="${itemInfo.financeEndDate}"
												pattern="yyyy/MM/dd HH:mm:ss" />' />
									</div>
									<div class="ui-service confirm-service" ">
										<div class="ui-service-tel" style="padding:0";>
											<i></i>客服热线：<br/> 
											400-6688-997
											<span>（全国）</span>
										</div>
									</div>
								</div>
								<!--票据结束-->

								<div class="clear"></div>
							</div>
				</div>
			</div>
		</div>
	   </div>
	</div>
		<!--弹窗-->
		<div class="blackBg"></div>
		<!--支付提醒弹窗-->
		<div id="prompt_box_XY" class="prompt_box">
			<div class="prompt_inner ui-window-1">
				<h3 class="title">
					<span class="ico_3"> </span><a class="close"
						href="javascript:void()"></a>
				</h3>
				<div class="pay-pop">
					<img src="${resource_dir}/images/defrayimg_11.png" />
				</div>
				<div class="pay-pop-bun">
					<input name="" type="checkbox" value="" />
					&nbsp;下次不再提醒
					<span><input name="" type="button" /> </span>
				</div>
			</div>
		</div>
		<!--支付提醒弹窗结束--
<!--添加银行卡弹窗-->
		<div class="prompt_box" id="bank-add">
			<div class="prompt_inner" id="pay">
				<h3 class="title">
					温馨提醒您
					<a href="javascript:void(0)" class="close" onclick="completePay('1');"></a>
				</h3>
				<div class="bank-alter-text">
					<p class="note-content">
						请你到新打开的网银页面进行支付，支付完成前请不要关闭该窗口
					</p>
					帮助：
					<a href="${ctx}/help/helpCenter/questionlist6.jsp" target="_blank" class="blue">支付遇到问题了？</a>
				</div>
				<div class="calculator-btn" style=" margin-left:220px;">
					<input style="width: 140px;" type="button" onclick="completePay();" value="已完成支付" />
					<input style="width: 145px;" type="button" class="alter" onclick="updateBank();" value="修改付款银行" />
				</div>
			</div>
			
			  <div class="prompt_inner " id="succ" style="display: none">
			    <h3 class="title">温馨提醒您<a href="javascript:void(0)" class="close"></a></h3>
			      <h1><i class="false_btn"></i>对不起，检测到您并未完成支付</h1>
			      <p>请检查您的银行卡是否已经扣款!</p>
			      <input class="gb" type="button"  onclick="closeWin();" value="关闭"/>
			  </div>
			  
			  <div class="prompt_inner " id="failure" style="display: none">
			    <h3 class="title">温馨提醒您<a href="javascript:void(0)" class="close"></a></h3>
			      <h1><i class="false_btn"></i>您所参与的项目投标完成</h1>
			      <p>但投资失败!</p>
			      <input class="gb" type="button"  onclick="closeWin();" value="关闭"/>
			  </div>
		</div>
		<!--添加银行卡结束-->
		<%@ include file="../foot.jsp" %>
	</body>
</html>
