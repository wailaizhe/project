<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>
	<head>
	    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>蒲公英金融服务平台——个人信息</title>
		<meta content="text/html; charset=utf-8" http-equiv=Content-Type />
		<meta name=keywords content="蒲公英金融服务平台,账户中心,会员中心" />
    <link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
    <link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="${resource_dir}/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/jquery.validate.message_cn.js"/>
	<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>

<script  type="text/javascript">
	$(function () {
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

	    $.ajax({
		        url: '${ctx}/account/baseInfo?neo='+Math.floor(Math.random()*10),
		        success: function(data) {
		               if(data.mobilePhone!=null){
		                   $("#orderDate").html(data.userCheckTime);
		                   $("#mobilePhone").html(data.mobilePhone);
		                   $("#mobilePhone2").html(data.mobilePhone);
		                   $("#mobilePhone3").html(data.mobilePhone);
		                   $("#td_MobileOld").html(data.mobilePhone);
		                   $("#idcode").val(data.id);
		                   $("#mobilePhon").val(data.mobilePhone);
		                   if(data.mobilePhone!=""){
		                      $("#phone").removeClass("ui-icon ui-mail-p jieshi");
		                      $("#phone").addClass("ui-icon ui-mail-p-ok jieshi");
		                      $("#phone").attr("alt","已绑定手机");
		                   }
		                   if(data.realName!=""&&data.realName!=null){
		                      $("#idCard").removeClass("ui-icon ui-mobile jieshi");
		                      $("#idCard").addClass("ui-icon ui-mobile-ok jieshi");
		                      $("#idCard").attr("alt","已实名认证");
		                   }
		                   if(data.email!=""&&data.email!=null){
		                      $("#mailP").removeClass("ui-icon ui-lock jieshi");
		                      $("#mailP").addClass("ui-icon ui-lock-ok jieshi");
		                      $("#mailP").attr("alt","已绑定邮箱");
		                   }
		               }
                       if(data.realName!=null&&data.realName!=""){
                           $("#realName2").hide();
                           $("#realName1").show();
                           $("#realName").html(data.realName);
                       }else{
                           $("#realName2").show();
                           $("#realName1").hide();
                       }  
		               if(data.identityCard!=null&&data.identityCard!=""){
                           $("#identityCard2").hide();
                           $("#identityCard1").show();
                           $("#identityCard").html(data.identityCard);
                       }else{
                           $("#identityCard2").show();
                           $("#identityCard1").hide();
                       }
		        }
		    });
		$("#ccp").html(FormatDigital($("#ccps").val()));
		$("#inc").html(FormatDigital($("#incs").val()));
		
		 $(".personal-info-text a").toggle(function () { // 伸缩效果
             $(this).parent().next(".personal-info-table").slideDown("slow");
             $(this).toggleClass("downward");
             
         }, function () {
             $(this).parent().next(".personal-info-table").slideUp("slow");
             $(this).toggleClass("downward");
         });
});
 
	

    //输入格式提示
    function onfocusFunction(ID) {
        switch (ID) {
            case "oldPassword":
                $("#oldPassword").removeClass("on-error");
                $("#oldPassword").parent().next(".ui-tips").remove();
                $("#oldPassword").parent().next(".tips-correct").remove();
                $("#oldPassword").addClass("on-focus");
                $("#oldPassword").parent().after('<div class="ui-tips tips-note"><span><i></i>请输入旧登录密码</span></div>')
                break;
            case "newPassword":
                $("#newPassword").removeClass("on-error");
                $("#newPassword").parent().next(".ui-tips").remove();
                $("#newPassword").parent().next(".tips-correct").remove();
                $("#newPassword").addClass("on-focus");
                $("#newPassword").parent().after('<div class="ui-tips tips-note"><span><i></i>密码最好由6~16位字符的字母、数字组合的新密码</span></div>')
                break;
            case "confirmPassword":
                $("#confirmPassword").removeClass("on-error");
                $("#confirmPassword").parent().next(".ui-tips").remove();
                $("#confirmPassword").parent().next(".tips-correct").remove();
                $("#confirmPassword").addClass("on-focus");
                $("#confirmPassword").parent().after('<div class="ui-tips tips-note"><span><i></i>与新密码输入一致</span></div>')
                break;
            case "verificationCodeinput":
                $("#verificationCodeinput").removeClass("on-error");
                $("#verificationCodeinput").next(".ui-tips").remove();
                $("#verificationCodeinput").next(".tips-correct").remove();
                $("#verificationCodeinput").addClass("on-focus");
                $("#verificationCodeinput").after('<div class="ui-tips tips-note"><span><i></i>请输入6位验证码</span></div>')
                break;
        }
    }

	//格式提示隐藏
	function onblurFunction(ID) {
	        $("#" + ID).removeClass("on-focus");
	        $("#" + ID).parent().next(".tips-note").remove();
	}
	 
    function cleraUser(){
         var TimeNow = $("#spTime").text() == "" ? 5 : parseInt($("#spTime").text());
         if(TimeNow!=0){
           $("#spTime").text((TimeNow - 1));
         }
         if (TimeNow <=0) {
             window.location.href = '${ctx}/baseInfo/loginOut?now='+Math.random();
         }
    }
      
    $("#verificationCodeinputPass").live("focus", function () {
         $("#verificationCodeinputPass").removeClass("on-error");
         $("#verificationCodeinputPass").parent().next(".ui-tips").remove();
         $("#verificationCodeinputPass").parent().next(".tips-correct").remove();
    }).live("blur", function () {
         if($(this).val()==""||$(this).val()==null){
           $("#verificationCodeinputPass").removeClass("on-error");
           $("#verificationCodeinputPass").parent().next(".ui-tips").remove();
           $("#verificationCodeinputPass").parent().next(".tips-correct").remove();
           $("#verificationCodeinputPass").addClass("on-err");
           $("#verificationCodeinputPass").parent().after('<div class="ui-tips tips-note"  style="left:95px;"><span><i></i>请输入短信验证码！</span></div>')
         }
    });    
       
    //  修改密码
    function UpdatePassWord() {
        var oldPassword = $("#oldPassword").val();
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();
        //验证旧密码
        if (oldPassword == "") {
            $("#oldPassword").parent(".ui-input-box").nextAll("div").remove();
            $("#oldPassword").addClass("on-error");
            $("#oldPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>原密码不能为空！</span></div>');
            return false;
        }
         //验证新密码
        if (newPassword == "") {
            $("#newPassword").parent(".ui-input-box").nextAll("div").remove();
            $("#newPassword").addClass("on-error");
            $("#newPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>新密码不能为空！</span></div>');
            return false;
        }else if(confirmPassword==""){
            $("#confirmPassword").parent(".ui-input-box").nextAll("div").remove();
            $("#confirmPassword").addClass("on-error");
            $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>确认密码不能为空！</span></div>');
            return false;
        }else{
             if (newPassword != confirmPassword) {
                 $("#confirmPassword").parent(".ui-input-box").nextAll(".tips-correct").remove();
                 $("#confirmPassword").addClass("on-error");
                 $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请确保两次密码输入相同！</span></div>')
                 return false;
             }
        }
        var sendMobilePass = $("#sendMobilePass").val();
        var verificationCodeinputPass = $("#verificationCodeinputPass").val();
        var reg = /^\d{6}$/;
        if(sendMobilePass==null||sendMobilePass==""){
            $("#verificationCodeinputPass").removeClass("on-error");
            $("#verificationCodeinputPass").parent().next(".ui-tips").remove();
            $("#verificationCodeinputPass").parent().next(".tips-correct").remove();
            $("#verificationCodeinputPass").addClass("on-err");
            $("#verificationCodeinputPass").parent().after('<div class="ui-tips tips-note"  style="left:95px;"><span><i></i>请获取短信验证码！</span></div>')
            return;
        }else if(!reg.test(verificationCodeinputPass)){
            $("#verificationCodeinputPass").removeClass("on-error");
            $("#verificationCodeinputPass").parent().next(".ui-tips").remove();
            $("#verificationCodeinputPass").parent().next(".tips-correct").remove();
            $("#verificationCodeinputPass").addClass("on-err");
            $("#verificationCodeinputPass").parent().after('<div class="ui-tips tips-note"  style="left:95px;"><span><i></i>请输入6位数字验证码！</span></div>')
           return;
        } 
        var valDate =valAuthCodePass("001");
         if("1"==valDate){
              $("#verificationCodeinputPass").removeClass("on-error");
              $("#verificationCodeinputPass").parent().next(".ui-tips").remove();
              $("#verificationCodeinputPass").parent().next(".tips-correct").remove();
              $("#verificationCodeinputPass").addClass("on-error");
              $("#verificationCodeinputPass").parent().after('<div class="ui-tips tips-error"  style="left:95px;"><span><i></i>验证码输入错误！请核对您接收到的，重新输入！</span></div>')
            return;
         }else if("2"==valDate){
             warnMsg("您10分钟内发送验证码次数已超出3次！请稍后再试.","关闭");
             return;
         }else if("link"==valDate){
             warnMsg("本次短信验证码尝试次数过多，请重新获取验证码","关闭");
             return;
         }else if("3"==valDate){
              $("#verificationCodeinputPass").removeClass("on-error");
              $("#verificationCodeinputPass").parent().next(".ui-tips").remove();
              $("#verificationCodeinputPass").parent().next(".tips-correct").remove();
              $("#verificationCodeinputPass").addClass("on-error");
              $("#verificationCodeinputPass").parent().after('<div class="ui-tips tips-error"  style="left:95px;"><span><i></i>您的验证码已过期！请重新获取.</span></div>')
         }

        // 验证旧密码
        if (oldPassword!="") {
            var flag = oldPasswordCheck(oldPassword);
            if (flag!="true") {
                $("#oldPassword").parent(".ui-input-box").nextAll("div").remove();
                $("#oldPassword").addClass("on-error");
                if(flag>3){
                   warnMsg("您修改密码次数已超过3次,请24小时后登陆重试！","关闭");
                   $("#ERR_SuccInfoModifyPassword").show();
                   window.setInterval("cleraUser()", 1000);
                }else{
                  $("#oldPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>原密码输入错误 '+flag+' 次！</span></div>')
                }
                return false;
            }else {
                $("#oldPassword").parent(".ui-input-box").nextAll("div").remove();
                $("#oldPassword").parent().after('<div class="tips-correct"></div>');
                $.ajax({
                    type: "POST",
                    async: false,
                    url: '${ctx}/account/updateIdcode',
                    data: "oldPassword="+strEnc(oldPassword,'${key}') + "&newPassword=" + strEnc(newPassword,'${key}') + "&confirmPassword=" +strEnc(confirmPassword,'${key}'),
                    dataType: "text",
                    error: function (err) {},
                    success: function (result) {
                        startModifyPasswordSuccTimer();
                        return true;
                    }
                });
            }
        }
 	 }
      // 密码验证码校验
      function valAuthCodePass(arg){
          var co;
          var authCode = $("#verificationCodeinputPass").val();
          $.ajax({
            type: "POST",
            async: false,
            url: '${ctx}/smsInfo/valAuthCode',
	      data: "messageType="+arg+"&authCode="+authCode,
            dataType: "text",
            error: function (err) {
            },success: function (result) {
                 co=result;
                  
            }});
            return co;
      }
        
     //修改密码成功后，执行跳转，重新登录。
     function startModifyPasswordSuccTimer() {
         iPoint = window.setInterval("setTime_ModifyPasswordSucc()", 1000);
         $("#div_SuccInfoModifyPassword").attr("tick", 2);
         $("#div_SuccInfoModifyPassword").show();
         $("#div_ExpandPassword").hide();
     }
     function setTime_ModifyPasswordSucc() {
         var TimeNow = parseInt($("#div_SuccInfoModifyPassword").attr("tick"));
         $("#div_SuccInfoModifyPassword").attr("tick", TimeNow - 1);
         if (TimeNow <= 0) {
             window.clearInterval(iPoint);
             $("#div_SuccInfoModifyPassword").hide();
             window.location.href = '${ctx}/baseInfo/loginOut?now='+Math.random();
         }
     }
        
    //检查输入的旧密码是否正确
   function oldPasswordCheck(oldPassword) {
        var idcode = $("#idcode").val();  //  主键ID
        var returnResult;
        $.ajax({
            type: "POST",
            async: false,
            url: '${ctx}/account/valPassword',
            data: "id="+idcode+"&OldPassword="+oldPassword,
            dataType: "text",
            error: function (err) {
            },success: function (result) {
                returnResult = result;
            }
        });
        return returnResult;
    };
   
          //发送手机验证码
     function sendMobileCheckCodePassWord(arg) {
        var oldPassword = $("#oldPassword").val();
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();
        //验证旧密码
        if (oldPassword == "") {
            $("#oldPassword").parent(".ui-input-box").nextAll("div").remove();
            $("#oldPassword").addClass("on-error");
            $("#oldPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>原密码不能为空！</span></div>');
            return false;
        }
        // var reg33 = /^^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@@#$%^&]))[\dA-Za-z!@@#$%^&]{6,16}/;
        var reg33=new RegExp("(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{2,})$");
         //验证新密码
        if (!reg33.test(newPassword) || newPassword.length < 6 || newPassword.length > 16||newPassword.indexOf(" ")>=0) {
            $("#newPassword").parent(".ui-input-box").nextAll("div").remove();
            $("#newPassword").addClass("on-error");
            $("#newPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>密码最好由6~16位字符的字母、数字组合的新密码！</span></div>');
            return false;
        }else if(confirmPassword==""){
            $("#confirmPassword").parent(".ui-input-box").nextAll("div").remove();
            $("#confirmPassword").addClass("on-error");
            $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>确认密码不能为空！</span></div>');
            return false;
        }else{
             if (newPassword != confirmPassword) {
                 $("#confirmPassword").parent(".ui-input-box").nextAll(".tips-correct").remove();
                 $("#confirmPassword").addClass("on-error");
                 $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请确保两次密码输入相同！</span></div>')
                 return false;
             }
        }
         $("#sendMobilePass").val(arg);
         var operId=$("#idcode").val();
         var phone=$("#mobilePhon").val();
         iPoint = window.setInterval("setTime_Password()", 1000);
         $("#60SecondsP").show();
         $("#btnSendMobileCodePassWord").attr("disabled", "disabled");
         $("#btnSendMobileCodePassWord").hide();
         $.ajax({
             async: true,
             type: "post",
             url: '${ctx}/smsInfo/addCode',
             dataType: "text",
             data: "operId="+operId+"&messageType="+arg,
             success: function (result) {
                 if("2"==result){
	                  warnMsg("您10分钟内发送验证码次数已超出3次！请稍后再试.","关闭");
	                  return;
                 }
             }
         });
     }
     
     //修改密码下发验证码倒数
     function setTime_Password() {
	         var TimeNow = $("#60SecondsP").val() == "" ? 120 : parseInt($("#60SecondsP").val());
	         $("#60SecondsP").val((TimeNow - 1) + "秒后重新获取");
	         if (TimeNow <= 0) {
             window.clearInterval(iPoint);
             $("#60SecondsP").hide();
             $("#60SecondsP").val("120秒后重新获取");
             $("#btnSendMobileCodePassWord").removeAttr("disabled");
             $("#btnSendMobileCodePassWord").show();
         }
     }
     
    //输入完成验证
    function onchangeFunction(ID) {
        switch (ID) {
           case "confirmPassword":
               var newPassword = $("#newPassword").val();
               var confirmPassword = $("#confirmPassword").val();
               if (confirmPassword != newPassword) {
                   $("#confirmPassword").parent(".ui-input-box").nextAll("div").remove();
                   $("#confirmPassword").addClass("on-error");
                   $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请确保两次密码输入相同！</span></div>')
                   return false;
                }
           break;
        }
    }
    
    function ShowHint(obj, msgType, msg) {
        var ctrl = $(obj).parent(".ui-input-box");
        $(ctrl).nextAll(".ui-tips").remove();
        $(ctrl).nextAll(".tips-correct").remove();
        var strExstyle = "";
        if ($(obj).attr("id")=="txt_CheckCode_Mobile" ||
            $(obj).attr("id")=="verificationCodeinput" ||
            $(obj).attr("id")=="txt_CheckCode_Email"){
            strExstyle = "left:94px;";
        }
        if (msgType == "ok") {
            $(ctrl).after("<div class=\"tips-correct\"></div>");
        }
        else if (msgType == "note") {
            $(ctrl).after("<div class=\"ui-tips tips-note\" style=\"z-index:999;"+strExstyle+"\"><span><i></i>" + msg + "</span></div>");
        }
        else if (msgType == "err") {
            $(ctrl).after("<div class=\"ui-tips tips-error\" style=\"z-index:999;"+strExstyle+"\"><span><i></i>" + msg + "</span></div>");
        }
     }
     
    function ShowinputHint(ctrl, hintType) {
        $(ctrl).removeClass("on-focus");
        $(ctrl).removeClass("on-error");
        if (hintType == "foc") {
            $(ctrl).addClass("on-focus");
        } else if (hintType == "err") {
            $(ctrl).addClass("on-error");
        }
    }
    
    function SetinputFont(ctrl, ftType) {
        if (ftType == 'black') {$(ctrl).css("color", "#666");}
        else {$(ctrl).css("color", "#ccc");}
    }
   
</script>
<body class=gray-bg>
<input id="identityC1" type="hidden" value="1"/>
<input id="mobileP" type="hidden" value="1"/>
<input id="password1" type="hidden" value="1"/>
<input id="idcode" type="hidden"/>
<input id="mobilePhon" type="hidden"/>
<input id="sendMobile1" type="hidden"/>
<input id="sendMobile4" type="hidden"/>
<input id="sendMobilePass" type="hidden"/>
<input id="sendMobileNEW" type="hidden"/>
<%@ include file="../header.jsp" %>	
		<div class="warp">
		   <div class="breadcrumb">
			<A href="${ctx}/item/index">首&nbsp;页</A>&nbsp;&gt;&nbsp;个人信息
		   </div>
		 	<div class="container">
				<div class="mod-wrap mod-assets">
					<div class="mod-contnet my-center">
						<div class="ui-icon ui-user">
							<IMG name=头像 alt=头像 src="${resource_dir}/images/my_pic.png"/>
							<A href="javascript:void(0)"></A>
						</div>
						<div class="ui_left">
							<div class="user-info">
								<span class="f-left"><span id="newCurrentTime">欢迎您</span>，<span id="mobilePhone2"></span></span>
									<a id="phone"   class="ui-icon ui-mail-p jieshi" 	href="${ctx}/account/personInfo"	alt="未绑定手机"></a>
									<a id="idCard"  class="ui-icon ui-mobile jieshi" 	href="${ctx}/account/personInfo" alt="未实名认证"></a>
							</div>
							<div class="investment-time">
								<p class="clear">
									上次登录时间：<span id="orderDate" style="color:#999;font-size:12px;padding-top: 0px;font-family:'Arial';"></span>
								</p>
							</div>
						</div>
						<div class="ui_right">
		                	<p>持有资产(元)<i></i></p>
		                    <h3 id="ccp"></h3>
		                    <input type="hidden" id="ccps" value="${capital }"/>
		                    <div class="ui_money">
		                    	<span>预估到期可获得收益：<em id="inc"></em>元</span>
		                    </div>
		                    <input type="hidden" id="incs" value="${income }"/>
						</div>
					</div>
				</div>
				<input id="BankAccountN_Hidden" type="hidden" value="0" />
				<div class="ui-main">
					<div class="ui-plate-sidebar">
						 
						<!--侧栏菜单-->
						<ul class="sidebar-nav">
							<LI class="first-nav-item">
								<A href="javascript:void(0)">我的账户</A>
								<UL>
									<LI>
										<A href="${ctx}/account/myassets"><I class=nav-icon1></I>我的资产</A>
									</LI>
									<LI>
										<A href="${ctx}/account/investment_newList"><I class=nav-icon2></I>投资记录</A>
									</LI>
									<LI>
										<A href="${ctx}/account/mybankcard"><I class=nav-icon3></I>我的银行卡</A>
									</LI>
									<LI>
										<A class="current" href="${ctx}/account/personInfo"><I	class=nav-icon4></I>个人信息</A>
									</LI>
									<LI>
										 <A href="${ctx}/account/informationCenter"><I class=nav-icon6></I>我的消息</A>
									</LI>
									<li>
										<A  href="${ctx}/account/toMyInvited"><I class=nav-icon4></I>我的推荐</A>
									</li>
									<li>
										<A   href="${ctx}/account/toMyGold"><I class=nav-icon6></I>我的金币</A>
									</li>
								</UL>
							</LI>
						</UL>
						<!--侧栏菜单结束-->
						<input id=tabIndexHidden type=hidden value=4 />
					</div>
					<div class=ui-plate-main>
						<H3 class=my-account-title>
							<span>个人信息</span>
						</H3>
						<div class=personal-info-text>
							<P>
								会&nbsp;&nbsp;员&nbsp;&nbsp;名：<span id="mobilePhone"></span>
							</P>
							<P id="realName2">
								真实姓名：您还未进行
								<span style="COLOR: #999; MARGIN-LEFT: 15px">实名认证</span>
							</P>
							<P id="realName1">
								真实姓名：
								<span id="realName"></span>
							</P>
							<P id="identityCard1">
								身份证号：
								<span id=identityCard></span>
							</P>
							<P id="identityCard2">
								身份证号：您还未进行
								<span style="COLOR: #999; MARGIN-LEFT: 15px">实名认证</span>
							</P>
							<P>
								手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：&nbsp;&nbsp;<span id="mobilePhone3"></span>
							</P>
							<P>
								登录密码：************
								<A class="blue up downward" href="javascript:void(0)">修改</A>
							</P>
							<div id=div_ExpandPassword class=personal-info-table
								style="DISPLAY: none">
								<table class=ui-table-2 cellSpacing=0 cellPadding=0 border=0>
									<tbody>
										<TR>
											<TH vAlign=middle width="15%" align=right>
												<div class=text-zd>
													原密码：
												</div>
											</TH>
											<TD width="85%">
												<div class=ui-out-box>
													<div class=ui-input-box>
														<input onchange='onchangeFunction($(this).attr("id"));'
															onfocus='onfocusFunction($(this).attr("id"));'
															onblur='onblurFunction($(this).attr("id"))'
															id="oldPassword" class=ui-input type="password"  maxlength="16"/>
													</div>
												</div>
											</TD>
										</TR>
										<TR>
											<TH vAlign=middle width="15%" align=right>
												<div class=text-zd>
													新密码：
												</div>
											</TH>
											<TD width="85%">
												<div class=ui-out-box>
													<div class=ui-input-box>
														<input onchange='onchangeFunction($(this).attr("id"));'
															onfocus='onfocusFunction($(this).attr("id"));'
															onblur='onblurFunction($(this).attr("id"))'
															id="newPassword" class="ui-input" type="password" maxlength="16"/>
													</div>
												</div>
											</TD>
										</TR>
										<TR>
											<TH vAlign=middle width="15%" align=right>
												<div class=text-zd>
													确认新密码：
												</div>
											</TH>
											<TD width="85%">
												<div class="ui-out-box">
													<div class="ui-input-box">
														<input onchange='onchangeFunction($(this).attr("id"));'
															onfocus='onfocusFunction($(this).attr("id"));'
															onblur='onblurFunction($(this).attr("id"))'
															id="confirmPassword" class="ui-input" type="password" maxlength="16"/>
													</div>
												</div>
											</TD>
										</TR>
										<TR>
											<TH vAlign=middle width="15%" align=right>
												<div class=text-zd>手机验证码：</div>
											</TH>
											<TD width="85%">
												<div class=ui-out-box>
													<div class=ui-input-box>
														<input id="verificationCodeinputPass" class="ui-input"
															style="WIDTH: 120px" maxlength="6"/>
															
														<input onclick="sendMobileCheckCodePassWord('001')"; id="btnSendMobileCodePassWord"
															class="button-yzm" type="button" value="获取验证码" />
														<input id='60SecondsP' class=button-disabled style="DISPLAY: none" type="button" value="120秒后重新获取" />
														<span id="checkPass"></span>
													</div>
												</div>
											</TD>
										</TR>
										<TR>
											<TH vAlign=middle align=right>
												&nbsp;
											</TH>
											<TD>
												<div class=ui-out-box>
													<div class=ui-input-box>
														<input onclick="UpdatePassWord();"
															class="ui-button-bank ui-button-orange" type=button
															value=确&nbsp;&nbsp;认 />
													</div>
												</div>
											</TD>
										</TR>
									</tbody>
								</table>
							</div>
							<div id=div_SuccInfoModifyPassword class=text-success
								style="DISPLAY: none">
									<IMG src="${resource_dir}/images/reg_20.png" />
								     &nbsp;&nbsp;密码修改成功，请重新登录！&nbsp;
							</div>
							<div id=ERR_SuccInfoModifyPassword class=text-success
								style="DISPLAY: none">
								<img src="${resource_dir}/images/reg_20.png" />
								     当前账户已锁定,请24小时后再试(<span id="spTime">5</span>秒后自动退出！)&nbsp;
							</div>
						</div>
					</div>
				</div>
			</div>
		</div> 
		<div class=blackBg></div>
		<P class=mouseTips><I></I></P>
		<%@ include file="../foot.jsp" %>
	</body>
</html>