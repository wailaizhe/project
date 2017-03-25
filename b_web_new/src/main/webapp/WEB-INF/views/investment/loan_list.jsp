<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>

		<title>我要借款</title>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/jkindex_v2.css">
		<link rel="stylesheet" href="${resource_dir}/css/easydialog.css" type="text/css"/>
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
		<script type="text/javascript">
	function jumpToLoanEntry(flag){
	    $.ajax({
	        url: "${ctx}/item/judgeLoanInfo",
	        async: false,
			type: "post",
	        data: "investJson=1",
	        error: function (msg) { warnMsg("网络链接异常，请稍后再试！",'确定'); },
	        success: function (msg) {
	
	                if(msg == '1'){
	                	if(flag == msg){
	                		window.location.href="${ctx}/item/gotoLoanInit";
	                	}else{
	                		warnMsg('请申请个人网络贷款','确定');
	                	}
	                }
	                 if(msg == '2'){
	                	if(flag == msg){
	                		window.location.href="${ctx}/item/gotoLoanInit";
	                	}else{
	                		warnMsg('请申请企业网络贷款','确定');
	                	}
	                }
	                if(msg == '3'){
	                	warnMsg('请先登录再申请网络贷款','确定',loginFun);
	                	
	                }
	         }
	    });
	}
	function loginFun(){
		window.location.href="${ctx}/item/gotoLoanInit";
	}
</script>

	</head>

	<body>

		<%@ include file="../header.jsp"%>

		<!--投资列表部分-->
			<div class="jk">
				<div class="jk_main">
					<div class="jk_left">
						<div class="jkl_head">
							<img src="${resource_dir}/images/qy.png" />
						</div>
						<p>
							企业网络贷款是平台推出针对企业在银行的授信额度融资业务。金融服务平台引导投资者的资本流向这些有投资价值的企业，推动产业发展，同时带给投资者更高的回报。
						</p>
						<div class="sq_btn">
							<a href="javascript:jumpToLoanEntry(2);">立即申请</a>
						</div>
					</div>
					<div class="jk_right">
						<div class="jkr_head">
							<img src="${resource_dir}/images/gr.png" />
						</div>
						<p>
							个人网络贷款是指符合条件的平台个人用户委托金融服务平台发起用于 个人消费、生产经营 等用途的融资业务。                      
						</p>
						<div class="sq_btn">
							<a href="javascript:jumpToLoanEntry(1);">立即申请</a>
						</div>
					</div>
				</div>
			</div>
		<%@ include file="../foot.jsp"%>
	</body>
</html>
