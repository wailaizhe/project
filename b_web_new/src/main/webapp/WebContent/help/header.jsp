<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>header</title>
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">
<script type="text/javascript">
var data1="03";
$(function(){
  		$.ajax({
	        url: '${ctx}/account/isLand?now='+Math.random(),
	        async:false,
	        success: function(data) {
	             data1 =data;
	        }
		 });
         if(data1=="03"||data1.length>20){
	          $(".nav2").html("<a href='${ctx}/baseInfo/login' class='login'>登录</a><a href='${ctx}/baseInfo/register'  class='reg'>注册</a>");
	      }else{
	      	   $(".nav ul").append("<li><a href='${ctx}/account/myassets' >我的账户</a></li><li><a href='${ctx}/baseInfo/loginOut?now="+Math.random()+"'  style='color:#999;font-size:20px;'>安全退出</a></li>");
	      }
 })
</script>
<script type="text/javascript">
    function addBookmark() {
    return;
        if (window.sidebar && window.sidebar.addPanel) { // Mozilla Firefox Bookmark
            window.sidebar.addPanel(document.title, window.location.href, '');
        } else if (window.external && ('AddFavorite' in window.external)) { // IE Favorite
            window.external.AddFavorite(location.href, document.title);
        } else if (window.opera && window.print) { // Opera Hotlist
            this.title = document.title;
            return true;
        } else { // webkit - safari/chrome
            alert('Press ' + (navigator.userAgent.toLowerCase().indexOf('mac') != -1 ? 'Command/Cmd' : 'CTRL') + ' + D to bookmark this page.');
        }
    }
    $("#icon_wx").click(function () {
        $("#window_1").show();
    })
    
</script>
</head>

<body>
<!--头部开始-->
<div class="head">
	<div class="head_main1">
    	<div class="logo">
        	<a><img src="${resource_dir}/images/logo.jpg"/></a>
        </div>
        <div class="nav_section">
        	<div class="nav">
                <ul>
                    <li class="current"><a href="${ctx}/item/index">首&nbsp;&nbsp;&nbsp;页</a></li>
                    <li><a href="${ctx}/item/gotoInvestmentList">惠赚钱</a></li>
                    <li><a href="${ctx}/invest/gotoloanApply">惠贷款</a></li>
                    <li><a href="${ctx}/item/eShop">惠生活</a></li>
                </ul>
            </div>
            <div class="nav2">
            	
            </div>
        </div>
    </div>
</div>
<!--头部结束-->
</body>
<script type="text/javascript">
		//控制页面头部选中样式
		$('ul li a').each(function(){
		    if($($(this))[0].href==window.location){
		        $(this).parent().addClass('current');
		        $(this).parent().siblings("li").removeClass("current");
		        $(this).removeAttr("href");
		    }
		    if((window.location.toString()).indexOf("/account/")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==3){
						$(this).parent().addClass('current');
				        $(this).parent().siblings("li").removeClass("current");
				        $(this).removeAttr("href");
				    }
				});
		    }
		    if((window.location.toString()).indexOf("/helpCenter/")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==4){
						$(this).parent().addClass('current');
				        $(this).parent().siblings("li").removeClass("current");
				        $(this).removeAttr("href");
				    }
				});
		    }
		    if((window.location.toString()).indexOf("findDetail")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==1){
						$(this).parent().addClass('current');
				        $(this).parent().siblings("li").removeClass("current");
				        $(this).removeAttr("href");
				    }
				});
		    }
		    
		    if((window.location.toString()).indexOf("arcOrder")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==1){
						$(this).parent().addClass('current');
				        $(this).parent().siblings("li").removeClass("current");
				        $(this).removeAttr("href");
				    }
				});
		    }
		    
		});
	</script>
</html>