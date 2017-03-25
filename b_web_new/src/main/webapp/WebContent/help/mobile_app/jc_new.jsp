<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>晋城农商银行-手机理财</title>
<link href="${resource_dir}/css/jc_new.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
<script>
var countAdrDownLoad = 0;
var mobileGzCount = 0;
$(function(){
	$("#androidA").click(function(){
		if(countAdrDownLoad!=0){
			return;
		}
		var count = parseInt($("#downLoadCount").text());
		count++;
		$("#downLoadCount").text(count);
		countAdrDownLoad++;
	});
	
	$("#mobileA").click(function(){
		if(mobileGzCount!=0){
			return;
		}
		var count = parseInt($("#gzCount").text());
		count++;
		$("#gzCount").text(count);
		mobileGzCount++;
	});
	
});
</script>
</head>

<body>
<div class="wrap">
	<div class="head_section">
    	<i><a href="${ctx}/item/index"><img src="${resource_dir}/images/mobile_app/logo.png"  /></a></i>
        <span>客服热线：0356-2210820</span>
    </div>
    <div class="context_section">
    	<div class="pic1_div"><img src="${resource_dir}/images/mobile_app/pic1.png" /></div>
        <div class="load_app">
        	<div class="pic2_div"><img src="${resource_dir}/images/mobile_app/pic2.png" /></div>
            <div class="app_con">
        	<div class="app_button">
        		<a style="cursor:default;" id="androidA"><img src="${resource_dir}/images/mobile_app/android.png" /></a>
            	<a style="cursor:default;"><img src="${resource_dir}/images/mobile_app/ios.png" /></a>
            </div>
            <div class="app_ma">
            	<i><img src="${resource_dir}/images/mobile_app/app1.png" /><br />扫一扫，下载App</i>
                <i><img src="${resource_dir}/images/mobile_app/app2.png" /><br />扫一扫关注微信账号</i>
            </div>
            </div>
        </div>
        <div class="s3">
        <div class="section_3">
        	<ul>
            	<li>
                	<h5>优质理财项目为你而来</h5>
                </li>
                <li>
                	<h6>银行全程见证</h6>
                </li>
                <li>
                	<h6>好项目层出不穷</h6>
                </li>
            </ul>
        </div></div>
        <div class="s4">
        <div class="section_4">
        	<ul>
            	<li>
                	<h5>随时随地,查看资产明细</h5>
                </li>
                <li>
                	<h6>你贴身的财富增值管家</h6>
                </li>
            </ul> 	
        </div></div>
        
    </div>
    
    <!--服务模块开始-->

<!--服务模块结束-->

</div>
<%@include file="../foot.jsp"%>
</body>
</html>
