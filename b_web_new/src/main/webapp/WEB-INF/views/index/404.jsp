<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>404报错</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/404.css"/>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
</head>
<body>
  <div class="bc">
    <span>您打开的页面不存在，休息一下！</span>
    <div class="gn">
      <a href="${ctx}/item/index" style="background:url(${resource_dir}/images/home.jpg) no-repeat;">返回首页</a>
    </div>
  </div>
</body>
</html>
