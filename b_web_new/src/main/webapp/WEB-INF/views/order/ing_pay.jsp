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
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css" />
		<link href="${resource_dir}/css/header_footer.css" rel="stylesheet" type="text/css"/>
        <link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/ucsvalidate.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
	</head>
		
<body>
<div class="warp">
<%@ include file="../header.jsp"%>
<div class="warp">
	<div class="container">
		<div class="ui-content">
			<div class="breadcrumb"></div>
			<h2 class="mod-object-title"><div id="sflex03" class="stepflex ">
								<dl class="first doing">
									<dt class="s-num ">1</dt>
									<dd class="s-text">确认投标金额<s></s><b></b></dd>
									<dd></dd>
								</dl>
								<dl class="normal doing">
									<dt class="s-num">2</dt>
									<dd class="s-text">确认支付<s></s><b></b></dd>
								</dl>
								<dl class="normal  doing">
									<dt class="s-num">3</dt>
									<dd class="s-text">投资结果<s></s><b></b></dd>
								</dl>
							</div></h2>
			<div class="pay-ok">
				<h3><img src="${resource_dir}/images/clz.png"/>您的订单正在处理中... </h3>
				<div class="pay-lose-textcenter" style="margin-left:320px;margin-top: -10px;">
					<p class="check">如需确认是否投标成功，请您进入账户中心查看投标状态！</p>
					<p><span class="f-left">您现在可以：</span><a href="${ctx}/account/investment_newList">查看投标状态</a><br/><a href="${ctx}/item/index" class="pay-ok-bgblue">返回首页</a></p>
				</div>
				
			</div>
		</div>
	</div>
</div>
<%@ include file="../foot.jsp"%>
</body>
</html>

