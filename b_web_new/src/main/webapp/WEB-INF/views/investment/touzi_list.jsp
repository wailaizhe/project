<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<%
	String rootPath = request.getContextPath();
%>
<meta charset="utf-8">
<title>惠赚钱-晋城农商银行蒲公英金融服务平台</title>
<link rel="stylesheet" type="text/css" href="${rootPath}/css/common_v2.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/list_v2.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css">
<script src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
<script>
$(function(){
	$(".head_main .list ul li").click(function(){
		$(this).addClass("current").siblings().removeClass("current");
		})
	$(".head_main .list1 ul li").click(function(){
		$(this).addClass("current").siblings().removeClass("current");
		})
	$(".head_main .list2 ul li").click(function(){
		$(this).addClass("current").siblings().removeClass("current");
		})

});
function finishItemBox(){
	<!--弹出框-->
	var yesBtn = function(){
		
	}
	$('.fs_btn').click(function(){
		var chks = $('#tan').html();
		easyDialog.open({
			container : {
				header : ' ',
				content :chks,
				yesFn : yesBtn,
			},
			fixed : false
		});
	});
}


function addXKtips(){
	$(".jieshi").mousemove(function (e) {
		var postX = e.pageX;
		var postY = e.pageY;
		var myText = $(this).attr("alt");
		$(".mouseTips").css({ "left": postX - 10, "top": postY - 40, "display": "block" })
		$(".mouseTips").html(myText + "<i></i>");
	})
	$(".jieshi").mouseout(function () {
		var myText = $(this).attr("alt");
		$(".mouseTips").hide()
		$(".mouseTips").html(myText + "<i></i>");
	})
}
</script>
<script >
var Data={};
$(document).ready(function () {
	GoSearch(false, 1);
	 //绑定搜索条件
	 BindSelect("#interestSelect", function (selVal) { $("#txtInterest").val(selVal); GoSearch(false,1); });
     BindSelect("#durationSelect", function (selVal) { $("#txtDuration").val(selVal); GoSearch(false,1); });
     BindSelect("#ProjectType", function (selVal) { $("#txtProjectType").val(selVal); GoSearch(false,1); });
});
function GoSearch(flag, pi) {
    var submitData = {};
    submitData.targetUrl = "${ctx}/item/queryItemByTmpl";
    //查询条件 开始
    submitData.condition={};
    submitData.condition.PageIndex = pi;//控制第几页
    submitData.condition.PageSize = 10;//控制每页显示条数
    submitData.condition.interest = $("#txtInterest").val();
    submitData.condition.duration = $("#txtDuration").val();
    submitData.condition.projectType = $("#txtProjectType").val();
    //查询条件 结束
    RenderTmpl({
            Data: submitData,
            Async: false,
            TmplSource: "#tmpl_projectList",
            TmplTarget: "#projectList_search",
            AfterFn:function (result) {
                if (result.totalCount < 1) {
                    $("#projectList_search").html('<div class="no-content" style="font-size:20px;"><p class="qidai"></p></div>');
                    $("#pagerHolder").html("");
                    $(".table_head").hide();
                }else if(result.totalCount < submitData.condition.PageSize) {
                    $("#pagerHolder").html("");
                    $(".table_head").show();
                    $("#pagerHolder").html("<a style='cursor:default;' title='上一页'>&lt;</a><a class='page-num'>1</a><a style='cursor:default;' title='下一页'>&gt;</a>");
                    addXKtips();//添加信控悬浮提示
                    finishItemBox();
                }else{
                    $("#pagerHolder").html(GetPagerHtmlSpan({
                        index: submitData.condition.PageIndex,
                        size:  submitData.condition.PageSize,
                        total: result.totalCount,
                        fnName: "GoSearch"
                    }));
                    $(".table_head").show();
                    addXKtips();//添加信控悬浮提示
                    finishItemBox();
                 }
                
            }
        });
}
function BindSelect(target, SelFn) {
    $(target).find("a").live("click", function () {
        var selVal = $(this).attr("selVal");
        SelFn(selVal);
    });
}
</script>
<script id="tmpl_projectList" type="text/x-jquery-tmpl">
{{each(i,v) Data.ResultList}}
<li class="toubiao current">
   <h3>
      {{= v[8]}}{{= v[9]}}&nbsp;&nbsp;
	  <input type="hidden" value="{{= v[0]}}"/>
      <i class="xin jieshi" alt="晋城农商银行作为项目见证机构，已对融资方信息进行审核。项目融资方具有晋城农商银行的授信额度"></i>
      <i class="kong jieshi" alt="项目委托第三方支付公司——中金支付有限公司进行资金监管及清算服务。晋城农商银行对融资方还款环节中到期应收款项的兑付过程进行控制"></i>
	  {{if v[12]=='01'}}
		<i class="zhuan jieshi" alt="专属项目"></i>
      {{/if}}
	  {{if v[15]=='01'}}
		<i class="xszx jieshi" style="width: 80px;" alt="新手专享"></i>
	  {{/if}}
	  {{if v[16]=='01'}}
		<i class="ding jieshi" alt="白名单专享"></i>
	  {{/if}}
   </h3><br/>
   <span class="tb_main3"> 期限<b>{{= v[5]}}</b>天</span>
   <span class="tb_main2"> 融资规模<b>{{= formatMoney(v[6])}}</b>万元</span>
   <span class="tb_main1">预期年化收益率<b>{{= FormatDigital(v[7])}}<em>%</em></b></span>
   <div class="lit_last">
     <span class="tb_main5"><h4 class="jd">
			<b class="b{{= v[11]}}">{{= v[11]}}%</b></h4><p>进度</p>
	</span>
{{if v[10]=='01'}}
    <span class="yr_btn">
      <a href="${ctx}/arcOrder/findDetail?itemId={{= v[0]}}">预热中</a> 
     </span>
{{/if}}
{{if v[10]=='02'}}
	<span class="tb_btn">
        <a href="${ctx}/arcOrder/findDetail?itemId={{= v[0]}}">投标中</a>
    </span>
{{/if}}
{{if v[10]=='03'}}
	 <span class="mb_btn">
         <a href="${ctx}/arcOrder/findDetail?itemId={{= v[0]}}">已售罄</a>
     </span>
{{/if}}
{{if v[10]=='04'}}
	<a><span class="fs_btn">已完成</span></a>
{{/if}}
{{if v[10]=='err'}}
	<span class="fs_btn">0%</span>
{{/if}}
</div>
</li>
{{/each}}
</script>
</head>
<body>
<!--解释标签-->
<DIV class="blackBg"></DIV>
<P class="mouseTips"><I></I></P>
<%@ include file="../index/header.jsp" %>
<!--投资列表部分-->
<div class="touzi_list">
	<div class="list_m">
        <div class="list_nav" style="padding-bottom:5px;">
            <a href="${ctx}/index">首页</a>&gt;
            <a class="current">惠赚钱</a>
        </div>
        <div class="listbanner" style="width:1024px;margin:0 auto;">
            <img src="${resource_dir}/images/listbanner.jpg"/>
        </div>
         <div class="head_main">
			<ul id="ui-search-tag">
            	<li class="list">
            		<h4 class="hm_t">类型 :</h4>
                	<ul class="hm" id="ProjectType">
                        <li class="hm1 current"><a href="javascript:void(0)">全部</a></li>
                        <li class="hm2"><a href="javascript:void(0)" selval="02">优选产品</a></li>
                        <li class="hm3"><a href="javascript:void(0)" selval="01">专属产品</a></li>
                    </ul>
                </li>
            	<li class="list2">
            		<h4 class="hm_t">理财期限 :</h4>
                	<ul class="hm" id="durationSelect">
                        <li class="hm1 current"><a href="javascript:void(0)" class="current">全部</a></li>
                        <li class="hm2"><a href="javascript:void(0)" selval="0,90">3个月以内</a></li>
                        <li class="hm3"><a href="javascript:void(0)" selval="90,180">3~6个月</a></li>
                        <li class="hm3"><a href="javascript:void(0)" selval="180,360">6~12个月</a></li>
                        <li class="hm3"><a href="javascript:void(0)" selval="360,10000">12个月以上</a></li>
                    </ul>
                </li>
            </ul>
            <input type="hidden" id="txtInterest" />
			<input type="hidden" id="txtDuration" />
			<input type="hidden" id="txtProjectType" />
        </div>
    </div>
    <div class="list_main">
        <div class="tz_lit">
        	<ul id="projectList_search">
            </ul>
        </div>
    </div>
    <!-- 分页开始 -->
    <div class="mod-page" id="pagerHolder">
    </div>
    <!-- 分页结束 -->
</div>
<%@ include file="../index/foot.jsp" %>
<!--弹出框-->
<div id="tan" class="buy_tan" style="display:none;">
	<p class="tan_main">
		项目已完成，请选择其他项目
    </p>
</div>
</body>
</html>
