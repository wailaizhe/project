<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>

		<title>借款申请</title>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/jiekuan_v2.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/list_v2.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/index.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css">
		<link rel="stylesheet" href="${resource_dir}/css/easydialog.css" type="text/css"/>
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
		<script type="text/javascript">
	function jumpToLoanEntry(){
	
		if($(".xieyi").attr("checked") == false){
			warnMsg('请勾选同意协议','确定');
		}else if($(".xieyi").attr("checked") == true){
			window.location.href="${ctx}/item/gotoLoanEntry";
		}
	}
	
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
			<div class="jk_main">
				<div class="jk_head">
					<h2>
						${registerType}网络贷款申请
					</h2>
				</div>
				<div class="jk_m">
					<p>
						您好，${mobilePhone}
					</p>
					<p>
						您是第一次使用晋城农商银行金融服务平台，为保证您的相关权益，请进行如下操作 :
					</p>
					<h3>
					</h3>
					<p class="lit_main">
						<input type="checkbox" class="xieyi" value="1" />
						我已阅读并同意
						<a href="javascript:jumpToLoanDetail()" >${content}</a>
					</p>
					<!-- 
					<h3>
						第二步 : 选择申请方式
					</h3>
					<p class="lit_main">
						<input type="radio" type="checkbox" />
						委托银行代为发布
						<br />
						<input type="radio" type="checkbox" />
						自行申请
					</p>
					<br />
					<br />
					<h3>
						第三步 : 联系方式
					</h3>
					<p class="lit_main">
						手机 : 18612367135
						<br />
						邮箱 : 543186929@qq.com
					</p>
					<br /> -->


				</div>
				<div class="jk_btn">
					<a href="javascript:jumpToLoanEntry();" class="ui-button2 w-200">确认</a>
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
