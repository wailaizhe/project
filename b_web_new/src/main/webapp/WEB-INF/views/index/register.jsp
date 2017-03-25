<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<html>
	<head>
		<title>蒲公英金融服务平台——注册</title>
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/style.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/index.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/main.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/new_style.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/jc_easydialog.css"/>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/register.css">
		<script type="text/javascript"	src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
        <script type="text/javascript" src="${resource_dir}/js/jquery.passwordstrength.js"></script>
        <script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>
        <style type="text/css">
      		.easyDialog_wrapper {padding-top:25px;}
      	</style>
	</head>
<body class="gray-bg">
		<script type="text/javascript">
    //关闭弹窗
   function dailongClo(){
      $(".prompt_box").hide()
      $(".blackBg").hide()
   }
    var codHide="show"; //初始化值;	
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
    function ShowInputHint(ctrl, hintType) {
        $(ctrl).removeClass("on-focus");
        $(ctrl).removeClass("on-error");
        if (hintType == "foc") {
            $(ctrl).addClass("on-focus");
        } else if (hintType == "err") {
            $(ctrl).addClass("on-error");
        }
    }
    function SetInputFont(ctrl, ftType) {
        $(ctrl).removeClass("f-6");
        if (ftType == 'black') {
            $(ctrl).addClass("f-6");
        }
    }
    //验证手机号
    var isSendSMSable = true;
    function CheckMobile(Mobile) {
	        var HintCtrl_Id = "Hint_Mobile";
	        if (Mobile == null || Mobile == "" || Mobile == $("#Mobile").attr("defaultval")) {
	            ShowHint(HintCtrl_Id, "err", "*手机号不能为空！");
	             ShowInputHint($("#MobilePhone"), "err");
	            $("#MobilePhone").focus();
	            return false;
	        }
	        var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
	        if (!reg.test(Mobile)) {
	            ShowHint(HintCtrl_Id, "err", "*请输入正确的手机号！");
	            ShowInputHint($("#MobilePhone"), "err");
	            return false;
	        }
	        return true;
    }
    $("#MobilePhone").live("focus", function () {
		       SetInputFont(this, "black");
		       ShowInputHint(this, "foc");
		       ShowHint("Hint_Mobile", null, "");
		       if ($(this).val() == $(this).attr("defaultval")) {
		           $(this).val("");
		       }
    }).live("blur", function (){
				var HintCtrl_Id = "Hint_Mobile";
				var Mobile = $.trim($(this).val());
				if (Mobile == null || Mobile == "") {
					SetInputFont(this, null);
					ShowHint(HintCtrl_Id, "err", "*手机号不能为空！");
					ShowInputHint($("#MobilePhone"), "err");
					return;
				}else if (Mobile == $(this).attr("defaultval")){
					$(this).val($(this).attr("defaultval"));
					ShowHint(HintCtrl_Id, null, null);
					ShowInputHint(this, null);
					SetInputFont(this, null);
					return;
				}
				var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
		        if (!reg.test(Mobile)) {
		            ShowHint(HintCtrl_Id, "err", "*请输入正确的手机号！");
		            ShowInputHint($("#MobilePhone"), "err");
		            return false;
		        }
				if(!valSendPhone()){ return;}
				isSendSMSable = true;		//验证手机
				ShowHint(HintCtrl_Id, "ok","");  
    });
    
    
    //  手机号检验
    function valSendPhone(){
            var HintCtrl_Id = "Hint_Mobile";
            var num=false;
        	var phone=$("#MobilePhone").val();
        	var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
		    if (reg.test(phone)){  
	            $.ajax({
				    async: false,
				    type: "post",
					url: '${ctx}/valdatePhone',
					data: "phone="+ phone,
					error: function (msg) { ShowHint(HintCtrl_Id, "err", "很抱歉，您的网络似乎有点问题,请重试！"); ShowInputHint($("#Mobile"), "err"); },
					success: function (msg) {
					    var existFlag = msg.flag;
						if ("1"==existFlag) {
						  	ShowHint(HintCtrl_Id, "err","此手机已被注册！");
						}else if("0"==existFlag){
						 	ShowHint(HintCtrl_Id, "ok","");  
						 	num=true;
						}else if("2"==existFlag){
						   howHint(HintCtrl_Id, "err","很抱歉，您的网络似乎有点问题,请重试!");
						}
					}
		         });
		    }
		return num;
    }
 
//	验证密码
function  CheckPassword(Password) {
        var HintCtrl_Id = "Hint_Password";
        if (Password == null || Password == "") {
            ShowHint(HintCtrl_Id, "err", "*密码不能为空");
            ShowInputHint($("#password"), "err");
            return false;
        }
         var llStyle = document.getElementById("passwordStrength").className;
         if("ui-pwdstreng"==llStyle){
              ShowHint("Hint_Password", "err", "*密码为6-16个字母、数字的组合！");
              ShowInputHint($("#password"), "err");
              return;
         }
        var Password2 = $.trim($("#txt_Password2").val());
       	// var reg = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/;
       	var reg=new RegExp("(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{2,})$");
        if (!reg.test(Password) || Password.length < 6 || Password.length > 16||Password.indexOf(" ")>=0){
            ShowHint(HintCtrl_Id, "err", "*密码为6-16个字母、数字的组合！");
            ShowInputHint($("#password"), "err");
            return false;
        }else if (Password2 != "") {
            ShowHint(HintCtrl_Id, "ok", "");
            ShowInputHint($("#txt_Password"), null);
            return CheckPassword2(Password2);
        }
        else {
            ShowHint(HintCtrl_Id, "ok", "");
            ShowInputHint($("#password"), null);
            return true;
        }
    }
    $("#password").live("focus", function () {
        ShowInputHint(this, "foc");
        ShowHint("Hint_Password", "info", "*密码为6-16个字母、数字的组合！");
        if ($(this).val() == "") {
            $("#spn_PasswordNote").html("");
        }
        SetInputFont(this, "black");
    }).live("blur", function () {
         var ll = document.getElementById("passwordStrength").className;
         if("ui-pwdstreng"==ll){
              ShowHint("Hint_Password", "err", "*密码为6-16个字母、数字的组合！");
              ShowInputHint($("#password"), "err");
              return;
         }
        var HintCtrl_Id = "Hint_Password";
        SetInputFont(this, "black");
        $("#spn_PasswordNote").removeClass("f-6");
        var Password = $.trim($(this).val());
        if (Password == null || Password == "") {
            ShowHint(HintCtrl_Id, "err", "*密码不能为空！");
            ShowInputHint($("#password"), "err");
            $(this).val("");
            $("#spn_PasswordNote").html($("#spn_PasswordNote").attr("defaultval"));
            $("#spn_PasswordNote").addClass("f-6");
            $("#spn_PasswordNote")("display", "");
            $("#txt_Password").focus();
            return;
        }
         if (Password == "") {
              ShowHint("Hint_Password", null, "");
              ShowInputHint(this, null);
              SetInputFont(this, null);
         $("#spn_PasswordNote").html($("#spn_PasswordNote").attr("defaultval"));
              $("#spn_PasswordNote")("display", "");
               return;
         }
         if (!CheckPassword($(this).val())) {
             return;
         }
        ShowInputHint(this, null);
    });
    
    
    
    //验证确认密码
    function CheckPassword2(Password2) {
        var HintCtrl_Id = "Hint_Password2";
        var HintCtrl_Id2 = "Hint_Password";
        if (Password2 == null || Password2 == "") {
            ShowHint(HintCtrl_Id, "err", "*确认密码不能为空！");
            ShowInputHint($("#txt_Password2"), "err");
            return false;
        }
        var Password = $.trim($("#password").val());
        if (Password != Password2) {
            ShowHint(HintCtrl_Id, "err", "*两次输入密码需要一致！");
            ShowInputHint($("#txt_Password2"), "err");
            return false;
        }
        else {
            var Password2 = $.trim($("#txt_Password2").val());
            if (Password2 != null && Password2 != "") {
                if (Password != Password2) {
                    ShowHint(HintCtrl_Id, "err", "*两次输入密码需要一致！");
                    ShowInputHint($("#txt_Password2"), "err");
                    return false;
                }
                else {
                    ShowHint("Hint_Password2", "ok", "");
                }
                 return true;
            }
             ShowHint($("#txt_Password2"), null);
             return true;
        }
    }
    $("#txt_Password2").live("focus", function () {
        SetInputFont(this, "black");
        ShowInputHint(this, "foc");
        ShowHint("Hint_Password2", null, "");
        if ($(this).val() == "") {
            $("#spn_PasswordNote2").html("");
        }
    }).live("blur", function () {
        var Password = $.trim($("#password").val());
        var Password2 = $.trim($(this).val());
        if (Password == "") {
            if (Password2 != "") {
                ShowHint(HintCtrl_Id2, "err", "*请先输入密码！");
                ShowInputHint($("#password"), "err");
                $("#password").focus();
            }
            else {
                ShowHint("Hint_Password2", null, "");
                ShowInputHint(this, null);
                SetInputFont(this, null);
                $(this).val("");
                $("#spn_PasswordNote2").html($("#spn_PasswordNote2").attr("defaultval"));
            }
            return;
        }
         if (!CheckPassword2($(this).val())) {
            return;
         }
         ShowInputHint(this, null);
    });
    
    //进行验证码验证
    var flag_nc=false;  // 是否获取验证码
	function CheckMobileCheckCode(MobileCheckCode) {
	    var HintCtrl_Id = "Hint_MobileCheckCode";
        var reg = /^\d{6}$/;
        if (MobileCheckCode == null || MobileCheckCode == "" || MobileCheckCode == $("#txt_MobileCheckCode").attr("defaultval")) {
            //验证码
            $("#Hint_MobileCheckCode").show();
            ShowHint(HintCtrl_Id, "err", "*短信验证码不能为空！");
            ShowInputHint($("#txt_MobileCheckCode"), "err");
            $("#sendMobi").hide();
            return false;
        }
        else if (!reg.test(MobileCheckCode)) {
            $("#Hint_MobileCheckCode").show();
            ShowHint(HintCtrl_Id, "err", "*请输入6位数字验证码！");
            ShowInputHint($("#txt_MobileCheckCode"), "err");
            $("#sendMobi").hide();
            return false;
        }
        return true;
    }
    $("#txt_MobileCheckCode").live("focus", function () {
        SetInputFont(this, "black");
        ShowInputHint(this, "foc");
        ShowHint("Hint_MobileCheckCode", null, "");
        if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
        }
    }).live("blur", function () {
        var HintCtrl_Id = "Hint_MobileCheckCode";
        var MobileCheckCode = $.trim($(this).val());
        if (MobileCheckCode == null || MobileCheckCode == "") {
            if(!codHide=="hid"){
               $("#sendMobi").hide();
               $("#"+HintCtrl_Id).show();
               ShowHint(HintCtrl_Id, "err", "*短信验证码不能为空！");
            }
            ShowInputHint(this, "err");
            $(this).val("");
            return;
        }
        if (MobileCheckCode == $(this).attr("defaultval")) {
            ShowHint($(this).attr("id"), null, null);
            ShowInputHint(this, null);
            SetInputFont(this, null);
            return;
        }
         if (!CheckMobileCheckCode($.trim($(this).val()))) {
           return;
         }
         if(!flag_nc){
            ShowHint(HintCtrl_Id, "err", "请获取短信验证码！");
           return ;
         }
         ShowInputHint(this, null);   
 });
 
   function isPhotoYZM(){
       if($("#photoYZM").val()==""){
         ShowInputHint("#photoYZM", "err");
         ShowHint("Hint_photoYZM", "err", "图片验证码不能为空！");
         SetInputFont("#photoYZM", null);
         return false;
      }
      if($("#photoYZM").val() == $("#photoYZM").attr("defaultval")){
         ShowHint("Hint_photoYZM", "err", "图片验证码不能为空！");
          ShowInputHint("#photoYZM", "err");
         SetInputFont("#photoYZM", null);
         return false;
      }
      if($("#photoYZM").val().length<4){
         ShowHint("Hint_photoYZM", "err", "请输入四位图片验证码！");
         ShowInputHint("#photoYZM", "err");
         SetInputFont("#photoYZM", null);
         return false;
      }
      if($("#photoYZM").val() != $("#photoYZM").attr("defaultval")){
         return true;
      }
   }

   $("#photoYZM").live("focus", function () {
        SetInputFont(this, "black");
        ShowInputHint(this, "foc");
        if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
        }
        ShowHint("Hint_photoYZM", null, "");
    }).live("blur", function () {
       isPhotoYZM();
 });
 
    //验证邀请码
 	function valInvitedCode(_invitedCode){
 		var result = "err";
 		$.ajax({
            type: "post",
            url: "${ctx}/valInvitedCode",
            async: false,
            data: "invitedCode="+_invitedCode,
            success: function (msg){
               result = msg.flag; 	 		  
            }
        });
        return result;
 	}
 
 $("#invitedCode").live("focus", function () {
  	   SetInputFont(this, "black");
       var invitedCode = $.trim($("#invitedCode").val());
       if(invitedCode == "请输入邀请人手机号码(选填)"){
       		$("#invitedCode").val("");
       }
       $("#invitedCodeMsg").hide();
    }).live("blur", function () {
    	ShowHint("Hint_invitedCode", "ok", "");
    	if($("#invitedCode").val()==""){
	    	$("#invitedCode").val("");
    	}
        //$("#invitedCodeMsg").show();
        var invitedCode = $.trim($("#invitedCode").val());
        if("" != invitedCode && "请输入邀请人手机号码(选填)" != invitedCode){
	        var flag = valInvitedCode(invitedCode);//验证邀请码
        	if("err" == flag){
        		ShowHint("Hint_invitedCode", "err","请输入正确的手机号!");
	        }else if("1"==flag){
	        	ShowHint("Hint_invitedCode", "err", "手机号不存在!");
	        }
        	else{
	        	ShowHint("Hint_invitedCode", "ok", "");
	        }
        }else{
        	ShowHint("Hint_invitedCode", "", "");
        }
 	});
 
 function EnterpriseName(){
     var companyName =$("#EnterpriseName").val();
     if(companyName==""||$("#EnterpriseName").val()==$("#EnterpriseName").attr("defaultval")){
         ShowHint("Hint_EnterpriseName", "err", "企业名称不能为空！");
         
         ShowInputHint($("#EnterpriseName"), "err");
         SetInputFont($("#EnterpriseName"), null);
         return false;
     }
     return true;
 } 
var noSend="2";
function sendMobileCheckCode() {
        noSend="1";
        var Mobile = $.trim($("#MobilePhone").val());
        var photoYZM = $.trim($("#photoYZM").val());
        var HintCtrl_Id = "MobileCheckCodeDiv";
        var HintCtrl_Id1 = "Hint_MobileCheckCode";
        var timeOut= $("#time").val();
        if (!CheckMobile(Mobile)) {
            return;
        }
        if(!isPhotoYZM()){ // 校验验证码
           return;
        }
        if(!valSendPhone()){  // 校验当前手机号
           return;
        }
        if (!isSendSMSable) {
            return;
        }
        $.ajax({
             type: "post",
             async:false,
             url: '${ctx}/getRegisterCode',
             data:{"phone":strEnc(Mobile,'${key}'),"code":photoYZM,"codeType":"registerCode","timeOut":timeOut},
             success: function (datas) {
                 $("#time").val(datas.time);
                 if("06"==datas.flag1){
                      ShowHint("Hint_photoYZM", "err", "您输入的图片验证码错误，请重新输入！");
			          ShowInputHint("#photoYZM", "err");
			          SetInputFont("#photoYZM", null);
			          $("#photoYZM").val("");
			          changeImg();
			          return false;
                 }else if("2"==datas.flag1){
                      $("#Hint_MobileCheckCode").hide();
                      $("#MobileCheckCodeDiv").show();
	                  ShowHint(HintCtrl_Id, "err","您10分钟内发送验证码次数已超出3次！请稍后再试.");
	                  $("#sendMobi").hide();
	                  codHide="hid";
	                  changeImg();
	                  return;
				 }else if("1"==datas.flag1){
				     $("#sendMobi").show();
				     $("#sendMobi").html("短信验证码已发送到手机："+Mobile+"，请注意查收.");
				     $("#sendMobi").css("color","#000");
				 }else if("05"==datas.flag1){
				     $("#Hint_MobileCheckCode").hide();
				     $("#sendMobi").html("短信验证码获取失败，请重新获取！");
				     $("#sendMobi").css("color","#000");
				     changeImg();
				     return;
				 }else if("exsit"==datas.flag1){
	                    $("#Hint_Mobile").show();
	                    ShowHint("Hint_Mobile", "err","此手机已被注册！");
	                 }
				 else if("1"!=datas.flag1){ // 
				      $("#spTime").val("60"+"秒后重新获取");
				      $("#sendMobi").html("短时间内请不要多次获取验证码.");
				      $("#sendMobi").css("color","red");
				 }
                 
				 $("#Hint_MobileCheckCode").hide();
				 $("#sendMobi").show();
				 iPoint = window.setInterval("setTime()", 1000);
				 $("#spTime").show();
				 $("#btnSendMobileCode").attr("disabled", "disabled"); $("#btnSendMobileCode").hide();
				 $("#sp_mobile").parent().show();
				 $("#sp_mobile").text(Mobile);
				 
				 flag_nc="true";
				 
				 
             }
         }); 
    }
    
//点击获取验证码后倒计时
function setTime() {
        var now = parseInt($("#spTime").val());
        $("#spTime").val((now - 1) + "秒后重新获取");  
        if (now <= 0) {
            window.clearInterval(iPoint);
            $("#spTime").hide();
            $("#spTime").val("120秒后重新获取");
            $("#btnSendMobileCode").removeAttr("disabled");
            $("#btnSendMobileCode").show();
        }
}  
 
   function showXIE(){ 
      var HintCtrl_Id = "Hint_Agreement";
      if($("#chk_Agreement").attr("checked") != "checked"){
          ShowHint(HintCtrl_Id, "", "请阅读并同意《用户注册服务协议》！");
      }else{
        if("0"==$("#isHre").val()){
          //window.open('${ctx}/help/helpCenter/platformRegistrationProtocol.jsp','_blank');
          $("#isHre").val("1");
          $("#btn_Register").css("background-color","#d84124")
        }
        ShowHint(HintCtrl_Id, "", "");
      }
   }
          
 //验证协议
 function agreement(HintAgreement){
      var IsReaded = $("#chk_Agreement").attr("checked");
      var HintCtrl_Id = "Hint_Agreement";
        if (!IsReaded) {
            ShowHint(HintCtrl_Id, "", "请阅读并同意《用户注册服务协议》！");
            return false;
        } else{
          if(IsReaded){
            ShowHint(HintCtrl_Id, "", "");
	      }   
        }
       return true;
 }
</script>

<script type="text/javascript">
     $(function () {
        $('#password').passwordStrength();
        $(".ui-input-box").click(function(){
			$(this).children(".login-tips-text").hide();
            $(this).children().first().focus();
		})
		$("#isEnterpriseH").hide();
		var invitorCode = $("#invitedCodeHidden").val();
		if(invitorCode == ""){
			$("#invitedCode").val("请输入邀请人手机号码(选填)");
		}else{
			$("#invitedCode").val(invitorCode);
		}
		
		//注册协议弹框
		$('#yhzcxyLink').click(function(){
	        var chks = $('#tan').html();
	        easyDialog.open({
	            container : {
	                header : ' ',
	                content :chks
	            },
	            fixed : false
	        });
	    });
    });
    //  注册确认按钮
    
    function Send_Submit() {
        var rad= $.trim($("#chk_Agreement").val());
        var Mobile = $.trim($("#MobilePhone").val());
        var Password = $.trim($("#password").val());
        var Password2 = $.trim($("#txt_Password2").val());
       	var MobileCheckCode = $.trim($("#txt_MobileCheckCode").val()); //获取验证码
       	var invitedCode = $.trim($("#invitedCode").val());
       	if("请输入邀请人手机号码(选填)" == invitedCode){
       		invitedCode = "";
       	}
        if (!agreement(rad)) {
             return;
        }
        if (!CheckMobile(Mobile)) {
            return;
        }
        if (!CheckMobileCheckCode(MobileCheckCode)) {    //  验证码校验
            return;
        }
        if(!CheckPassword(Password)){
           return;
        }
        if(!CheckPassword2(Password2)){
           return;
        }
        if(!valSendPhone()){  // 校验当前手机号
           return;
        }
        if(Mobile == invitedCode){return;}//自己不能邀请自己
         
        var isEnterprise =$("#isEnterprise").val();
        if("0"==isEnterprise){
            if(!EnterpriseName()){
              return;
            }
	        var companyName = $.trim($("#EnterpriseName").val());
	        if(companyName!=""){
	           model.companyName = companyName;
	        }
        }
        var code=$("#txt_MobileCheckCode").val(); 
        var HintCtrl_Id = "Hint_MobileCheckCode";
        var photoYZM = $.trim($("#photoYZM").val());
        if(""==photoYZM||photoYZM==null){
           ShowHint("Hint_photoYZM", "err", "图片验证码不能为空，请重新输入！");
           ShowInputHint("#photoYZM", "err");
           SetInputFont("#photoYZM", null);
           return;
        }
				$("#btn_Register").attr("disabled","disabled");
				$("#btn_Register").val("注册中...");
		        $.ajax({
		            type: "post",
		            url: "${ctx}/successRegister",
		            async: false,
		            data: {"mobilePhone":Mobile,"code":code,"password":strEnc(Password2,'${key}'),"invitedCode":invitedCode},
		            success: function (msg){
		            	alert(msg.success);
		                if(msg.success=="5"){ 
		                    window.location.href = "${ctx}/"+msg.pathUrl;
		                }else if(msg.success=='0'){
		                    warnMsg("网络出问题了...请稍后！","关闭");
		                    $("#sendMobi").hide();
		                }else if("3"==msg.success){
		                    $("#Hint_MobileCheckCode").show();
			 		        ShowHint(HintCtrl_Id, "err", "您的短信验证码已过期,请重新获取!");
			 		        $("#sendMobi").hide();
			 		        changeImg();
	                        $("#Hint_photoYZM").hide();
			 		     }else if("1"==msg.success){
			 		        $("#Hint_MobileCheckCode").show();
			 		        ShowHint(HintCtrl_Id, "err", "短信验证码输入有误！");
			 		        $("#sendMobi").hide();
	                        $("#Hint_photoYZM").hide();
			 		     }else if("1"==msg.err){
		                    $("#Hint_Mobile").show();
		                    ShowHint("Hint_Mobile", "err","此手机已被注册！");
		                 }else if("2"==msg.err){
		                    $("#Hint_Mobile").show();
		                    ShowHint("Hint_Mobile", "err","手机号不能为空！");
		                 }else if("invitedCodeErr" == msg.err){
		                 	ShowHint("Hint_invitedCode", "err","请输入正确的手机号！");
		                 }
		                 $("#btn_Register").val("免费注册");
		                 $("#btn_Register").attr("disabled",false);
		            }
		        });
};
    
    function changeCodeImg(imgId, sessionName, eId) {
        if ($("#" + eId).val() != "" && $("#" + eId).val() != $("#" + eId).attr("defaulttext")) {
            //清除数据缓存，否则不会经行验证
            $("#" + eId).data("previousValue", null);
            fValidator.element("#" + eId);
        }
        getCodeImg(imgId, sessionName);
    }
    
    function changeImg(){    
	    var imgSrc = $("#imgObj");    
	    var src = "${ctx}/authimg?codeType=registerCode&now="+Math.random();   
	    //console.info(src);
	    imgSrc.attr("src",src);    
	}
</script>
<%@ include file="./header.jsp" %>
<input type="hidden" value="1" id="isEnterprise">
<input type="hidden" value="${time}" id="time" name="time">
<input type="hidden" value="0" id="isHre" name="isHre">
<!--注册开始-->
<div class="reg_section">
	<h3 class="reg">
    	<i><img src="${resource_dir}/images/username.png"/></i>
        <em>用户注册：</em>
    </h3>
    <div class="reg_head"><h3></h3></div>
    <div class="reg_main">
        <div class="ui-content register-box reg-bg2">
					<form class="ui-form ui-form-setpwd reg-box" method="post" action="">
						<div class="ui-form-item reg-form">
							<label class="ui-label f-left">
								<span class="ui-hit red">*</span><span class="ui-icon">手机号码：</span>
							</label>
							<span class="ui-input-box f-left"> <input type="text" value="请输入您的手机号" defaultval="请输入您的手机号"
									class="ui-input w-300 login-ui-input2 f-left" id="MobilePhone"
									maxlength="11" name="MobilePhone" /> </span>
							<div class="ui-tips" id="Hint_Mobile"></div>
						</div>
						<div class="ui-form-item reg-form" id="isEnterpriseH" style="display:none">
							<label class="ui-label f-left">
								<span class="ui-hit red">*</span><span class="ui-icon">企业名称：</span>
							</label>
							<span class="ui-input-box f-left"> <input type="text"
									value="请输入企业名称" defaultval="请输入企业名称"
									class="ui-input w-300 login-ui-input2 f-left" id="EnterpriseName"
									name="EnterpriseName" /> </span>
							<div class="ui-tips" id="Hint_EnterpriseName" style="width: 300px;"></div>
						</div>
						<div class="ui-form-item reg-form">
							<label class="ui-label f-left">
								<span class="ui-hit red">*</span><span class="ui-icon">设置密码：</span>
							</label>
							<span class="ui-input-box f-left"> <input type="password"
									maxlength="16" value=""  oncopy="return false;" onpaste="return false"
									class="ui-input w-300 login-ui-input2 f-left" id="password"
									name="password" /> <span class="login-tips-text"
								id="spn_PasswordNote" defaultval="请设置密码">请设置密码</span> </span>
							<div class="ui-tips" id="Hint_Password">
							</div>
							<div class="ui-pwdstreng" id="passwordStrength" style="margin-left:40px;margin-top: 5px;">
								安全程度：
								<span></span>
							</div>
						</div>
						<div class="ui-form-item reg-form">
							<label class="ui-label f-left">
								<span class="ui-hit red">*</span><span class="ui-icon">确认密码：</span>
							</label>
							<span class="ui-input-box f-left reg-Password2"> <input
									type="password" maxlength="16" id="txt_Password2"
									name="txt_Password2" value="" oncopy="return false;" onpaste="return false"
									class="ui-input w-300 login-ui-input2 f-left"
									id="loginUserName" /> <span class="login-tips-text"
								id="spn_PasswordNote2" defaultval="请再次输入密码">请再次输入密码</span> </span>
							<div class="ui-tips" id="Hint_Password2"></div>
						</div>
                        
                        <div class="ui-form-item reg-form" id="photoYZMS" style="display:hidden">
							<label class="ui-label f-left">
								<span class="ui-hit red">*</span><span class="ui-icon">图片验证码：</span>
							</label>
							<span class="ui-input-box f-left"> <input type="text"
									value="请输入图片验证码" defaultval="请输入图片验证码"
									class="ui-input  login-ui-input2 f-left" id="photoYZM"
									name="photoYZM" maxlength="4"/> </span>
						    <img style="float:left; display:block; margin:0 0 0 25px;cursor: pointer;" id="imgObj" title="看不清?请点击" style="cursor: pointer;" onclick="changeImg()" src="${ctx}/authimg?codeType=registerCode"/>
							<div  class="ui-tips" id="Hint_photoYZM" style="width: 300px;margin-left:48px;"></div>
						</div>
						<div class="ui-form-item reg-form" style="height: 50px;">
							<label class="ui-label f-left">
								<span class="ui-hit red">*</span><span class="ui-icon">短信验证码：</span>
							</label>
							<span class="ui-input-box f-left"> <input type="text" oncopy="return false;" onpaste="return false"
									value="请输入短信验证码" defaultval="请输入短信验证码"
									class="ui-input  login-ui-input2 f-left"
									id="txt_MobileCheckCode" maxlength="6" name="txt_MobileCheckCode" /> <input
									type="button" value="获取验证码" id="btnSendMobileCode"
									onclick="sendMobileCheckCode()" class="ui-button button-yzm" style="width:130px;" />
								    <input id="spTime" style="display: none;width:130px;" type="button"	value="120秒后重新获取" class="ui-button button-disabled" /> 
							</span>
							<div class="ui-tips" id="Hint_MobileCheckCode"
								style="width: 210px; margin-left: 24px;">
							</div>
							<div class="ui-tips" id="MobileCheckCodeDiv" style="padding-left:25px;">
							</div>
							<div id="sendMobi" style="font-size:12px;float: left;"></div>
						</div>
						<div class="ui-form-item reg-form" style="height: 50px;">
							<label class="ui-label f-left">
								<span class="ui-icon">&nbsp;邀请码 :&nbsp;</span>
							</label>
							<input type="hidden" value="${invitedCode}" id="invitedCodeHidden"/>
 						   <span class="ui-input-box f-left"> 
 						   		<input type="text" id="invitedCode" value="请输入邀请人手机号码(选填)" defaultval="请输入邀请人手机号码(选填)" maxlength="11" class="ui-input  login-ui-input2 f-left" />
						   </span>
						   <div class="ui-tips" id="Hint_invitedCode"></div>
						   <!--  <span id='invitedCodeMsg' style="display:none;color:red;font-size:14px;">&nbsp;&nbsp;请输入正确的手机号</span>-->
						</div>
						<span id="sendPhon"></span>
				        <div class="ui-form-item reg-form" style="padding-bottom:10px;">
							<label class="ui-label f-left">&nbsp;</label>
							<span class="info-other">
		                    <input type="checkbox" id='chk_Agreement'  onclick="showXIE();" id="chk_Agreement" name="chk_Agreement" value="" />
                            <label for="chk_Agreement" >我已阅读并同意</label> 
                            <a id="yhzcxyLink" class="black forgot">《用户注册服务协议》</a> 
                            </span>
						</div>
						<div class="ui-tips" id="Hint_Agreement" style="font-size: 12px; color: red; margin-left: 150px;margin-bottom:20px">
						</div>
						<div class="clear"></div>
						<div class="ui-form-item">
							<div style="margin-left: 98px">
								<input type="button" id="btn_Register" name="btn_Register" class="ui-button lg-submit-btn" style="cursor: pointer;background-color: #ccc;  "  value="免费注册" onclick="Send_Submit()"/>
								<span class="lg-form-other"	style="margin-left: 20px;color:black;">已有账号， 请 <a 	title="登 录" href="${ctx}/login" class="textlink" style="color: red">登录</a> </span>
							</div>
						</div>
					</form>
					<div class="blackBg">
					</div>
				</div></div>
				</div>
				<%@ include file="./foot.jsp" %>		
				
				<div id="tan" class="buy_tan" style="display:none;background-color:#fff;">
        	 	<h2 style="text-align:center;font-weight:bold;">用户注册服务协议</h2><br>
                <p>欢迎使用互联网金融服务平台（以下简称“平台”或“本平台”）服务，平台向用户提供基于互联网的,包括但不限于投融资项目居间撮合等中介服务（以下简称“服务”）。为了保障用户的权益，请用户确认已于使用平台服务前，已经详细阅读了本协议的所有内容。对于责任限制等特别重要条款，本文将用粗体标注，请予以重点关注。</p>
                <h3>第一章 总则</h3>
                <p>1.用户在平台注册并确认本协议的行为，表示用户已阅读、理解并同意本协议之所有内容。</p>
                <p>2.鉴于网络服务的特殊性，本协议可由平台随时更新，且无需另行通知。用户在使用平台服务时，应关注并遵守其所适用的相关条款。</p>
                <p>3.用户在使用平台服务之前，应仔细阅读本协议。如用户不同意本协议及/或平台随时对其的修改，用户可以主动取消平台服务；用户一旦使用平台服务，即视为用户已了解并完全同意本协议各项内容，包括本平台对本协议随时所做的任何修改，并成为平台用户。</p>
                <p>4.平台拥有本协议在法律许可范围内的最终解释权。 </p>
                <p>5.如用户所属的国家或地区排斥本协议条款内容之全部或部分内容，则用户应立即停止使用平台服务。 </p>
                <h3>第二章 声明与承诺</h3>
                <p>6.在使用“平台”服务前，用户确认并同意以下事项： </p>
                <p>1)用户是具有法律规定的完全民事权利能力和民事行为能力，能够独立承担民事责任的自然人、法人或其他组织，且本协议内容不受用户所属地区的排斥。不具备前述条件的，用户应立即终止注册或停止使用本网站提供的服务。平台仅向符合完全民事权利能力与民事行为能力的自然人，或符合平台或平台关联实体相关规则的法人或其他组织提供服务。</p>
                <p>2)为了注册平台服务，用户必须向平台提交用户的完整、准确的信息，包括但不限于姓名、电子邮件地址、法人或其他组织的合法登记资料等。同时用户确认用户对提交的信息的准确性、真实性与完整性负责。</p>
                <p>3)用户同意，尽管平台会尝试提醒用户关于此类操作或告知用户后续处理方式，平台并不对任何由于用户提供资料有误而导致无法通知用户相关信息的情况负责。</p>
                <p>4)平台协议项下任何权利或义务，都不得在未经平台同意的情况下被出售或转移到第三方自然人或法人。 </p>
                <p>5)任何用户与平台之间的电子邮件形式的沟通都被视为有效沟通。 </p>
                <p>7.用户承诺遵守中华人民共和国法律、法规及一切适用于互联网金融的部门规章及监管文件的规定，用户同意不利用平台服务进行任何违法或不正当的活动，包括但不限于下列行为： </p>
                <p>1)违反法律或合同约定义务的： </p>
                <p>i.侵犯第三方的著作权、专利、商标、商业秘密或其它专有权利、公共利益和隐私的； </p>
                <p>ii.侮辱或者诽谤他人，侵害他人合法权益的； </p>
                <p>iii.教唆犯罪的； </p>
                <p>iv.提供赌博信息或以其他方式引诱他人参与赌博的等；</p>
                <p>v.洗钱、非法套现、传销、贩卖枪支、毒品、禁药、盗版软件、淫秽物品或其他违禁物等； </p>
                <p>vi.违反依法律或合约所应负之保密义务的； </p>
                <p>vii.国家法律、行政法规禁止的其他内容。 </p>
                <p>2)为任何非法目的而使用平台服务的： </p>
                <p>i.冒用他人名义使用平台服务的； </p>
                <p>ii.使用无效银行卡号码，或未经授权使用他人银行卡号码进行交易的； </p>
                <p>iii.非法使用他人银行账号或使用无效银行账号进行交易的。 </p>
                <p>3)危害计算机信息网络安全的： </p>
                <p>i.从事任何可能含有电脑病毒或是可能侵害平台服务系统、资料的行为的； </p>
                <p>ii.故意制作、传播计算机病毒等破坏性程序的； </p>
                <p>iii.未经允许，进入计算机信息网络或者使用计算机信息网络资源的； </p>
                <p>iv.未经允许，对计算机信息网络功能进行删除、修改或者增加的； </p>
                <p>v.未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的； </p>
                <p>vi.其他危害计算机信息网络安全的行为。 </p>
                <p>4)或本平台有正当理由认为用户有不适当的其他行为。 </p>
                <p>本平台在有合理理由怀疑用户进行了本条规定的违约行为时，有权对用户的账户进行调查。如果调查结果证实用户的账户确实存在上述违约行为，本平台有权锁定用户的账户并终止与用户的合作。用户理解并同意本平台不会就账户的冻结以及锁定提供任何赔偿或者补偿。</p>
                <p>8.对于用户因违反本协议条款，导致或产生的任何第三方主张的任何索赔、要求或损失，包括合理的律师费，用户同意赔偿本平台及其合作公司、关联公司，并使之免受损害。 </p>
                <p>9.用户承担法律责任的形式包括但不限于：对受到侵害者进行赔偿，以及在本平台首先承担了因用户行为导致的行政处罚或侵权损害赔偿责任后，用户应给予本平台等额的赔偿；若导致本平台的合作伙伴或关联公司损害的，用户同样应对该损害给予等额的赔偿。</p>
                <h3>第三章 平台账号的注册及密码安全</h3>
                <p>10.注册平台的服务，用户将获得一个平台账号。用户可以自行设定其密码，并通过账号及密码及平台的其他验证方式登录并向平台发送各类指令，获得平台提供的包括但不限于投融资项目居间撮合等中介服务。</p>
                <p>11.平台不会以电子邮件方式要求用户提供密码或个人敏感信息。</p>
                <p>12.平台要求用户不对其他任何人或第三方告知或分享用户的密码或其他个人可识别信息。用户将对任何向第三方透露密码之行为，及其可能造成的影响负责。 </p>
                <p>13.当用户发现用户的账户或密码被盗，或用户账户发生未经授权的操作时，用户承诺应在第一时间以有效形式通知（通知方式见本协议第32条）平台。用户了解并接受当此类事件发生时，平台将对用户账户实行临时性暂停服务操作。</p>
                <p>14.因用户主观过错或者过失导致的任何损失由用户自行承担，该过错或者过失包括但不限于：不按照交易提示操作，未及时进行交易操作，遗忘密码，泄漏密码，密码被他人破解，用户使用的计算机被他人侵入。</p>
                <p>15.任何在接受通知前发生的因用户主观过失导致的未经授权交易或造成的其他损失，平台都不承担任何责任，除非可证明平台存在重大过失。</p>
                <h3>第四章  使用限制</h3>
                <p>16.用户明确理解和同意，在出现下述情况之一时，本平台有权暂停或终止用户对平台服务的使用，且无需事先通知，本平台不承担违约责任或其他任何赔偿责任： </p>
                <p>1)本平台有合理的依据证明用户已经违反本协议的规定； </p>
                <p>2)本平台发现用户有异常交易或发现用户的交易涉嫌违法时；</p>
                <p>3)在特殊情况下，本平台认为必要之时。 </p>
                <p>本平台暂停、拒绝或终止用户对平台的使用后： </p>
                <p>1)在本平台暂停用户的平台服务后，若用户纠正违反本协议的行为且向本平台书面保证不再违法本协议的规定后，本平台可视情况恢复用户的平台服务； </p>
                <p>2)在本平台终止用户的平台服务后，将关闭或删除用户的账号及用户账号中所有相关资料及档案，并将用户滞留在平台的全部资金退回到用户的银行账户中；</p>
                <p>3)平台保留拒绝用户将平台服务用于任何未经平台书面同意的商业用途的权利；</p>
                <p>4)使用平台服务，将可能会产生相应的服务费用。详细各项服务费用如没有在平台网站上所展示或其他协议约定，则表示目前免费。公司保留制定与不时调整服务费用的权利；</p>
                <p>5)用户同意基于运行和交易安全的需要，平台在没有提前通知用户的情况下，可以新增新的服务，或暂时停止提供或者限制部分服务功能。对于功能的变更而导致的用户协议的变化，平台没有义务告知。只要用户仍然使用平台服务，表示用户仍然同意本条款或者本条款修正后的条款。 </p>
                <h3>第五章 不可抗力及服务中断  </h3>
                <p>17.本平台需要定期或不定期地对提供平台服务系统及其相关的设备进行检修或者维护，如因此类情况而造成网络服务（包括收费服务）在合理时间内的中断，本平台无需为此承担任何责任。本平台保留不经事先通知为维修保养、升级或其它目的暂停本服务任何部分的权利。</p>
                <h3>第六章 信息收集与披露 </h3>
                <p>18.关于用户的用户注册及其他特定资料信息依本章各条款的约定进行收集与披露。本信息收集与披露条款正在不断改进中，随着平台服务范围的扩大，平台会随时更新平台的信息收集与披露条款。平台欢迎用户随时回来查看本信息收集与披露条款，并向平台反馈用户的意见。 </p>
                <p>19.本平台所提供的实名认证、提现业务以及将来本平台的其他服务将可能需要合理获取用户的银行账户信息，平台将严格履行相关法规，确保用户的资料安全。 </p>
                <p>20.在用户注册平台账户后，使用平台服务、或参加本平台的其他活动时，本平台会收集用户的个人身份识别资料，并会将这些资料用于：改进为用户提供的服务并可能将该综合统计资料向平台关联实体披露。 </p>
                <p>21.为了保障平台服务的安全以及不断改进对用户的服务，本平台可能会记录和保存用户登陆和使用平台网站的相关信息。本平台还跟踪全天的页面访问数据。全天页面访问数据可能被用来反映网站流量，以便于本平台为改进对用户的服务制定未来的发展计划。 </p>
                <p>22.本平台或第三人可提供与其它互联网上之网站或资源之链接。由于本平台无法控制这些网站及资源，用户了解并同意，此类网站或资源是否可供利用，本平台不予负责，存在或源于此类网站或资源之任何内容、广告、产品或其它资料，本平台亦不予保证或负责。因使用或依赖任何此类网站或资源发布的或经由此类网站或资源获得的任何内容、商品或服务所产生的任何损害或损失，本平台不承担任何责任。 </p>
                <p>23.除非本章前述条款有约定外，本平台不对外公开或向第三方提供用户的信息，除非： </p>
                <p>1)事先获得用户的明确授权； </p>
                <p>2)只有透露用户的个人资料，才能提供用户所要求的产品和服务；  </p>
                <p>3)按照平台服务规则的要求应予以提供或披露；  </p>
                <p>4)根据有关的法律法规要求；  </p>
                <p>5)按照相关政府主管部门的要求；  </p>
                <p>6)为维护本平台的合法权益。  </p>
                <p>24.在进行平台交易时，用户的某些私人信息将会被提供给交易对方。用户使用平台服务进行交易，即视为用户同意并授权平台进行上述操作。这些信息包括但不限于：用户的真实姓名，企业信息，联系方式，信用状况，平台账号。 </p>
                <div style="text-decoration:underline;">
                <h3>第七章 责任范围及责任限制</h3>
                <p><b>25.本平台无法保证用户所提交信息的准确性、合法性和及时性，请用户在与其他用户交易过程中谨慎判断。</b></p>
                <p><b>26.本平台无法保证平台服务符合用户的要求，或平台服务不会出错等。 </b></p>
                <p><b>27.本平台不对合作伙伴所提供的服务质量及内容承担保证责任。 </b></p>
                <p><b>28.用户在平台网站下载或取得任何资料而导致用户的任何损害，本平台不承担任何责任。 </b></p>
                <p><b>29.本平台仅承担本协议明确约定的直接责任。除本协议另有规定外，在任何情况下，本平台对本协议所承担的违约赔偿责任总额不超过向用户收取的当次平台服务费用总额。 </b></p>
               	</div>
                <h3>第八章 商标、知识产权的保护</h3>
                <p>30.本平台或平台关联方拥有本平台网站内相应资料、技术及展现形式的知识产权。</p>
                <p>31.未经许可，任何人不得擅自使用（包括但不限于：以非法的方式复制、传播、展示、镜像、上载、下载）、修改、传播本平台或平台关联方的知识产权。否则，本平台将依法追究法律责任。 </p> 
                <h3>第九章  其他</h3>
				<p>32.通知方式： </p>
				<p>1)拨打客服电话、向客服邮箱发送邮件、传真、EMS等方式均视为客户的有效通知。</p>
				<p>2)拨打客户电话、网站公告、平台站内信、手机短信，向客户指定邮箱发送邮件、传真、快递等方式均视为平台的有效通知。本平台不保证用户能够收到或者及时收到上述邮件（或传真或挂号邮件），且不对此承担任何后果，因此，在交易过程中用户应当及时登录到本网站查看和进行交易操作。因用户没有及时查看和对交易状态进行修改或确认或未能提交相关申请而导致的任何纠纷或损失，本平台不负任何责任。 </p>
				<p>3)如果本协议条款中的部分条款被有管辖权的法院认定为违法，那么这些条款并不影响其他条款的有效性并将应用其他有效条款按最接近双方意图的可能而推定。 </p>
				<p>4)本平台未行使或执行本协议任何权利或规定，不构成对前述权利或权益之放弃。 </p>
				<p>5)如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍应有效并且有约束力。 </p>
				<p>33.不可抗力：</p>
				<p>用户理解并同意，在使用本平台服务的过程中，可能会遇到不可抗力等风险因素，使本服务发生中断。不可抗力是指不能预见、不能克服并不能避免且对一方或双方造成重大影响的客观事件，包括但不限于自然灾害如洪水、地震、瘟疫流行和风暴等以及社会事件如战争、动乱、政府行为等。出现上述情况时，平台将努力在第一时间与相关单位配合，及时进行修复，但是由此给用户造成的损失平台在法律允许的范围内免责。</p>
				<p>在法律允许的范围内，平台对以下情形导致的服务中断或受阻不承担责任：</p>
				<p>1)受到计算机病毒、木马或其他恶意程序、黑客攻击的破坏；</p>
				<p>2)用户或平台的电脑软件、系统、硬件和通信线路出现故障；</p>
				<p>3)用户操作不当；</p>
				<p>4)用户通过非平台授权的方式使用本服务；</p>
				<p>5)其他平台无法控制或合理预见的情形。</p>
				<p>34.平台依据本协议约定获得处理违法违规内容的权利，该权利不构成平台的义务或承诺，平台不能保证及时发现违法行为或进行相应处理。</p>
				<div style="text-decoration:underline;">
				<p>35.在任何情况下，用户不应轻信借款、索要密码或其他涉及财产的网络信息。涉及财产操作的，请一定先核实对方身份，并请经常留意平台有关防范诈骗犯罪的提示。</p>
				</div>
				<h3>第十章 管辖</h3>
				<p>36.本协议的订立、执行和解释及争议的解决均应适用中华人民共和国法律。 </p>
				<p>37.因本协议引起的或与本协议有关的任何争议，尽最大诚意进行友好协商，如果双方不能协商一致，则该争议由平台运营商所在地有管辖权的人民法院管辖。平台运营商所在地为北京市丰台区。 </p>         
        </div>
	</body>
</html>