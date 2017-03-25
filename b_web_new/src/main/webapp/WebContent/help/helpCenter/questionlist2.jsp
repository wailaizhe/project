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
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
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
<script type="text/javascript">
var Data={};
function GoSearch(flag, pi) {
    var submitData = {};
    submitData.targetUrl = "${ctx}/notice/noticeList";
    //查询条件 开始
    submitData.condition={};
    submitData.condition.PageIndex = pi;//控制第几页
    submitData.condition.PageSize = 10;//控制每页显示条数
    //查询条件 结束
    RenderTmpl({
            Data: submitData,
            TmplSource: "#tmpl_projectList",
            TmplTarget: "#projectList_search",
            AfterFn:function (result) {
                if (result.totalCount < 1) {
                    $("#projectList_search").html('');
                    $("#pagerHolder").html("");
                    $(".table_head").hide();
                }else if(result.totalCount < submitData.condition.PageSize) {
                    $("#pagerHolder").html("");
                    $(".table_head").show();
                }else{
                    $("#pagerHolder").html(GetPagerHtmlSpan({
                        index: submitData.condition.PageIndex,
                        size:  submitData.condition.PageSize,
                        total: result.totalCount,
                        fnName: "GoSearch"
                    }));
                    $(".table_head").show();
                 }
            }
        });
}

$(function(){
		$('.hpl ul li a').each(function(){
		    if($($(this))[0].href==window.location){
		        $(this).parent().addClass('current');
		        $(this).parent().siblings("li").removeClass("current");
		    }
		});
		GoSearch(false, 1);
	})
</script>
<script id="tmpl_projectList" type="text/x-jquery-tmpl">
{{each(i,v) Data.ResultList}}
	<li> <a href="questionlist2_notic1.jsp?id={{= v.id}}"  title="{{= v.noticeTitle}}"> {{= v.noticeTitle}}</a> </li>
{{/each}}
</script>
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

                //$("html,body").animate({scrollTop: $(".open").offset().top-150}, 1000);	
            }
        });
    })
</script>
        <br />
        <h3 class="r_title">平台公告</h3>
			<div class="centent-nr">
				<ul class="xy-list" id="projectList_search">
				</ul>
			</div>
			<!-- 分页开始 -->
		    <div class="mod-page" id="pagerHolder">
		    </div>
	    	<!-- 分页结束 -->
    </div>
</div>
<%@ include file="../foot.jsp" %>
</body>
</html>
