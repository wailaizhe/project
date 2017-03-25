<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>下载跳转</title>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport"/>
<style>
.tz_page img{
	width:100%;
	}
</style>
<script>
window.onload=function()
{
    var oImg=document.getElementById('bgImg');
    oImg.style.width='100%';
    oImg.style.height=document.documentElement.clientHeight+'px';
    //高度为可视区的1/3
}
</script></head>

<body>
<div class="tz_page">
    <img id="bgImg" src="${resource_dir}/images/mobile_app/downloadZy.jpg"/>
</div>
</body>
<script type="text/javascript">
	var mobileUrl="http://client.jcnsh.com/jc_app/resources/DandelionBank.apk";
	var iosUrl="https://itunes.apple.com/cn/app/wan-zhuan-quan-cheng/id1071373935?mt=8";
	window.onload = function(){
		if(isWeiXin()){
		var p = document.getElementsByTagName('p');
		var s = window.navigator.userAgent;
			//p[0].innerHTML = s;
			$("#button").show();
		}else{
			//0:iPhone    1:Android
			var flag=ismobile();
			if(flag==0){
				window.location.href=iosUrl;
			}else if(flag==1){
				window.location.href=mobileUrl;
			}
		}
	}
	function isWeiXin(){
		var ua = window.navigator.userAgent.toLowerCase();
		if(ua.match(/MicroMessenger/i) == 'micromessenger'){
			return true;
		}else{
			return false;
		}
	}
	
	/**
 * [isMobile 判断平台]
 * @param test: 0:iPhone    1:Android
 */
function ismobile(test){
    var u = navigator.userAgent, app = navigator.appVersion;
    if(/AppleWebKit.*Mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))){
     if(window.location.href.indexOf("?mobile")<0){
      try{
       if(/iPhone|mac|iPod|iPad/i.test(navigator.userAgent)){
        return '0';
       }else{
        return '1';
       }
      }catch(e){}
     }
    }else if( u.indexOf('iPad') > -1){
        return '0';
    }else{
        return '1';
    }
};
</script>
</html>

