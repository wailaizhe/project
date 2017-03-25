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
        <h3 class="r_title">名词解释</h3>
        <div class="centent-nr">
            <br />
            <div class="help-node">
                <h5>
                    <a href="javascript:void(0)">在平台投资前，我需要了解哪些项目名词？</a></h5>
                <div>
                    <span></span>
                    <table cellpadding="0" cellspacing="0" class="ui-table-help1">
                        <tr>
                            <th>
                                投融资服务
                            </th>
                            <td>
                                由平台向投资人及融资人提供的服务，主要包括：融资信息发布、交易撮合、由平台指定的第三方支付机构进行交易资金划付等。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                预期年化收益率
                            </th>
                            <td>
                                指本次交易由融资人发布的回购利率或投资回报率，以预期年化收益率表示。计算公式为年化收益率=（投资内收益/本金）/（投资天数/360）×100%。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                支付/兑付账户
                            </th>
                            <td>
                                支付投资金额及兑付项目到期后的本金及收益的账户。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                一次性还本付息
                            </th>
                            <td>
                                平台将项目产生的本金及收益在项目到期日一次性兑付给投资人。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                项目发行规模
                            </th>
                            <td>
                                融资方所发布项目所需的总融资金额。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                投资金额
                            </th>
                            <td>
                                本次交易由投资人成功支付并与融资人达成有效交易的本金金额。（人民币币种）
                            </td>
                        </tr>
                        <tr>
                            <th>
                                投资期限
                            </th>
                            <td>
                                指自投资人起息日起至到期日止的期间。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                项目最迟起息日
                            </th>
                            <td>
                                投资项目真正生效并开始计算利息的最后期限。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                项目到期日期
                            </th>
                            <td>
                                投资项目结束的日期。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                融资用途
                            </th>
                            <td>
                                融资主体融资资金的使用用途。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                工作日
                            </th>
                            <td>
                                根据《中华人民共和国劳动法》规定的工作时间。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                还款方式
                            </th>
                            <td>
                                指融资方还款的方式，目前仅限于"一次性到期还款" 方式，投资人将按照融资方的还款方式获得收益，《项目说明书》另有规定的除外。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                最小投资单位
                            </th>
                            <td>
                                指本次交易投资人最低出资限额，投资人可按照该限额的整数倍增加投资金额。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                预热
                            </th>
                            <td>
                                为便于用户提前了解，项目在投标开始前将会提前发布，即为预热。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                投标期间
                            </th>
                            <td>
                                本平台发布融资方项目信息时公布投资人投标的起止时间。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                满标
                            </th>
                            <td>
                                在投标结束日期前投资项目完成100%的资金募集。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                完成
                            </th>
                            <td>
                                项目在投标结束时间后即为完成状态，项目在完成状态时无法投标。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                已投标，待起息
                            </th>
                            <td>
                                投资人投资项目并支付成功，但项目还没有到达起息日，尚未开始计算利息。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                投标成功
                            </th>
                            <td>
                                投资人投资支付成功且项目募集期结束、该项目确认正式成立后，即视为投标成功。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                兑付完成
                            </th>
                            <td>
                                成功兑付投资人投资项目的本金和相关收益。
                            </td>
                        </tr>
                        <tr>
                            <th>
                                专项融资项目
                            </th>
                            <td>
                                为满足特定投资人、融资人的个性化需求成立的专属性项目，目前只对拥有专项识别码的投资人开放投标。
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%@ include file="../foot.jsp" %>
</body>
</html>
