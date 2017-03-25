<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html public "-//w3c//dtd html 4.01 transitional//en" "http://www.w3.org/tr/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>我的资产-晋城农商银行蒲公英金融服务平台</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
<script type="text/javascript"	src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>	
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tab.js"></script>
<script type="text/javascript">
$(function(){
    $("#tab2").tab({
        trigger:"click", //触发事件，click | mousemove
        navId:".mod-detail-tab",  //tab的ID
        selCss:"tab_on", //选中时的css
        conId:".tab-list-wrap" //内容id的包围
    });
      iconNew();
      GoSearch(false, 1);
      
     $("#ccp").html(FormatDigital($("#ccps").val()));
	 $("#inc").html(FormatDigital($("#incs").val()));
})

function iconNew(){
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
 


function changeStatus(arg){
    $("#pagerHolder").html("");
    $("#investType").val(arg);
    GoSearch(false, 1);
}

function GoSearch(flag, pi) {
    var submitData = {};
    submitData.targetUrl = "${ctx}/account/myassetsList?newDate="+Math.floor(Math.random()*100);
    //查询条件 开始
    submitData.condition={};
    submitData.condition.PageIndex = pi; //控制第几页
    submitData.condition.PageSize = 8;   //控制每页显示条数
    
    var now;
    var state;
    if("022"==$("#investType").val()){  // 回款中
       now = "022";
       state ="01"
    }else if("01"==$("#investType").val()){ // 投标中
       now= "01";
       state ="01"
    }else{  // 已回款
       now= "06";
       state ="06"
    }
    $("#payType").val(now);
    submitData.condition.now = now;
    submitData.condition.state = state;
    var tmplTarget = "#myproject-list"+$("#investType").val();
    //查询条件 结束
    RenderTmpl({
            Data: submitData,
            TmplSource: "#tmpl_projectList",    // 需要显示的模板列表
            TmplTarget: tmplTarget,      
            AfterFn:function (result) {
                if (result.totalCount < 1) {
                    $("#pagerHolder").html("");
                    $(tmplTarget).html('<div class="can-not-find0" style="background:url(${resource_dir}/images/empty_box.jpg) no-repeat center; text-align:center; font-size:18px; line-height:24px; padding-top:200px;"><p>暂无记录</p></div>');
                }else if(result.totalCount < submitData.condition.PageSize) {
                    $("#pagerHolder").html("");
                    iconNew();
                }else{
                    $("#pagerHolder").html(GetPagerHtmlSpan({
                        index: submitData.condition.PageIndex,
                        size:  submitData.condition.PageSize,
                        total: result.totalCount,
                        fnName: "GoSearch"
                    }));
                    iconNew();
                 }
            }
        });
}
</script>
</head>
<body>
<%@ include file="../index/header.jsp" %>
<!--解释标签 begin-->
<div class="blackBg"></div>
<p class="mouseTips"><i></i></p>
<!--解释标签 end-->
        <input type="hidden" id="investType" value="01"/>
        <input type="hidden" id="payType" value="01"/>
        <input type="hidden" id="newDate"  name="newDate" value="${newDate}"/>
		<DIV class="warp">
			<DIV class=breadcrumb>
				<A href="${ctx}/index">首&nbsp;页</A>&nbsp;&gt;&nbsp;我的账户
			</DIV>
			<DIV class=container>
				<DIV class="mod-wrap mod-assets">
					<DIV class="mod-contnet my-center">
						<DIV class="ui-icon ui-user">
							<IMG name=头像 alt=头像 src="${resource_dir}/images/my_pic.png"/>
							<A href="javascript:void(0)"></A>
						</DIV>
						<div class="ui_left">
							<DIV class=user-info>
								<SPAN class=f-left><span id="newCurrentTime">欢迎您</span>，<span id="mobilePhone">${mobile}</span></SPAN>
									<A id="phone"   class="ui-icon ui-mail-p<c:if test="${mobile!=''}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"	 alt="已绑定手机"></A>
									<A id="idCard"  class="ui-icon ui-mobile<c:if test="${realName!=null}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="<c:if test="${realName!=null}">已</c:if><c:if test="${realName==null}">未</c:if>实名认证"></A>
							</DIV>
							<DIV class=investment-time>
								<P class=clear>
									上次登录时间：${ordeDdate}
								</P>
							</DIV>
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

					</DIV>
				</DIV>
				<DIV class=ui-main>
					<DIV class=ui-plate-sidebar>
		               <!--侧栏菜单-->
						<UL class=sidebar-nav>
							<LI class=first-nav-item>
								<A href="javascript:void(0)">我的账户</A>
								<UL>
									<LI>
										<A class="current" href="${ctx}/account/myassets"><I class=nav-icon1></I>我的资产</A>
									</LI>
									<LI>
										<A href="${ctx}/account/investment_newList"><I class=nav-icon2></I>投资记录</A>
									</LI>
									<LI>
										<A href="${ctx}/account/getAllBannks"><I class=nav-icon3></I>我的银行卡</A>
									</LI>
									<LI>
										<A  href="${ctx}/account/personInfo"><I class=nav-icon4></I>个人信息</A>
									</LI>
									<LI>
										<A  href="${ctx}/account/informationCenter"><I class=nav-icon6></I>我的消息</A>
									</LI>
									<li>
										<A  href="${ctx}/account/toMyInvited"><I class=nav-icon7></I>我的推荐</A>
									</li>
									<li>
										<A   href="${ctx}/account/toMyGold"><I class=nav-icon8></I>我的金币</A>
									</li>
								</UL>
							</LI>
						</UL>
        <!--侧栏菜单结束--> 
      </div>
      <div class="ui-plate-main">
        <h3 class="my-account-title"><span class="title">我的资产</span></h3>
        <div id="tab2" class="myproject_nav clearfix" >
          <ul id="Navi_tab2" class="mod-detail-tab clearfix">
            <!-- <li class="tab_on" id="Navi_tab2_0" onclick="changeStatus('01');"><a href="javascript:void(0)" >投标中</a></li> -->
            <li class="" id="Navi_tab2_1" onclick="changeStatus('01');"><a href="javascript:void(0)" >持有资产</a></li>
            <li class="" id="Navi_tab2_2" onclick="changeStatus('06');"><a href="javascript:void(0)" >历史资产</a></li>
          </ul>
          <!--详细-->
          <div id="Navi_box2" class="tab-list-wrap">
          
            <div class="tab-list" style="display: block;" id="myproject-list01">
            </div>
            
            <div class="tab-list" style="display:none;" id="myproject-list06">
                    
            </div>
          </div>
        <!--分页-->
		<div class="mod-page" id="pagerHolder">
		</div>
		<!--分页结束-->
          
        </div>
      </div>
    </div>
  </div>
</div>
	
<script id="tmpl_projectList" type="text/x-jquery-tmpl">
{{each(i,v) Data.ResultList}}
      <div class="myproject_title"><strong style="font-size:16px;"><span style="display:inline-block;vertical-align:middle;"><img src="${resource_dir}/images/lit.png" width="25px;" ></span> {{= v[9]}}{{= v[5]}}</strong> 
       {{html getPrHtml(v)}}
       <em class="xin jieshi" alt="晋城农商银行作为项目见证机构，已对融资方信息进行审核。项目融资方具有晋城农商银行的授信额度"></em>
       <em class="kong jieshi" alt="项目委托第三方支付公司——中金支付有限公司进行资金监管及清算服务。晋城农商银行对融资方还款环节中到期应收款项的兑付过程进行控制"></em>
        
       {{html getPrHtml11(v)}}
       {{html getPrHtmlIsNew(v)}}
       {{html getPrHtmlIsNewWhite(v)}}

      </div>
         <table width="100%" border="0" class="myprodject_table">
                <tr>
                  <td>持有金额</td>
                  <td>累计收益/净值(元)</td>
                  <td>{{html getState(v)}}</td>
                  <td>年化收益率</td>
                  <td rowspan="2" class="calculator-btn" style="text-align: right;">
                     <input  onclick="window.location.href='${ctx}/account/investRecordDetail?orderId={{= v[0]}}&itemId={{= v[1]}}'" type="button" value="查看详情"  save-ui-bank="isrefresh"/> 
                 </td>
                </tr>
                <tr>
                  <td class="myproject_black">{{html getPrHtml3(v)}}元</td>
                  <td class="myproject_black">{{html getPrHtml4(v)}}元</td>
                  <td class="myproject_red">{{html getDate(v)}}</td>
                  <td class="myproject_red">{{html getPrHtml2(v)}}%</td>
                </tr>
        </table>            
{{/each}}
</script>

<script type="text/javascript">
function getPrHtml(p){
	  var now = $("#payType").val();
	  if("01"==now){
	     return '<span class="myproject_date">起息日期：'+p[10]+'</span> <span class="myproject_date">投资时间：'+p[8]+'</span>  ';
	  }else if("022"==now){
	     return '<span class="myproject_date">结算日期：'+p[11]+'</span> <span class="myproject_date">起息日期：'+p[10]+'</span>  ';
	  }else if("06"==now){
	     return '<span class="myproject_date">项目到期日：'+p[11]+'</span>  ';
	  }
 }
 
 function getPrHtml2(p){
       var now = p[13];
       var strResult1 = parseFloat(now).toFixed(2).toString();
       return strResult1;
 }
 
 function getPrHtml3(p){
       var now1 = p[2];
       var strResult2 = FormatDigital(now1);
       return strResult2;
 }
 
  function getPrHtml4(p){
       var now2 = p[3];
       var strResult3 = FormatDigital(now2);
       return strResult3;
 }
 
 function getPrHtml11(p){
     var now1 = p[15];  
     if("01"==now1){
       return "<em class='zhuan jieshi' alt='专属项目'></em>";
     }else{
        return "";
     }
 }
 function getDate(p){
	   var date = document.getElementById("newDate").value;  // 当前时间
	   var EndTime= new Date(date);
	   var systemDate = p[10];                               // 项目起息日
	   var endXi = p[7];                                     // 项目到期日
	   var endXiTime = new Date(Date.parse(endXi.replace(/-/g,   "/")));
	   var NowTime = new Date(Date.parse(systemDate.replace(/-/g,   "/")));
	   var t =EndTime.getTime() - NowTime.getTime();
	   var e =endXiTime.getTime() - EndTime.getTime();
	   var ed=Math.ceil(e/1000/60/60/24);
	   
	   var tu = EndTime.getTime()- endXiTime.getTime(); // 当前时间 - 项目到期日 到期三天内显示已兑付
	   var ed2=Math.ceil(tu/1000/60/60/24-3);
	   
	   if(t<=0){
	     return "<em style='font-size:14px;'>交易成功</em>";
	   }else if(ed>0){
	     return "<em style='font-size:14px;'>还剩"+ed+"天</em>";
	   }else{
	     var state= p[4];
	     if("01"==state||"10"==state){
	       return "<em style='font-size:14px;'>交易成功</em>";
	     }else{
	       if(ed2>0){
	         return "<em style='font-size:14px;'>已成功兑付</em>";
	       }else{
	         return "<em style='font-size:14px;'>已兑付，3个工作日内到账</em>";
	       }
	     }
	   }
 }
 
function getState(p){
	   var date = document.getElementById("newDate").value;  // 当前时间
	   var EndTime= new Date(date);
	   var systemDate = p[10];                               // 项目起息日
	   var endXi = p[7];                                     // 项目到期日
	   var endXiTime = new Date(endXi);
	   var NowTime = new Date(systemDate);
	   var t =EndTime.getTime() - NowTime.getTime();
	   var e =endXiTime.getTime() - EndTime.getTime();
	   var ed=Math.ceil(e/1000/60/60/24);
	   if(t<=0){
	     return "状态";
	   }else if(ed>0){
	     return "距离项目到期日";
	   }else{
	     return "状态";
	   }
 }
 
 function getPrHtmlIsNew(p){
     var now1 = p[17];  
     if("01"==now1){
       return "<em class='xszx jieshi' style='width:70px;' alt='新手专享'></em>";
     }else{
       return "";
     }
 } 
 
  function getPrHtmlIsNewWhite(p){
     var now1 = p[18];  
     if("01"==now1){
       return "<em class='ding jieshi' alt='白名单专享'></em>";
     }else{
       return "";
     }
  } 
 
 
 
</script>


<%@ include file="../index/foot.jsp" %>
</body>
</html>

