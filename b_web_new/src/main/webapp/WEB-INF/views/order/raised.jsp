<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<TITLE>蒲公英金融服务平台——投资结果</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css" />
		<link href="${resource_dir}/css/header_footer.css" rel="stylesheet" type="text/css">
        <link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css">
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
				<h3><img src="${resource_dir}/images/chaomu_icon.png" />购买超募!</h3>
		         
		          <p class="sucess_tip" style="padding-left:350px;padding-top:30px;padding-bottom: 20px;">超募资金将在1-3个工作日内返回至您的银行卡！</p>
		        
		        <div class="pro-sucess_btn" style="margin-left: 280px;"><a href="${ctx}/account/investment_newList" class="sucess_btn">查看投标状态</a><a href="${ctx}/item/gotoInvestmentList" >继续购买</a>
		        </div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../foot.jsp"%>
</body>
</html>