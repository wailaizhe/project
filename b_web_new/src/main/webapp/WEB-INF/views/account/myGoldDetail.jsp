<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<TITLE>蒲公英金融服务平台——我的金币详情</TITLE>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<META content="text/html; charset=utf-8" http-equiv=Content-Type>
    <link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
    <link rel=stylesheet type=text/css	 href="${resource_dir}/css/public.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>、
</head>
<script type="text/javascript">
$(function () {
	 
		var startdate=new Date().getHours();
	    var startMin=new Date().getMinutes();
         iconN();
        GoSearch(false, 1);
        
     $("#ccp").html(FormatDigital($("#ccps").val()));
	 $("#inc").html(FormatDigital($("#incs").val()));
	 
	 
	 var URL= window.location.toString();
   	URL=URL.substring(0,URL.indexOf("${ctx}"))+$("#invitedURL").val();
	$("#UrlInput").val(URL);
        
});

function iconN(){
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


function changeStatus(){
    GoSearch(false, 1);
}
function GoSearch(flag, pi) {
    var submitData = {};
    submitData.targetUrl = "${ctx}/baseInfo/queryGoldDetail?newD="+Math.random();
    //查询条件 开始
    submitData.condition={};
    submitData.condition.PageIndex = pi; //控制第几页
    submitData.condition.PageSize = 8;   //控制每页显示条数
    //查询条件 结束
    RenderTmpl({
            Data: submitData,
            TmplSource: "#tmpl_projectList",    // 需要显示的模板列表
            TmplTarget: "#myproject-list",      
            AfterFn:function (result) {
               
                if (result.totalCount < 1) {
                    $("#myproject-list").html('<div class="can-not-find0" style="background:url(${resource_dir}/images/empty_box.jpg) no-repeat center; text-align:center; font-size:18px; line-height:24px; padding-top:200px;"><p>暂无记录</p></div>');
                    $("#pagerHolder").html("");
                    $(".table_head").hide();
                }else if(result.totalCount < submitData.condition.PageSize) {
                    $("#pagerHolder").html("");
                    $(".table_head").show();
                    iconN();
                }else{
                    $("#pagerHolder").html(GetPagerHtmlSpan({
                        index: submitData.condition.PageIndex,
                        size:  submitData.condition.PageSize,
                        total: result.totalCount,
                        fnName: "GoSearch"
                    }));
                    iconN();
                    $(".table_head").show();
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
		<a href="${ctx}/item/index">首&nbsp;页</a>&nbsp;&gt;&nbsp;我的金币详情
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
										<A  href="${ctx}/account/toMyInvited"><I class=nav-icon4></I>我的推荐</A>
									</li>
									<li>
										<A class="current" href="${ctx}/account/toMyGold"><I class=nav-icon6></I>我的金币</A>
									</li>
						</ul>
					</li>
				</ul>

<!--侧栏菜单结束--> 
      </div>
      <div class="ui-plate-main">
        <h3 class="my-account-title"><span class="title" style="padding:0;"><img src="${resource_dir}/images/jbDetail.png"/></span></h3>
        <div id="tab2" class="myproject_nav clearfix" >
			<div class="gold_detail">
            	<div class="invite_main myproject-list"  id="myproject-list">
            	
            </div>
            
            <!--分页-->
            <div class="mod-page" id="pagerHolder">
                <a class="page-num">&lt;&lt;</a><a class="page-num">&lt;</a><a class="page-num current" href="javascript:void(0)">1</a><a class="page-num" href="javascript:GoSearch(false,2)">2</a><a class="page-num" href="javascript:GoSearch(false,2)">&gt;</a><a class="page-num" href="javascript:GoSearch(false,2)">&gt;&gt;</a>
            </div>
            </div>
        </div>
      </div>
    </div>
  </div>
</div>
		
<script id="tmpl_projectList" type="text/x-jquery-tmpl">
            <table>
                	<thead>
                    	<tr>
                        	<th>时间</th>
                        	<th>详情</th>
                        	<th>备注</th>
                        </tr>
                    </thead>
				<tbody>
             	{{each(i,v) Data.ResultList}}
                <tr>
                    <td align="center">{{html getDate(v[0])}}</td>
					<td align="center">获得{{= v[1]}}个<i><img src="${resource_dir}/images/jb_icon.png"/></i></td>
					<td align="center">{{html getRank(v[2])}}</td>
                </tr>
            	{{/each}}
				</tbody>
           </table>

</script>
<script type="text/javascript">
function getProjectProgress(p) {
   var order = p[4];
      var date = document.getElementById("newDate").value;  // 系统时间
      var EndTime= new Date(Date.parse(date.replace(/-/g,   "/")));
	  var endXi = p[8];                              
      var endXiTime = new Date(Date.parse(endXi.replace(/-/g,   "/")));  // 订单创建时间
	  var e =EndTime.getTime() - endXiTime.getTime();
	  var ed=e/1000/60;//订单生成分钟数
   if(order=="01"){
   	 var payTime = p[16];                              
       payTime = new Date(Date.parse(payTime.replace(/-/g,   "/")));  // 订单创建时间
	  var payE =EndTime.getTime() - payTime.getTime();
	   payE=payE/1000/60;//订单生成分钟数
     if(30>payE){
     	progress="<p style='font-size:14px;'>支付成功，交易确认中</p>";
     }else{
     	progress="交易成功";
     }
   }else if(order=="03"){
     progress="超募";
   }else if(order=="02"||order==null){
	  if(120>ed){
	     progress="待系统确认";
	  }else{
	     progress="未支付";
	  }
   }else if(order=="04"){
     progress="已退款";
   }else if(order=="05"){
     progress="超募";
   }else if(order=="07"){
     progress="<p>订单处理中</p>";
   }else if(order=="06"){
      progress="已兑付，3个工作日内到账";
   }else if(order=="08"){
      progress="<p>未支付</p><p style='font-size:12px; color:#999;'>支付失败</p>";
   }else if(order=="09"){
      progress="超募";
   }else if(order=="10"){
      progress="支付成功";
   }
   
	return progress;
}

function getPrHtml(p){
  var order = p[4];
  if(order=="03"||order=="05"||order=="09"){
   return '<span class="info jieshi" style="margin-left: 15px;"  alt="支付成功，投资失败"></span> ';
  }else if(order=="07"){
    return '<span class="info jieshi" style="margin-left: 45px;"  alt="订单正在排队系统将会在当天内处理完，敬请留意!"></span> ';
  }else{
     return '';
  }
}
 
function getPrHtml2(p){
   var now2 = p[2];
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
	//显示奖项
	function getRank(obj){
		if(obj=='0'){
		return "特等奖";
		}else if(obj=='1'){
		return "一等奖";
		}else if(obj=='2'){
		return "二等奖";
		}else if(obj=='3'){
		return "三等奖";
		}else if(obj=='4'){
		return "四等奖";
		}else if(obj=='used'){
		return "投资抵扣";
		}
	}
	
	
	//显示日期
	function getDate(obj){
	   var mydate = new Date(obj);
	   var mydateY = mydate.getFullYear();//年"
	   var mydateM= (mydate.getMonth()+1);//月
	   var mydateD= mydate.getDate();// 日
	   var mydate = new Date(obj);
		var mydateH= mydate.getHours(); //时
		var mydateF= mydate.getMinutes(); //分
		if(mydateF<10)
		{
			mydateF="0"+mydateF;
		}
	   return  mydateY+"-"+mydateM+"-"+mydateD+"  "+mydateH+":"+mydateF;
	}
	
	
</script>

 
<P class=mouseTips><I></I></P>

<%@ include file="../foot.jsp" %>
</body>
</html>
