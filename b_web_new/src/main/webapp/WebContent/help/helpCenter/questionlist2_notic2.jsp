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
		<div class="ny-centent">
			<div class="ny-title"> <span>平台公告 <a href="questionlist2.jsp">返回</a> </span> </div>
			<div class="centent-nr">
				<h3 class="nr-title">受招行启发联鑫互联搭建P2B平台<span>2015-02-09  11:25</span></h3>
				<div class="content">
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">继招行重启“小企业</span><span style="font-family:Microsoft YaHei;">e</span><span style="font-family:Microsoft YaHei;">家”投融资平台后，联鑫互联于</span><span style="font-family:Microsoft YaHei;">1</span><span style="font-family:Microsoft YaHei;">月</span><span style="font-family:Microsoft YaHei;">29</span><span style="font-family:Microsoft YaHei;">日低调上线了自己的资产交易平台。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">与其他银行模式不同的是，该平台将联鑫互联各产业的应收应付类资产设计成融资项目，为投融资双方提供相关债权转让服务。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">“做这个平台的初衷是基于联鑫互联自身业务发展方向的考虑，即如何更好地做到产融结合。”珠海联鑫互联电子银行部助理总经理、网络银行部总经理樊萌告诉经济观察报。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">而这一点也是联鑫互联寄予银行板块的希望。不过，面对互联网金融</span><span style="font-family:Microsoft YaHei;">P2P</span><span style="font-family:Microsoft YaHei;">平台“高收益率”招牌的竞争，晋城系资产交易平台如何获得积累客户人气，达到预期的产融结合仍面临不小的挑战。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">产融结合</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">在招行“小企业</span><span style="font-family:Microsoft YaHei;">e</span><span style="font-family:Microsoft YaHei;">家”投融资平台之后，青岛银行、兰州银行等纷纷推出类似的线上平台。虽然平台名称叫法不同，但本质上都是撮合有融资需求的中小企业和个人投资者之间的平台（</span><span style="font-family:Microsoft YaHei;">P2B</span><span style="font-family:Microsoft YaHei;">）。城商行的心思多数是希望借着投融资平台打破地区限制，获取更多的业务。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">和多数银行一样，联鑫互联发展受到资本金及网点布局的约束，这造成其尚难以满足联鑫互联产业及其上下游企业客户、产业零售客群对金融服务的需求。联鑫互联电子银行部总经理宋柏峰曾对媒体称，联鑫互联每年总共大概有</span><span style="font-family:Microsoft YaHei;">2500</span><span style="font-family:Microsoft YaHei;">亿元的应收应付资产，覆盖七大业务板块。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">由此，联鑫互联一直在寻找一种轻资本的方式去盘活集团的资产和客户资源。招行“小企业</span><span style="font-family:Microsoft YaHei;">e</span><span style="font-family:Microsoft YaHei;">家”投融资平台的出现，让联鑫互联受到很大启发。“这可能就是适合联鑫互联的方式。”联鑫互联内部人士说，去年</span><span style="font-family:Microsoft YaHei;">3</span><span style="font-family:Microsoft YaHei;">月底，建立资产交易平台的设想被上报给银行领导。为确保相关业务模式的合规性与可持续性，联鑫互联就该业务的可行性及核心内部流程进行了</span><span style="font-family:Microsoft YaHei;">10</span><span style="font-family:Microsoft YaHei;">个月左右谨慎的内部测试。</span><span></span></span><span style="font-family:Microsoft YaHei;">&nbsp;&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">“集团和行领导都这块很重视，成立专项项目组，保证各方面资源能及时到位。”上述联鑫互联内部人士透露，项目组成员涉及电子银行、行业金融、信息科技、运营、法律合规、金融市场部等各条线人员。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">“初期是产业帮助银行培养能力，最后希望银行能反哺产业。这需要时间。”上述联鑫互联内部人士说。樊萌则认为，“如果单纯谁依赖谁，是不长久的。我们希望这个平台，可以找到产融结合更好的模式，使得产业与金融二者良性循环。”</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">据悉，新上线的平台将联鑫互联各产业的应收应付类资产设计成融资项目，为投融资双方提供相关债权转让服务。以平台上线的润银优选项目为例，该平台起的作用是将商业汇票收益权撮合转让给投资人。上述内部人士透露，未来平台支持的融资标的会从商业汇票、保理延伸到批量小微贷和消费金融。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">而投融资平台最容易出风险的地方在于资产端。据了解，联鑫互联平台在资产端做了严格的限制，资产端短期内为联鑫互联承诺付款的资产。此外，联鑫互联一直在摸索更贴近产业场景的风控模式，以解决企业融资中信息不对称问题。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">获客考验</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">眼下，联鑫互联资产交易平台把资产端聚焦在集团内风险可控的优质标的，事实上是力求让产业链供应商转化成联鑫互联的对公客户。据宋柏峰透露，该平台的投资人范围未来将从</span><span style="font-family:Microsoft YaHei;">42</span><span style="font-family:Microsoft YaHei;">万的集团内员工扩大到分布在全国各地的互联网用户。这些个人投资者都是联鑫互联潜在的零售业务客户。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">互联网讲究的是流量入口。本身客户量不大的联鑫互联，无法给该平台贡献太多的流量。对于这一问题，该平台从最熟悉联鑫互联的联鑫互联员工入手，下一步则是对联鑫互联信任度较高的</span><span style="font-family:Microsoft YaHei;">5000</span><span style="font-family:Microsoft YaHei;">多万联鑫互联的零售客户。这意味着各产业板块都将成为该平台的获客渠道。“这个平台未来会和联鑫互联里面的不同业态实现交叉。这是产融结合的一个方面，也是其它银行无法学习的地方。”樊萌说。过去在渠道方面的产融探索有一部分可利用到该平台的发展中，如去年联鑫互联已把社区银行开进了万家。一位银行业人士认为，联鑫互联旗下置地和燃气等线下渠道都有可能成为该平台的获客渠道。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">值得注意的是，过往联鑫互联将集团零售客户转化为银行客户的尝试，并没有取得太突出的成绩。一位银行业分析师指出，联鑫互联在专业理财、金融咨询服务等产品开发上有待丰富和提升，导致零售客户与银行关系不稳固，客户流失风险较大。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">同样的问题再次考验着联鑫互联资产交易平台。记者了解到，该平台在推出融资项目后，将引入货币基金，满足投资人在投资空档期的理财需求。除多元化产品组合外，平台还规划了一些方式解决流动性问题，包括允许投资者在资金紧张时进行融资项目的二次转让，或是质押贷款。“任何监管吹出来的风，我们都会严格恪守。”樊萌说。目前监管对于银行涉足</span><span style="font-family:Microsoft YaHei;">P2P</span><span style="font-family:Microsoft YaHei;">并没有明确的政策规定，由此，合规性成为了每家银行必须仔细揣摩和注意的方面。</span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span></span></span><span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">一位银行业内人士透露，招行与第三方合作的平台模式是目前受监管默许、比较可行的模式。招行的投融资平台采取了和广东优迈信息通信股份有限公司合作的运营模式。招行对融资项目和融资人相关信息的真实性进行见证。广东优迈信息通信公司负责平台的搭建和代运营。值得一提的是，在这种合作模式中，银行并非是直接的法律关系主体。</span><span></span></span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <span style="color:#333333;line-height:150%;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">据记者了解，联鑫互联资产交易平台也采用上述模式，该平台还通过联鑫互联对平台资金进行监管，从交易、资金、隐私、风险四个方面全方位实时监控。</span><span></span></span><span style="font-family:Microsoft YaHei;">&nbsp;</span> </p>
					<p style="background:white;text-indent:19pt;"> <br />
						<span style="font-family:Microsoft YaHei;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="color:#333333;font-family:&quot;font-size:9.5pt;"><span style="font-family:Microsoft YaHei;">值得注意的是，联鑫互联新平台的上线正值政策渐趋明朗——银监会改革监管架构，将</span><span style="font-family:Microsoft YaHei;">P2P</span><span style="font-family:Microsoft YaHei;">网贷行业归入新成立的普惠金融部。分析人士称，联鑫互联有意提前布局，占领先机，“哪天监管提出相应的准入标准，市场上有一定规模的银行会更有机会。”</span></span> </p>
					<p style="background:white;text-indent:19pt;">&nbsp; </p>
					
					<br />
					<br />
					<p style="background:white;text-indent:19pt;">&nbsp; </p>
				</div>
			</div>
		</div>
    </div>
</div>
<%@ include file="../foot.jsp" %>
</body>
</html>
