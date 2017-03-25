<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>蒲公英金融服务平台——邮箱激活提示</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css">
<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
</head>
<script type="text/javascript">
   $(function () {
      window.setInterval("setTimeIdentity()", 1000);
   });
       
   function setTimeIdentity() {
         var TimeNow = $("#spTime").text() == "" ? 5 : parseInt($("#spTime").text());
         if(TimeNow!=0){
           $("#spTime").text((TimeNow - 1));
         }
         if (TimeNow <=0) {
              window.location.href="${ctx}/item/index";
         }
     }
</script>	
<body>
<%@ include file="../header.jsp"%>
<div class="container">
  <div class="mailsucess">
    <h3>邮箱激活提示</h3>
    <p class="clearfix" ><img src="${resource_dir}/images/smiley.png" width="64" height="64"  alt=""/><span class="maxword">您的邮箱激已激活，请勿重复激活！</span></p>
    <div><b class="red" id="spTime">5</b> 秒钟之后将自动跳转至首页界面，或者直接<a href="${ctx}/item/index">点击此处</a>跳转</div>
  </div>
</div>
<%@ include file="../foot.jsp"%>
</body>
</html>

