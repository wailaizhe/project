<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>

<html>
<head>
<meta charset="utf-8">
<title>邀请有好礼</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/activity.css">
<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<!-- 滚动控制 -->
<script src="${resource_dir}/js/scroll.js"></script>
</head>

<body>
<body>
<!--头部开始-->
<%@ include file="../header.jsp"%>
<!--头部结束-->
<div class="actbg"></div>
<div class="actmain">
	<div class="yq">
    	<div class="yqtit">
        	<p>成功邀请满15-29人，送京东电子购物卡：<img src="${resource_dir}/images/20160906/icon1.jpg"/> 50元</p>
        	<p>成功邀请满30人及以上，送京东电子购物卡：<img src="${resource_dir}/images/20160906/icon2.jpg"/> 100元<em>活动时间：2016年9月15日至2016年10月14日</em></p>
        </div>
        <div class="yqmain">
        	<ul>
            	<li>登录“我的账户”进入“我的推荐”页面点击“<a href="${ctx}/account/toMyInvited">复制链接</a>”分享给好友注册</li>
                <li>登录手机APP进入“我的账户”-“我的推荐”页面，点击“复制链接”通过微信、QQ或短信形式分享给好友注册</li>
                <li>登录手机H5页面进入“我的账户”-“我的推荐”页面，点击“复制链接”通过微信、QQ或短信形式分享给好友注册</li>
                <li>好友注册时，在邀请码栏准确填写邀请人手机号</li>
            </ul>
        </div>
        <div class="yqbtn">
        	<a href="${ctx}/account/toMyInvited"></a>
        </div>
    </div>
    <div class="activity">
    	<div class="activitymain">
        	<h3>活动细则：</h3>
            <P>1.  活动时间：2016年9月15日-10月14日</P>
            <P>2.  活动奖励：</P>
            <P class="indent">成功邀请15-29人，送一张50元的京东电子购物卡</P>
            <P class="indent">成功邀请30人及以上，送一张100元的京东电子购物卡 </P>
            <P class="indent">50元和100元的京东购物卡不可兼得；</P>
            <P>3.  成功邀请条件：必须在活动时间内，邀请人本人必须是已注册并绑卡的用户，被邀请人完成注</P>
            <P class="indent">册并绑卡成功；</P>
            <P>4.  查看邀请记录：进入个人中心的我的邀请页查看邀请名单；</P>
            <P>5.  活动结束后，平台会统计满足邀请条件的邀请人的数量和名单；我们将以短信形式把京东购物</P>
            <P class="indent">卡卡号、密码发送到邀请人注册的手机上；</P>
            <P>6.  本活动规则最终解释权归蒲公英银行互联网金融服务平台所有；</P>
            <P>7.  本次活动提供商品与苹果公司无关。</P>
        </div>
    </div>
    <div class="record">
    	<!-- 邀请列表 -->
    	<div class="recordmain" id="activity-recommend-table"></div>
    </div>
</div>




<script type="text/javascript">
	
	
	
	//初始化
	$(function () {
		findActivityList(false, 1);//加载活动推荐列表
		$("div.list_lh").myScroll({
			speed:40, //数值越大，速度越慢
			rowHeight:68 //li的高度
		});
	});
	
	

	//查询活动推荐列表
	function findActivityList(flag, pi) {
	    var submitData = {};
	    //查询条件 开始
	    submitData.condition={};
	    submitData.condition.PageIndex = pi; //控制第几页
	    submitData.condition.PageSize = 10;   //控制每页显示条数
	    //查询条件 结束
	
	    $.ajax({
        	url: "${ctx}/baseInfo/queryInvited?type=activityIndex&newD="+Math.random(),
       	 	type: 'post',
        	data: 'jsonStr='+JSON.stringify(submitData.condition),
       	 	dataType: 'json',
        	async: false,
        	error: function (err) {
					     alert("网络繁忙！");
					},
        	success: function (jsonResult) {
	            if(jsonResult!=null){
	                 Data.activityList  = jsonResult.datas;
		       		 $("#activity-recommend-table").html("");
		             $("#activity-recommend-tmpl").tmpl().appendTo("#activity-recommend-table");
		             
		            /*  var data = jsonResult.datas;
		             for(var i=0;i<data.length;i++){
	   					var cardMage = data[i][3] ? '已绑卡' : '未绑卡';
	   					var html="<li class='hdmain'><span>"+data[i][4]+"</span><span class='line'>"+data[i][1]+"</span><span>"+data[i][2]+"</span><span>"+cardMage+"</span></li>";
	   					$(html).appendTo($("#dataUl"));
	   					} */
					}
				}
					
  			});
	   }

</script>


<script id="activity-recommend-tmpl" type="text/x-jquery-tmpl">
		  <div class="recordtit">
             <h3>活动邀请记录</h3>
             <p><a href="${ctx}/account/toMyInvited?type=activity">查看我的邀请记录>></a></p>
         </div>
         <div class="hdtit">
             <span>邀请人</span>
             <span>被邀请人</span>
             <span>注册时间</span>
             <span>状态</span>
         </div>
		 <div class="list_lh">
		 	<ul id="dataUl">
         		{{each(i,v) Data.activityList}}
             		<li class="hdmain">
						<span>{{= v[4]}}</span>
						<span>{{= v[1]}}</span>
						<span>{{= v[2]}}</span>
						<span>{{if v[5]}}已绑卡{{else}}未绑卡{{/if}}</span>
			 		</li>
         		{{/each}}
		 	</ul>
		 </div>
		 <br />
		<p class="sm">说明：邀请人本人必须是已注册并绑卡的用户，被邀请人完成注册并绑卡成功</p>
</script>


</body>
<%@ include file="../foot.jsp"%>
</html>