<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<c:set var="ctx" value="<%=request.getContextPath()%>"/>
<c:set var="resource_dir" value="${ctx}/resources" />
<c:set var="key" value="@@#$!==1" />
<script type="text/javascript">
   if (window!=top) // 判断当前的window对象是否是top对象
   top.location.href =window.location.href; // 如果不是，将top对象的网址自动导向被嵌入网页的网址
</script>