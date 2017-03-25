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
	</head>
	
<script type="text/javascript">
      //实名认证 发验证码倒数
     function setTimeIdentity() {
         var TimeNow = $("#spTime").text() == "" ? 5 : parseInt($("#spTime").text());
         if(TimeNow!=0){
           $("#spTime").text((TimeNow - 1));
         }
         if (TimeNow <=0) {
             window.location.href="${ctx}/baseInfo/login";
         }
     }
</script>	
	
<body>
<div class="warp">
<%@ include file="../header.jsp"%>
<div class="warp">
  <div class="container"> 
    <!--步骤-->
    <div class="mod-step step-top">
      <img src="${resource_dir}/images/step123_10.png" title="" alt="">
    </div>
    <!--步骤结束-->
    <div class="ui-content" style="margin: 50px 0px 110px; ">
      <div class="mod-result">
        <div class="result-content">
           <div class="result-content" style="padding: 0 50px 0 10px; background: url('${resource_dir}/images/sucess_icon.png') no-repeat 10px 0 ; ">
          <p class="title orange" style="padding-left:105px;padding-top:20px;">密码修改成功，请重新登录！</p>
          <p class="result-link" style="padding-left:125px;padding-top:20px;font-size: 14px;">
            <a href="${ctx}/baseInfo/login" class="blue">返回登录</a>
          </p>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="../foot.jsp"%>
</body>
</html>