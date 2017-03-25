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
                <li>
                	<a href="questionlist1.jsp">平台介绍</a>
                </li>
                <li>	
                	<a href="questionlist2.jsp">平台公告</a>
                </li>
                <li>
                	<a href="questionlist18.jsp">安全保障</a>
                </li>
                <li class="current">
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
<div class="dt-centent">
    <h1>
        <span>
            <h3>蒲公英金融服务平台</h3>
            <i class="dt_icon"></i>
        </span>
        <a href="questionlist4.jsp">返回</a>
    </h1>
    <div class="centent-dt">
        <h2>快捷支付用户协议</h2>
        <p>1.您确认，在您使用本快捷支付服务（以下简称“本服务“）时，您是具有中华人民共和国法律规定的完全民事权利能力和民事行为能力的，能够独立承担民事责任的自然人（中华人民共和国境内（香港、澳门除外）的用户应年满18周岁），或者是在中国大陆地区合法开展经营活动或其他业务的或其他组织；本协议内容不受您所属国家或地区法律的排斥。不具备前述条件的，您应立即终止使用本服务。</p>
        <p>2.本协议条款与您的权益具有或可能具有重大关系，请您在同意接受本服务前确认，您已经充分阅读、理解并接受本协议的全部内容，一旦您选择本服务，即表示您同意遵循本协议的所有约定。 </p>
        <p>3.您知晓，您选择使用的本服务要求您提供个人的支付信息，您需保证您所提供的所有信息是真实的、合法的、正确的、完整的。本协议所指支付信息是指您使用本服务时需要提供的个人信息，包括但不限于账户名、密码、个人姓名、身份证号码、银行卡号等。</p>
        <p>4.您同意，为了提供本服务的技术需要，本公司有权采集、获取或在系统内保存您的部分支付信息。</p>
        <p>5.本公司将严格确保您的个人信息和支付信息的安全。 </p>
        <p>6.您知晓，您在使用本服务时应当认真确认交易信息，包括且不限于产品名称、份数、金额等，并按平台业务流程发出符合《快捷支付协议》约定的指令。您认可和同意：确认交易信息已不可撤销地向本公司的支付系统发出指令，本公司有权根据您的指令委托银行或第三方从您绑定的银行卡中将您确认的交易资金划扣给收款人。您不应以非本人意愿交易或其他任何原因要求退款或承担其他责任。 </p>
        <p>7.您承诺，对使用本服务过程中您发出的所有指令的真实性、有效性承担全部责任；本公司依照您的指令进行操作的一切风险由您自行承担。</p>
        <p>8.您认可，您使用本服务所涉及的账户的使用记录数据、交易金额数据等均以本公司系统平台记录的数据为准。 </p>
         <p>9.您保证，不向其他任何人泄露该支付信息。您知晓，您应妥善保管银行卡、卡号、密码以及您的账号、密码、数字证书等与银行卡或与您的支付账户有关的一切信息。如您遗失银行卡、泄露账户密码或相关信息的，您应及时通知发卡行及/或本公司，以减少可能发生的损失。因泄露密码、数字、丢失银行卡等导致的损失需由您自行承担。 </p>
        <p>10.您认可，在本公司有合理理由怀疑您提供的资料错误、不实、过时或不完整的情况下，本公司有权暂停或终止向您提供部分或全部本服务，您将承担因此产生的一切责任，本公司对此不承担任何责任。</p>
        <p>11.您认可，如果您违反本协议的约定；或违反本网站或其他关联公司网站的条款、协议、规则、通告等相关规定，而被终止提供服务的，本公司有权暂停或终止向您提供部分或全部本服务，您将承担因此产生的一切责任，本公司对此不承担任何责任。 </p>
        <p>12.如您发现有他人冒用或盗用您的账户及密码或任何其他未经合法授权之情形时，应立即以书面方式通知本公司并要求本公司暂停本。本公司将积极响应您的要求，但您理解，对您的要求采取行动需要合理期限，在此之前，本公司对已执行的指令及(或)所导致的您的损失不承担任何责任。 </p>
        <p>13.若您的支付信息变更而您未及时更新资料，导致本服务无法提供或提供时发生任何错误，您不得将此作为取消交易、拒绝付款的理由，您将承担因此产生的一切后果，本公司不承担任何责任。</p>
        <p>14.您使用本服务时同意并认可，可能由于银行本身系统问题、银行相关作业网络连线问题或其他不可抗拒因素，造成本服务无法提供。您确保您所输入的您的资料无误，如果因资料错误造成本公司于上述异常状况发生时，无法及时通知您相关交易后续处理方式的，本公司不承担任何损害赔偿责任。</p>
        <p>15.您同意，基于运行和交易安全的需要，本公司有权暂停提供或者限制本服务部分功能,或提供新的功能，在减少、增加或者变化任何功能时，只要您仍然使用本服务，表示您仍然同意本协议或者变更后的协议。 </p>
        <p>16.您同意，本公司有权随时对本协议内容进行单方面的变更，并以在本网站公告的方式予以公布，无需另行单独通知您；若您在本协议内容公告变更后继续使用本服务的，表示您已充分阅读、理解并接受修改后的协议内容，也将遵循修改后的协议内容使用本服务；若您不同意修改后的协议内容，您应停止使用本服务。</p>
    	<p>17.本协议之效力、解释、变更、执行与争议解决均适用中华人民共和国法律，没有相关法律规定的，参照通用国际商业惯例和（或）行业惯例。 </p>
    	<p>18.因平台提供服务所产生的争议均适用中华人民共和国法律，并由平台运营商所在地有管辖权的人民法院管辖。平台运营商所在地为北京市丰台区。  </p>
    </div>
</div>
	</div>
</div>
<%@ include file="../foot.jsp" %>
</body>
</html>
