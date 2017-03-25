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
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css" />
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/ucsvalidate.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
	</head>
		
<body>
<div class="warp">
<%@ include file="../header.jsp"%>
	
	  <div class="container"> 
	    <div class="mod-step step-top"> <img src="${resource_dir}/images/step123_03.png" title="" alt=""> </div>
	    <div class="ui-set-change">
	      <div class="set-item">
	        <table cellspacing="0" cellpadding="0" border="0" class="ui-table-2">
	          <tbody>
	            <tr>
	              <th align="center" valign="middle"><img src="${resource_dir}/images/icon_phone.png"></th>
	              <td width="72%"><h4 class="title-2">通过手机验证找回<img alt="" src="${resource_dir}/images/icon_tj.png" name=""></h4></td>
	              <td align="center" width="17%" valign="middle">
	              <input type="button" onclick="window.location.href='${ctx}/account/getBackPwdByMobile'" value="立即找回" class="ui-button-3" name=""></td>
	            </tr>
	          </tbody>
	        </table>
	      </div>
	      
	    </div>
	  </div>
	</div>
<%@ include file="../foot.jsp"%>
</body>
</html>

