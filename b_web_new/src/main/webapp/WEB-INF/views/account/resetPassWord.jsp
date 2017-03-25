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
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/ucsvalidate.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>
	</head>
	
<script type="text/javascript">
   
    var flagM="01";
    $("#txt_Password").live("focus", function () {
           //$("#Password_Note").hide();
           $("#Hint_Password").hide();
           $("#txt_Password").removeClass("on-error");
    }).live("blur", function () {
        if($(this).val()==""){
          //$("#Password_Note").show();
          $("#Hint_Password").show();
          ShowHint("Hint_Password", "err", "新密码不能为空！");
          $("#txt_Password").addClass("on-error");
          return;
        }else{
            var Password = $("#txt_Password").val();
	        //var reg = /^^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@@#$%^&]))[\dA-Za-z!@@#$%^&]{6,16}/;
	        var reg=new RegExp("(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{2,})$");
	        if(!reg.test(Password) || Password.length < 6 || Password.length > 16||Password.indexOf(" ")>=0) {
	            $("#Hint_Password").show();
	            ShowHint("Hint_Password", "err", "密码为6-16个字母、数字的组合！");
	            $("#txt_Password").addClass("on-error");
	            return false;
	        }
        }
        flagM="02"; 
    });
    
    
    
    var flagP="01";
    $("#txt_Password2").live("focus", function () {
          // $("#Password2_Note").hide();
           $("#Hint_Password2").hide();
           $("#txt_Password2").removeClass("on-error");
           var txtPass = $("#txt_Password").val();
	       if(txtPass==""){
	             $("#Hint_Password").show();
	             ShowHint("Hint_Password", "err", "新密码不能为空！");
	             $("#txt_Password").addClass("on-error")
	             return;
	       }
    }).live("blur", function () {
        if($(this).val()==""){
          //$("#Password2_Note").show();
          $("#Hint_Password2").show();
          ShowHint("Hint_Password2", "err", "确认密码不能为空！");
          $("#txt_Password2").addClass("on-error")
          return;
        }else{
            var txt_Password = $.trim($("#txt_Password").val());
            var Password2 = $.trim($("#txt_Password2").val());
	        if(txt_Password!=Password2){
	                $("#Hint_Password2").show();
	                ShowHint("Hint_Password2", "err", "*两次输入密码需要一致！");
                    $("#txt_Password2").addClass("on-error")
                    return;
	        }
        }
        flagP="02"; 
    });
    
        
    function Submit(){
            var txt_Password = $("#txt_Password").val();
            var Password2 = $("#txt_Password2").val();
            var reg=new RegExp("(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{2,})$");
	        if(!reg.test(txt_Password) || txt_Password.length < 6 || txt_Password.length > 16||txt_Password.indexOf(" ")>=0){
	           $("#Hint_Password").show();
               ShowHint("Hint_Password", "err", "密码为6-16个字母、数字的组合");
               $("#txt_Password").addClass("on-error");
               return;
	        }
            
            if(txt_Password!=Password2){
                 $("#Hint_Password2").show();
                 ShowHint("Hint_Password2", "err", "两次输入密码需要一致");
                 $("#txt_Password2").addClass("on-error")
                 return;
            }
            txt_Password = $.trim(txt_Password);
            Password2 = $.trim(Password2);
            $.ajax({
		 	    async: false,
		 		type: "post",
	 		    url: '${ctx}/account/findPassWord',
		 		data: "Password="+strEnc(Password2,'${key}')+"&txt_Password="+strEnc(txt_Password,'${key}'),
		 		success: function (msg) {
		 		    if("3"==msg){
		 		       alert("您的验证码已过期！");
		 		       return;
		 		    }
		 		    if("1"==msg){
		 		       alert("您的验证码错误，请返回重试！");
		 		       return;
		 		    }
		 		    if("err"==msg){
		 		       alert("密码修改失败！");
		 		       return;
		 		    }
		 		    if("ok"==msg){
		 		      window.location.href="${ctx}/account/resetPwdSuc";
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
    function SetInputFont(ctrl, ftType) {
        $(ctrl).removeClass("f-6");
        if (ftType == 'black') {
            $(ctrl).addClass("f-6");
        }
    } 
</script>	
	
<body>
<div class="warp">
<%@ include file="../header.jsp"%>
<input type="hidden" id="code" name="code"  value="${code}"/>
	<div class="warp">
    <div class="container">
        <!--步骤-->
        <div class="mod-step step-top">
            <img src="${resource_dir}/images/step123_09.png" title="" alt="">
        </div>
        <!--步骤结束-->
        <div class="ui-content">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="ui-table-3">
                <tbody>
                    <tr>
                        <th align="right" width="17%" valign="middle" height="70">
                            <span class="red">*&nbsp;</span>新&nbsp;&nbsp;密&nbsp;&nbsp;码：
                        </th>
                        <td width="83%">
                            <div class="ui-out-box mod-Password1">
                                <div class="ui-input-box">
                                    <input type="password" id="txt_Password" name="txt_Password"  class="ui-input" maxlength="16"/>
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_Password">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th align="right" width="17%" valign="middle" height="70">
                            <span class="red">*&nbsp;</span>确认密码：
                        </th>
                        <td width="83%">
                            <div class="ui-out-box mod-Password2">
                                <div class="ui-input-box">
                                    <input type="password" id="txt_Password2" name="txt_Password2" class="ui-input" maxlength="16"/>
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_Password2">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th align="right" valign="middle" height="70">
                            &nbsp;
                        </th>
                        <td valign="bottom">
                            <input type="button" name="" class="ui-button-1" value="确&nbsp;&nbsp;认" onclick="Submit();">
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