<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="com.maiseries.core.bank.web.common.kit.CookieKit"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<%
String status=(String)session.getAttribute("status");

%>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/common_v2.css">

<script type="text/javascript">

$(function(){
		
        	var status=<%=status%>
             if(status!="01"){
            	   
            	 $(".nav2").html("<a href='/login' class='login'>登&nbsp;&nbsp;录</a><a href='/register'  class='reg'>注&nbsp;&nbsp;册</a>");
             }else{
            	 $(".nav ul").append("<li><a href='/account/myassets' >我的账户</a></li><li><a href='/loginOut?now="+Math.random()+"'  style='color:#999;font-size:20px;'>安全退出</a></li>");
            	   
             }
            
        
	
})
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
        	<a style="cursor:default;"><img src="${resource_dir}/images/logo.jpg"/></a>
        </div>
        <div class="nav_section">
        	<div class="nav">
                <ul>
                    <li class="current"><a href="/index">首&nbsp;&nbsp;&nbsp;页</a></li>
                    <li><a href="${ctx}/investment/touzi">惠赚钱</a></li>
                    <li><a href="${ctx}/loan/gotoLoan">惠贷款</a></li>
                    <li><a href="${ctx}/investment/eShop">惠生活</a></li>
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
$(document).ready(function () {
	   //控制页面头部选中样式
		$('ul li a').each(function(){
		    if($($(this))[0].href==window.location){
		        $(this).parent().addClass('current');
		        $(this).parent().siblings("li").removeClass("current");
		        $(this).removeAttr("href");
		    }
		    if((window.location.toString()).indexOf("/account/")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==4){
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
		    
		    if((window.location.toString()).indexOf("/invest/")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==2){
						$(this).parent().addClass('current');
				        $(this).parent().siblings("li").removeClass("current");
				        $(this).removeAttr("href");
				    }
				});
		    }
		    
		    if((window.location.toString()).indexOf("/awardCtl/")>-1){
		    	$('.nav ul li a').each(function(i){
				    if(i==0){
						$(this).parent().addClass('current');
				        $(this).parent().siblings("li").removeClass("current");
				        $(this).removeAttr("href");
				    }
				});
		    }
		    
		    
		});
});
	</script>
</html>