<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>借款申请</title>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/list_v2.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/index.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css">
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript">
	function jumpToLoanDetail(){
			window.location.href="${ctx}/item/gotoLoanDetail";
	}
</script>
	</head>

	<body>

		<%@ include file="../header.jsp"%>

		<!--投资列表部分-->

		<div class="list_m">
			<div class="list_nav">
				<a href="${ctx}/item/index">首页</a> &nbsp;&gt;&nbsp;
				<a href="${ctx}/item/gotoLoanList">我要借款</a> &nbsp;&gt;&nbsp;借款申请
			</div>

			<div class="warp">
				<div class="container">
					<div class="ui-content">
						<div class="breadcrumb">
							<div class="pay-ok">
								<div class="financing-table">
									<h3 class="title_1">
										${registerType}网络贷款申请
									</h3>
									<div class="content">
										<div class="sqxx">
											<div class="sqts">
												您好，
												<span class="blue">${mobilePhone}</span>！
												<p>
													您已阅读并接受
													<a class="xY blue"  href="javascript:jumpToLoanDetail()" target="_blank" >${content}</a>
													约束，并选择委托银行代为发布融资项目信息，请与您的客户经理联系。
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../foot.jsp"%>
	</body>
	<script type="text/javascript">
		$('.nav ul li a').each(function(i){
		   if(i==2){
				$(this).parent().addClass('current');
		        $(this).parent().siblings("li").removeClass("current");
		   }
		});
	</script>
</html>
