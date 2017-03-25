<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<html>
	<head>
		<title>蒲公英金融服务平台——登录</title>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/login.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/index.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css" />
		<script type="text/javascript"	src="${resource_dir}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>

		<script type="text/javascript">
      
        function baseLogin(){
             var phone=$("#mobilePhone").val();  
			 var mi1=$("#password").val();
			 
			 var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
	         if (!reg.test(phone)) {
	            $("#show_error").show();
	            $("#show_error").html("请输入正确的手机号！");
	            return;
	         }
			 if(phone==""||mi1==""){
			   $("#show_error").show();
			   $("#show_error").html("用户名或密码不能为空！");
			   return;
			 }
			
			var code = $("#loginCode").attr("value");
			if(code.length<4){
			   $("#show_error").show();
			   $("#show_error").html("请输入4位图片验证码！");
			   return;
			}
			$("#btnLogin").val("登录中...");
			$("#btnLogin").attr("disabled","disabled");
			         $.ajax({
						    async: false,
						    type: "post",
							url:  '${ctx}/baseInfo/checkLogin?newData='+Math.floor(Math.random()*10),
							data: "userName="+strEnc(phone,'${key}')+"&password="+strEnc(mi1,'${key}')+"&code="+code+"&codeType=loginCode",
							success: function (msg) {
							  var yzm=msg.yzm;
							  var value=msg.value;
							  if(yzm=="06"){
							     $("#show_error").show();
							 	 $("#show_error").html("验证码错误");
							 	 $("#loginCode").focus();
							 	 $("#loginCode").val(""); 
							 	 changeImg();
							 	 $("#btnLogin").val("登  录"); 
							 	 $('#btnLogin').attr("disabled",false);
							  }else if(value=="03"){
							       // 登陆成功 返回上一页并刷新页面
							       var historyUrl=document.referrer;
							       var redirect=$("#redirect").val();
							       if(""!=redirect&&redirect!=null&&redirect.length>0){
							           if("/arcOrder/orderConfirm"==redirect){
							              self.location=document.referrer;
							           }else if("/account/myassets"==redirect){
							              window.location.href = "${ctx}"+redirect;
							           }else{
							               window.location.href = "${ctx}/item/index";
							           }
							       }else{
							           window.location.href = "${ctx}/item/index";
							       }
							  }else{
							     var err = msg.err;
							     var message;
							     $("#show_error").show();
							     if("lock"==err){
							        message="密码输错3次已被锁定，24小时后重试！"
							     }else if(undefined==err||err==""){
							        message="您的用户名或密码输入错误！";
							     }else if("02"==err){
							        message="企业用户暂不允许登陆！";
							     }else{
							        if("0"==err){
							          message="密码输错3次已被锁定，24小时后重试！"
							        }else{
							           var  kh;
							           if("1"==err){
							             var  kh= 2;
							           }else{
							              kh= 1;
							           }
							           message="密码输入错误"+kh+"次，还剩"+err+"次机会！";
							        }
							     }
							     $("#loginCode").focus();
							 	 $("#loginCode").val("");
							 	 changeImg();
							     $("#show_error").html(message);
							     $("#btnLogin").val("登  录");
							     $('#btnLogin').attr("disabled",false);
							  }
							}
						});
		}
    
     $("#loginCode").live("focus", function () {
         $("#spn_loginCode").hide();
         inputColor(this,null);
    }).live("blur", function () {
        var loginCode= $("#loginCode").val();
         if(''==loginCode||undefined==loginCode){
          $("#spn_loginCode").show();
         }else if($(this).val().length<4){
			   $("#show_error").show();
			   $("#show_error").html("请输入4位图片验证码！");
			   return;
         }else{
           $("#show_error").hide();
         }
    });
    
    
    $("#password").live("focus", function () {
         $("#spn_PasswordNote").hide();
         inputColor(this,null);
    }).live("blur", function () {
        var password= $("#password").val();
         if(''==password||undefined==password){
          $("#spn_PasswordNote").show();
         }
    });
   
    $("#mobilePhone").live("focus", function () {
           $("#spn_mobilePhone").hide();
           $("#show_error").hide();
           inputColor(this,null);
    }).live("blur", function () {
          var mobilePhonek = $("#mobilePhone").val();    // spn_PasswordNote1
         if(''==mobilePhonek||undefined==mobilePhonek){
             $("#spn_mobilePhone").show();
             $("#show_error").show();
             inputColor(this,"black");
         }else{
            var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
	        if (!reg.test(mobilePhonek)) {
	            $("#show_error").show();
	            $("#show_error").html("请输入正确的手机号！");
	        }
         }
    });
    
     function changeImg(){    
	    var imgSrc = $("#imgObj");    
	    var src = "${ctx}/authimg?codeType=loginCode&now="+Math.random();   
	    imgSrc.attr("src",src);    
	} 
    
   function inputColor(ctrl,ftType){
        $(ctrl).css({"color":"#666"});
        if (ftType == 'black') {
          $(ctrl).css({"color":"#ccc"});
        }
    }
    
    
</script>

	</head>
	<body class="gray-bg">
		<%@ include file="../header.jsp"%>
		 
		<!--logo及主导航-->
          <input type="hidden" value="${param.redirect}" id="redirect"/>
		<!--主体-->
		<form class="ui-form login-form" method="post" action="">
			<div class="login-wrap">
				<div class="login">
					<!--手机+密码-->
					
					<div class="ui-form-item lg-username">
						<div class="ui-input-box">
							<span class="ui-icon icon-mb"></span>
							<input  type="text" maxlength="11" autocomplete="off"
								qiantu_txtusername="Qiantu" id="mobilePhone" name="mobilePhone"
								l_type="0" class="ui-input  login-ui-input" style="height:40px;"/>
				             <span class="login-tips-text" style="padding-left:52px;padding-top:10px;"
								id="spn_mobilePhone">请输入手机号</span>
						</div>						
						<span class="tips-correct"></span>
					</div>

					<div class="ui-form-item lg-password">
						<div class="ui-input-box">
							 
							<span class="ui-icon icon-mm"></span>
							<input oncopy="return false;" onpaste="return false" style="height:40px;" type="password" maxlength="16"
								id="password" name="password" l_type="0" class="ui-input  login-ui-input"/>
                               <span class="login-tips-text" style="padding-left:52px;padding-top:10px;"
								id="spn_PasswordNote">请输入密码</span>
						</div>
					</div>
					<div class="ui-form-item " style="padding-top:10px; margin-bottom:5px;">
						<div class="ui-input-box" style="width:168px;">
							<span class="ui-icon icon-yz"></span>
							<input type="text" maxlength="4" oncopy="return false;" onpaste="return false"
								id="loginCode" name="loginCode" l_type="0" class="ui-input  login-ui-input" style="width:90px;"/>
                             <span class="login-tips-text" style="width:100px;padding-left:52px;padding-top:10px;" id="spn_loginCode">图片验证码</span>     
						</div>
						
							<img id="imgObj" class="yzm" title="看不清?请点击" style="cursor: pointer;" onclick="changeImg()" src="${ctx}/authimg?codeType=loginCode"/>   
					</div>
					
					
					<div class="ui-form-item clear">
					    <div style="height:28px;">
						    <div id="show_error" class="ui-tips  ui-tips-login"
								show_error="Qiantu">
								<i></i>
							</div>				
                        </div>
						<input type="button" class="ui-button lg-submit-btn"
							qiantu_btnlogin="Qiantu" l_type="0" id="btnLogin"
							onclick="baseLogin()" value="登&nbsp;&nbsp;录" />


						<p class="lg-form-other"  style="float: left;">
							还没有账号，请&nbsp;
							<a title="注册" href="${ctx}/baseInfo/register" class="textlink">注册</a>
						</p>
						<p class="lg-form-other" style="text-align: right; style="float: right;"">
							<a title="忘记密码"  href="${ctx}/account/retrievePassword"	class="textlink">忘记密码？</a>
						</p>
					</div>

				</div>
			</div>
			<!--框结束-->
			<!--banner-->
			<div class="banner-wrap">
				<div class="banner banner-login">
					<div class="banner-item"
						style="display: block; background-color:#FFB342;">
						<img style="margin-left:6%;" src="${resource_dir}/images/login_banner.png"> 
					</div>
				</div>
			</div>
			<div class="module mod-featrue">
				<div class="wrap-960">

					<div class="mod-contnet">
						<ul class="mod-list mod-listmt">
							<li class="cell-item" style="background: none;">
								<i class="cell-item-icon"> <img alt=""
										src="${resource_dir}/images/icon_td_5.png" name=""> </i>
								<h3 class="cell-item-title">
									精选顶目
								</h3>
							</li>
							<li class="cell-item" style="background: none;">
								<i class="cell-item-icon"> <img alt=""
										src="${resource_dir}/images/icon_td_6.png" name=""> </i>
								<h3 class="cell-item-title">
									稳健收益
								</h3>
							</li>
							<li class="cell-item" style="background: none;">
								<i class="cell-item-icon"> <img alt=""
										src="${resource_dir}/images/icon_td_7.png" name=""> </i>
								<h3 class="cell-item-title">
									安全保障
								</h3>
							</li>
							<li style="background: none;" class="cell-item">
								<i class="cell-item-icon"> <img alt=""
										src="${resource_dir}/images/icon_td_8.png" name=""> </i>
								<h3 class="cell-item-title">
									零手续费
								</h3>
							</li>
						</ul>
					</div>
					<div>
					</div>
				</div>
			</div>
			<!--服务特点结束-->

			<!--服务特点 结束-->
			<!-- script开始 -->
			<script type="text/javascript">
    function init() {

        $(".ui-input-box").focus(function () {
            //$(this).siblings(".ui-select-list").show()
            $(this).addClass("on-focus");

        })
        $(".ui-input-box").blur(function () {
            $(this).siblings(".ui-select-list").hide()

        })
        $(".ui-input-box").click(function () {
            $(this).children(".login-tips-text").hide()
            $(this).children(".ui-input").focus();
        })

        if ($("#Pwd").val() != "") {
            $(".lg-password .login-note").empty();
        }
        if ($("#UserName").val() != "") {
            $(".lg-username .login-note").empty();
        }

    }
    $(document).keyup(function (e) {
        if (e.keyCode == 13) {
            $("#btnLogin").click();
        }
    })

    $(".login-ui-input").focus(function () {
        $(this).siblings(".ui-select-list").show();
        $(this).parent(".ui-form-item").children(".login-note").hide();
        $(this).addClass("on-foucs");

    })
    $(".login-ui-input").blur(function () {
        $(this).siblings(".ui-select-list").hide()

    })
    $(".ui-form-item").click(function () {
        $(this).children(".login-note").hide();
        $(this).children(".ui-input").focus();
    })
    $(function () {
        //changeIMG();
        init();
        $("#divQQbox").hide();
		$(".login").animate({right:"200px"},"slow")
    })
</script>
		</form>
		<%@ include file="../foot.jsp"%>
	</body>
</html>
