<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>order</title>
<link href="${resource_dir}/css/header_footer.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/public.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/main.css" rel="stylesheet" type="text/css">
		
<script type="text/javascript" src="${resource_dir}/js/share.js"></script>
<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
<script type="text/javascript" src="${resource_dir}/js/json2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.extend.js"></script>
<script type="text/javascript" src="${resource_dir}/js/fn_qiantu.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>

<style type="text/css">
		.txtList li,.handCtl {
			cursor: pointer;
		}
		.txtList {
		  position: absolute;
		  left: -1px;
		  top: 27px;
		  padding: 5px 0;
		  background: #FFF;
		  border: 1px solid #ccc;
		  z-index: 200;
		  width: 100%;
		  box-shadow: 0 2px 2px #8f8f8f;
		  display: none;
		}
</style>

<script type="text/javascript">
	// 初始化 页面JS    非开发人员勿动 
	$(function () {
	    $.ajax({
		        url: '${ctx}/account/baseInfo',
		        success: function(data) {
		               if(data.mobilePhone!=null){
		                  $("#orderDate").html(data.pram1);
		                  //$('#nickName').val(data.mobilePhone);
		                  //document.getElementById("mobilePhone").innerText = data.mobilePhone;
		                  //document.getElementById("mobilePhone2").innerText = data.mobilePhone;
		                  //document.getElementById("mobilePhone3").innerText = data.mobilePhone;
		                  //document.getElementById("td_MobileOld").innerText = data.mobilePhone;
		                  
		                  $("#idcode").val(data.id);
		                  $("#mobilePhon").val(data.mobilePhone);
		               }
                        //  document.getElementById("hello").innerText = data.mobilePhone;
                       if(data.realName!=null&&data.realName!=""){
                           $("#realName2").hide();
                           $("#realName1").show();
                           document.getElementById("realName").innerText = data.realName;
                       }else{
                           $("#realName2").show();
                           $("#realName1").hide();
                          // $("#realNames").innerText = "未实名认证";
                       }  
		               if(data.identityCard!=null&&data.identityCard!=""){
                           $("#identityCard2").hide();
                           $("#identityCard1").show();
                           document.getElementById("identityCard").innerText = data.identityCard;
                       }else{
                           $("#identityCard2").show();
                           $("#identityCard1").hide();
                           // $("#realNames").innerText = "未实名认证";
                       }
                        if(data.email!=null&&data.email!=""){
	                           document.getElementById("email").innerText =data.email;
	                           document.getElementById("daiMail").innerText =data.email;
	                           
	                           $("#email2").show();
	                           $("#email1").hide();
                        }else{
                               // alert("232");
	                           $("#email1").show();
	                           $("#email2").hide();
                        }
		        }
		    });
	       
	});
	
	// 手机修改(点击“修改”按钮，隐藏或展现)
	function mobilePHT(){
		//alert("111");
     	var ty=$("#mobileP").val();
     	if(ty=="1"){
        	$("#mobilePH").show();
        	$("#mobileP").val("0");
     	}else{
        	$("#mobilePH").hide();
         	$("#mobileP").val("1");
     	}
	}
	
	//收缩展开效果
    $(document).ready(function () {
         $(".personal-info-text a").toggle(function () {
             $(this).parent().next(".personal-info-table").animate({ height: 'toggle', opacity: 'toggle' }, "slow");
             $(this).toggleClass("downward");
         }, function () {
             $(this).parent().next(".personal-info-table").animate({ height: 'toggle', opacity: 'toggle' }, "slow");
             $(this).toggleClass("downward");
         });

     });
     
     //格式提示隐藏
    function onblurFunction(ID) {
        $("#" + ID).removeClass("on-focus");
        $("#" + ID).parent().next(".tips-note").remove();
    }
	// 手机更换 修改
   function UpdateMobile(arg) {
           
         var idcode = $("#idcode").val();  //  主键ID
         var Mobile = "";
         var step = $("#btn_MobileNext").attr("step");
         var CheckCode = $.trim($("#txt_CheckCode_Mobile").val());
         var CheckType = 0;

             var tu = phoneValAuthCode("007");
             
             if("1"==tu){
               alert("验证码输入错误！请核对您接收到的，重新输入.");
               return;
            }else if("2"==tu){
               alert("您10分钟内发送验证码次数已超出3次！请稍后再试.");
               return;
            }else if("3"==tu){
               alert("您的验证码已过期！请重新获取.");
               return;
            }
             document.getElementById("newPhone").innerText="";
         
         $.ajax({
             type: "POST",
             async: false,
             url: '${ctx}/account/updateIdcode',
		     data:'id='+idcode+'&mobilePhone='+$("#mobileInput").val(),
             dataType: "text",
             error: function (err) {
                  QT_Tip.MsgAlert("当前网络异常，请稍后再试：" + err.statusText);
             },success: function (result) {
                 //  alert(result);
                  if (result == "ok") {
                     if ("ok" == "ok") {
                     if (CheckType == 0) {
                         $("#mobileInput").attr("readonly", false);
                         $("#div_MobileTitle").html("新手机号：");                         
                         $("#td_MobileOld").hide();
                         $("#td_MobileNew").show();
                         $("#txt_CheckCode_Mobile").val($("#txt_CheckCode_Mobile").attr("defaultval"));
                         $("#btn_MobileNext").attr("step", "check_new");

                         //重新设置验证码计时
                         window.clearInterval(iPoint);
                         $("#btnTime_Mobile").hide();
                         $("#btnTime_Mobile").val("60秒后重新获取");
                         $("#btnSendMobileCode_Mobile").removeAttr("disabled");
                         $("#btnSendMobileCode_Mobile").show();
                     }
                     else {
                         $("#btn_MobileNext").attr("step", "check_old");
                         startModifyMobileSuccTimer();  // 刷新页面  
                     }
                  }else {
                     QT_Tip.MsgAlert(result);
                  }
                }
           }}); 
     }
     
     // 手机号 验证码校验
     function phoneValAuthCode(arg){
            var co;
            var operId=$("#idcode").val();
            var phone=$("#mobilePhon").val();
             var authCode=$("#txt_CheckCode_Mobile").val();
            $.ajax({
	             type: "POST",
	             async: false,
	             url: '${ctx}/smsInfo/valAuthCode',
			     data: "phone="+phone+"&operId="+operId+"&messageType="+arg+"&authCode="+authCode,
	             dataType: "text",
	             error: function (err) {
	             },success: function (result) {
	                if("2"==result){
	                  alert("您10分钟内发送验证码次数已超出3次！请稍后再试.");
	                  return;
					 }
	                 document.getElementById("oldMail").innerText="您当前的验证码为： "+result;
	                   
	        }});
	             return co;
        }
     
     
     // 校验 并获取验证码
     function CheckMobileCheckCode(MobileCheckCode) {
         var ctrl = $("#txt_CheckCode_Mobile");
         var reg = /^\d{6}$/;
         if (MobileCheckCode == null || MobileCheckCode == "" || MobileCheckCode == $("#txt_MobileCheckCode").attr("defaultval")) {
             //验证码
             ShowHint(ctrl, "err", "验证码不能为空");
             ShowInputHint(ctrl, "err");
             return false;
         }else if(!reg.test(MobileCheckCode)) {
             ShowHint(ctrl, "err", "验证码错误");
             ShowInputHint(ctrl, "err");
             return false;
         }
         return true;
     }

	  //修改 成功手机号码 后的操作
	    function startModifyMobileSuccTimer(arg) {
	    
	         iPoint = window.setInterval("setTime_ModifyMobileSucc()", 1000);
	         $("#div_SuccInfoModifyMobile").attr("tick", 1);
	         $("#div_SuccInfoModifyMobile").show(); 
	         $("#div_ExpandMobile").hide(); 
	     }
	     
	    function setTime_ModifyMobileSucc() {
	         var TimeNow = parseInt($("#div_SuccInfoModifyMobile").attr("tick"));
	         $("#div_SuccInfoModifyMobile").attr("tick", TimeNow - 1);
	         if (TimeNow <= 0) {
	             window.clearInterval(iPoint);
	             $("#div_SuccInfoModifyMobile").hide();
	             location.reload(true);
	         }
	     }
	 function likai(){
			var sd =$("#mobileInput").val();
			if(sd != ""){
				var s =$("#txt_CheckCode_Mobile").val();
				var d=$("#newPhone1").val();
				if(s != d){
					alert("验证码错误");
				}else{
				}
			}
	 }
     //获取手机验证码
     function sendMobileCheckCode_Mobile(arg) {
         var operId=$("#idcode").val();
         var phone=$("#mobilePhon").val();
         var Mobile = "";
         var step = $("#btn_MobileNext").attr("step");
         if (step == "check_old"){
            $("#sendMobile4").val(arg); 
            step = 0; 
         }else{
             $("#sendMobile4").val("006");
             //新手机
             if (!isSendSMSable) {
                 return;
             }

             if (!CheckMobile($("#mobileInput").val())) {
                 return;
             }
             Mobile = $.trim($("#mobileInput").val());
             step = 1;
         }

         iPoint = window.setInterval("setTime_Mobile()", 1000);
         $("#btnTime_Mobile").show();
         $("#btnSendMobileCode_Mobile").attr("disabled", "disabled"); 
         $("#btnSendMobileCode_Mobile").hide();
         $("#btnTime_Mobile").parent().show();
         //$("#btnTime_Mobile").text(Mobile);
         //验证手机
         $.ajax({
             async: false, //false
             type: "post",
             url: '${ctx}/smsInfo/addCode',
             dataType: "text",
             data: "phone="+phone+"&operId="+operId+"&messageType="+$("#sendMobile4").val(),
             error: function (err) {
             },
             success: function (message) {
          //        if("2"==message){
	      //            alert("您10分钟内发送验证码次数已超出3次！请稍后再试.");
	       //           return;
			//	}
				document.getElementById("newPhone").innerText="您当前的验证码为： "+message;
				document.getElementById("newPhone1").value=message;
             }
         });
     } 
     function  ShowHint(id, iocType, msg) {
         var ctrl = $("#" + id);
        $(ctrl).removeClass("tips-error");
        $(ctrl).removeClass("tips-ok");
        $(ctrl).removeClass("ui-tips-text");
        if (iocType == "ok") {
            $(ctrl).addClass("tips-ok");
        }
        else if (iocType == "err") {
            $(ctrl).addClass("tips-error");
         }
        else if (iocType == "note") {
            $(ctrl).addClass("ui-tips-text");
        }
        $(ctrl).html(msg);
    }

        function CheckMobile() {
      		var Mobile= $("#mobileInput").val();
	        var HintCtrl_Id = "Hint_Mobile";
       		$("#Hint_Mobile").hide();
	        if (Mobile == null || Mobile == "" || Mobile == $("#Mobile").attr("defaultval")) {
	       $("#Hint_Mobile").show();
	            ShowHint(HintCtrl_Id, "err", "*手机号不能为空！");
	            ShowInputHint($("#MobilePhone"), "err");
	            $("#MobilePhone").focus();
	            return false;
	        }
	        var reg = /^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
	        if (!reg.test(Mobile)) {
	          $("#Hint_Mobile").show();
	            ShowHint(HintCtrl_Id, "err", "*请输入正确的手机号");
	            ShowInputHint($("#MobilePhone"), "err");
	            //$("#Mobile").focus();
	            return false;
	        }
	        return true;
    }
     

     //发送 手机验证码 验证密码  huangxiaohui
     function sendMobileCheckCodePassWord(arg) {
         // alert(arg);
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
             data: "phone="+phone+"&operId="+operId+"&messageType="+arg,
             success: function (result) {
                 alert(result);
                 if("2"==result){
	                  alert("您10分钟内发送验证码次数已超出3次！请稍后再试.");
	                  return;
                 }
                 document.getElementById("checkPass").innerText="您当前的验证码为： "+result;
             }
         });
     }
     
     //修改手机号码
     function startModifyMobileSuccTimer() {
         iPoint = window.setInterval("setTime_ModifyMobileSucc()", 1000);
         $("#div_SuccInfoModifyMobile").attr("tick", 1);
         $("#div_SuccInfoModifyMobile").show(); 
         $("#div_ExpandMobile").hide(); 
     }
     function setTime_ModifyMobileSucc() {
         var TimeNow = parseInt($("#div_SuccInfoModifyMobile").attr("tick"));
         $("#div_SuccInfoModifyMobile").attr("tick", TimeNow - 1);
         if (TimeNow <= 0) {
             window.clearInterval(iPoint);
             $("#div_SuccInfoModifyMobile").hide();
             location.reload(true);
         }
     }

     //修改电话下发验证码倒数
     function setTime_Mobile() {
         var TimeNow = $("#btnTime_Mobile").val() == "" ? 60 : parseInt($("#btnTime_Mobile").val());
         $("#btnTime_Mobile").val((TimeNow - 1) + "秒后重新获取");
         if (TimeNow <= 0) {
             window.clearInterval(iPoint);
             $("#btnTime_Mobile").hide();
             $("#btnTime_Mobile").val("60秒后重新获取");
             $("#btnSendMobileCode_Mobile").removeAttr("disabled");
             $("#btnSendMobileCode_Mobile").show();
         }
     }


     $("#txt_CheckCode_Mobile").live("focus", function () {
         SetInputFont(this, "black");
         ShowInputHint(this, "foc");
         ShowHint(this, null, "");
         if ($(this).val() == $(this).attr("defaultval")) {
             $(this).val("");
         }
     }).live("blur", function () {
         var MobileCheckCode = $.trim($(this).val());
         if (MobileCheckCode == "" || MobileCheckCode == $(this).attr("defaultval")) {
             $(this).val($(this).attr("defaultval"));
             ShowHint($(this).attr("id"), null, null);
             ShowInputHint(this, null);
             SetInputFont(this, null);
             return;
         }

         if (!CheckMobileCheckCode($.trim($(this).val()))) {
             return;
         }

         ShowInputHint(this, null);
     });
     
    //检查验证码
    function CheckMobileCode() {
        var ismobileCodeCorrect = false;
        var verificationCode = $("#verificationCodeInput").val();
        var reg = /^\d{6}$/;
        if (!reg.test(verificationCode)) {
            QT_Tip.MsgAlert("验证码输入错误！请核对您接收到的，重新输入${resource_dir}.");
            return false;
        }
        $.ajax({
            type: "POST",
            async: false,
            url: '/center/CheckMobileCode',
            data: "verificationCode=" + verificationCode,
            dataType: "text",
            error: function (err) {
                // QT_Tip.MsgAlert("当前网络异常，请稍后再试" + err.statusText);
            },
            success: function (result) {
                switch (result) {
                    case "True": ismobileCodeCorrect = true;
                        break;
                    case "False": QT_Tip.MsgAlert("验证码输入错误！");
                        break;
                    case "Invalid": QT_Tip.MsgAlert("验证码已过期！请重新获取${resource_dir}.");
                        break;
                    case "Error": QT_Tip.MsgAlert("请点击【获取验证码】发送验证码到您的手机${resource_dir}.");
                        break;
                }
            }
        });

        return ismobileCodeCorrect;
    }

    //输入完成验证
    function onchangeFunction(ID) {
        // alert(ID);
        switch (ID) {
            case "userNameInput":
                var UserName = $("#userNameInput").val();
                var reg = /^[\u4e00-\u9fa5]{2,6}$/;
                if (!reg.test(UserName)) {
                    $("#userNameInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#userNameInput").addClass("on-error");
                    $("#userNameInput").parent().after('<div class="ui-tips tips-error"><span><i></i>请输入正确的姓名！</span></div>')
                    //$("#userNameInput").val("");
                    //$("#userNameInput").focus()
                    return false;
                }
                else {
                    $("#userNameInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#userNameInput").parent().after('<div class="tips-correct"></div>')
                }
                break;
            case "IDCardInput":
                var IDCard = $("#IDCardInput").val();
                var reg = /^[1-9]([0-9]{14}|[0-9|X|x]{17})$/;
                if (!reg.test(IDCard)) {
                    $("#IDCardInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#IDCardInput").addClass("on-error");
                    $("#IDCardInput").parent().after('<div class="ui-tips tips-error"><span><i></i>请输入合法有效身份证号码！</span></div>')
                    //$("#IDCardInput").val("");
                    //$("#IDCardInput").focus()
                    return false;
                }
                else {
                    $("#IDCardInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#IDCardInput").parent().after('<div class="tips-correct"></div>');
                }
                break;
            case "mobileInput":
                var Mobile = $("#mobileInput").val();
                var reg = /^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
                if (!reg.test(Mobile)) {
                    $("#mobileInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#mobileInput").addClass("on-error");
                    $("#mobileInput").parent().after('<div class="ui-tips tips-error"><span><i></i>请输入正确手机号码！</span></div>')
                    //$("#mobileInput").val("");
                    //$("#mobileInput").focus()
                    return false;
                }
                else {
                    $("#mobileInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#mobileInput").parent().after('<div class="tips-correct"></div>');
                }
                break;
            case "emailInput":
                var Email = $("#emailInput").val();
                var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
                if (!reg.test(Email)) {
                    $("#emailInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#emailInput").addClass("on-error");
                    $("#emailInput").parent().after('<div class="ui-tips tips-error"><span><i></i>邮箱格式错误！</span></div>')
                    //$("#emailInput").val("");
                    //$("#emailInput").focus()
                    return false;
                }
                else {
                    $("#emailInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#emailInput").parent().after('<div class="tips-correct"></div>');
                }
                break;
            case "emailInputNEW":
                var Email = $("#emailInputNEW").val();
                var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
                if (!reg.test(Email)) {
                    $("#emailInputNEW").parent(".ui-input-box").nextAll("div").remove();
                    $("#emailInputNEW").addClass("on-error");
                    $("#emailInputNEW").parent().after('<div class="ui-tips tips-error"><span><i></i>邮箱格式错误！</span></div>')
                    //$("#emailInput").val("");
                    //$("#emailInput").focus()
                    return false;
                }
                else {
                    $("#emailInput").parent(".ui-input-box").nextAll("div").remove();
                    $("#emailInput").parent().after('<div class="tips-correct"></div>');
                }
                break;
            case "oldPassword":
                var oldPassword = $("#oldPassword").val();
                //Ajax请求，验证旧密码是否输入正确
                var flag = oldPasswordCheck(oldPassword);
                if (flag == "False") {
                    $("#oldPassword").parent(".ui-input-box").nextAll("div").remove();
                    $("#oldPassword").addClass("on-error");
                    $("#oldPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>旧密码输入错误！</span></div>')
                    //$("#oldPassword").val("");
                    //$("#oldPassword").focus();
                    return false;
                }
                else {
                    $("#oldPassword").parent(".ui-input-box").nextAll("div").remove();
                    $("#oldPassword").parent().after('<div class="tips-correct"></div>')
                }
                break;
            case "newPassword":
                var newPassword = $("#newPassword").val();
                var confirmPassword = $("#confirmPassword").val();
                var reg = /^^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@#$%^&]))[\dA-Za-z!@#$%^&]{6,16}/;
                if (!reg.test(newPassword) || newPassword.length < 6 || newPassword.length > 16) {
                    $("#newPassword").parent(".ui-input-box").nextAll("div").remove();
                    $("#newPassword").addClass("on-error");
                    $("#newPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请按格式要求设置密码！</span></div>')
                    return false;
                }
                else {
                    if (confirmPassword == "") {
                        $("#newPassword").parent(".ui-input-box").nextAll("div").remove();
                        $("#newPassword").parent().after('<div class="tips-correct"></div>');
                    }
                    else {
                        if (newPassword != confirmPassword) {
                            $("#newPassword").parent(".ui-input-box").nextAll("div").remove();
                            $("#newPassword").addClass("on-error");
                            $("#newPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请确保两次密码输入相同！</span></div>')
                            return false;
                        }
                        else {
                            $("#newPassword").parent(".ui-input-box").nextAll("div").remove();
                            $("#newPassword").parent().after('<div class="tips-correct"></div>');
                            $("#confirmPassword").removeClass("on-error");
                            $("#confirmPassword").parent().next(".tips-error").remove();
                            $("#confirmPassword").parent().after('<div class="tips-correct"></div>');
                        }
                    }
                }
                break;
            case "confirmPassword":
                var newPassword = $("#newPassword").val();
                var confirmPassword = $("#confirmPassword").val();
                var reg = /^^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@#$%^&]))[\dA-Za-z!@#$%^&]{6,16}/;
                if (!reg.test(confirmPassword) || confirmPassword.length < 6 || confirmPassword.length > 16) {
                    $("#confirmPassword").parent(".ui-input-box").nextAll("div").remove();
                    $("#confirmPassword").addClass("on-error");
                    $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请按格式要求设置密码！</span></div>')
                    return false;
                }
                else {
                    if (confirmPassword != newPassword) {
                        $("#confirmPassword").parent(".ui-input-box").nextAll("div").remove();
                        $("#confirmPassword").addClass("on-error");
                        $("#confirmPassword").parent().after('<div class="ui-tips tips-error"><span><i></i>请确保两次密码输入相同！</span></div>')
                        return false;
                    }
                    else {
                        $("#confirmPassword").parent(".ui-input-box").nextAll("div").remove();
                        $("#confirmPassword").parent().after('<div class="tips-correct"></div>');
                        $("#newPassword").removeClass("on-error");
                        $("#newPassword").parent().next(".tips-error").remove();
                        $("#newPassword").parent(".ui-input-box").nextAll(".tips-correct").remove();
                        $("#newPassword").parent().after('<div class="tips-correct"></div>');
                    }
                }
                break;
        }
    }
</script>

<script type="text/javascript">
		$(document).ready(function () {
			BindSelect(".settlementTypeSelect", function (selVal) { $("input[name='cardBank']").val(selVal); });
			$(".ui-bank").click(function () {
			   
				$(this).find(".txtList").show(); 
			});
			$(".ui-bank").mouseleave(function () {
				$(this).find(".txtList").hide();
			 });
			 
			 //初始化省市
            jointProvinceStr();
		});
		
		function BindSelect(target, SelFn) {
        	$(target).find(".txtList").find("li").unbind("click");
            $(target).find(".txtList").find("li").bind("click", function () {
            // alert("23424");
                var selVal = $(this).attr("value");
                SelFn(selVal);
                var selHtml = $(this).html().trim();
                $(target).find(".txt").html(selHtml);
                setTimeout(function () { $(target).find(".txtList").hide(); }, 1);
            });
        }
		
	function disable()
	  {
	  document.getElementById("accept").disabled=true
	  }
	function enable()
	  {
	  document.getElementById("accept").disabled=false
  	}
  	
  	function confirmCommit(){
	  	var orderBo = {
	  		mobilePhone:$("#mobilePhone").html(),//手机号
	  		yield:$("#currentIncome").html(),//预期收益
	  		fkItemId:$("#fkItemId").val(),//项目编号
	  		totalMoney:$("#currentAmount").val()//金额
	  	};
	  	//未绑定账户或未选择支付/回款账户给予提示
	  	var bankCode = $("#selectBank1").find(".txt").find("span").attr("code");
	  	if(bankCode == "0000"){//没有选择账户
	  		alert("您还没有绑定用于支付及回款的帐户，请先去添加帐户！");
	  		return false;
	  	}
	  	
	  	//勾选协议提示
	  	if($("#chk_AgreeProtocol").attr("checked") != true){
	  		$("#xieYiMsg").html('请阅读勾选协议');
	  		$("#xieYiMsg").show();
	  		return false;
	  	}
	  	$("#hiddenData").val(JSON.stringify(orderBo));
  		document.submitForm.action="${ctx}/arcOrder/submit";
  		document.submitForm.submit();
  		$("#accept").attr("disabled","true");
  	}
</script>
<style type="text/css">
		.txtList li,.handCtl {
			cursor: pointer;
		}
		.txtList {
		  position: absolute;
		  left: -1px;
		  top: 27px;
		  padding: 5px 0;
		  background: #FFF;
		  border: 1px solid #ccc;
		  z-index: 200;
		  width: 100%;
		  box-shadow: 0 2px 2px #8f8f8f;
		  display: none;
		}
</style>

<script type="text/javascript">
	$(document).ready(function () {
		BindSelect(".settlementTypeSelect", function (selVal) { $("input[name='cardBank']").val(selVal); });
		$(".ui-bank").click(function () {
			$(this).find(".txtList").show(); 
		});
		$(".ui-bank").mouseleave(function () {
			$(this).find(".txtList").hide();
		 });
	});
	function BindSelect(target, SelFn) {
        	$(target).find(".txtList").find("li").unbind("click");
            $(target).find(".txtList").find("li").bind("click", function () {
                var selVal = $(this).attr("value");
                SelFn(selVal);
                var selHtml = $(this).html().trim();
                $(target).find(".txt").html(selHtml);
                setTimeout(function () { $(target).find(".txtList").hide(); }, 1);
            });
        }
</script>
<script type="text/javascript">
    /**收益计算器_计算功能*/
    function Calculate() {
        var investreg = /^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/;
        var numreg = /^-?\d+$/;
        if ($.trim($("#jsqAmonut").val()) == "") {
            alert("请输入投资金额!");
            $("#jsqAmonut").focus();
            return;
        }
        if (!investreg.test($.trim($("#jsqAmonut").val()))) {
            alert("投资金额格式错误，只保留两位小数！")
            $("#jsqAmonut").focus();
            return false;
        }

        if ($.trim($("#jsqYint").val()) == "") {
            alert("请输入预期投资收益!");
            $("#jsqYint").focus();
            return;
        }
        if (!investreg.test($.trim($("#jsqYint").val()))) {
            alert("年化利率格式错误，只保留两位小数！")
            $("#jsqYint").focus();
            return false;
        }

        if ($.trim($("#jsqDay").val()) == "") {
            alert("请输入投资期限!");
            $("#jsqDay").focus();
            return;
        }
        if (!numreg.test($.trim($("#jsqDay").val()))) {
            alert("投资期限格式错误，只能输入数字！")
            $("#jsqDay").focus();
            return false;
        }
        
        var investreg = /^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/;
        var numreg = /^-?\d+$/;
        if ($.trim($("#currentAmount").val()) == "") {
            alert("请输入投资金额!");
            $("#currentAmount").focus();
            return;
        }
        if (!investreg.test($.trim($("#currentAmount").val()))) {
            alert("投资金额格式错误，只保留两位小数！")
            $("#").focus();
            return false;
        }

        //当前进度
		$("#nowaday").html(divide(parseFloat($("#total").val()),parseInt($("#totalFinanceMoney").val())));
		//利息计算
        $("#currentIncome").html(CalculateInterest(parseFloat(obj.val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
    }

	//加号
    function add(obj) {
    	 var surplus = parseInt($("#surplus").html());// zs
    	 var count =parseInt($("#currentAmount").val());//xs
    	 
    	  var remain =parseInt($("#remain").val());//剩余可投份数
    	 
    	 if($.trim(surplus) != "" && count < surplus){
	 		if((surplus-count) < 1000){ //剩余可投
	 			$("#currentAmount").val(surplus);
	  		}else{
	  			$("#currentAmount").val(count+1000);
	  		}
	    }
    	 if($.trim(remain) != "" && remain <= 10 ){
	  		alert("还剩最后 "+remain+" 份可投标了!");
		 }
        $("#remain").val(Remain(parseInt($("#surplus").html()),parseInt($("#currentAmount").val())));
        $("#currentIncome").html(CalculateInterest(parseFloat($("#currentAmount").val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
		 
   	
   }
   
   //减号
   function del(obj){
   		var finanCount = parseInt($("#currentAmount").val());
   		var remain =parseInt($("#remain").val());
	   if($.trim(remain) != "" && remain <= 10 ){
	    	alert("还剩最后 "+remain+" 份可投标了!");
	    }
	    if($.trim(finanCount) != "" &&  finanCount >= 1000){
	    	$("#currentAmount").val(finanCount-1000);
	    	//最后10条时提示
  			$("#remain").val(Remain(parseInt($("#surplus").html()),parseInt($("#currentAmount").val())));
	    	//利息计算
        	$("#currentIncome").html(CalculateInterest(parseFloat($("#currentAmount").val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    }
	    if($.trim(finanCount) != "" &&  finanCount < 1000){
	   	 	$("#currentAmount").val(1000)
	    }
    }
    
    //手动输入
    function PartsCountChange(obj){
    	var numreg = /^-?\d+$/;
		if(numreg.test($.trim($("#currentAmount").val()))){
			var maxNum = parseInt(parseInt($("#surplus").html()));
			var remain = parseInt($("#remain").val());
			var countNum = parseInt($("#currentAmount").val());
			var minNum = 1000;
		    if($.trim(remain) != "" && remain <= 10 ){
		    	alert("还剩最后 "+remain+" 份可投标了!");
		    }
			if($.trim(countNum) != "" &&  countNum <= minNum){
			    $("#currentAmount").val(1000)
			}
			if($.trim(countNum) != "" &&  countNum >= maxNum){
			  $("#currentAmount").val(parseInt($("#surplus").html()));
			}
			//最后10条时提示
  			$("#remain").val(Remain(parseInt($("#surplus").html()),parseInt($("#currentAmount").val())));
			//利息计算
        	$("#currentIncome").html(CalculateInterest(parseFloat($("#currentAmount").val()), parseFloat($("#currentYint").text()) / 100, parseInt($("#currentDay").text())).toFixed(2));
	    }else{
		    alert("金额格式错误，请输入整数！");
		    $("#currentAmount").val(obj.val());
		}
    }
    /**
    *收益计算器_重置功能
    **/
    function ReSetjsq() {
        $("#jsqAmonut").val("");
        $("#jsqYint").val("");
        $("#jsqDay").val("");
        $("#Income").html("");
        $("#totalIncome").html("");
        $("#jsqAmonut").focus();
    }
    //利息计算
    function CalculateInterest(amount, rate, daysCount) {
        var interest = (amount * rate / 360) * daysCount;
        return ToDigits2(interest);
    }
    
    //进度计算（除法）
    function divide(dividend, divisor) {
        var interest = (dividend / divisor) * 100;
        return interest;
    }
    
    //还剩10份时给出温馨提示
    function Remain(minuend,subtractor){
    	var interest = (minuend - subtractor)/1000;
        return interest;
    }
    
    //处理结果
    function ToDigits2(floatVal) {
        var strResult = parseFloat(floatVal).toFixed(4).toString();
        return parseFloat(strResult.substr(0, strResult.length - 2));
    }
</script>
<script type="text/javascript"><!--
	 function bindBank(){
//        var UserBankAccountId=$("#selectbank .bank-select span").attr("bankid");
//        if(UserBankAccountId)
//        {
//            $("#lnk_AddBink").text("修改帐户");
//        }else{
//            $("#lnk_AddBink").text(" +添加帐户");
//        }

        InitBank_per();

        //添加银行卡弹窗
        $("#div_VerifyUserFailed").hide();
        $("#div_VerifyUserInfo").hide();

        //添加结果弹窗
        $("#p_LogoBankChecking").hide();
        $("#p_BankCheckOk").hide();
        $("#p_BankCheckFailse").hide();
        $("#lnk_BindBankFinished").attr("accountNo", "");

        //Initialize form data
        $("#txt_frmMerCode").val("");
        $("#txt_frmAccountNo").val("");
        $("#txt_frmAccountType").val("");
        $("#txt_frmOpenBankId").val("");
        $("#txt_frmBackUrl").val("");
        $("#txt_frmCertType").val("");
        $("#txt_frmCertNum").val("");
        $("#txt_frmUsrName").val("");
        $("#txt_frmCardCvn2").val("");                    
        $("#txt_frmCardExpire").val("");                    
        $("#txt_frmCardPhone").val("");                
        $("#txt_frmSignData").val("");

        if(IsCheckedRealName==true){
                $("#txtAccountName").val(RealName);SetInputFont($("#txtAccountName"), "black");
                $("#tb_CheckedRealName").css("display", "none");
                $("#lnk_AddBink").attr("open_win", "addbink_2||ui-window-1||500||380");
                $("[open_win=\"addbink_2||ui-window-1||500||380\"]").click();
        }
        else{
                $("#tb_CheckedRealName").css("display", "");
                $("#lnk_AddBink").attr("open_win", "addbink_2||ui-window-1||500||520");
                $("[open_win=\"addbink_2||ui-window-1||500||520\"]").click();
        } 
    }
	
	
	function InitBank_per() {
	   //  alert("3242432");
        Set_btnAddBankSubmitDisabled(false);
        $("#txtUserName").val($("#txtUserName").attr("defaultval")); ShowMessageNote($("#txtUserName"), null, null); SetInputFont($("#txtUserName"), null);
        $("#txtIDcard").val($("#txtIDcard").attr("defaultval")); ShowMessageNote($("#txtIDcard"), null, null); SetInputFont($("#txtIDcard"), null);
        $("#txtAccountName").val($("#txtAccountName").attr("defaultval")); ShowMessageNote($("#txtAccountName"), null, null); SetInputFont($("#txtAccountName"), null);
        $("#txtAccountNo").val($("#txtAccountNo").attr("defaultval")); ShowMessageNote($("#txtAccountNo"), null, null); SetInputFont($("#txtAccountNo"), null);
        
        $("#div_AddBink_BankSelected bank-list ul li").eq(0).click();
        
    }
    
    function VerifyBank() {
        var verInfo = {};
        //verInfo.IDCard=$.trim($("#txtIDcard").val());
        //verInfo.RealName=$.trim($("#txtUserName").val());
        verInfo.AccountName = $.trim($("#txtAccountName").val());
        verInfo.AccountNo = $.trim($("#txtAccountNo").val()).replace(/ /g, "");
        verInfo.BankName = $.trim($("#div_AddBink_BankSelected").find("span").attr("title"));
        verInfo.BankCode = getEnumStatus(verInfo.BankName, null, "Descrip").split(";")[1];

        var regAccountNo = /^\d{13,19}$/;
        if (!regAccountNo.test(verInfo.AccountNo)) {
            ShowMessageNote($("#txtAccountNo"), "err", "账号不正确");
            return;
        }

        $.AjaxWebService("/Ajax/SignBankData", verInfo, function (result) {
            if (result.IsSuccess) {
                var signDatas = new Array();
                signDatas = result.Message.split("|");
                $("#txt_frmMerCode").val(signDatas[0]);
                $("#txt_frmAccountNo").val(signDatas[1]);
                $("#txt_frmAccountType").val(signDatas[2]);
                $("#txt_frmOpenBankId").val(signDatas[3]);
                $("#txt_frmCertType").val(signDatas[4]);
                $("#txt_frmCertNum").val(signDatas[5]);
                $("#txt_frmUsrName").val(signDatas[6]);
                $("#txt_frmCardPhone").val(signDatas[7]);
                $("#txt_frmBackUrl").val(signDatas[8]);
                $("#txt_frmSignData").val(signDatas[9]);
                $("#form_verifyBindBank").submit();

                $('.blackBg').hide();
                $(".close").click();
                $("#btn_VerifySucceed").click();
                $("#lnk_BindBankFinished").attr("accountNo", verInfo.AccountNo);

                //GetBankAccount();
                //$('.blackBg').hide();
                //$(".close").click();
                return true;
            } else {
                QT_Tip.MsgAlert(result.Message)
                return false;
            }
        });
    }
    
    
    function Set_btnAddBankSubmitDisabled(isDisabled) {
        var btn = $("#btn_AddBankSubmit"); if (btn == null) return;
        btn.removeClass("submit");
        btn.removeClass("reset");
        if (isDisabled) {
            btn.addClass("reset");
            btn.attr("disabled", "disabled");
        }
        else {
            btn.addClass("submit");
            btn.removeAttr("disabled");
        }
    }
    
   function CheckSelectedBankName() {
        var bankSpan = $("#div_AddBink_BankSelected").find("span");
        if (bankSpan == null) {
            QT_Tip.MsgAlert("请选择开户行");
            return false;
        }

        var bankName = $.trim(bankSpan.attr("title"));
        if (bankName == null || bankName.length == 0) {
            //QT_Tip.MsgAlert("请选择开户行");
            return false;
        }

        return true;
    }
    
    
    var  IsCheckedRealName=false;
    
    function ShowMessageNote(obj, msgType, msg) {
        var ctrl = $(obj).parent(".ui-input-box");
        $(ctrl).nextAll(".ui-tips").remove();
        if (msgType == "ok") {
            $(ctrl).after("<div class=\"ui-tips tips-correct\"></div>");
        }
        else if (msgType == "note") {
            $(ctrl).after("<div class=\"ui-tips tips-note\" ><span><i></i>" + msg + "</span></div>");
        }
        else if (msgType == "err") {
            $(ctrl).after("<div class=\"ui-tips tips-error\" ><span><i></i>" + msg + "</span></div>");
        }
        //else{
        //    $(ctrl).nextAll(".ui-tips").remove();
        //}
    }
    
     function bindBankMax() {
        //if(document.getElementById("ul_bankaccountlist").getElementsByTagName("li").length>=20)
        //{
            //QT_Tip.MsgAlert("当前最多可添加10张支付/回款账户");
           // return true;
        //}

        //return false;
    }
    //初始化省市
    function jointProvinceStr(obj){
			var provinceStr = "";
			$.ajax({
	            async: false,
	            type: "post",
	            url: '${ctx}/dicRegion/getTopLevelRegion',
	            success: function (msg) {
	            	for(var i=0,l=msg.length;i<l;i++){
	            		provinceStr+="<option id="+msg[i].code+" value="+msg[i].code+">"+msg[i].text+"</option>";
	            	}
	            	$("#province").append(provinceStr);
	            }
        	});
		}
    
    //省份选择
    function toggleProvince(){
			var cityStr = "";
			var pcode = $("#province").find("option:selected").val();
			if(!pcode){
				$("#city").empty();
				$("#city").css('display','none');
			}else{
				$.ajax({
		            async: false,
		            type: "post",
		            data:"pcode="+pcode,
		            url: '${ctx}/dicRegion/findArray',
		            success: function (msg) {
		            	for(var i=0,l=msg.length;i<l;i++){
		            		cityStr+="<option id="+msg[i].code+" value="+msg[0].code+">"+msg[i].text+"</option>";
		            	}
		            	$("#city").css('display','');
		            	$("#city").empty();
		            	$("#city").append(cityStr);
		            }
	        	});
			}
		}
		
	function VerifyUser(isPer) {
        $("#div_VerifyUserFailed").hide();
        $("#div_VerifyUserInfo").show();
       
        var verInfo = {};
        verInfo.IDCard = $.trim($("#txtIDcard").val());
        verInfo.RealName = $.trim($("#txtUserName").val());
        //verInfo.AccountName=$.trim($("#txtAccountName").val());
        //verInfo.AccountNo=$.trim($("#txtAccountNo").val()).replace(/ /g, "");
        //verInfo.BankName = $.trim($("#div_AddBink_BankSelected").find("span").attr("title"));
        //verInfo.BankCode = getEnumStatus(verInfo.BankName, null, "Descrip").split(";")[1];
       
        //$.AjaxWebService("", verInfo, function (result) {
            Set_btnAddBankSubmitDisabled(false);
            if (true) {
                IsCheckedRealName = true;
                RealName = verInfo.RealName;
                //QT_Tip.MsgAlert(result.Message)
                //GetBankAccount();
                //$('.blackBg').hide();
                //$(".close").click();
                $("#div_VerifyUserFailed").hide();
                $("#div_VerifyUserInfo").hide();
                if (isPer) {
                    savebank_per();
                }
                return true;
            } else {
                //QT_Tip.MsgAlert(result.Message)
                $("#div_VerifyUserFailed").show();
                $("#div_VerifyUserInfo").hide();
                return false;
            }
        //});
    }
    
    function appendSelectBank(){
    	//定义样式
    	var bankCssJson={
    		"0":"bank-crbank",
    		"100":"bank-psbc",
    		"102":"bank-icbc",
    		"103":"bank-abc",
    		"104":"bank-boc",
    		"105":"bank-ccb",
    		"302":"bank-ecitic",
    		"303":"bank-cebbank",
    		"305":"bank-cmbc",
    		"306":"bank-cgbchina",
    		"307":"bank-pingan",
    		"308":"bank-cmb",
    		"309":"bank-cib"
    	};
    	
    	
    	 //向后台请求新的绑定银行列表
        $.ajax({
			 url: '${ctx}/arcOrder/freshSelectBank',
		   	 success: function(result){
		   	 	var html ='';
			   	for(var i=0;i<result.length;i++){
			   		var tempObj = result[i];
			   		var accountName = tempObj.accountName;
			   		var cardNumber = tempObj.cardNumber;
			   		var cardBank = tempObj.cardBank;
			   		html += '<li > <span title="银行名字" code="'+cardBank+'" class="bank-logo '+bankCssJson[cardBank]+'" style="display:block;padding:15px;width:100px; float:left;"></span><span class="bank-number">'+cardNumber+'<b>|</b>'+accountName+'</span></li> ';
			   		
			   	}
			   	
			   	$("#bankListUl").find("li").remove();
			   	$("#bankListUl").append(html);
			   	$("#bankListUl").find("li").bind("click",function(){
			   		var targetHtml = $(this).html();
			   		$(".txt").empty();
			   		$(".txt").append(targetHtml);
			   		$("#bankListUl").hide();
			   	});
		     }  
		});
    }
    
     function SetInputFont(ctrl, ftType) {
        if (ftType == 'black') {
            $(ctrl).css("color", "#666");
        }
        else {
            $(ctrl).css("color", "#ccc");
        }
    }
    
    $("#txtIDcard").live("focus", function () {
        SetInputFont(this, "black");
        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == defVal) {
            $(this).val("");
            ShowMessageNote(this, "note", defVal);
        }
    }).live("blur", function () {
        ShowMessageNote(this, null, null); //remove note

        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == "" || value == defVal) {
            $(this).val(defVal);
            SetInputFont(this, null);
            return;
        }
        if (!CheckIDcard()) {
            return;
        }

        $.AjaxWebService("/Ajax/IsIDCardExist", { IDCard: value }, function (result) {
            if (result.IsSuccess) {
                ShowMessageNote($("#txtIDcard"), "err", "此身份证已经被使用");
            } else {
                ShowMessageNote($("#txtIDcard"), "ok", null); //remove note
            }
        });
    });
    
		
	//开户名
    function CheckAccountName() {
        return true; //开户名取真实姓名
        var ctrl = $("#txtAccountName");
        var value = $(ctrl).val();
        if (value == null || value == "" || value == $(ctrl).attr("defaultval")) {
            ShowMessageNote(ctrl, "err", "开户名不能为空");
            return false;
        }
        var reg = /^[a-zA-Z0-9\u4e00-\u9fa5]+$/;
        if (!reg.test(value)) {
            ShowMessageNote(ctrl, "err", "开户名不正确");
            return false;
        }

        return true;
    }
    
    $("#txtAccountName").live("focus", function () {
        return; //开户名取真实姓名
        SetInputFont(this, "black");
        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == defVal) {
            $(this).val("");
            ShowMessageNote(this, "note", defVal);
        }
    }).live("blur", function () {
        return; //开户名取真实姓名
        ShowMessageNote(this, null, null); //remove note

        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == "" || value == defVal) {
            $(this).val(defVal);
            SetInputFont(this, null);
            return;
        }

        if (CheckAccountName()) {
            ShowMessageNote(this, "ok", null);
        }
    });
    
    
    //账号
    function CheckAccountNo() {
        var ctrl = $("#txtAccountNo");
        var value = $(ctrl).val();
        if (value == null || value == "" || value == $(ctrl).attr("defaultval")) {
            ShowMessageNote(ctrl, "err", "账号不能为空");
            return false;
        }
        value = value.replace(/ /g, "");
        var reg = /^\d{13,19}$/;
        if (!reg.test(value)) {
            ShowMessageNote(ctrl, "err", "账号不正确");
            return false;
        }

        ShowMessageNote(ctrl, "ok", null);
        return true;
    }
    
    function saveBankinfo_hr(bankaccount, IsFinMang) {
        if (IsFinMang) {
            //企业
            $.AjaxWebService("/Ajax/AddBankOfComp", bankaccount, function (result) {
                if (result.IsSuccess) {
                    $('.blackBg').hide();
                    $(".close").click();
                    //InitBank_per();
                    BtnSave_Update();
                    return true;
                } else {
                    QT_Tip.MsgAlert(result.Message)
                    return false;
                }
            }, null, false);
        }
        else {
            //个人
            $.AjaxWebService("/Ajax/SaveBank", bankaccount, function (result) {
                if (result.IsSuccess) {
                    //GetBankAccount();
                    $('.blackBg').hide();
                    $(".close").click();
                    VerifyBank(); //验卡
                    //InitBank_per();
                    //BtnSave_Update();
                    return true;
                } else {
                    $('.blackBg').hide();
                    $(".close").click();
                    QT_Tip.MsgAlert(result.Message)
                    return false;
                }
            }, null, false);
        }
    }
    
    
     $("#txtAccountNo").live("focus", function () {
        SetInputFont(this, "black");
        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == defVal) {
            $(this).val("");
            ShowMessageNote(this, "note", defVal);
        }
    }).live("blur", function () {
        ShowMessageNote(this, null, null); //remove note

        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == "" || value == defVal) {
            $(this).val(defVal);
            SetInputFont(this, null);
            return;
        }

        if (!CheckAccountNo()) {
        }
    }).live("keyup", function () {
        var value = $(this).val();
        //    $(this).val($.trim(value));
        var len = value.length;

        value = $.trim($(this).val());

        var reg = /^\d+$/;
        if (!reg.test(value.replace(/ /g, ""))) {
            ShowMessageNote(this, "note", "只能输入数字");
            var len = value.length;
            $(this).val(value.substr(0, len - 1));
            return;
        }
        else {
            ShowMessageNote(this, null, null);
        }

        $(this).val(value.replace(/(\d{4})(?=\d)/g, "$1 "));
    });
    
    
    //姓名
    function CheckUserName() {
        var ctrl = $("#txtUserName");
        var value = $(ctrl).val();
        if (value == null || value == "" || value == $(ctrl).attr("defaultval")) {
            ShowMessageNote(ctrl, "err", "姓名不能为空");
            return false;
        }

        var reg = /^[\u4e00-\u9fa5]{2,6}$/;
        if (!reg.test(value)) {
            ShowMessageNote(ctrl, "err", "您填写的姓名有误，请核对修改");
            return false;
        }

        ShowMessageNote(ctrl, "ok", null);
        return true;
    }
    
    $("#txtUserName").live("focus", function () {
        SetInputFont(this, "black");
        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == defVal) {
            $(this).val("");
            ShowMessageNote(this, "note", defVal);
        }
    }).live("blur", function () {
        ShowMessageNote(this, null, null); //remove note

        var value = $.trim($(this).val());
        var defVal = $.trim($(this).attr("defaultval"));
        if (value == "" || value == defVal) {
            $(this).val(defVal);
            SetInputFont(this, null);
            $("#txtAccountName").val($("#txtAccountName").attr("defaultval"));
            SetInputFont($("#txtAccountName"), null);
            return;
        }
        if (!CheckUserName()) {
            return;
        }

        $("#txtAccountName").val(value);
        SetInputFont($("#txtAccountName"), "black");

    }).live("keyup", function () {
        var value = $(this).val();
        //    $(this).val($.trim(value));
        var len = value.length;

        value = $.trim($(this).val());
        var reg = /^[\u4e00-\u9fa5]{2,6}$/;
        if (!reg.test(value)) {
            ShowMessageNote(this, "note", "2-6个汉字");
            //            var len = value.length;
            //            if(len>2){
            //                $(this).val(value.substr(0, len - 1));
            //            }
        }
        else {
            ShowMessageNote(this, null, null);
        }
    });
    
    
    
     //身份证
    function CheckIDcard() {
        var ctrl = $("#txtIDcard");
        var value = $(ctrl).val();
        if (value == null || value == "" || value == $(ctrl).attr("defaultval")) {
            ShowMessageNote(ctrl, "err", "身份证号不能为空");
            return false;
        }

        var reg = /^[1-9]([0-9]{14}|[0-9|X|x]{17})$/;
        if (!reg.test(value)) {
            ShowMessageNote(ctrl, "err", "您填写的身份证号有误，请核对修改");
            return false;
        }

        ShowMessageNote(ctrl, "ok", null);
        return true;
    }

	function savebank_per() {
        var verInfo = {};
        verInfo.accountCode = $.trim($("#txtIDcard").val());
       //varlnk_AddBink RealName = $.trim($("#txtUserName").val());
        verInfo.cardBank = $.trim($("#div_AddBink_BankSelected").find("span").attr("code"));
        verInfo.accountName=$.trim($("#txtAccountName").val());
        verInfo.cardNumber=$.trim($("#txtAccountNo").val()).replace(/ /g, "");
        verInfo.cardProvince = $("#province option:selected").val();
        verInfo.card_city = $("#city option:selected").val();
       	if(verInfo.cardProvince == ""){
       		alert("请选择开户行省份");
       		return;
       	}
        //if (!saveBankinfo_hr(bankaccount, false)) {
            //return;
        //}
        //var form = $("#formbank_2");
        //form.submit();
        
        //向后台请求绑定银行卡保存到数据库
        $.ajax({
			 type: 'POST',
			 url: '${ctx}/arcOrder/accountSubmit',
			 data: "cardInfo="+JSON.stringify(verInfo),
		   	 success: function(result){
			   	 //绑定成功后，动态刷新下拉列表
			   	 if(result.flag == "ok"){
			   	 	$("#closeAddDiv").trigger("click");
			   	 	alert("绑定成功");
			   	 	appendSelectBank();
			   	 }else{
			   	 	alert("绑定失败");
			   	 }
		     }  
		});
       
    }

	//点击确认按钮
	 function addbank_per() {
        $("#lnk_BindBankClose").hide();
        $("#lnk_BindBankCancel").show();
        $("#lnk_BindBankFinished").show();

        var UserName = $.trim($("#txtUserName").val());
        var IDcard = $.trim($("#txtIDcard").val());

        if (!CheckSelectedBankName() || !CheckAccountName() || !CheckAccountNo()) {
            return;
        }
        if (IsCheckedRealName) {
            Set_btnAddBankSubmitDisabled(true);
            savebank_per();
        }else {
            //先格式校验
            if (!CheckUserName() || !CheckIDcard()) {
                return;
            }
            Set_btnAddBankSubmitDisabled(true);
            VerifyUser(true);
        }
    }
    
    function closeDiv(){
    	//$("#addbink_2").remove();
    }
    
     $(document).ready(function () {
     	$("#banklist").find("li").bind("click", function () {
    		var selVal = $(this).attr("value");
    		var targetHtml = $(this).html();
    		$("#div_AddBink_BankSelected").html(targetHtml);
    		$("#banklist").hide();
    	});
     });
    
    function BindSelect1(){
    	$("#banklist").css('z-index','100');
    	$("#banklist").show();
    }
    
    function verfythisBox(box){
    	if($(box).attr("checked")==true) {
    		$("#xieYiMsg").hide();
    	}else{
    		$("#xieYiMsg").html('请阅读并勾选协议');
    		$("#xieYiMsg").show();
    	}
    }
</script>

<!--添加账户弹窗 -->
<div class="prompt_box" id="addbink_2">
    <div class="prompt_inner bank-add-box">
        <h3 class="title">
            添加账户<a href="javascript:void()" class="close" close-ui="addbink_2" id="closeAddDiv"></a></h3>
        <div class="conent" style="padding: 0 20px">
            <table width="100%" border="0" cellspacing="5" cellpadding="0" class="table_5">
                <tr>
                    <th>
                        &nbsp;
                    </th>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <th width="30%">
                        <span class="red">*</span><span class="ui-icon">选择银行：</span>
                    </th>
                    <td width="70%">
                        <div class="ui-bank" id="selectBank" style="height: 35px; width: 200px;">
                            <div class="bank-select" id="div_AddBink_BankSelected" style="height:35px;"  onclick="BindSelect1()"><span title="华润银行" code="0" class="bank-logo bank-crbank" style="margin-top:3px;"></span></div>
                            <div class="bank-list"  id="banklist" style="top:35px;"><ul><li value="0"> <span title="华润银行" code="0" class="bank-logo bank-crbank"></span></li><li value="1"> <span title="中国邮政储蓄银行" code="100" class="bank-logo bank-psbc"></span></li><li value="2"> <span title="中国工商银行" code="102" class="bank-logo bank-icbc"></span></li><li value="3"> <span title="中国农业银行" code="103" class="bank-logo bank-abc"></span></li><li value="4"> <span title="中国银行" code="104" class="bank-logo bank-boc"></span></li><li value="5"> <span title="中国建设银行" code="105" class="bank-logo bank-ccb"></span></li><li value="6"> <span title="中信银行" code="302" class="bank-logo bank-ecitic"></span></li><li value="7"> <span title="中国光大银行" code="303" class="bank-logo bank-cebbank"></span></li><li value="8"> <span title="中国民生银行" code="305" class="bank-logo bank-cmbc"></span></li><li value="9"> <span title="广发银行" code="306" class="bank-logo bank-cgbchina"></span></li><li value="10"> <span title="平安银行" code="307" class="bank-logo bank-pingan"></span></li><li value="11"> <span title="招商银行" code="308" class="bank-logo bank-cmb"></span></li><li value="12"> <span title="兴业银行" code="309" class="bank-logo bank-cib"></span></li></ul></div>
                        </div>
                    </td>
                </tr>
                <tbody id="tb_CheckedRealName" style="display: ;">
                    <!-- 普通用户未验证显示 -->
                    <tr>
                        <th>
                            <span class="red">*</span><span class="ui-icon">真实姓名：</span>
                        </th>
                        <td>
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" id="txtUserName" value="填写姓名" defaultval="填写姓名" class="ui-input w-150"
                                        style="height: 35px; line-height: 35px; width: 200px; color: #ccc;" />
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <span class="red">*</span><span class="ui-icon">身份证号：</span>
                        </th>
                        <td>
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" id="txtIDcard" value="填写身份证号" defaultval="填写身份证号" class="ui-input w-150"
                                        onblur="if (this.value=='') this.value=this.defaultValue;" onfocus="if (this.value==this.defaultValue) this.value='';"
                                        style="height: 35px; line-height: 35px; width: 200px; color: #ccc;" />
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tr>
                    <th>
                        <span class="red">*</span><span class="ui-icon"> 开户名：</span>
                    </th>
                    <td>
                        <div class="ui-out-box">
                            <div class="ui-input-box">
                                <input type="text" id="txtAccountName" readonly="readonly" value="填写开户名" defaultval="填写开户名"
                                    class="ui-input w-150" id="loginPassword2" onblur="if (this.value=='') this.value=this.defaultValue;"
                                    onfocus="if (this.value==this.defaultValue) this.value='';" style="height: 35px;
                                    line-height: 35px; width: 200px; color: #ccc;" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span class="red">*</span><span class="ui-icon">账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</span>
                    </th>
                    <td>
                        <div class="ui-out-box">
                            <div class="ui-input-box">
                                <input type="text" id="txtAccountNo" value="填写银行账号" defaultval="填写银行账号" class="ui-input w-150"
                                    onblur="if (this.value=='') this.value=this.defaultValue;" onfocus="if (this.value==this.defaultValue) this.value='';"
                                    style="height: 35px; line-height: 35px; width: 200px; color: #ccc;" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th align="right" valign="middle">
                        <div class="text-zd">
                            <span class="red">*</span>开户省市：</div>
                    </th>
                    <td>
                        <div class="ui-out-box">
                            <select class="ddlProvince" name="Province" id="province" style="height: 27px; width: 110px;" onchange="toggleProvince()">
								<option selected="selected" value="">请选择省</option>
							</select>
							<select class="ddlCity" name="City" id="city" style="height: 27px; width: 98px; display: none;">
							</select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <div class="calculator-btn">
                            <input type="button" id="btn_AddBankSubmit" onclick="addbank_per();" value=" 确 认 "
                                class="submit" style="width: 120px;" />
                            <input type="button" id="btn_VerifySucceed" value=" 验证成功 " open_win="addbink_2_result||ui-window-3||720||520"
                                style="width: 0px; display: none;" />
                        </div>
                    </td>
                </tr>
            </table>
            <div id="div_VerifyUserInfo" style="text-align: center; font-size: 16px; display: none;">
                <img src="${resource_dir}/images/loading.gif" align="absmiddle" />&nbsp;实名验证中......</div>
            <div id="div_VerifyUserFailed" style="text-align: center; font-size: 14px; display: none">
                <img src="${resource_dir}/images/icon_c.png" align="absmiddle" />&nbsp;实名验证失败，请重新提交</div>
        </div>
    </div>
</div>
<!-- 添加账户弹窗结束 -->

<!--添加帐户确认时弹窗-->
<div class="prompt_box" id="addbink_2_result">
    <div class="prompt_inner bank-add-box">
        <h3 class="title">
            新增帐户<a href="javascript:void()" class="close" close-ui="addbink_2_result"></a></h3>
        <div class="conent">
            <p class="title2">
                请在新开的页面绑定账户，完成后点击“已完成”</p>
            <p class="txt1">
                （如果验证失败，请点击 <span><a href="javascript:bindBank();" onclick="return !addNewBankCard()">
                    添加新银行卡</a></span>）</p>
            <p align="center" id="p_LogoBankChecking" class="txt6" style="display: none">
                <img align="absmiddle" src="${resource_dir}/images/loading.gif"></p>
            <p class="txt2" id="p_BankCheckOk" style="display: none">
                验证成功</p>
            <p class="txt3" id="p_BankCheckFailse" style="display: none">
                验证失败</p>
            <p class="txt4">
                <a href="#" class="a1" id="lnk_BindBankFinished" onclick="CheckBindBank()" accountno="">
                    已完成</a><a href="#" class="a2" id="lnk_BindBankCancel" onclick="CancelCheckBinkBank()">取消</a><a
                        href="#" class="a2" id="lnk_BindBankClose" onclick="CancelCheckBinkBank()" style="display: none">关闭</a></p>
            <p class="txt5">
                <a href="/HelpCenter/QuestionList10" target="_BLANK">绑卡遇到问题？</a></p>
        </div>
    </div>
</div>
<!--添加帐户确认时弹窗结束-->

</head>
	<body>
	<%@ include file="../header.jsp" %>
		<input id="identityC1" type="hidden" value="1"/>
		<input id="mobileP" type="hidden" value="1"/>
		<input id="em1" type="hidden" value="1"/>
		<input id="em2" type="hidden" value="1"/>
		<input id="em3" type="hidden" value="1"/>
		<input id="password1" type="hidden" value="1"/>
		<input id="idcode" type="hidden"/>
		<input id="mobilePhon" type="hidden"/>
		<input id="sendMobile1" type="hidden"/>
		<input id="sendMobile4" type="hidden"/>
		<input id="sendMobilePass" type="hidden"/>
		<input id="sendMobileNEW" type="hidden"/>
		
		<form name="submitForm" method="post" action="">
			<input id="hiddenData" name="hiddenData" type="hidden" />
		
		<input type="hidden" name="OrderNo" id="hidOrderNo" value="">
		<div class="warp">
			<div class="container">
				<div class="ui-content">
					<div class="breadcrumb">
						<a href="${ctx}/item/index">首&nbsp;页</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="${ctx}/item/gotoInvestmentList">我要投资</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="javascript:history.go(-1);">项目详情</a>&nbsp;
						<span>&gt;</span>&nbsp;确认投标金额
					</div>
					<div class="module">
						<div class="mod-wrap mod-bid-box">
							<h2 class="mod-object-title">
								<span>${itemInfo.itemName}</span>
								<input type="hidden" id="fkItemId" name="fkItemId"
									value="${itemInfo.id}" />
							</h2>
							<h2 class="mod-title">
								<span>确认投标金额</span>
							</h2>
							<div class="mod-content" >
								<table border="0" cellspacing="0" cellpadding="0"
									class="ui-table-4">
									<tbody>
										<tr>
											<th width="14%">
												预期收益：
											</th>
											<td width="86%">
												<p>
													<span class="ui-currency" name="yield" id="currentIncome">${order.yield}</span>元
													<input title="剩余可投份数" type="hidden" id="remain"/>
													<span title="投资期限" class="fz-60" id="currentDay" style="display:none;">${itemInfo.financePeriod}</span>
													<span title="收益率" class="fz-60 red" id="currentYint" style="display:none;">${itemInfo.investerYearRate}</span>
												</p>
											</td>
										</tr>
										<tr>
											<th>
												<p>
													投标金额：
												</p>
											</th>
											<td>
												<div class="fillIn-input">
													<input type="text" class="textFild" id="FinanCount"
													name="PartsCount"
													onblur="PartsCountChange($('#FinanCount'))" value="${order.totalMoney}">
													<a class="add" href="javascript:void(0)" onclick="add($('#FinanCount'))"> </a>
													<a class="del" href="javascript:void(0)" onclick="del($('#FinanCount'))"> </a>
													<span style="position: absolute; right: -20px; top: 6px;">元</span>
													<!-- txt_InvestAmount 份额转金额显示 -->
													<input id="currentAmount" type="text" onblur="PartsCountChange($('#FinanCount'))"
														class="textFild textFild-2" name="totalMoney"
														value="${order.totalMoney}">
												</div>
												<span
													style="float: left; line-height: 35px; margin-left: 40px;"
													class="red">(该项目您最多可投<span title="剩余可投金额" style="display:none;" id="surplus"><fmt:formatNumber value="${itemInfo.totalFinanceMoney-total}" pattern="#00"/></span><span title="剩余可投金额-显示"><fmt:formatNumber value="${itemInfo.totalFinanceMoney-total}" pattern="#,#00"/></span>元)</span>
											</td>

										</tr>
									</tbody>
								</table>
							</div>
							<h2 class="mod-title">
								<span>支付/回款账户</span>
								<div class="ui-tips">
									<img src="${resource_dir}/images/arrow_left_03.png">
									<i></i>请仔细核对，本账户是本次投资支付及未来投资本金及收益回款的账户&nbsp;
									<a href="${ctx }/help/helpCenter/questionlist7.htm" class="a-line"
										target="_BLANK">查看详情&gt;&gt;</a>
								</div>
							</h2>
							<div class="mod-content" style="position: relative; z-index: 6;">

								<table cellspacing="0" cellpadding="0" border="0"
									class="table_5">
									<tbody>
										<tr>
											<th width="8%" valign="top">
												<div style="margin-top: 16px; font-size: 16px;">
													账 &nbsp;&nbsp;户：
												</div>
											</th>
											<td width="92%" id="bankListTd">
											<div class="ui-bank settlementTypeSelect handCtl" id="selectBank1"
										style="height: 35px; width: 350px;" >
										<div class="txt" style="height: 35px;">
											<span title="选择银行" code="0000" class="" style="display:block;padding:5px;width:200px; float:left;">选择账户</span>
										</div>
										<ul class="txtList" id="bankListUl">
										<c:if test="${!empty bankList}" >
										<c:forEach var="ss" items="${bankList}">
															<li > <span title="${ss.cardBank}" code="100" class="bank-logo  
															<c:if test="${ss.cardBank=='308'}">bank-cmb</c:if>
				                                            <c:if test="${ss.cardBank=='306'}">bank-cgbchina</c:if>
				                                            <c:if test="${ss.cardBank=='309'}">bank-cib</c:if>
				                                            <c:if test="${ss.cardBank=='303'}">bank-cebbank</c:if>
				                                            <c:if test="${ss.cardBank=='105'}">bank-ccb</c:if>
				                                            <c:if test="${ss.cardBank=='104'}">bank-boc</c:if>
				                                            <c:if test="${ss.cardBank=='305'}">bank-cmbc</c:if>
				                                            <c:if test="${ss.cardBank=='103'}">bank-abc</c:if>
				                                            <c:if test="${ss.cardBank=='100'}">bank-psbc</c:if>
				                                            <c:if test="${ss.cardBank=='102'}">bank-icbc</c:if>
				                                            <c:if test="${ss.cardBank=='华润银行'}">bank-crbank</c:if>
				                                            <c:if test="${ss.cardBank=='307'}">bank-pingan</c:if>
				                                            <c:if test="${ss.cardBank=='302'}">bank-ecitic</c:if>
														" style="display:block;padding:15px;width:100px; float:left;"></span><span
																	class="bank-number">${ss.cardNumber}<b>|</b>
																	${ss.accountName}</span></li>
														</c:forEach>
												</c:if>
										</ul>
									</div>
												<div class="ui-link add-bank f-left" id="div_AddBink">
													<a href="javascript:bindBank();" class="blue" onclick="return !bindBankMax()"
														is-back="True" id="lnk_AddBink" open_win="addbink_2||ui-window-1||500||520">添加账户</a>
												</div>
												<div class="new-account clear" style="">
													<a href="javascript:void(0)" id="div_SinglePayLimit"
														class="red">单次支付限额：无限额</a>
												</div>
											</td>
										</tr>


									</tbody>
								</table>
								<div class="ui-form-item confirmation">
									<label class="ui-label f-left">
										<span class="ui-icon" id="mobilePhone3">手机号：</span>
									</label>
									<div class="ui-input-box f-left">
										<p>${phone}</p>
									</div>
									<div class="f-left" style="margin-left: 15px;">
										<a href="javascript:void(0)" onclick="mobilePHT();"
											class="a-line" target="_blank" is-back="True"
											style="font-size: 15px;"> 修改</a>
									</div>
							<DIV  class=personal-info-table 	style="DISPLAY: none" id="mobilePH">
								<TABLE class=ui-table-2 cellSpacing=0 cellPadding=0 border='0'>
									<TBODY>
										<TR>
											<TH vAlign=middle width="14%" align=right>
												<DIV id=div_MobileTitle class=text-zd>
													新手机号码：
												</DIV>
											</TH>
											<TD id=td_MobileOld width="86%">
												<input type="text" id="mobileInput" name="mobilePhone" onblur='CheckMobile();' />
												<div class="ui-tips" id="Hint_Mobile" style="width:300px;"></div>
											</TD>
										</TR>
										<TR>
											<TH vAlign=middle width="14%" align=right>
												<DIV class=text-zd>
													手机验证码：
												</DIV>
											</TH>
											<TD width="86%">
												<DIV class=ui-out-box>
													<DIV class=ui-input-box>
														<INPUT id=txt_CheckCode_Mobile class=ui-input
															style="WIDTH: 120px; COLOR: #ccc" defaultval="" onblur="likai();"/>
															
														<INPUT onclick="sendMobileCheckCode_Mobile('007')"
															id=btnSendMobileCode_Mobile class=button-yzm type=button
															value=获取验证码 />
														<INPUT id=btnTime_Mobile class=button-disabled
															style="DISPLAY: none" type=button value=60秒后重新获取 />
														<span id="newPhone"></span>
														<input type="text" id="newPhone1" style="DISPLAY: none"/>
													</DIV>
												</DIV>
											</TD>
										</TR>
										<TR>
											<TH vAlign=middle align=right>
												&nbsp;
											</TH>
											<TD>
												<DIV class=ui-out-box>
													<DIV class=ui-input-box>
														<INPUT onclick="UpdateMobile('007');" id=btn_MobileNext
															class="" type=button value=下一步 />
													</DIV>
												</DIV>
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</DIV>
							<DIV id=div_SuccInfoModifyMobile class=text-success
								style="DISPLAY: none" tick="0">
								<IMG
									src="${resource_dir}/images/reg_20.png" />
								&nbsp;&nbsp;恭喜您，手机号码修改成功！&nbsp;
							</DIV>
									<div class="ui-tips f-left">
										（此号码用于接收您的投资提醒短信）
									</div>
								</div>
								<div class="clear">
								</div>
							</div>
						</div>
						<div class="mod-bottom">
							<div class="info-agm">
								<p>
									<b> <input type="checkbox" onclick="verfythisBox(this)" class="ui-checkbox" name="agree" id="chk_AgreeProtocol" seed="JIndexForm-JAgree"
											smartracker="on"> </b>我已阅读
									<a href="javascript:void(0)"
										action-data="win_InvestorsServiceAgreement||ui-window-1||740||410||absolute"
										class="a-line openWindow">《资产交易平台投资人服务协议》</a>
									<span id="spn_OpenDirect">、<a
										href="javascript:void(0)"
										action-data="win_HuarunDirectBankServiceAgreement||ui-window-1||740||410||absolute"
										class="a-line openWindow">《珠海华润银行直销银行服务协议》</a>并同意开通珠海华润银行直销银行电子账户
									</span>
								</p>
								<p id="xieYiMsg" style="color:red;display:none;"></p>
							</div>
							<div class="submit-btn">
								<input type="button" is-back="True" id="accept"
									value="确认无误，提交" onclick="confirmCommit();"
									financingid="" class="ui-button-text ui-button-2">
							</div>
							<div class="other-info">
								<p>
									<span class="red">*</span> 免责声明：预期投资收益仅供参考，具体以实际发生收益为准。
								</p>
								<p>
									<span class="red">*</span> 温馨提示：建议选择使用IE或者带IE内核的浏览器进行投资支付。
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
		
		<!--《华润银行资产交易平台投资人服务协议》-->
<div class="prompt_box" id="win_InvestorsServiceAgreement" style="top: 150px;">
    A
    <div class="prompt_inner ck_2" style="width: 740px; left: -370px; height: 400px;">
        <h3 class="title">
            <span class="ico_3">《资产交易平台投资人服务协议》</span> <a href="javascript:void()" class="close">
            </a>
        </h3>
        <div class="content smBook" style="height: 300px; overflow-y: auto; overflow-x: hidden">
            <div class="fwxy">
                
                <p style="text-indent: 30px;">
                    本投资人服务协议（下称“本协议”）签约双方为资产交易平台运营商（下称“平台”）与平台用户，本服务协议经用户勾选后，即成立并生效。<strong>本协议条款已对与用户的权益有或可能具有重大关系的内容，及对平台具有或可能具有免责或限制责任的条款用粗体字予以标注，请用户注意。</strong>
                </p>
                <p style="text-indent: 30px;">
                    用户投资前必须勾选同意本协议，受以下条款的约束。用户依本协议进行投资且支付成功时，将为用户开通华润银行直销银行，直销银行具体权利义务由《华润直销银行服务协议》所确定，相关责权由珠海华润银行股份有限公司与用户所承担，与本协议中的运营商无关。
                    本协议内容包括以下条款及已经发布的或将来可能发布的各类规则。所有规则为协议不可分割的一部分，与协议正文具有同等法律效力。本协议与《资产交易平台注册服务协议》及上述各类规则构成用户与平台运营商之间的全部权利义务法律关系。
                </p>
                <span>一、定义及解释 </span>
                <br />
                <p>
                    （一）投资人：符合《资产交易平台注册服务协议》及其他规则要求，具备完全民事行为能力，能够根据自身交易目标、交易期限、风险承受能力和资产状况等，在平台上对平台或融资人发布的资产管理或融资项目等，以其具有合法处分权的资金进行投资，获得投资收益，自行承担投资风险的用户，并受本协议所约束的自然人或企业用户。</p>
                <p>
                    （二）融资人：符合珠海华润银行股份有限公司企业网银开立条件及平台注册协议要求，经见证方见证，通过平台发布借款融资项目需求的用户，并受《资产交易平台融资人服务协议》规定约束的企业法人或其他组织。
                </p>
                <p>
                    （三）第三方支付机构：依据《非金融机构支付服务管理办法》，获得人民银行颁发《支付业务许可证》的第三方支付公司，负责对投资人和融资人在本平台上的权益转让过程实现资金保管、划拨、还款等资金交易行为。本协议项下所指定第三方支付机构依照投融资项目的项目说明书确定。</p>
                <p>
                    （四）投融资：本协议项下的融资，是指融资人通过平台，将其合法持有的财产权益转让予投资人，并在约定期限届满后向投资人溢价回购上述权益或以其他形式依约向投资人支付相应投资回报的行为，财产权益包括且不限于应收账款收益权、票据收益权等。
                </p>
                <p>
                    （五）投融资服务：由平台向投资人及融资人提供的服务，具体服务内容主要包括：融资信息发布、交易撮合、由平台指定的第三方支付机构进行交易资金划付等。</p>
                <span>二、交易规则 </span>
                <br />
                <p>
                    （一）概述</p>
                <p>
                    投资人通过浏览平台展示的融资项目信息，通过平台的投融资服务功能，向投资人自己认可的融资项目投资。投融资双方通过平台指定的第三方支付机构进行资金交易行为，如融资人获取投资人的投资款以及向投资人进行还款等。<strong>自投资款发放至融资人指定的银行账户之日起，视同投资人和融资人正式确立权益转让合同关系，平台将上述相关事宜通过平台站内信、电子邮件或短信等方式告知双方。</strong></p>
                <p>
                    （二）投资人确认：</p>
                <p style="font-weight: bold">
                    1.遵守本协议及相关法律法规，不得利用本平台进行信用卡套现、洗钱或其他不正当交易行为，否则应依法独立承担法律责任。<br />
                    2. 如融资人以其持有的票据或其他到期兑付凭证质押担保本协议项下还款的，投资人同意接受上述权利质押，并不可撤销地委托见证机构以见证机构自己名义代为签署相关质押合同、对上述凭证进行到期托收及代为行使质权等。
                    <br />
                    3. 如融资人以其基础合同（即融资人与第三方之间产生包括但不限于应收账款等权益之交易法律文件）项下资产权益，作为其履行本协议项下还款义务保障的，投资人同意一旦发生可能导致本协议项下收益权无法实现的基础合同违约情形或融资人违反本协议约定、怠于行使基础合同相关权利等情况下，无条件且不可撤销地委托见证机构代为接受该项资产权益并在条件成就情况下成为该项资产权益的权利人或委托见证机构代为行使代位权。
                </p>
                <p>
                    （三）项目信息</p>
                <p>
                    投资人可在平台，根据融资人提供的年化利率、还款方式等项目信息自主进行投资。项目信息包括但不限于以下内容。
                </p>
                <p>
                    a. 融资金额：指融资人所发布项目所需的融资上限金额。
                    <br />
                    b. 投资金额：指本次交易，由投资人成功支付并与融资人达成有效交易的本金金额。
                    <br />
                    c. 预期年化收益率/年化利率：指本次交易，由融资人发布的回购利率或投资回报率，以预期年化收益率/年化利率表示。（月利率=年化利率/12，日利率=年化利率/360
                    ）<br />
                    d. 还款方式：指融资人还款的方式，包括不仅限于"一次性到期还本付息"或"每月等额还款"等方式，投资人将按照融资人的还款方式获得收益。具体还款方式依照项目说明书约定方式确定。<br />
                    e. 最小投资单位：指本次交易，投资人最低出资限额，投资人可按照该限额的整数倍增加投资金额。
                    <br />
                    f. 起息日/放款日：指本次交易，所需融资款项通过第三方支付机构发放至融资人银行账户之日。起息日/放款日为银行在中国大陆的对公业务工作日。
                    <br />
                    g. 融资期限：指自起息日起至到期日止的期间。
                    <br />
                    h. 投资期间：投资人投资的起止时间。<br />
                    i. 还款日：还款日是指融资人在融资需求中列明的根据约定的还款方式所确定的还款日期，为融资人支付利息或/和本金的日期；如当月无该日期，则以当月的最后一日为还款日。融资的到期日为最后一期的还款日。还款日为银行在中国大陆的公司业务工作日<br />
                    j. 到期日：指本次交易，融资项目的融资期限届满之日，即全部或最后一期融资款项本金和利息的还款日。<br />
                </p>
                <p>
                    （四）支付</p>
                <p>
                    1. 投资人同意并认可使用平台指定的第三方支付机构提供的交易资金管理服务。第三方支付机构将根据投资人授权平台发送的交易指令进行资金支付、接收、保管、退款、发放、代扣平台服务费、划转投资本息等服务，并为资金在所有过程中的安全性提供保障。</p>
                <p>
                    2. 投资人同意并确认投资本协议项下融资项目的，应将投资资金支付给指定第三方支付机构。在第三方支付机构将上述投资资金划转至融资人银行账户前，投资人所支付投资资金由指定第三方支付机构保管并保证其安全。
                    投资人确认，其投资的资金在项目起息日之前，不产生利息等投资收益。</p>
                <p>
                    3. 投资人了解并同意：投资结束后，如所有投资人投资金额之和等于融资金额，第三方支付机构将按照平台指令，将投资人的投资资金支付至融资人所指定的银行账户；如所有投资人投资金额之和小于融资金额, 则由融资人对实际融资金额进行书面确认，确认后项目成立; 否则项目不成立，投资金额将无息返还投资人。自上述投资金额发放至融资人指定的银行账户之日起，投资人和融资人正式确立权益转让合同关系。</p>
                <p style="font-weight: bold">
                    4.投融资双方的权益转让合同关系中权利义务的约定，由平台服务协议、本协议条款、融资人服务协议以及双方在平台的实际交易行为等予以规定，投资人明确知悉并予以确认。</p>
                <p>
                    5.投资结束后，如产生超募（即项目实际募集资金大于融资金额），平台将根据投资人的投资时间顺序将顺序在后的投资资金/部分投资资金通过第三方支付机构对超募资金进行退款处理。超募资金将被退至投资人在投资时指定的银行账户。投资人同意并接受超募资金不产生任何形式的孳息。</p>
                <p>
                    （五）本息回收</p>
                <p>
                    1. 投资人在成功支付后，可通过平台查看投资及投资回报等详细情况。<br />
                    2. 投资人有权在项目融资成功后（起息日起），根据自己的投资金额，按与融资人所发布的融资信息中约定的利率、还款方式等进行投资资金本金回收，并获得相应的投资收益。<br />
                    3. 在融资项目投资人为多方的情况下，投资人按照各自投资金额占实际融资金额的比例从融资人支付的还款资金中分配投资本金和利息、逾期利息等。
                    <br />
                    4. 在还款日当天或还款日的下一个工作日，投资人收到融资人足额支付的融资本金和/或利息的，视为融资人正常还款。为避免歧义，投资人在还款日的下一个工作日足额收到投资本金和/或利息的，不视为发生融资人逾期还款/投资人回收逾期，融资利息仍按照本条款约定的融资期限计算。
                    <br />
                    5. 投资人投资所取得的收入，应当由投资人按照所适用法律法规自行缴纳相应的税费。<br />
                </p>
                <span>三、账户及交易安全 </span>
                <br />
                <p>
                    （一） 账户安全
                </p>
                <p>
                    投资人同意：</p>
                <p>
                    <strong>1.投资人确认，只有投资人本人可以使用投资人的平台账户。所有使用投资人账号及密码登陆平台后的操作行为，均视为投资人本人的操作。</strong>在投资人决定不再使用该账户时，投资人应向平台申请注销该账户。
                </p>
                <p>
                    2.投资人同意平台在履行法律法规规定的客户身份识别等义务时，有权核对投资人的有效身份证件或其他必要文件，并留存有效身份证件的复印件或者影印件，投资人应积极配合，否则平台有权限制或停止向投资人提供平台服务。</p>
                <p style="font-weight: bold">
                    3.投资人同意，如投资人发现有他人冒用或盗用投资人的平台登录名及密码或任何其他未经合法授权之情形，或发生与平台账户关联的手机或其他设备遗失或其他可能危及到平台账户资金安全情形时，应立即以有效方式通知平台，向平台申请暂停相关服务。平台不能也不会对因投资人未能遵守本款约定而发生的任何损失、损毁及其他不利后果负责。投资人理解平台对投资人的请求采取行动需要合理期限，在此之前，平台对已执行的指令及(或)所导致的投资人的损失不承担任何责任。
                </p>
                <p style="font-weight: bold">
                    4.交易异常处理：投资人使用本服务时同意并认可，可能由于银行系统问题、银行相关作业网络连线问题或其他不可抗拒因素，造成本服务无法提供。投资人确保投资人所输入的投资人的资料无误，如果因资料错误造成平台于上述异常状况发生时，无法及时通知投资人相关交易后续处理方式的，平台不承担任何损害赔偿责任。</p>
                <p>
                    5.投资人同意，基于运行和交易安全的需要，平台可以暂时停止提供或者限制本服务部分功能,或提供新的功能，在任何功能减少、增加或者变化时，只要投资人仍然使用本服务，表示投资人仍然同意本条款或者变更后的协议。</p>
                <p>
                    6.平台有权了解投资人使用平台产品或服务的真实交易背景及目的，投资人应如实提供平台所需的真实、全面、准确的信息；如果平台有合理理由怀疑投资人提供虚假交易信息或从事违法犯罪活动的，平台有权暂时或永久限制投资人所使用的产品或服务的部分或全部功能，并通过邮件或者短信等方式通知投资人，投资人应及时予以关注。</p>
                <span>四、项目见证机构及运营服务提供商 </span>
                <br />
                <p>
                    （一）珠海华润银行股份有限公司作为为平台上有关融资项目的见证机构，为融资人提供资信见证服务（包括但不限于各类基本资料见证、财务见证、银行账户信息见证等），并向投资人全部或部分披露上述见证信息。见证机构采取各种其认为必要手段对平台会员的身份进行识别，但是基于目前信用认证手段有限，见证机构及平台运营商对融资人身份的准确性和绝对真实性不做任何保证。</p>
                <p>
                    （二）广东优迈信息通信股份有限公司作为平台的运营商，基于本条款有权代表平台从事对外签署协议等相关民事行为，享有平台在本条款项下的权利并履行平台在本条款项下的义务。</p>
                <span>五、风险承担及免责 </span>
                <br />
                <p style="font-weight: bold">
                    （一）在使用本服务时，若投资人或融资人未遵从本协议或网站说明、交易页面中之操作提示、规则），则平台有权拒绝为投资人与交易对方提供相关服务，且平台不承担违约责任。<br />
                    （二）因投资人的过错导致的任何损失由投资人自行承担，该过错包括但不限于：不按照交易提示操作，未及时进行交易操作，遗忘或泄漏密码、校验码等，密码被他人破解，投资人使用的计算机或其他硬件、终端等被他人侵入或丢失，或投资人使用的软件被他人侵入等。
                    <br />
                    （三）平台投资人信息是由投资人本人自行提供的，平台无法保证该信息之准确、及时和完整，投资人应对自身的判断承担全部责任。<br />
                    （四）平台不对交易标的及本服务提供任何形式的保证，包括但不限于以下事项：
                    <br />
                    a.投资标的符合投资人的最终需求，且投资本金及收益将依约收回。
                    <br />
                    b.平台服务不受干扰、及时提供或免于出错。
                    <br />
                    c.投资人经由本平台投资或取得之任何服务、资讯或其他资料符合投资人的期望。
                    <br />
                    （五）投资人经由平台使用下载或取得任何资料，应由投资人自行考量且自负风险，因资料之下载而导致投资人电脑系统之任何损坏或资料流失，投资人应负完全责任。<br />
                    （六）投资人自平台及平台工作人员取得之建议和资讯，无论其为书面或口头形式，均不构成平台对本服务之保证。
                    <br />
                    （七）除本条款另有规定或平台另行同意外，投资人对平台的委托及向平台发出的指令均不可撤销。<br />
                    （八）投资人存在损害平台或其他用户利益的行为时，平台有权单方面终止并解除本协议，并不对用户进行任何补偿或赔偿。如平台因此遭受损失，用户应负赔偿责任。<br />
                </p>
                <span>六、服务费用 </span>
                <br />
                <p>
                    本版本条款生效期间，平台不向投资人收取服务费，但平台保留在本条款未来的修改版中增加收费项目的权利，投资人在条款修改版公布后继续使用平台服务的，视为无条件认可条款修改版的全部内容。
                </p>
                <span>七、计算及证据 </span>
                <br />
                <p>
                    （一）投资人确认并同意，委托平台对本条款项下的交易资金本息等任何金额进行计算并清分；平台对本条款项下任何金额的证明或确定，应作为该金额有关事项的终局证明。<br />
                    （二）本条款经投资人通过平台以网络在线点击确认的方式与平台运营商订立。投资人委托平台保管所有与本条款有关的书面文件或电子信息；并确认并同意由平台提供的与本条款有关的书面文件或电子信息应作为本条款有关事项的终局证明。
                </p>
                <span>八、终止 </span>
                <br />
                <p>
                    除非平台终止本协议或者用户申请终止本协议且经平台同意，否则本协议始终有效。平台有权在不通知用户的情况下在任何时间终止本协议或者限制用户使用平台。平台终止或限制用户使用平台的，除相关国家机关有明确指令或裁决外，不影响用户依照已经发生的权益转让行为及相关协议获得相应资金。</p>
                <span>九、法律适用与管辖 </span>
                <br />
                <p>
                    本条款之效力、解释、变更、执行与争议解决均适用中华人民共和国法律，没有相关法律规定的，参照通用国际商业惯例和（或）行业惯例。因本条款产生之争议，均应依照中华人民共和国法律予以处理，并由广州市天河区人民法院管辖。</p>
                <span>十、附加条款 </span>
                <br />
                <p>
                    在平台的某些部分或页面中可能存在除本协议以外的单独的附加服务条款，当这些条款存在冲突时，在该部分和页面中附加条款优先适用。</p>
                <span>十一、条款的独立性 </span>
                <br />
                <p>
                    若本协议的部分条款被认定为无效或者无法实施时，本协议中的其他条款仍然有效。</p>
                <span>十二、投诉与建议 </span>
                <br />
                <p>
                    用户对平台有任何投诉和建议，请将投诉和建议请反馈给平台客服热线或邮箱。</p>
            </div>
        </div>
    </div>
</div>
<!--《珠海华润银行直销银行协议》-->
<div class="prompt_box" id="win_HuarunDirectBankServiceAgreement" style="top: 150px;">
    <div class="prompt_inner ck_2" style="width: 740px; left: -370px; height: 400px;">
        <h3 class="title">
            <span class="ico_3">《珠海华润银行直销银行服务协议》</span> <a href="javascript:void()" class="close">
            </a>
        </h3>
        <div class="content smBook" style="height: 300px; overflow-y: auto; overflow-x: hidden">
            <div class="fwxy">
                
                <p>
                    甲方：用户（简称“用户”或“您”）</p>
                <p>
                    乙方：珠海华润银行股份有限公司（简称“我行”或“华润银行”）</p>
                <p>
                    用户与我行就用户使用我行直销银行服务有关事项自愿订立珠海华润银行直销银行服务协议（简称“本协议”），本协议为双方具有法律效力的有效合同。用户通过我行直销银行门户（含电脑Web端、手机微信端及手机App端）页面点击确认接受本协议，即表示用户与我行已达成一致协议并同意接受本协议的全部内容。<br />
                    提示：在接受本协议之前，请您仔细阅读本协议的全部内容（包含以下直销银行用户注册、直销银行账户、直销银行智能存款以及其它约定所列内容），如果您不同意本协议的全部内容，或者无法准确理解本协议条款的含义，请不要进行后续操作。<br />
                    声明：本协议内容包括协议正文及所有我行已经发布的或将来可能发布（或修改）的有关直销银行的各类规则。所有规则为本协议不可分割的组成部分，与协议正文具有同等法律效力。除我行另行明确声明外，任何与我行直销银行有关的服务、交易及非交易活动均受本协议约束。
                </p>
                <p>
                    <strong>第一条 定义</strong></p>
                <p>
                    <strong>1.1 注册用户</strong> 指注册我行直销银行用户并使用我行直销银行服务（简称“本服务”）的客户。符合条件的申请人在我行直销银行门户上，提供本人手机号码并完成用户注册步骤、经我行核准后成为我行直销银行注册用户。<br />
                    <strong>1.2 直销银行</strong> 指我行为国内客户（不含港澳台）提供的、可自助申请开立银行结算账户、进行资金划转支付的互联网金融服务平台，包含但不限于直销银行门户、直销银行微信端、直销银行手机APP端及直销银行后台管理系统。我行直销银行门户服务网址为：http://www.icrbank.com。<br />
                    <strong>1.3 直销银行账户</strong> 指用户基于我行直销银行门户自助申请，经过我行通过人行联网核查及银行账户同名验证后开立的华润银行电子账户。直销银行账户部分功能须经实名认证审核（上传身份证明材料至我行并得到我行核实）通过后方可开通（以系统提供功能为准）。直销银行账户下设活期账户及智能存款账户，均作为电子账户使用，不出具任何纸质凭证或证明。<br />
                    <strong>1.4 智能存款</strong> 指用户存入直销银行账户下智能存款账户的存款，用户存入时不事先确定存期和利率，系统日终检查当日存取款差额，仅当差额为支取时，系统对支取差额的实际存期自动套档为活期、通知或定期存款的某一组合，按组合中的存款类型以相应档次利率计算利息，利息记入用户活期账户。用户可随时支取智能存款。<br />
                    <strong>1.5 留存金额</strong> 用户开立并激活直销银行账户时，系统自动设置在智能存款转存后用户活期账户留存金额为零元，当用户活期账户余额不足时，系统自动为用户支取智能存款。<br />
                    <strong>1.6 起存金额</strong> 用户开立并激活直销银行账户时，系统自动设定在系统日终批处理时、当用户活期账户余额达伍佰元(含)时全部转存为智能存款。
                </p>
                <p align="center">
                    <strong>直销银行用户注册</strong></p>
                <p>
                    <strong>第二条 注册条件</strong></p>
                <p>
                    <strong>2.1</strong>在办理我行直销银行用户注册程序时，用户应当是具备完全民事权利能力和完全民事行为能力的自然人、法人或其他组织，并符合我行规定的其他用户注册条件。</p>
                <p>
                    <strong>第三条 注册须知</strong></p>
                <p>
                    <strong>3.1</strong> 用户在申请注册直销银行用户时应由本人自行输入注册信息和设置直销银行登录密码，用户有义务在注册用户时提供完整的信息及相关注册资料，保证该信息及资料内容的完整性、真实性、有效性和合法性，并同意我行通过必要方式对其身份和资质进行审核。用户的信息及相关资料发生变更时，用户有义务及时在我行直销银行门户进行更新。<br />
                    <strong>3.2 </strong>因用户的信息或其他注册资料不完整、不真实、不准确、失效或违法而导致我行无法提供本服务或提供本服务时发生错误，用户不得将此作为取消交易、拒绝付款的理由，由此产生的全部法律后果由用户承担，因此给我行或其他第三方造成损失的，用户应予以赔偿。<br />
                    <strong>3.3</strong> 用户设置的手机号码应为本人实名登记号码，不得侵犯或涉嫌侵犯他人合法权益。如用户超过一定时限（时限另行发布）未登录使用我行直销银行，我行有权终止向用户提供本服务。</p>
                <p>
                    <strong>第四条 用户使用</strong></p>
                <p>
                    <strong>4.1</strong> 用户通过我行直销银行门户成为注册用户后，有权使用已注册的手机号登录直销银行。用户应妥善保管自己的手机号码及密码，避免以不安全的方式或在不安全的环境下使用登录信息，切勿将密码以任何形式透露给任何他人，或以易被他人发现、获得、盗用的方式保管。用户应对使用其登录信息而从事的一切交易或非交易行为承担法律责任。<br />
                    <strong>4.2</strong> 用户不得以任何形式转让、出租或授权他人使用自己的登录信息，用户违反该规定而引起的一切后果均由用户自行承担责任，因此给我行或第三方造成损失的，用户应予以赔偿。<br />
                    <strong>4.3</strong> 用户的登录信息遭到未经授权的使用或发生其他任何安全问题，用户应立即通知我行。<br />
                    <br />
                    <strong>4.4</strong> 用户办理我行直销银行业务应直接登录我行直销银行门户所在网站办理，而不应通过未经我行认可的邮件或其他网站提供的链接登录。<br />
                    <br />
                    <strong>4.5</strong> 我行有权对用户的注册资料进行查阅，发现注册资料违反本协议约定的，均有权向用户发出询问的通知，并有权根据具体情况要求用户改正或依据本协议规定采取相应措施。我行有权自主排列用户信息在页面的展示位置。
                </p>
                <p>
                    <strong>第五条 用户信息</strong></p>
                <p>
                    <strong>5.1</strong> 为方便用户使用我行直销银行服务及我行关联公司或其他组织的服务，用户同意并授权我行将用户在注册或使用本服务过程中提供的或形成的信息传递给我行关联公司或其他组织使用。
                </p>
                <p>
                    <strong>第六条 服务终止</strong></p>
                <p>
                    <strong>6.1</strong> 经我行审核认为用户违反我国法律、监管规定、我行规定或本协议约定的，我行有权终止对用户提供本服务。</p>
                <p align="center">
                    <strong>直销银行账户</strong></p>
                <p>
                    <strong>第七条 开户须知</strong></p>
                <p>
                    <strong>7.1</strong> 用户需持有有效的国内第二代居民身份证、自愿申请开立我行直销银行账户，同意遵守国家有关金融法律法规、政策及我行的有关业务规章制度。<br />
                    <strong>7.2</strong> 用户保证向我行提供的开户证件符合《个人存款账户实名制规定》要求，开户时填写的开户资料正确、真实、合法、有效。直销银行账户的开户必须由用户本人办理，不得由他人代办。<br />
                    <strong>7.3 </strong>用户同意我行将直销银行账户中的活期账户设置为银行结算账户。用户保证其对直销银行账户的使用遵守《人民币银行结算账户管理办法》及监管机构对银行账户管理的有关规定。<br />
                    <strong>7.4</strong> 用户申请开立直销银行账户后，享有通过直销银行门户办理我行直销银行所有业务的权利（以系统提供功能为准）。用户同意，开通直销银行账户的相关服务功能，除非我行规定该项服务功能需要用户经过实名认证审核或需本人亲自到银行柜台办理相关确认手续后方能开通外，用户已开立的直销银行账户均自动开通该项服务功能。<br />
                    <strong>7.5</strong> 用户在申请开立直销银行账户时所设定的绑定账户和手机号码，必须是用户本人实名合法获得，并处于用户有效掌控下。因用户遗失绑定手机，或将绑定账户、绑定手机转借、转租他人使用，或泄露资料及交易信息等行为所产生的损失，由用户自行承担。<br />
                    <strong>7.6</strong> 用户申请开立直销银行账户时设置交易密码，用户在办理资金转出或支付业务时使用交易密码。凡使用密码进行的交易均视为用户本人所为。用户应妥善保管直销银行账户登录信息，不得将账户转借、转租他人使用。因用户将账户转借、转租他人使用或泄露资料所产生的风险及全部损失由用户自行承担。<br />
                    <strong>7.7</strong> 用户在开户时默认同意开通我行短信“银信通”业务（暂免收短信费，收费时另行公告），在用户开户或办理其他业务的过程中，我行将向用户预留手机号码发送授权码及各种交易短信（交易短信仅为提示目的，非交易凭证），必要时将会主动致电核实用户身份，以确保用户资金安全。用户仅能开立一个直销银行账户及预留一个手机号码（以系统提供功能为准）。<br />
                    <strong>7.8</strong> 我行仅通过移动号码106575580796588、106575585796588、联通号码106550206588、106550200292及电信号码1065902003693、1065902003588向用户发送短信通知，仅通过http://www.icrbank.com及微信号icrbank向用户提供我行直销银行服务；仅通过我行直销银行手机端上传功能，接收用户身份证等相关身份识别信息图片。因用户相信虚假、欺诈电话短信或在虚假、欺诈网站使用其直销银行账户或向虚假、欺诈电话、邮箱、传真发送个人信息，所造成的全部损失将由用户自负。
                </p>
                <p>
                    <strong>第八条 账户开户</strong></p>
                <p>
                    <strong>8.1</strong> 当用户完成身份证号码、绑定手机号码及绑定账户等注册开户必须的信息录入和验证、并设置账户交易密码后，用户即完成直销银行账户开户并获得直销银行账户号。用户可以身份证号码、手机号码或直销银行账户号登录我行直销银行。我行直销银行账户开户网点默认为我行总行营业部。<br />
                </p>
                <p>
                    <strong>第九条 账户激活</strong></p>
                <p>
                    <strong>9.1 </strong>直销银行账户开立后需要激活方可正常使用。当用户选择绑定我行账户进行直销银行账户激活时，用户只需提供本人华润银行账号及交易密码，验证通过后直销银行账户自动激活；当用户选择绑定本人他行账户（仅限具银联标识的银行卡）进行直销银行账户激活时，用户需以本人他行账户向其直销银行账户转入一笔任意金额款项，当用户再次登录直销银行门户时，系统查询到该笔款项到帐后自动激活直销银行账户，并以本人他行账户作为直销银行的绑定账户。</p>
                <p>
                    <strong>第十条 账户使用</strong></p>
                <p>
                    <strong>10.1</strong> 用户可通过直销银行账户实现投资理财、资金转入等操作；用户除了与我行签署相关代扣代缴协议可以向指定账户支付资金外，可以且只能通过本人绑定的同名银行账户实现资金转出操作。直销银行账户不配发实体卡片、不支持需刷卡的交易渠道。<br />
                    <strong>10.2</strong> 用户需在直销银行账户开户激活后，及时上传个人身份证明材料进行账户实名认证。直销银行账户只有在用户实名认证审核通过后方可办理资金转出。我行将及时审核用户上传的个人身份证明材料，审核结果最晚不超过5个工作日反馈。
                </p>
                <p>
                    <strong>第十一条 账户密码</strong></p>
                <p>
                    <strong>11.1 </strong>用户可直接登录直销银行门户修改账户登录密码或交易密码；若用户遗忘账户交易密码，用户需先登录直销银行门户提交交易密码重置申请，然后由用户使用绑定手机号码致电我行客服中心，我行客服中心人员查验用户交易密码重置申请记录并核实用户身份信息后，用户可按语音提示录入新的交易密码。</p>
                <p>
                    <strong>第十二条 绑定账户变更</strong></p>
                <p>
                    <strong>12.1 </strong>用户需要变更绑定账户时，需通过需变更的本人银行账户向其直销银行账户转入一笔任意金额，转入成功后用户登录直销银行查看可变更的银行账户记录，若需变更的本人账户为可选项，即可确认为绑定账户。绑定账户解除绑定后，可直接再绑定。直销银行账户暂定最多可绑定三个银行账户（以系统提供功能为准）。<br />
                </p>
                <p>
                    <strong>第十三条 账户自助冻结、解冻</strong></p>
                <p>
                    <strong>13.1</strong> 用户可登录直销银行自助冻结（止付）直销银行账户。当账户需要解除冻结（解付）时，需由用户使用绑定手机号码致电我行客户中心进行申请，身份核验通过后，由客户中心人员进行账户解冻。
                </p>
                <p>
                    <strong>第十四条 账户修改</strong></p>
                <p>
                    <strong>14.1</strong> 用户直销银行账户一旦激活成功后，不可在直销银行门户修改身份证号和姓名等账户关键信息，但可修改其他信息（以系统提供功能为准）。
                </p>
                <p>
                    <strong>第十五条 账户销户</strong></p>
                <p>
                    <strong>15.1</strong> 用户暂不可登录直销银行办理账户销户（以系统提供功能为准），可致电我行客服中心（0756-96588或400-880-0338）申请销户。账户销户后，直销银行账户本息金额将自动转回至绑定账户（用户在账户销户前需确保绑定账户仍为有效账户）。待销户账户必须为激活状态的账户。<br />
                    <strong>15.2</strong> 用户开立我行直销银行账户后应及时激活账户，若用户开户后超过一个月时间尚未激活账户且账户没有发生过任何交易，系统将自动清理用户账户，用户可在账户销户日隔日重新办理开户。<br />
                    <strong>15.3 </strong>经我行审核认为用户违反我国法律、监管规定、我行规定或本协议约定的，我行保留对用户账户进行即时关闭处理的权利，将用户账户状态改为未激活、未实名认证或销户状态。<br />
                </p>
                <p align="center">
                    <strong>直销银行智能存款</strong></p>
                <p>
                    <strong>第十六条 存款账户</strong></p>
                <p>
                    16.1 用户直销银行账户开立并激活时，系统自动为用户在直销银行账户下开立活期账户和智能存款账户，活期账户将作为用户存取款资金结算账户，智能存款账户记录智能存款余额。
                </p>
                <p>
                    <strong>第十七条 存款规则</strong></p>
                <p>
                    <strong>17.1</strong> 自动转存 我行直销银行系统日终批处理时，活期账户余额达伍佰元时自动触发转存智能存款交易，用户活期账户资金全部转入智能存款账户中。<br />
                    <strong>17.2</strong> 存期套档 系统日终批处理时自动对用户存款账户当日发生额进行轧差，当支出大于活期余额加当日存入金额时，系统自动扣减智能存款余额，并按扣减存款金额的实际存期套档计算利息。套档规则如下：<br />
                    1) 金额小于伍万元时，套档为5年、3年、2年、1年、6个月、3个月或活期存款组合；<br />
                    2) 金额大于伍万元（含）时，存期套档为5年、3年、2年、1年、6个月、3个月、7天通知、1天通知或活期存款组合。<br />
                    17.3 利息计算 当日扣减的智能存款将按套档组合结果以相应档次的存款利率计算利息，并在系统完成日终处理时支付至用户活期账户。计息规则如下：<br />
                    1) 套档为定期类型的扣减存款按智能存款转存日我行挂牌公告定期存款利率计息；<br />
                    2) 套档为通知存款类型的扣减存款按支取日我行挂牌公告通知存款利率计息；<br />
                    3) 套档为活期类型的扣减存款按支取日我行挂牌公告活期存款利率计息；<br />
                    4) 套档为通知存款的扣减存款，系统默认用户已提前通知我行并如期支取；<br />
                    5) 用户活期账户中的存款在法定结息日结息；<br />
                    6) 扣减存款存期套档时，各档次遇央行或我行利率调整不分段计息。<br />
                    <strong>17.4</strong> 资金使用 用户活期账户进行资金转出、投资理财支付交易时，金额不大于活期账户可用余额的，则直接进行资金划转或支付；若交易金额大于活期账户余额，系统自动支取智能存款，支取金额自动划转活期账户供交易使用。<br />
                    <strong>17.5</strong> 存款补足 如用户在当日我行进行日终处理前将资金存入活期账户，并得以补足当日支取的款项总额，我行将视同用户当日未动用智能存款账户资金。<br />
                    <strong>17.6 </strong>账户余额 智能存款账户可一次或多次部分支取，部分支取后剩余金额不足50元时将自动结清转至活期账户。<br />
                </p>
                <p>
                    <strong>第十八条 交易确认</strong></p>
                <p>
                    <strong>18.1</strong> 用户在我行直销银行门户开立并激活直销银行账户时，我行认为用户已接受其活期存款在满足智能存款转存条件时自动转存为智能存款的约定，并同意用户的存取款操作记录及支取金额利息计算以我行直销银行系统数据记录为准。<br />
                </p>
                <p>
                    <strong>第十九条 税费计缴</strong></p>
                <p>
                    <strong>19.1</strong> 用户和我行应各自承担其在本协议项下应交纳的税费。我行根据法令的或税务机关、外汇管理机关等国家机关的命令或要求，代扣代缴用户应缴的相应税费。我行有权按照一定的收费标准向用户收取相关服务费，并有权调整服务费收费标准，但应提前进行公告通知用户。我行将针对符合优惠条件的用户给予优惠收费待遇。
                </p>
                <p align="center">
                    <strong>其它约定</strong></p>
                <p>
                    <strong>第二十条 责任与免责</strong></p>
                <p>
                    <strong>20.1</strong> 华润银行有权依据法律、法规、规章或业务需要对本协议及各类规则不时进行调整或修改，不再单独通知用户。涉及收费或其他用户主要权利义务变更的调整或修改，将以网站公示的方式进行公告，自公告施行之日公告内容构成对华润银行与用户间协议约定的有效修改和补充。<br />
                    <strong>20.2</strong> 在使用本服务时，若用户或用户的交易对手未遵从本服务条款或网站说明、交易页面中之操作提示、规则，则华润银行有权拒绝为用户与交易对方提供相关服务，且华润银行不承担损害赔偿责任。因用户的原因导致华润银行或第三方损失的，华润银行保留追索的权利，同时用户应当承担华润银行合理的追索费用。<br />
                    <strong>20.3 </strong>因用户原因导致的任何损失由用户自行承担，原因包括但不限于：用户不按照交易提示操作，用户未及时进行交易操作，直销银行账户余额不足导致交易失败，直销银行账户内资金被有权机关冻结或扣划而导致交易失败，用户发送的交易指令错误或不完整。<br />
                    <strong>20.4</strong> 用户对于其发布在华润银行直销银行（简称“华润直销银行”）门户所在网站的各类信息（但不包括用户的身份信息）以及其派生的知识产权等，均授予华润银行独家的、全球通用的、永久的、免费的许可使用权，华润银行有权对之以电子或书面等方式进行使用、复制、发行、修订、改写、发布、翻译、分发、执行和展示或制作其派生作品。<br />
                    <strong>20.5</strong> 用户不得使用与华润直销银行正常业务无关的任何软、硬件装置干预或试图干预华润直销银行的正常运作或正在华润直销银行进行的任何交易。
                    <br />
                    <strong>20.6</strong> 用户不得对华润直销银行上的任何资料作商业性利用，包括但不限于在未经华润银行授权的情况下，复制在直销银行上展示的任何资料并用于商业用途。
                    <br />
                    <strong>20.7</strong> 用户在使用本服务过程中，本协议内容、网页上出现的关于交易操作的提示说明或华润银行发送给用户的信息（通过向用户预留手机发送短信或通过电话语音形式发送）内容是用户使用本服务的相关规则的组成部分，用户使用本服务即表示用户同意接受该相关规则。用户了解并同意华润银行有权单方修改本服务的相关规则。
                    <br />
                    <strong>20.8</strong> 华润银行将通过华润直销银行或其他适当渠道发布有关华润直销银行的各类规则、通知、公告及声明，用户应当经常浏览华润直销银行发布的各类规则、通知、公告及声明，以了解华润直销银行各类政策、规则、事项的变化。华润银行无义务个别地通知用户前述信息。但用户仍应及时更新个人通讯或联系方式，因用户未及时更新而导致通知不到、权利丧失、服务中断或终止等不利后果由用户承担。
                    <br />
                    <strong>20.9</strong> 华润银行有义务在现有条件下提高服务质量，确保为用户提供的服务顺利进行。如因不可抗力或华润银行控制范围外的原因造成的服务中断或其他缺陷（包括但不限于自然灾害、社会事件、硬件故障以及因网站所具有的特殊性质而产生的包括黑客攻击、电信部门原因导致的影响、政府管制而造成的暂时性关闭在内的任何影响网络正常运营的因素），华润银行不承担任何责任，但将尽力减少因此而给用户造成的损失和影响。
                    <br />
                    <strong>20.10</strong> 任何由于华润银行合理控制范围以外的原因而产生的交易或服务系统问题，造成资料、行情等信息传输或储存上的错误，导致资料泄露、丢失、被盗用或被篡改等，致使华润直销银行响应延迟或未能履约的，对此可能造成的任何责任华润银行不予承担。
                    <br />
                    <strong>20.11</strong> 华润银行有权依据内部业务规定及商业判断独立决定是否同意用户所申请事项。
                    <br />
                    <strong>20.12</strong> 华润银行对自身发布的公告信息真实性负责。华润直销银行用户信息由用户提供，用户依法应对其提供的任何信息承担全部责任。华润银行对此等信息的准确性、完整性、合法性或真实性均不承担任何责任。
                    <br />
                    <strong>20.13</strong> 华润银行对本服务中涉及的用户资料负有保密义务，但在下述情况下披露用户资料，华润银行均可免责：<br />
                    1) 本协议另有约定或事先获得用户的明确授权或应允；<br />
                    2) 根据有关的法律法规要求；<br />
                    3) 按照相关政府主管部门或司法机关按法定程序的要求；<br />
                    4) 为维护社会公众的利益；<br />
                    5) 披露前已为公众所知悉；<br />
                    6) 为维护华润银行的合法权益。<br />
                    <strong>20.14</strong> 对于用户在本服务的不当行为（包括但不限于违反用户所做承诺或约定义务、违反华润直销银行规则等）或其它任何华润银行认为应当终止服务的情况，华润银行有权采取删除或屏蔽用户发布的信息、限制或终止全部或部分服务、解除协议、列入黑名单、网站公示等一项或多项处理措施，并保留追究其法律责任的权利。华润银行在有证据证明用户或具体交易事项存在违法违规或违反本协议等问题时，有权根据不同情况选择做出给予用户包括但不限于警告、公示、限权、终止服务等不同程度的处罚，并保留追究其相关法律责任的权利。
                    <br />
                    <strong>20.15</strong> 对交易各方发生的争议，华润银行有权依据争议任何一方的要求向相关单位提交系统记录作为证据。用户自华润直销银行及华润直销银行工作人员或经由本服务取得的建议和资讯，无论其为书面或口头形式，均不构成华润银行对本服务的保证。对用户因使用上述建议或资讯而产生的损失，华润银行不承担任何责任。
                    <br />
                    <strong>20.16</strong> 除非法律法规明确要求，或华润银行有合理的理由认为用户可能存在违法或违约情形，否则，华润银行没有义务对所有用户的注册数据等事项进行事先审查。
                    <br />
                    <strong>20.17</strong> 华润银行仅负责按"当时现状"和"当时可得到"的状态向用户提供本服务。除非华润银行另行以书面方式明确无误的作出承诺，否则华润银行对本服务不作任何明示或暗示的保证，包括但不限于本服务的适用性、没有错误或疏漏、持续性、准确性、可靠性、适用于某一特定用途；华润银行也不对本服务所涉及的技术及信息的有效性、准确性、正确性、可靠性、质量、稳定、完整和及时性作出任何承诺和保证。
                </p>
                <p>
                    <strong>第二十一条 用户承诺</strong></p>
                <p>
                    <strong>21.1</strong> 用户同意，华润银行对于本协议有关免除、限制华润银行责任的条款，以及华润银行单方面拥有某些权利的条款已向本人予以解释说明，本人已理解相关含义。
                    <br />
                    <strong>21.2</strong> 用户同意，在使用本服务时的所有行为遵守国家法律、法规以及华润银行相关规则并符合社会公共利益或公共道德。本人应对其在本服务中传输、发送、发布的全部信息内容负全部责任。因本人在本服务中传输、发送、发布的信息内容而导致华润银行或其他第三方任何直接或间接损失的，本人应承担全部责任，并赔偿华润银行或第三方因此遭受的全部损失。
                    <br />
                    <strong>21.3</strong> 用户同意，华润银行在本人的计算机上设定或取用与华润直销银行交易相关的有关信息。
                    <br />
                    <strong>21.4</strong> 用户同意，华润银行有权根据业务需要将本协议项下的全部或部分权利义务转让给其关联公司，发生此种情况时华润银行仅需提前以网站公告的形式通知本人。
                    <br />
                    <strong>21.5</strong> 用户同意，华润银行不对因下述任一情况而导致本人的任何损害赔偿承担责任，包括但不限于利润、商誉、使用、数据等方面的损失或其它无形损失的损害赔偿
                    （无论华润银行是否已被告知该等损害赔偿的可能性）：<br />
                    1) 使用或未能使用本服务；<br />
                    2) 第三方未经批准的使用本人的账户或更改本人的数据；<br />
                    3) 本人对本服务的误解；<br />
                    4) 对于华润直销银行门户提供的与其它互联网网站或资源的链接，本人可能会因此连结至其它第三方经营的网站或资源，但该类第三方经营的网站或资源均由各经营者自行负责，不属于华润银行控制及负责范围之内，本人因使用或依赖该类网站或资源发布的或经由此类网站或资源获得的任何内容、物品或服务所产生的任何损害或损失，华润银行不承担任何责任；<br />
                    5) 任何非因华润银行的原因而引起的与本服务有关的其它损失。<br />
                </p>
                <p>
                    <strong>第二十二条 协议签订与终止</strong></p>
                <p>
                    <strong>22.1 </strong>用户接受本协议、注册华润直销银行用户时即视为用户与华润银行签订本协议，用户销户直销银行账户即视为用户与华润银行终止本协议。
                </p>
                <p>
                    <strong>第二十三条 协议解释</strong></p>
                <p>
                    23.1 华润银行有权依法对本协议进行解释，并保留根据国家法律和规定修改本协议的权利，修改后的条款对双方具有同等的法律效力。
                </p>
                <p>
                    <strong>第二十四条 适用法律</strong></p>
                <p>
                    24.1 本协议适用中华人民共和国法律，为本协议之目的，中华人民共和国法律不包括香港特别行政区、澳门特别行政区及台湾地区法律。
                </p>
                <p>
                    <strong>第二十五条 争议解决</strong></p>
                <p>
                    25.1 用户与华润直销银行之间因本协议引起的任何争议，应通过协商解决；协商未达成一致意见的，向华润银行住所地人民法院提起诉讼。在诉讼期间，本协议不涉及争议部分的条款仍须履行。
                </p>
            </div>
        </div>
    </div>
</div>
<!--提交订单弹窗-->
<script type="text/javascript">
    //初始化分组验证
    //弹窗
    $(".openWindow").click(function () {
        var _top = $(window).scrollTop();
        var parameters = $(this).attr("action-data");
        var paraArr = []
        paraArr = parameters.split("||")
        $(".blackBg").show()
        $("#" + paraArr[0]).show()
        if (paraArr[4] == "absolute") {
            $("#" + paraArr[0]).css({ position: paraArr[4], top: _top + 80 })

        } else {
            $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], top: -paraArr[3] / 2, left: -paraArr[2] / 2 })
        }
        $("#" + paraArr[0]).find(".prompt_inner").addClass(paraArr[1]);
    })
    //关闭弹窗
    $(".prompt_inner .close").click(function () {
        $(".prompt_box").hide()
        $(".blackBg").hide()
    })
		
	
    //移除掉未读的红点
    //    function removeClassRed(ID) {
    //        $("#" + ID).children("span").remove();
    //    }

    //    jQuery(document).ready(function () {
    //        $(".info-news").click(function () {
    //            this.children("span").remove();
    //        })
    //    })


    $(function () {
        $(window).scroll(function () {
            var top = $(window).scrollTop();
            if (top > 100) {
                $(".top-bar").addClass("top-bar-shadow");
            } else {
                $(".top-bar").removeClass("top-bar-shadow");
            }
            /*if(top >300){
            $("#scrolltop").fadeIn();
            }else{
            $("#scrolltop").fadeOut();
            }*/
            if (top > 300 && !$("#scrolltop").data("start")) {
                $("#scrolltop").data("start", true);
                $("#scrolltop").fadeIn(function () {
                    $("#scrolltop").data("start", false);
                });
            }
            if (top < 300 && !$("#scrolltop").data("start")) {
                $("#scrolltop").fadeOut();
            }
        });
        $("#scrolltop").click(function () {
            $("html,body").animate({ scrollTop: 0 });
        });
    });


    //弹窗
    $(".openWindow").click(function () {
        var _top
        var parameters = $(this).attr("action-data");
        if (parameters == null || parameters == "") {
            return;
        }

        var paraArr = []
        paraArr = parameters.split("||")
        $(".blackBg").show()
        $("#" + paraArr[0]).show()
        if ($.inArray("canDrag", paraArr) != -1) {
            DrawNow($("#" + paraArr[0]).find(".prompt_inner"))
        }
        if ($.inArray("inIframe", paraArr) != -1) {
            _top = $(this).offset().top - 80;
        } else {
            _top = $(window).scrollTop();
        }
        if ($.inArray("absolute", paraArr) != -1) {
            $("#" + paraArr[0]).css({ position: "absolute", top: _top + 80 })
            $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], left: -paraArr[2] / 2 })
        } else {
            $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], top: -paraArr[3] / 2, left: -paraArr[2] / 2 })
        }
        $("#" + paraArr[0]).find(".prompt_inner").addClass(paraArr[1]);
        //IE6兼容
        if (! -[1, ] && !window.XMLHttpRequest) {
            $("#" + paraArr[0]).css({ position: "absolute", top: _top + 380 })
        }

    })
    //关闭弹窗
    $(".prompt_box .close").live("click", function () {
        $(".prompt_box").hide()
        $(".blackBg").hide()
    });

    //浮动
    $("#scrolltop").click(function () {
        $("html,body").animate({ scrollTop: 0 });
    });
    $("#scrolltop2").click(function () {
        $("html,body").animate({ scrollTop: 0 });
    });
    $(".close_kf").click(function () {
        $(this).parent().animate({ right: -$(this).parent().width() }, 300, "easeOutQuint")
        $(this).siblings(".show_kf").animate({ left: -$(this).siblings(".show_kf").width() / 2 }, 300, "easeInElastic", function () { $(this).show() })
    })
    $(".show_kf").mouseover(function () {
        $(this).hide()
        $(this).parent().animate({ right: 0 }, 300, "easeOutQuint")
        $(this).css({ left: 100 })
    })

    function moveTips() {
        var tt = 50;
        if (window.innerHeight) {
            pos = window.pageYOffset
        } else if (document.documentElement && document.documentElement.scrollTop) {
            pos = document.documentElement.scrollTop
        } else if (document.body) {
            pos = document.body.scrollTop;
        }
        pos = pos - tips.offsetTop + theTop;
        pos = tips.offsetTop + pos / 10;
        if (pos < theTop) pos = theTop;
        if (pos != old) {
            tips.style.top = pos + "px";
            tt = 10;
            //alert(tips.style.top);
        }
    }
</script>
		<%@ include file="../foot.jsp" %>
	</body>
</html>
