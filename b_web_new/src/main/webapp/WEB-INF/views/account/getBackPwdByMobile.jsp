<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<TITLE>蒲公英金融服务平台</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
        <link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
        <script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>
	</head>

<script type="text/javascript">
    
    var flagM="01";
    $("#txt_Mobile").live("focus", function () {
           inputColor(this,null);
           $("#Hint_Mobile").hide();
           $("#txt_Mobile").removeClass("on-error");
           if($(this).val() == $(this).attr("defaultval")){
              $(this).val('');
           }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入您的手机号");
          $("#Hint_Mobile").show();
          ShowHint("Hint_Mobile", "err", "手机号不能为空");
          $("#txt_Mobile").addClass("on-error");
          return;
        }else{
            var txt_Mobile= $("#txt_Mobile").val();
            var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
	        if (!reg.test(txt_Mobile)) {
	             $("#Hint_Mobile").show();
	             ShowHint("Hint_Mobile", "err", "请输入正确的手机号");
	            $("#txt_Mobile").addClass("on-error");
	            return;
	        }else{
	           // ShowHint("Hint_Mobile", "ok", "");
	           // $("#Hint_Mobile").addClass("tips-ok");
	        }
	         //验证用户是否存在  是否实名认证
	          $.ajax({	
	             async: false,
	             type: "post",
	             url: '${ctx}/baseInfo/checkBaseInfo',
	             data: "phone="+strEnc(txt_Mobile,'${key}'),
	             success: function (result) {
					     if("03"==result){
					         $("#t12").show();
					         $("#t11").show();
					     }else if("05"==result){
					       $("#Hint_Mobile").show();
		                   ShowHint("Hint_Mobile", "err", "您输入的注册手机号有误，请确认后重新输入");
		                   return;
					     }else{
					     	 $("#t12").hide();
					         $("#t11").hide();
					     }
	             }
	         });
          flagM="02";
        } 
    });
     
     
    
    var flagD="01";
    $("#MobileCheckCode").live("focus", function () {
        inputColor(this,null);
        $("#Hint_MobileCheckCode").hide();
        $("#MobileCheckCode").removeClass("on-error");
        if($(this).val() == $(this).attr("defaultval")){
           $(this).val('');
        }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入短信验证码");
          $("#Hint_MobileCheckCode").show();
          ShowHint("Hint_MobileCheckCode", "err", "短信验证码不能为空");
          $("#MobileCheckCode").addClass("on-error");
          return;
        }
        var reg = /^\d{6}$/;
        if(!reg.test($(this).val())){
           $("#Hint_MobileCheckCode").show();
           ShowHint("Hint_MobileCheckCode", "err", "请输入6位数字短信验证码");
           $("#MobileCheckCode").addClass("on-error");
           return;
        }
        flagD="02";
    });
    
    var flagY="01";
    $("#yzmValue").live("focus", function () {
        inputColor(this,null);
        $("#Hint_YZM").hide();
        $("#yzmValue").removeClass("on-error");
        if($(this).val() == $(this).attr("defaultval")){
           $(this).val('');
        }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入图片验证码");
          $("#Hint_YZM").show();
          ShowHint("Hint_YZM", "err", "图片验证码不能为空");
          $("#yzmValue").addClass("on-error");
          return;
        }
        flagY="02";
    });
    
    
    var flah12="01";
    $("#txt_realName").live("focus", function () {
         inputColor(this,null);
         $("#Hint_realName").hide();
         $("#txt_realName").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入您的真实姓名");
          $("#Hint_realName").show();
          ShowHint("Hint_realName", "err", "请输入您的真实姓名");
          $("#txt_realName").addClass("on-error");
          return;
        }
        var realName = $("#txt_realName").val();
        var reg = /^[\u4e00-\u9fa5]{2,6}$/;
        if(!reg.test(jQuery.trim(realName))){
          $("#Hint_realName").show();
          $("#txt_realName").addClass("on-error");
          ShowHint("Hint_realName", "err", "请输入2~6个汉字的真实姓名!");
          return;
        }
        flah12="02";
    });
    
    
    var flah13="01";
    $("#txt_indetify").live("focus", function () {
         inputColor(this,null);
         $("#Hint_indetify").hide();
         $("#txt_indetify").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入您的身份证号");
          $("#Hint_indetify").show();
          ShowHint("Hint_indetify", "err", "请输入您的身份证号");
          $("#txt_indetify").addClass("on-error");
          return;
        }
        var identity = $("#txt_indetify").val();
        var reg = /^[1-9]([0-9]{14}|[0-9|X|x]{17})$/;
        if(!reg.test(jQuery.trim(identity))){
          $("#Hint_indetify").show();
          $("#txt_indetify").addClass("on-error");
          ShowHint("Hint_indetify", "err", "请输入15位或18位有效身份证号码!");
          return;
        }
        flah13="02";
    });
    
    
    var sendM="01"
    function sendMobileCheckCode(){  // 修改密码 获取验证码
         $("#Hint_MobileCheckCode").hide();
         $("#MobileCheckCode").removeClass("on-error");
         if(flagM!="02"){
           $("#Hint_Mobile").show();
	       ShowHint("Hint_Mobile", "err", "请输入正确的手机号");
	       return;
         }
         var HintCtrl_Id = "Hint_MobileCheckCode";
         var txt_Mobile= $("#txt_Mobile").val();
         if(flagY!="02"){
           $("#Hint_YZM").show();
	       ShowHint("Hint_YZM", "err", "请输入4位图片验证码");
	       $("#yzmValue").addClass("on-error");
	       return;
         }
         var yzmValue= $("#yzmValue").val();
         if(""==yzmValue||yzmValue.length<4){
           $("#Hint_YZM").show();
	       ShowHint("Hint_YZM", "err", "请输入4位图片验证码");
	       $("#yzmValue").addClass("on-error");
	       return;
         }
         $.ajax({	
             async: false,
             type: "post",
             url: '${ctx}/smsInfo/registerCode',
             data: "phone="+strEnc(txt_Mobile,'${key}')+"&messageType=007&code="+yzmValue+"&codeType=msCode",
             success: function (result) {
                 if("2"==result.flag1){
	                   $("#Hint_MobileCheckCode").show();
	 		           ShowHint(HintCtrl_Id, "err", "您10分钟内已发送验证码3次！请稍后再试.");
	                   return;
				 }else if("05"==result.flag1){
				       $("#Hint_Mobile").show();
	                   ShowHint("Hint_Mobile", "err", "您输入的注册手机号有误，请确认后重新输入");
	                   return;
				 }else if("06"==result.flag1){
				      $("#yzmValue").addClass("on-error");
				      $("#Hint_YZM").show();
				      ShowHint("Hint_YZM", "err", "图片验证码输入错误，请重新输入");
	                  changeImg();
	                  $("#yzmValue").val("");
	                  return;
				 }else{
				     if("03"==result.flag1){
				         $("#t12").show();
				         $("#t11").show();
				     }
				     iPoint = window.setInterval("setTimeIdentity()", 1000);
			         $("#spTime").show();
			         $("#btnSendMobileCode").attr("disabled", "disabled");
			         $("#btnSendMobileCode").hide();
				 }
             }
         });
         sendM="02";
    }
    
     //实名认证 发验证码倒数
     function setTimeIdentity() {
         var TimeNow = $("#spTime").val() == "" ? 120 : parseInt($("#spTime").val());
         $("#spTime").val((TimeNow - 1) + "秒后重新获取");
         if (TimeNow <= 0) {
             window.clearInterval(iPoint);
             changeImg();
             //$("#yzmValue").val("");
             $("#spTime").hide();
             $("#spTime").val("120秒后重新获取");
             $("#btnSendMobileCode").removeAttr("disabled");
             $("#btnSendMobileCode").show();
         }
     } 
   
   // 验证码手机校验
   function NextStep(){
   
      if("02"!=flagM){
          $("#Hint_Mobile").show();
	      ShowHint("Hint_Mobile", "err", "请输入正确的手机号");
	      $("#txt_Mobile").addClass("on-error");
	      return;
      }
      if("02"!=sendM){
          $("#Hint_MobileCheckCode").show();
          ShowHint("Hint_MobileCheckCode", "err", "请获取短信验证码");
          $("#MobileCheckCode").addClass("on-error");
          return;
      }
     var showT=$("#t12").is(":hidden");
     if("false"==showT){
	     if("02"!=flah13){
	          $("#Hint_indetify").show();
	          ShowHint("Hint_indetify", "err", "请输入15位或18位有效身份证号码!");
	          $("#txt_indetify").addClass("on-error");
	          return;
	     }
     }
     
     if("false"==showT){
          if("02"!=flah12){
	          $("#Hint_realName").show();
	          ShowHint("Hint_realName", "err", "请输入2~6个汉字的真实姓名!");
	          $("#txt_realName").addClass("on-error");
	          return;
          }
     }
    
    if("02"!=flagD){
	   $("#Hint_MobileCheckCode").show();
       ShowHint("Hint_MobileCheckCode", "err", "请输入6位数字短信验证码");
       $("#MobileCheckCode").addClass("on-error");
       return;
	}
     
      
	    var HintCtrl_Id = "Hint_MobileCheckCode";
		var phone=$("#txt_Mobile").val(); 
		var code=$("#MobileCheckCode").val();  
		var txt_realName = $("#txt_realName").val();
		var txt_indetify = $("#txt_indetify").val();
      
       if(""==code||code==null||code.length<6){
           $("#Hint_MobileCheckCode").show();
	       ShowHint("Hint_MobileCheckCode", "err", "请输入6位数字短信验证码");
	       $("#MobileCheckCode").addClass("on-error");
	       return;
       }
		
	    $.ajax({
	 	    async: false,
	 		type: "post",
			url: '${ctx}/smsInfo/valresetPwd',
	 		data: "phone=" + strEnc(phone,'${key}')+"&code="+code+"&txt_indetify="+strEnc(txt_indetify,'${key}')+"&txt_realName="+strEnc(txt_realName,'${key}'),
	 		success: function (msg) {
	 		     if("3"==msg){
	 		        $("#Hint_MobileCheckCode").show();
	 		        ShowHint(HintCtrl_Id, "err", "您的短信验证码已过期,请重新获取!");
	 		        return;
	 		     }else if(msg=="0"){
	 		        ShowHint(HintCtrl_Id, "ok", "");
	 		        window.location.href="${ctx}/account/resetPwd";
	 		     }else if("1"==msg){
	 		        $("#Hint_MobileCheckCode").show();
	 		        ShowHint(HintCtrl_Id, "err", "您输入的短信验证码错误!");
	 		        return;
	 		     }else if("5"==msg){
	 		         $("#Hint_realName").show();
	 		         ShowHint("Hint_realName", "err", "您输入的实名信息有误请确认后重新输入!");
	 		        return;
	 		     }
	 		      else if("link"==msg){
	 		         $("#Hint_MobileCheckCode").show();
	 		         warnMsg("本次短信验证码尝试次数过多，请重新获取验证码！","关闭");
	 		        return;
	 		     }
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
    function ShowInputHint(ctrl, hintType) {
        $(ctrl).removeClass("on-focus");
        $(ctrl).removeClass("on-error");
        if (hintType == "foc") {
            $(ctrl).addClass("on-focus");
        } else if (hintType == "err") {
            $(ctrl).addClass("on-error");
        }
    }
    
  function inputColor(ctrl,ftType){
        $(ctrl).css({"color":"#666"});
        if (ftType == 'black') {
          $(ctrl).css({"color":"#ccc"});
        }
    }
  
  function changeImg(){    
    var imgSrc = $("#imgObj");    
    var src = "${ctx}/authimg?codeType=msCode&now="+Math.random();   
    imgSrc.attr("src",src);    
  }
  
   
</script>		
<body>
<div class="warp">
<%@ include file="../header.jsp"%>
	<div class="warp">
    <div class="container">
        <!--步骤-->
        <div class="mod-step step-top">
            <img src="${resource_dir}/images/step123_06.png" title="" alt="">
        </div>
        <!--步骤结束-->
        <div class="ui-content bg-password">
            <table cellspacing="0" cellpadding="0" border="0" class="ui-table-3" width="100%">
                <tbody>
                    <tr>
                        <th width="17%" height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>您注册的手机号：
                        </th>
                        <td width="83%">
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" maxlength="11" id="txt_Mobile" name="txt_Mobile" style="color:#ccc;" class="ui-input" value="请输入您的手机号" defaultval="请输入您的手机号">
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_Mobile">
                                </div>
                            </div>
                        </td>
                    </tr>
                    
                    <tr id ="t12" style="display: none;">
                        <th width="17%" height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>真实姓名：
                        </th>
                        <td width="83%">
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" maxlength="10" id="txt_realName" name="txt_realName" style="color:#ccc;" class="ui-input" value="请输入您的真实姓名" defaultval="请输入您的真实姓名">
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_realName">
                                </div>
                            </div>
                        </td>
                    </tr>
                    
                     <tr  id ="t11" style="display: none;">
                        <th width="17%" height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>身份证号：
                        </th>
                        <td width="83%">
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" maxlength="18" id="txt_indetify" name="txt_indetify" style="color:#ccc;" class="ui-input" value="请输入您的身份证号" defaultval="请输入您的身份证号">
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_indetify">
                                </div>
                            </div>
                        </td>
                    </tr>
                    
                    
                    <tr>
                        <th width="17%" height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>图片验证码：
                        </th>
                        <td width="83%">
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" maxlength="4" id="yzmValue" name="yzmValue" style="color:#ccc;width:200px;" class="ui-input" value="请输入图片验证码" defaultval="请输入图片验证码">
                                    <img id="imgObj" class="yzm" title="看不清?请点击" style="cursor: pointer;padding-left:20px;padding-top:5px;" onclick="changeImg()" src="${ctx}/authimg?codeType=msCode"/>
                                </div>
                                
                                <div class="tips-error-1" style="display: none" id="Hint_YZM">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码：
                        </th>
                        <td>
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" maxlength="6" id="MobileCheckCode" name="MobileCheckCode" class="ui-input w-100" value="请输入短信验证码" defaultval="请输入短信验证码" style="color:#ccc;"  >
                                </div>
                                <div class="ui-code">
                                    <input type="button" value="获取验证码 " id="btnSendMobileCode" onclick="sendMobileCheckCode()" class="ui-code-button">
                                    <input id="spTime" style="display: none;width:110px;"  type="button" value="120秒后重新获取 " class="ui-code-sent">
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_MobileCheckCode">
                                </div>
                                <span id="newPhoneIden"></span>
                            </div>
                    </td></tr>
                    <tr>
                        <th height="70" align="right" valign="middle">&nbsp;
                            
                        </th>
                        <td valign="bottom">
                            <input type="button" onclick="NextStep();" value="下一步" class="ui-button-1" name="">
                        </td>
                    </tr>
                    <tr>
                        <th height="30" align="right" valign="bottom">&nbsp;
                            
                        </th>
                        <td valign="bottom">
                            <div class="ui-table-ts">
                                没有账号，<a href="${ctx}/baseInfo/register" class="blue">快速注册&gt;&gt;</a></div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@ include file="../foot.jsp"%>
</body>
</html>

