<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>晋城农商银行-互联网金融服务平台</title>
<meta name="keyword" content="晋城农商银行，互联网金融服务平台，直销银行，金融超市，投资理财"/>
<meta name="description" content="晋城农商银行-互联网金融服务平台，为个人和中小企业提供投资、理财、融资、消费等全方位创新型金融服务, 项目优质、低风险、期限灵活、高收益，”晋“心尽力为您提供优势服务。"/>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/index_v3.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css">
<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/slide.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>

<script type="text/javascript">

$(function(){  
	setInterval('autoScroll(".apple")',2000);
	
	   	getNotice();
	   
	   	GoSearch(false, 1);
	   
	   	<!--banner轮播-->
		$(".slideInner").slide({
			slideContainer: $('.slideInner a'),
			effect: 'easeOutCirc',
			autoRunTime: 3000 ,
			slideSpeed: 1000,
			nav: true,
			autoRun: true,
			prevBtn: $('a.prev'),
			nextBtn: $('a.next')
		});
	
}) 
//添加信控悬浮解释
function addXKtips(){
	$(".jieshi").mousemove(function (e) {
		var postX = e.pageX;
		var postY = e.pageY;
		var myText = $(this).attr("alt");
		$(".mouseTips").css({ "left": postX - 10, "top": postY - 40, "display": "block" })
		$(".mouseTips").html(myText + "<i></i>");
	});
	$(".jieshi").mouseout(function () {
		var myText = $(this).attr("alt");
		$(".mouseTips").hide();
		$(".mouseTips").html(myText + "<i></i>");
	});
}

function finishItemBox(){

	
	var yesBtn = function(){
		
	}
	$('.wc_btn').click(function(){
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
var Data={};
function GoSearch(flag, pi) {
    var submitData = {};
    submitData.targetUrl = "${ctx}/item/queryItemIndex";
    
    //查询条件 开始
    submitData.condition={};
    submitData.condition.PageIndex = pi;//控制第几页
    submitData.condition.PageSize = 3;//控制每页显示条数
    submitData.condition.interest = "";
    submitData.condition.duration = "";
    submitData.condition.projectType = "";
    //查询条件 结束
    RenderTmpl({
            Data: submitData,
            Async: false,
            TmplSource: "#tmpl_projectList",
            TmplTarget: "#projectList_search",
            AfterFn:function (result) {
            	console.log(result);
                if (result.totalCount < 1) {
                    $("#projectList_search").html('<li class="noproject"> <img src="${resource_dir}/images/nocont.png"/><div class="lit_right"></div> </li>');
                    $("#pagerHolder").html("");
                    $(".table_head").hide();
                }else if(result.totalCount < submitData.condition.PageSize) {
                    $("#pagerHolder").html("");
                    $(".table_head").show();
                    addXKtips();
                    finishItemBox();
                }else{
                    $("#pagerHolder").html(GetPagerHtmlSpan({
                        index: submitData.condition.PageIndex,
                        size:  submitData.condition.PageSize,
                        total: result.totalCount,
                        fnName: "GoSearch"
                    }));
                    $(".table_head").show();
                    addXKtips();
                    finishItemBox();
                 }
            }
        });
}
//查询公告
function getNotice(){
	$.ajax({
		type: "post",
		async: false,
		url: '${ctx}/notice/queryIndexNoticeList',
		success: function (data) {
			html='';
			if(data != null || data != undefined || data != 'undefined'){
				for(var i=0;i<data.length;i++){
					var result = data[i];
					var title = result.noticeTitle;
					var title1 = result.noticeTitle;
					var noticeId = result.id;
					if(title.length > 44){
						title = title.substring(0,40)+"...";
					}
					html += '<li><a href="${ctx}/help/helpCenter/questionlist2_notic1.jsp?id='+noticeId+'" target="_blank" title="'+title1+'">'+title+'</a></li>';
				}
			}else{
				html = "暂无公告！";
				$("#noticeTitle").attr('style','cursor:default;');
			}
			$("#noticeTitle").html(html);
		}
	});
}
// 公告上下滚动
function autoScroll(obj){  
	$(obj).find("ul").animate({  
		marginTop : "-39px"  
	},500,function(){  
		$(this).css({marginTop : "0px"}).find("li:first").appendTo(this);  
	})  
}  

		

var landFlag="03";
function isLand(){
	$.ajax({
			async: false,
			type: "post",
			url: "${ctx}/account/indexIsLand?t="+Math.random(),
			success: function (msg) {
				landFlag = msg;
			}
	});
	if(landFlag=="03"||landFlag.length>20){//未登录
	    return false;  
	}else{
		return true;
	}
}
//value="{{= v[12]}}
</script>

<script id="tmpl_projectList" type="text/x-jquery-tmpl">
{{each(i,v) Data.ResultList}}
			<li>
			<input id="fwqCurrenTime" type="hidden" value="{{= v[12]}}"/>
            	<div class="lit_left">
                    <h3>
                        <i><img src="${resource_dir}/images/lit.png"/></i>
                        <span>{{= v[8]}}{{= v[9]}}</span>
                        <em class="xin jieshi" alt="晋城农商银行作为项目见证机构，已对融资方信息进行审核。项目融资方具有晋城农商银行的授信额度"></em>
						<em class="kong jieshi" alt="项目委托第三方支付公司——中金支付有限公司进行资金监管及清算服务。晋城农商银行对融资方还款环节中到期应收款项的兑付过程进行控制"></em>
						{{if v[12]=='01'}}
							<em class="zhuan jieshi" alt="专属项目"></em>
						{{/if}}
						{{if v[15]=='01'}}
							<em class="xszx jieshi" style="width:80px;" alt="新手专享"></em>
						{{/if}}
						{{if v[16]=='01'}}
							<em class="ding jieshi" style="margin-left: 11px;" alt="白名单专享"></em>
						{{/if}}
                    </h3>
                    <div class="leftmain">
                    	<span class="tim">期限<b>{{= v[5]}}</b><em>天</em></span>
                        <span class="guimo">融资规模<em>{{= formatMoney(v[6])}}<b>万元</b></em></span>
                        <span class="lilv">预期年化收益率<b>{{= FormatDigital(v[7])}}</b><em>%</em></span>
                    </div>
                </div>
                <div class="lit_right">
				{{if v[10]=='01'}}                	
                    <div class="yr_btn"><a href="${ctx}/arcOrder/findDetail?itemId={{= v[0]}}">预热中</a></div>
				{{/if}}
				{{if v[10]=='02'}}                	
					<div class="lit_btn"><a href="${ctx}/arcOrder/findDetail?itemId={{= v[0]}}">投标中</a></div>
				{{/if}}
				{{if v[10]=='03'}}                	
                    <div class="mb_btn"><a href="${ctx}/arcOrder/findDetail?itemId={{= v[0]}}">已售罄</a></div>
				{{/if}}
				{{if v[10]=='04'}}                	
                    <div class="wc_btn"><a>已完成</a></div>
				{{/if}}
				{{if v[10]=='err'}}                	
                    <div class="wc_btn"><a>0%</a></div>
				{{/if}}
   			</div></li>
{{/each}}
</script>
</head>
<body>
<!--解释标签-->
<DIV class=blackBg></DIV>
<P class=mouseTips><I></I></P>
		<!--头部开始-->
		<%@ include file="header.jsp"%>
		<!--banner开始-->
		<div class="slides">
			<div class="slideInner">
				 <a href="${ctx}/awardCtl/inviteActivityIndex" style="background:url(${resource_dir}/images/activity_background.jpg);">
					<div class="moveElem img1" rel="0,easeInOutExpo" style="top:0px;"> <img src="${resource_dir}/images/banner_activity.jpg" /> </div>
				 </a> 
				 <a href="${ctx}/awardCtl/goSmashingEggs" style="background:url(${resource_dir}/images/banner_bg.jpg);">
					<div class="moveElem img1" rel="0,easeInOutExpo" style="top:0px;"> <img src="${resource_dir}/images/jdbanner.jpg" /> </div>
				</a> 
				 <a href="${ctx}/help/mobile_app/jc_new.jsp" style="background-color:#FE8101;" target="_blank">
					<div class="moveElem img1" rel="0,easeInOutExpo" style="top:0px;margin-left:-650px;margin-top:30px;"> <img src="${resource_dir}/images/banner2.jpg" /> </div>
				</a> 
				<a href="#" style="background:url(${resource_dir}/images/bannericon2.png); cursor:default;">
					<div class="moveElem img1" rel="0,easeInOutExpo" style="top:0px;"> <img src="${resource_dir}/images/banner3.jpg" /> </div>
				</a>
			</div>
		   <!--	<div class="nav">
				<a class="prev" href="javascript:;"></a>
				<a class="next" href="javascript:;"></a>
			</div>-->
			
			
		</div>
		<div class="notice">
		    	<div class="notice_con">
		            <p>通知公告：
		                <i></i>
		                <div class="apple">
		                    <ul id="noticeTitle">
		                    </ul> 
		                </div>
		            </p>
		        </div>
		    </div>
		
		<div class="newbanner">
			<ul>
		    	<li class="newbanner1">
		        </li>
		    	<li class="newbanner2">
		        </li>
		        
		        <li class="newbanner3">
		        	<div class="download">
		                <a target="_blank" href="/WebContent/help/mobile_app/jc_new.jsp"><img src="${resource_dir}/images/mobile_app/android.png"/></a>
		                <a target="_blank" href="/WebContent/help/mobile_app/jc_new.jsp"><img src="${resource_dir}/images/mobile_app/ios.png"/></a>
		            </div>
		        </li>
		        
		        
		    </ul>
		</div>
<!--banner结束-->
		<!--理财推荐开始-->
		<div class="list_section">
			<div class="list_head">
		    	<h3>推荐项目</h3>
		        <a href="${ctx }/investment/touzi">查看全部 >></a>
		    </div>
		    <div class="list_main">
		    	<ul id="projectList_search"></ul>
		    </div>
		</div>
		<!--理财推荐结束-->
		<!--服务模块开始-->
<div class="service_section">
	<ul>
    	<li>
        	<img src="${resource_dir}/images/kf.png"/>
            <div class="kf">
            	<h3>全国统一客服电话</h3>
                <p class="kfphone">0356-2210820</p>
            </div>
        </li>
        <li>
        	<img src="${resource_dir}/images/pro.png"/>
            <div class="help">
            	<h3>新手帮助</h3>
                <p><a href="/WebContent/help/helpCenter/questionlist7.jsp">新手指引</a> 
                	<a href="/WebContent/help/helpCenter/questionlist1.jsp">帮助中心</a>
                </p>
                <p><a href="/WebContent/help/helpCenter/questionlist6.jsp">常见问题</a> 
                <a href="/WebContent/help/helpCenter/questionlist2.jsp">平台公告</a></p>
            </div>
        </li>
        <li>
        	<img src="${resource_dir}/images/erw.jpg"/>
            <div class="help help2">
            	<h3>微信公众号</h3>
                <p>扫一扫二维码</p>
                <p>立即关注</p>
            </div>
        </li>
        <li class="last">
        	<img src="${resource_dir}/images/fx.png"/>
            <div class="help help1">
            	<h3>金融服务平台服务商</h3>
                <p>北京蜂向信息科技有限公司</p>
                <p>客服电话：400-6688-997</p>
            </div>
        </li>
    </ul>
</div>
<!--服务模块结束-->
<!--底部开始--> 
<%@ include file="foot.jsp"%>
<!--底部结束-->

<!--弹出框-->
<div id="tan" class="buy_tan" style="display:none;">
	<p class="tan_main">
		项目已完成，请选择其他项目
    </p>
</div>

</body>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?43098a62624b54a35a0ae0f82dbe45e5";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
<script type="text/javascript">


</script>
</html>