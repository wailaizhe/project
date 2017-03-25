<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.net.*" %>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>惠贷款-晋城农商银行蒲公英金融服务平台</title>
	<meta name="description" content="晋城农商银行晋城农村信用社蒲公英金融服务平台p2p投融资平台"/>
	<meta name="keyword" content="晋城农商银行,晋城农村信用社,蒲公英金融服务平台,p2p投融资平台"/>
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/loan.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/demo.css">
	<link rel="stylesheet" href="${resource_dir}/css/easydialog.css" type="text/css"/>
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/jquery.easydropdown.js"></script>
</head>
<script type="text/javascript">
	function gotoLoan(flag)
	{
		//window.location.href="${ctx}/invest/saveLoan?loanObject="+flag;
	}	
	
		//判断是否登陆   更改申请提示
		var data1;
		/* $(function(){
	  		$.ajax({
		        url: '${ctx}/account/isLand?now='+new Date(),
		        async:false,
		        success: function(data) {
		             data1 =data;
		        }
			 });
		     if(data1=="03"||data1.length>20){
		          //$("#button").html('<a href="javascript:login()">登录立即申请</a>');
		        $('a:contains("立即申请")').html("登录立即申请");
			          
		      }else{
		      	 // $("#button").html('<a href="javascript:chick()">立即申请</a>');
		      }
		 }) */
</script>
<body>
	
<%@ include file="../index/header.jsp" %>
	
	<!--banner开始-->
<div class="banner_section">
	<div class="banner">
    	<img src="${resource_dir}/images/life_banner.jpg"/>
    </div>
</div>

<!--产品介绍开始-->
<div class="loan_pro">
	<div class="pro_head">
    	<h3>产品介绍</h3>
    </div>
    <div class="pro_main">
    	<ul>
        	<li class="pj">
            	<img src="${resource_dir}/images/pj.png"/>
                <div class="pj_btn">
                	<a onclick="gotoLoan('01');">立即申请</a>
                </div>
                <div class="pj_main">
                	<p><em>贷款对象：</em><i>优质商业承兑汇票的持票人,优质银行承兑汇票的持票人</i></p>
                </div>
            </li>
        	<li class="xw">
            	<img src="${resource_dir}/images/xw.png"/>
                <div class="xw_btn">
                	<a onclick="gotoLoan('02');">立即申请</a>
                </div>
                <div class="pj_main">
                	<p><em>贷款对象：</em><i>使用银联或第三方支付公司收单服务的商户</i></p>
                </div>
            </li>
        	<li class="gw">
            	<img src="${resource_dir}/images/gw.png"/>
                <div class="gw_btn">
                	<a onclick="gotoLoan('03');">立即申请</a>
                </div>
                <div class="pj_main">
                	<p><em>贷款对象：</em><i>国家行政机关公务人员,事业单位工作人员</i></p>
                	<p><em>贷款额度：</em>30万元</p>
                </div>
            </li>
        	<li class="dy">
            	<img src="${resource_dir}/images/dy.png"/>
                <div class="dy_btn">
                	<a onclick="gotoLoan('04');">立即申请</a>
                </div>
                <div class="pj_main">
                	<p><em>贷款对象：</em><i>个体工商户,白领</i></p>
                	<br><br>
                	<p><em>贷款额度：</em>30万元</p>
                </div>
            </li>
        </ul>
    </div>
</div>
<!--申请流程-->
<div class="apply">
	<div class="apply_head">
    	<h3>申请流程</h3>
    </div>
    <div class="yb_apply">
    	<img src="${resource_dir}/images/apply.png"/>
    </div>
</div>
<%@ include file="../index/foot.jsp" %>
</body>
</html>
