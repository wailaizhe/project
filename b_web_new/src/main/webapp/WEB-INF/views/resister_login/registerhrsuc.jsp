<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<html>
<head>
    <title>晋城农商银行——注册成功</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/register.css">
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.4.4.min.js"></script>
</head>
<script type="text/javascript">
  function goWindow(){
   window.location.href="${ctx}/item/index";
  }

</script>
<body class="gray-bg">
 <%@ include file="../header.jsp" %>	
 


<!--注册开始-->
<div class="reg_section">
	<h3 class="reg">
    	<i><img src="${resource_dir}/images/username.png"/></i>
         <em>用户注册：</em>
    </h3>
    <div class="reg_head2">
    	<h3></h3>
    </div>
    <div class="reg_main">
    	<h3 class="suc"><i><img src="${resource_dir}/images/sucess_icon.png"/></i>恭喜你,注册成功！</h3>
        <div class="suc_btn">
        	<a href="${ctx}/item/gotoInvestmentList">去 赚 钱</a>
        </div>
        <div class="return">
        	<a href="${ctx}/item/index">返回首页</a>
        </div>
    </div>
</div>
<!--注册结束-->




<%@ include file="../foot.jsp" %>
</body>
</html>