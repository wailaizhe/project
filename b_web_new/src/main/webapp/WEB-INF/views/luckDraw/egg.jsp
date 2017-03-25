<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>砸金蛋</title>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport"/>
<script src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/scroll.js"></script>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/egg.css">
<script>
function  zadan(obj) { 
	
    $(obj).children("span").hide(); 
    eggClick($(obj)); 
}; 
function donghua(){
  $("#hammer").animate({top:"20%",left:"65%"},1000);
  $("#hammer").animate({top:"25%",left:"70%"},1000);

}
var dingshi=setInterval("donghua()",2000);
var dansui=1;
function eggClick(obj) { 
		if(dansui<1){
			// alert("蛋都碎了，请勿再敲，马上给你换一个！");
			location.reload();
			return;
		}
    	var randomMath;
	    var str= new Array();   
	    $.ajax({
		      type: "post",
		      async: false,
		      url:'${ctx}/awardCtl/smashingEggs',
		      success: function(data){
		        randomMath = data;
		      }
		});
		if("nullUser"==randomMath){
		   window.location.href="${ctx}/baseInfo/login"
		} 
	    str=randomMath.split("_"); 
	    var resultC;
	    if("5"==str[0]){
	      resultC= "很遗憾,请再接再励！"; 
	    }else if("-1"==str[0]){
	      resultC = "您剩余抽奖次数为0";
	    }else{
	      resultC="恭喜您获取"+str[1]+"金币！"; 
	    }
	    dansui=0;
	    clearInterval(dingshi);
        var _this = obj; 
		$("#hammer").stop(true);
		clearInterval(dingshi);
        $(".hammer").css({"top":"20%","left":"65%"});
        setTimeout(function(){
       	   _this.addClass("curr"); //蛋碎效果 
           _this.find("sup").show(); //金花四溅 
           $(".hammer").hide();//隐藏锤子 
           $('.resultTip').css({display:'block',top:'20%',left:'32%',opacity:0}).animate({top: '20%',opacity:1},300,function(){    
	           dansui=0;
	           $("#result").html(resultC); 
	       })
		},300)
} 
</script>
<script type="text/javascript">
$(function(){
	$("div.list_lh").myScroll({
		speed:40, //数值越大，速度越慢
		rowHeight:200 //li的高度
	});
});
</script>

</head>


<body style="background:url(${resource_dir}/images/bg.jpg) center 0 no-repeat;min-height:3000px;">
<%@ include file="../header.jsp"%>
<div class="egg">
<div class="muji">
</div>
<ul class="eggList">
	<p class="hammer" id="hammer">锤子</p>
	<li id="jindan" onclick="zadan(this)">
        <span></span>
        <p class="resultTip" id="resultTip"><b id="result"></b></p>
    </li>
</ul>
</div>
<div class="reward">
	<div class="reward_top">
         <h1>目前共有${eggSize}个金蛋被砸开</h1>
    </div>
    <div class="reward_list">
    	<h3>最新获奖名单</h3>
        <div class="rewardlistbg">
        	<img src="${resource_dir}/images/reward_bg.png"/>
        </div>
        <div class="rewardmain">
            <div class="listmain">
                <ul>
                    <li>会员账号</li>
                    <li style="width:28%;">金币奖励</li>
                    <li style="width:30%;text-align:right;padding-right:9%;">参与时间</li>
                </ul>
            </div>
            <div class="list_lh">
                <ul>
                    <c:forEach var="couent" items="${list}">
                    <li>
                        <span style="width:27%;">${couent.moblicPhone}</span>
                        <span style="width:31%;">${couent.totalCoinNum}金币</span>
                        <span style="width:40%;">${couent.createDate}</span>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="act">
    <div class="act_bg">
        <img src="${resource_dir}/images/act_bg.png"/>
    </div>
    <div class="act_main">
    	<div class="act1">
        	<h3>奖项设置</h3>
           	<p>特等奖：800-1000金币</p>
           	<p>一等奖：81-100金币</p>
           	<p>二等奖：51-80金币</p>
           	<p>三等奖：31-50金币</p>
           	<p>四等奖：1-30金币</p>
        </div>
    	<div class="act1">
        	<h3>抽奖机会</h3>
           	<p>1）每成功注册平台可获得1次抽奖机会</p>
           	<p>2）首次成功绑定银行卡可获得1次抽奖机会</p>
           	<p>3）每成功邀请1名注册用户可获得1次抽奖机会，每成功邀请1名注册用户并绑卡可获得2次抽奖机会</p>
           	<p>4）每成功购买一款产品可获得1次抽奖机会</p>
            <p>5）抽取获得的金币可在【账户】--“我的金币“里查看</p>
        </div>
    	<div class="act1">
        	<h3>金币使用规则</h3>
           	<p>1）金币不可提现，但购买产品支付时每10个金币可抵扣1元人民币</p>
           	<p>2）限期在有效期内使用，获得的金币需在90天内使用，逾期自动失效</p>
        </div>
        <div style="padding-top:20px;font-size:22px;">
           <b>本活动规则最终解释权归蒲公英银行互联网金融服务平台所有</b>
        </div>
    </div>
</div>
</body>
<%@ include file="../foot.jsp"%>
</html>