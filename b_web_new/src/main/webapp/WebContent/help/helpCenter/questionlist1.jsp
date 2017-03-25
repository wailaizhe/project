<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
 <title>帮助中心</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/index.css" />
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/style_help.css" />
<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/fn_qiantu.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript">
$(function(){
		$('.hpl ul li a').each(function(){
		    if($($(this))[0].href==window.location){
		        $(this).parent().addClass('current');
		        $(this).parent().siblings("li").removeClass("current");
		    }
		});
	})
</script>
</head>
<body class="gray-bg">
<%@ include file="../header.jsp" %>
<div class="helpbanner">
	<img src="${resource_dir}/images/helpbanner.jpg"/>
</div>
<div class="wrap wrap-960">
    	<div class="hpl">
        	<ul>
        	<h3 class="abouticon">关于我们</h3>
                <li class="current">
                	<a href="questionlist1.jsp">平台介绍</a>
                </li>
                <li>	
                	<a href="questionlist2.jsp">平台公告</a>
                </li>
                <li>
                	<a href="questionlist18.jsp">安全保障</a>
                </li>
                <li>
                	<a href="questionlist4.jsp">服务协议</a>
                </li>
        	<h3 class="newicon">新手指引</h3>
                <li>
                	<a href="questionlist3.jsp">名词解释</a>
                </li>
                <li>
                	<a href="questionlist8.jsp">注册登录指引</a>
                </li>
                <li>
                	<a href="questionlist7.jsp">投资操作指引</a>
                </li>
        	<h3 class="wenicon">常见问题</h3>
                <li>
                	<a href="questionlist6.jsp">投资操作问题</a>
                </li>
                <li>
                	<a href="questionlist12.jsp">如何找回密码</a>
                </li>
                <li>
                	<a href="questionlist10.jsp">如何添加银行卡</a>
                </li>
                  <li>
                	<a href="questionlist11.jsp">如何开通无卡支付</a>
                </li>
                <li>
                	<a href="paymentLimit.jsp">快捷支付银行限额</a>
                </li>
            </ul>
        </div>
    <div class="main main2">
<script type="text/javascript">
    $(function () {
        $(".help-node:eq(0)").addClass("open").children("div").slideDown(200);
        $(".help-node h5").click(function () {
            if ($(this).parent(".help-node").attr("class") != "help-node open") {
                $(".help-node").removeClass("open").find("div").slideUp(200);
                $(this).next("div").slideToggle();
                $(this).parent(".help-node").addClass("open");
            }
        });
    })
</script>
        <br />
            <h3 class="r_title">平台介绍</h3>
			<div class="centent-nr">
                <div class="help-node">
                    <h5>
                        <span>1</span><a href="javascript:void(0)">蒲公英金融服务平台是什么？</a></h5>
                    <div>
                        <span></span>
                        <p>
                            蒲公英金融服务平台是全新的互联网投融资服务平台。依托晋城农商银行优质资产，为投融资双方提供一个专业、安全、高效、透明的投融资平台。蒲公英金融服务平台为广大理财者提供良好的投资环境，既能帮助有资金需求的融资者解决燃眉之急，更能帮投资者实现财富的稳健增值。
                        </p>
                    </div>
                </div>
                <div class="help-node">
                    <h5>
                        <span>2</span><a href="javascript:void(0)">蒲公英金融服务平台有什么投资项目？</a></h5>
                    <div>
                        <span></span>
                        <p>
                            平台目前推出“晋优e贷”、“稳盈小票”系列服务。
                            <br/>
                           “晋优e贷”、“稳盈小票”系列服务是晋城农商银行蒲公英金融服务平台推出的互联网投融资服务。以晋城农商银行承诺付款的项目为投资标的，平台为投融资双方提供交易撮合服务，包括但不限于：居间服务、项目信息发布、信息查询、交易组织等。
                        </p>
                    </div>
                </div>
			</div>
            </div>
    </div>
</div>
<%@ include file="../foot.jsp" %>
</body>
</html>
