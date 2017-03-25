<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
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
        <h3 class="r_title">安全保障</h3>     
        <div class="centent-nr">
            <div id="help-content" class="help-content">
                <br />
                <div class="help-node">
                    <h5>
                        <span>1</span><a href="javascript:void(0)">使用金融服务平台的融资资产是否可靠安全？</a></h5>
                    <div>
                        <span></span>
                        <p>
                            平台将从以下方面为用户提供全方位安全的服务：<br />
                            （1）<strong>银行信息见证：</strong>本平台上所有发布的项目都经过晋城农商银行严格的审核见证，见证审核资料包括但不限于营业执照、组织机构代码证、银行开户许可证、银行授信、授信抵押方式、经营场所、人民银行征信记录、近年财务报表等并向投资人全部或部分披露上述见证信息。<br />
                            （2）<strong>交易资金安全：</strong> 晋城农商银行对平台进行交易资金监管，同时第三方支付机构中金支付有限公司对平台上交易的资金进行严格的管理。中金支付有限公司成立于2010年2月4日，注册资金 1亿元，是中金金融认证中心有限公司（即中国金融认证中心，CFCA）的全资子公司。中金支付有限公司依托中国金融认证中心的风险控制技术，从交易、资金、隐私、风险4个方面进行全方位实施监控，为平台资金交易保驾护航。<br />
                        </p>
                    </div>
                </div>
                <div class="help-node">
                    <h5>
                        <span>2</span><a href="javascript:void(0)">使用金融服务平台的投资账户信息是否安全？</a></h5>
                    <div>
                        <span></span>
                        <p>
                            平台的注册及银行卡绑定平台会通过向用户手机号发送短信验证码的方式确定该手机号码是否为用户本人所持有。平台支持安全套接层协议和128位加密技术，所有用户在进行敏感信息操作时，信息将自动加密后安全发送。网站间页面跳转、数据发送采用数字签名技术保证信息及其来源的不可否认性。</p>
                    </div>
                </div>
                <div class="help-node">
                    <h5>
                        <span>3</span><a href="javascript:void(0)">我在蒲公英金融服务平台提供的信息数据是否会保密？</a></h5>
                    <div>
                        <span></span>
                        <p>
                            您的用户信息保密会严格按《平台注册服务协议》、《投资人服务协议》、《快捷支付服务协议》执行。详细描述参考协议相关条款。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
<%@ include file="../foot.jsp" %>
</body>
</html>
