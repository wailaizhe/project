<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<TITLE>蒲公英金融服务平台——我的金币</TITLE>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<META content="text/html; charset=utf-8" http-equiv=Content-Type>
    <link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
    <link rel=stylesheet type=text/css	 href="${resource_dir}/css/public.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
</head>
<script type="text/javascript">
$(function () {
     $("#ccp").html(FormatDigital($("#ccps").val()));
	 $("#inc").html(FormatDigital($("#incs").val()));
});

$(function(){    
<!--alt解释标签-->
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
})

function goSmashingEggs(){
	  $.ajax({
            type: "post",
            async: false,
            url: '${ctx}/awardCtl/isOnGoldenEgg',
            error: function (err) {},
            success: function (result) {
            	if(result=="true"){
            	    window.location.href="${ctx}/awardCtl/goSmashingEggs";
            	}else if(result=="before"){
            	warnMsg("活动未开始！","关闭");
            	}else if(result=="after"){
            	warnMsg("活动已经结束","关闭");
            	}else{
            	warnMsg("活动未开始","关闭");
            	}
             }
        });
	
	}
</script>

<body class="gray-bg">
<%@ include file="../header.jsp" %>
<div class="warp">
     <input type="hidden" id="newDate"  name="newDate" value="${newDate}"/>
     <div class="breadcrumb">
		<a href="${ctx}/item/index">首&nbsp;页</a>&nbsp;&gt;&nbsp;我的金币
	</div>
	<div class="container">
		<div class="mod-wrap mod-assets">
			<div class="mod-contnet my-center">
				<div class="ui-icon ui-user">
					<img alt="头像" src="${resource_dir}/images/my_pic.png" name="头像"> <a href="javascript:void(0)"></a>
				</div>
				<div class="ui_left">
					<div class="user-info">
						  <span class=f-left><span id="newCurrentTime">欢迎您</span>，${mobliePPhon}</span>
						 	<A id="phone"   class="ui-icon ui-mail-p<c:if test="${mobliePhon!=''}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="已绑定手机"></A>
							<A id="idCard"  class="ui-icon ui-mobile<c:if test="${realName!=null}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="<c:if test="${realName!=null}">已</c:if><c:if test="${realName==null}">未</c:if>实名认证"></A>
 					</div>
					<div class="investment-time">
						<P class=clear>
									上次登录时间：${ordeDdate}
						</P>
					</div>
				 </div>
				
			   <div class="ui_right">
                	<p>持有资产(元)<i></i></p>
                    <h3 id="ccp"></h3>
                    <input type="hidden" id="ccps" value="${capital }"/>
                    <div class="ui_money">
                    	<span>预估到期可获得收益：<em id="inc"></em>元</span>
                    </div>
                    <input type="hidden" id="incs" value="${income }"/>
				</div>
				
			</div>
		</div>
		<div class="ui-main">
			<div class="ui-plate-sidebar">
				
				<!--侧栏菜单-->
				<ul class="sidebar-nav">
					<li class="first-nav-item"> <a href="javascript:void(0)">我的账户</a>
						<ul>
							<LI>
									<a href="${ctx}/account/myassets"><i class=nav-icon1></i>我的资产</a>
									</li>
									<li>
										<A  href="${ctx}/account/investment_newList"><I class=nav-icon2></I>投资记录</A>
									</li>
									<li>
										<A href="${ctx}/account/mybankcard"><I class=nav-icon3></I>我的银行卡</A>
									</li>
									<li>
										<A  href="${ctx}/account/personInfo"><I class=nav-icon4></I>个人信息</A>
									</li>
									<li>
										<A  href="${ctx}/account/informationCenter"><I class=nav-icon6></I>我的消息</A>
									</li>
									<li>
										<A   href="${ctx}/account/toMyInvited"><I class=nav-icon7></I>我的推荐</A>
									</li>
									<li>
										<A class="current"  href="${ctx}/account/toMyGold"><I class=nav-icon8></I>我的金币</A>
									</li>
						</ul>
					</li>
				</ul>
				  <!--侧栏菜单结束--> 
      </div>
      <div class="ui-plate-main">
        <h3 class="my-account-title"><span class="title" style="padding:0;"><img src="${resource_dir}/images/jb.png"/></span></h3>
        <div id="tab2" class="myproject_nav clearfix" >
			<div class="gold clearfix">
            	<div class="gold_left">
                	<h3><i><img src="${resource_dir}/images/gold_icon.png"/></i><em>当前可用金币:<a href='${ctx}/account/toMyGoldDetail' style='color: #0066ff;'>详情</a></em></h3>
                    <p>剩余<em>${coinNum }</em>个金币</p>
                    <h3>剩余抽奖次数：</h3>
                    <p>剩余<em>${changeNum }</em>次</p>
                </div>
            	<div class="gold_right">
                	<img src="${resource_dir}/images/gold.png"/>
                </div>
            </div>
            <div class="gold_btn">
            	<a href="javascript:void(0);" onclick="goSmashingEggs()">去抽奖</a>
            </div>
        </div>
      </div>
    </div>
  </div>
</div>

 
<P class=mouseTips><I></I></P>

<%@ include file="../foot.jsp" %>
</body>
</html>
