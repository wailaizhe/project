<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%
	String qes = (String)request.getParameter("q");
%>
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
                <li>
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
                <li class="current">
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
var q = "<%=qes%>";
    $(function () {
        //$(".help-node:eq(0)").addClass("open").children("div").slideDown(200);
        $(".help-node h5").click(function () {
            if ($(this).parent(".help-node").attr("class") != "help-node open") {
                $(".help-node").removeClass("open").find("div").slideUp(200);
                $(this).next("div").slideToggle();
                $(this).parent(".help-node").addClass("open");
            }
        });
        if(q!= null || q!="" || q!=undefined){
			if(q=="1"){
				$("#q2").trigger("click");
			}
			if(q=="2"){
				$(".q4").trigger("click");
			}
			if(q=="3"){
				$(".q5").trigger("click");
			}
			if(q=="4"){
				$(".q7").trigger("click");
			}
			if(q=="5"){
				$("#q10").trigger("click");
			}
		}
    })
</script>
<br />
        <h3 class="r_title">投资操作问题</h3>     
		<div class="centent-nr">
			<div id="help-content" class="help-content"> <br />
				<div class="help-node">
					<h5 id="q2"> <span>1</span><a href="javascript:void(0)">投资时是否可以用信用卡来进行支付？</a></h5>
					<div> <span></span>
						<p> 不可以。央行下发了《支付业务风险提示——加大审核力度、提高管理水平、防范网络信贷平台风险》，要求相关机构严格防范信用卡透支资金用于网络信贷。</p>
					</div>
				</div>
				<div class="help-node">
					<h5 class="q4"> <span>2</span><a href="javascript:void(0)">支付成功就一定是投标成功吗？</a></h5>
					<div> <span></span>
						<p> 不一定。投标结束后，如多个投资人在投标期间进行投资导致项目实际募集资金超过项目融资规模（即产生超募），投融资平台将根据投资人的投资时间顺序将顺序在后的投资资金/部分投资资金（即超募资金）于所投项目投标结束日的T+1日（均为工作日，非工作日将延后至下一个工作日），通过第三方支付机构向投资人指定的回款账户发起退款。</p>
					</div>
				</div>
				<div class="help-node">
					<h5 class="q5"> <span>3</span><a href="javascript:void(0)">投资人可以提前收回投资资金吗？</a></h5>
					<div> <span></span>
						<p> 目前平台推出的项目暂不支持提前收回投资，到期日后将一次性还本付息到回款账户。 </p>
					</div>
				</div>
				<div class="help-node">
					<h5 class="q7"> <span>4</span><a href="javascript:void(0)">怎么查询我的投资回收和收益？</a></h5>
					<div> <span></span>
						<p> 用户可以进入“我的账户”－“我的项目”或“投资记录“页面中查看投资收益</p>
					</div>
				</div>
				<div class="help-node">
					<h5 id="q10"> <span>5</span><a href="javascript:void(0)">如何修改个人信息，所有信息都可以修改吗？</a></h5>
					<div> <span></span>
						<p> 可通过平台中“我的账户“ - ”个人信息“修改和完善个人信息。但其中实名认证或添加银行卡成功后无法进行更改，已保障投资人的信息安全。</p>
					</div>
				</div>
				<div class="help-node">
					<h5> <span>6</span><a href="javascript:void(0)">平台对投资者有什么要求？</a></h5>
					<div> <span></span>
						<p> 投资人需年满18周岁，具有法律规定的完全民事权利和民事行为能力，具备一定风险承受能力，有合法的投资资金。平台暂不支持外籍人士及港澳台人士注册投资。<br />
							投资者经过实名身份认证，持有境内手机号码及任一银行的本人名下借记卡（账户状态不能为冻结、过期、销户等异常情况）即可参与平台项目投资。 </p>
					</div>
				</div>
				<div class="help-node">
					<h5 class="q3"> <span>7</span><a href="javascript:void(0)">投资人支付成功后，项目什么时候开始计算收益？</a></h5>
					<div> <span></span>
						<p> 根据您所投资的项目，在"项目起息日期"开始计算收益。</p>
					</div>
				</div>
				<div class="help-node">
					<h5 class="q6"> <span>8</span><a href="javascript:void(0)">我是否必须要有晋城农商银行的借记卡才可以在平台上投资吗？</a></h5>
					<div> <span></span>
						<p> 不是。除了晋城农商银行借记卡外，平台还支持其他银行的借记卡支投。当前投融资平台可以选择通过银直接通过网银支付和快捷支付两种方式，在支付前请确认银行卡个人网银开通情况。详见下列表。</p>
						<p>&nbsp; </p>
						<table class="ui-table-help2" cellpadding="0" cellspacing="0">
							<tr>
								<th> 银行 </th>
								<th> 客户类型 </th>
								<th> 单笔限额（元） </th>
								<th> 日累计限额（元） </th>
								<th> 客服热线 </th>
							</tr>
							<tr>
								<td> 安徽省农村信用社联合社 </td>
								<td> 个人网银 </td>
								<td> 100万 </td>
								<td> 200万 </td>
								<td> 96669 </td>
							</tr>
							<tr>
								<td> 中国工商银行 </td>
								<td>
                                	<p>电子口令卡</p>
                                	<p>短信认证</p>
                                	<p>电子密码</p>
                                	<p class="lat">U盾</p>
                                </td>
								<td>
                                	<p>500</p>
                                	<p>2000</p>
                                	<p>50万</p>
                                	<p class="lat">100万</p>
                                </td>
								<td>
                                	<p>1000</p> 
                                	<p>5000</p> 
                                	<p>100万</p> 
                                	<p class="lat">100万</p> 
                                </td>
                                <td>95588</td>
							</tr>
							<tr>
								<td> 中国农业银行 </td>
								<td>
                                	<p>动态口令</p> 
                                	<p>移动证书（一代k宝）</p> 
                                	<p class="lat">移动证书（二代k宝）</p> 
                                </td>
								<td>
                                	<p>1000</p>
                                	<p>50万</p>
                                	<p class="lat">100万</p>
                                </td>
								<td>
                                	<p>3000</p>
                                	<p>100万</p>
                                	<p class="lat">500万</p>
                                </td>
								<td> 95599 </td>
							</tr>
							<tr>
								<td> 中国银行 </td>
								<td> USBk证书认证、令牌+动态口令 </td>
								<td> 1万 </td>
								<td> 20万 </td>
								<td> 95566 </td>
							</tr>
							<tr>
								<td> 中国建设银行 </td>
								<td>
                                	<p>账号直接支付</p> 
                                	<p>动态口令</p> 
                                	<p>网银盾1代</p> 
                                	<p class="lat">网银盾2代</p> 
                                </td>
								<td>
                                	<p>1000</p> 
                                	<p>5000</p> 
                                	<p>5万</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td>
                                	<p>1000</p> 
                                	<p>5000</p> 
                                	<p>10万</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td> 95533 </td>
							</tr>
							<tr>
								<td> 交通银行 </td>
								<td>
                                	<p>手机短信密码验证</p> 
                                	<p class="lat">USBkey证书认证</p> 
                                </td>
								<td>
                                	<p>5万</p> 
                                	<p class="lat">100万</p> 
                                </td>
								<td>
                                	<p>5万</p> 
                                	<p class="lat">100万</p> 
                                </td>
								<td> 95559 </td>
							</tr>
							<tr>
								<td> 中信银行 </td>
								<td>
                                	<p>手机动态密码</p> 
                                	<p class="lat">U盾</p> 
                                </td>
								<td>
                                	<p>1000</p> 
                                	<p class="lat">100万</p> 
                                </td>
								<td>
                                	<p>5000</p> 
                                	<p class="lat">100万</p> 
                                </td>
								<td> 95558 </td>
							</tr>
							<tr>
								<td> 光大银行 </td>
								<td>
                                	<p>手机动态密码</p> 
                                	<p class="lat">令牌动态密码及阳光网盾验证方式</p> 
                                </td>
								<td>
                                	<p>1万</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td>
                                	<p>1万</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td> 95595 </td>
							</tr>
							<tr>
								<td> 华夏银行 </td>
								<td>
                                	<p>大众版</p> 
                                	<p>手机动态</p> 
                                	<p class="lat">数字证书</p> 
                                </td>
								<td>
                                	<p>300</p> 
                                	<p>1000</p> 
                                	<p class="lat">5万</p> 
                                </td>
								<td>
                                	<p>1000</p> 
                                	<p>5000</p> 
                                	<p class="lat">10万</p> 
                                </td>
								<td> 95577 </td>
							</tr>
							<tr>
								<td> 民生银行 </td>
								<td>
                                	<p>大众版</p> 
                                	<p>贵宾版</p> 
                                	<p class="lat">u宝用户</p> 
                                </td>
								<td>
                                	<p>300</p> 
                                	<p>5000</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td>
                                	<p>300</p> 
                                	<p>5000</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td> 95568 </td>
							</tr>
							<tr>
								<td> 招商银行 </td>
								<td>
                                	<p>大众版</p>
                                	<p class="lat">专业版</p>
                                </td>
								<td>
                                	<p>500</p>
                                	<p class="lat">无限额</p>
                                </td>
								<td>
                                	<p>500</p>
                                	<p class="lat">无限额</p>
                                </td>
								<td> 95555 </td>
							</tr>
							<tr>
								<td> 浦发银行 </td>
								<td>
                                	<p>手机动态密码</p> 
                                	<p class="lat">数字证书（浏览器证书或U盾）</p> 
                                </td>
								<td>
                                	<p>20万</p> 
                                	<p class="lat">无限额，自行设置</p> 
                                </td>
								<td>
                                	<p>20万</p> 
                                	<p class="lat">无限额，自行设置</p> 
                                </td>
								<td> 95528 </td>
							</tr>
							<tr>
								<td> 上海银行 </td>
								<td>
                                	<p>办理E盾证书版个人网银，开通网上支付功能</p> 
                                	<p class="lat">办理动态密码版个人网银（含文件证书），开通网上支付功能</p> 
                                </td>
								<td>
                                	<p>50万</p> 
                                	<p class="lat">6000</p> 
                                </td>
								<td>
                                	<p>100万</p> 
                                	<p class="lat">1万</p> 
                                </td>
								<td>  </td>
							</tr>
							<tr>
								<td> 中国邮政储蓄银行 </td>
								<td>
                                	<p>手机短信客户</p> 
                                	<p>电子令牌+短信客户</p> 
                                	<p class="lat">Ukey+短信客户</p> 
                                </td>
								<td>
                                	<p>1万</p> 
                                	<p>20万</p> 
                                	<p class="lat">200万</p> 
                                </td>
								<td>
                                	<p>1万</p> 
                                	<p>20万</p> 
                                	<p class="lat">200万</p> 
                                </td>
								<td> 95580 </td>
							</tr>
							<tr>
								<td> 徽商银行 </td>
								<td>
                                	<p>动态密码</p> 
                                	<p class="lat">USBKEY</p> 
                                </td>
								<td>
                                	<p>1000</p> 
                                	<p class="lat">50万</p> 
                                </td>
								<td>
                                	<p>5000</p> 
                                	<p class="lat">200万</p> 
                                </td>
								<td> 4008896588 </td>
							</tr>
							<tr>
								<td> 颖淮农村商业银行 </td>
								<td> 个人网银 </td>
								<td> 100万 </td>
								<td> 200万 </td>
								<td>400-17-96669 </td>
							</tr>
						</table>
					</div>
				</div>
				<div class="help-node">
					<h5> <span>9</span><a href="javascript:void(0)">在选择具体的投资项目时，我的投资时间是否有限制？</a></h5>
					<div> <span></span>
						<p> 是。只有在该项目投资期限内、且项目状态显示未投满前可以投标。项目状态为“预热”、“满标”、“完成”等状态时皆不可投标。</p>
					</div>
				</div>
				<div class="help-node">
					<h5> <span>10</span><a href="javascript:void(0)">第一次投标支付和添加银行卡时可以不进行实名认证吗？</a></h5>
					<div> <span></span>
						<p> 不可以。为确保用户资金安全，在添加银行卡之前，用户需要先完成实名认证。</p>
					</div>
				</div>
			</div>
		</div>
		<!--centent-nr --> 
	</div>
</div>
<%@ include file="../foot.jsp" %>
</body>
</html>
