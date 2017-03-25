<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<TITLE>蒲公英金融服务平台——个人信息</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css" />
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/ucsvalidate.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
	</head>
		
<body>
<div class="warp">
<%@ include file="../header.jsp"%>
	<div class="warp">
    <div class="container">
        <!--步骤-->
        <div class="mod-step step-top">
            <img src="../images/step123_06.png" title="" alt="">
        </div>
        <!--步骤结束-->
        <div class="ui-content bg-password">
            <table cellspacing="0" cellpadding="0" border="0" class="ui-table-3" width="100%">
                <tbody>
                    <tr>
                        <th width="17%" height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>您的注册手机号：
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
                    <tr>
                        <th height="70" align="right" valign="middle">
                            <span class="red">*&nbsp;</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码：
                        </th>
                        <td>
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input type="text" maxlength="6" class="ui-input w-100" value="请输入验证码" defaultval="请输入验证码" style="color:#ccc;" id="MobileCheckCode" name="Code" validate="{required:true,remote:{url:'/Account/ValidateMobileCheckCode',data:{SessionName:'FindPwd',CheckCode:function(){return $('#MobileCheckCode').val()}}},messages:{required:'请填写验证码',remote:'验证码有误'}}">
                                </div>
                                <div class="ui-code">
                                    <input type="button" value="获取验证码" id="btnSendMobileCode" onclick="sendMobileCheckCode()" class="ui-code-button">
                                    <input id="spTime" style="display: none" type="button" value="60秒后获取" class="ui-code-sent">
                                </div>
                                <div class="tips-error-1" style="display: none" id="Hint_MobileCheckCode">
                                </div>
                            </div>
                    </td></tr>
                    <tr>
                        <th height="70" align="right" valign="middle">&nbsp;
                            
                        </th>
                        <td valign="bottom">
                            <input type="button" onclick="NextStep();" value="下一步" class="ui-button-1" name="">
                            <a href="/Account/FindPwd" class="blue">重新选择验证方式</a>
                        </td>
                    </tr>
                    <tr>
                        <th height="30" align="right" valign="bottom">&nbsp;
                            
                        </th>
                        <td valign="bottom">
                            <div class="ui-table-ts">
                                没有账号，<a href="Register" class="blue">快速注册&gt;&gt;</a></div>
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

