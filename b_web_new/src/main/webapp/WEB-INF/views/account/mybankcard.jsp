<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<TITLE>蒲公英金融服务平台——我的银行卡</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<META name=keywords content=蒲公英金融服务平台,账户中心,会员中心>
        <link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/style.css" />
        <link rel="stylesheet" type="text/css" href="${resource_dir}/css/main.css">
        <link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
        <link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/jquery.autocomplete.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>  	
	</HEAD>
<BODY class=gray-bg>
<script type="text/javascript">
    // 添加银行卡弹出框
    function addBankAccountOnClick() {
             $("#province").html("");
		     jointProvinceStr("");
		     $("#inputBank").val("");
		     $("#city").hide();
		     $("#determineHtml").html("<span style='color: rgb(204, 204, 204);'>请核对卡号信息</span>");
		     $("#inputBank").css({"color": "rgb(204, 204, 204)"});
		     $("#txtAccountNo").css({"color": "rgb(204, 204, 204)"});
		     $("#txtAccountName").css({"color": "rgb(204, 204, 204)"});
		     $("#cardSubBankInput").html("");
		     $("#cardSubBankInput").append("<option>请选择</option>");
             $("#addBankAccount_li").attr("action-data", "bankadd||ui-window-1||800||610||absolute");
             $(".prompt_box").show();
             $.ajax({
		      url: '${ctx}/account/baseInfo?now='+new Date(),
		      success: function(data) {
		            if(""!=data.identityCard&&data.identityCard!=null&&""!=data.realName&&data.realName!=null){
		                $("#identity2").html(data.identityCard);
		                $("#realName1").html(data.realName);
		                $("#isRealName").val("1");
		            } 
		      }
		    });
          openBankS();
    }
    
    function redicte(){
      window.location.href='${ctx}/account/personInfo';
    }
    //关闭弹窗
    $(".bankadd .close").click(function () {
        $(".prompt_box").hide()
        $(".blackBg").hide()
    })
    var datasJson;
	$(document).ready(function () {
        $(".openWindow").click(function () {
            var _top = $(window).scrollTop();
            var parameters = $(this).attr("action-data");
            if (parameters == null || parameters == "") {
                return;
            }
            var paraArr = []
            paraArr = parameters.split("||")
            $(".blackBg").show()
            $("#" + paraArr[0]).show()
            if (paraArr[4] == "absolute") {
                $("#" + paraArr[0]).css({ position: paraArr[4], top: _top +50 })
                $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], left: -paraArr[2] / 2 })
            } else {
                $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], top: -paraArr[3] / 2, left: -paraArr[2] / 2 })
            }
            $("#" + paraArr[0]).find(".prompt_inner").addClass(paraArr[1]);
        });


        //银行卡下拉效果
        $(".bank-select").click(function () {
            $(this).siblings(".bank-list").show()
            $(this).addClass("bank-select-current")
        })
        $(".bank-list ul li").mouseover(function () {
            $(this).addClass("current")
        })
        $(".bank-list ul li").mouseout(function () {
            $(this).removeClass("current")
        })
        $(".bank-list ul li").click(function () {
            var temp = $(this).parent().parent()
            $(this).addClass("current")
            temp.siblings(".bank-select").empty()
            temp.siblings(".bank-select").append($(this).clone())//$(this).children().clone()
            temp.hide()
            $(".bank-select").removeClass("bank-select-current")
        });

         
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
 
       $("#ccp").html(FormatDigital($("#ccps").val()));
	   $("#inc").html(FormatDigital($("#incs").val()));
	     
	});
	
	// 查询快捷支付银行
	function openBankS(){
	     $("#oldBank").html("");
	     var datasJson1;
	     $.ajax({
	         async: false,
	         type: "post",
	         dataType: "json",
	         url: "${ctx}/account/queryBank",
	         success: function (msg) {
	         	 for(var i=0,l=msg.length;i<l;i++){
	         		datasJson1+="<option  value="+msg[i].code+">"+msg[i].text+"</option>";
	          	 } 
	         	 $("#oldBank").append(datasJson1);
	         }
       });
	}
	
	// 查询省市
	function jointProvinceStr(obj){
			var provinceStr = "<option>请选择</option>";
			$.ajax({
	            async: false,
	            type: "post",
	            url: '${ctx}/account/getTopLevelRegion',
	            success: function (msg) {
	            	for(var i=0,l=msg.length;i<l;i++){
	            		provinceStr+="<option id="+msg[i].code+" value="+msg[i].code+">"+msg[i].text+"</option>";
	            	}
	            	$("#province").append(provinceStr);
	            }
        	});
		}
	
	// 查询市
	function toggleProvince(){
		var cityStr = "";
		var pcode = $("#province").find("option:selected").val();
		if(!pcode){
			$("#city").empty();
			$("#city").css('display','none');
		}else{
			$.ajax({
	            async: false,
	            type: "post",
	            data:"pcode="+pcode,
	            url: '${ctx}/account/getcitys',
	            success: function (msg) {
	            	for(var i=0,l=msg.length;i<l;i++){
	            		cityStr+="<option id="+msg[i].code+" value="+msg[0].code+">"+msg[i].text+"</option>";
	            	}
	            	$("#city").css('display','');
	            	$("#city").empty();
	            	$("#city").append(cityStr);
	            }
        	});
		}
		checkSubBank();
	}       

    //刷新页面
    function reloadPage(){
        location.reload(true);
    }
    var flah="01";
    $("#txtAccountName").live("focus", function () {
         inputColor(this,null);
         $("#txtV").hide();
         $("#txtAccountName").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("填写储蓄卡银行卡号");
          $("#txtV").show();
          ShowHint("txtV", "err", "银行卡号不能为空");
          $("#txtAccountName").addClass("on-error");
          return;
        }
        var txtAccountName = $("#txtAccountName").val();
        var reg = /^\d{13,19}$/;
        if(!reg.test(txtAccountName)){
          $("#txtV").show();
          $("#txtAccountName").addClass("on-error");
          ShowHint("txtV", "err", "请输入合法的银行卡号(13~19位数字组成)！");
          return;
        }
        flah="02";
    }).live("keyup",function (){
        if(!isNaN(this.value.replace(/[ ]/g,""))){
           $("#determineHtml").html(this.value.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 "));//四位数字一组，以空格分割
	    }else{
	       $("#determineHtml").html("<span style='color: rgb(204, 204, 204);font-weight:normal;'>请核对卡号信息</span>");
	    }
	    if(""==this.value){
	      $("#determineHtml").html("<span style='color: rgb(204, 204, 204);font-weight:normal;'>请核对卡号信息</span>");
	    }
    });
    
    
    
    var flah1="01";
    $("#realName").live("focus", function () {
         inputColor(this,null);
         $("#txtV1").hide();
         $("#realName").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("填写真实姓名");
          $("#txtV1").show();
          ShowHint("txtV1", "err", "请填写真实姓名");
          $("#realName").addClass("on-error");
          return;
        }
        var realName = $("#realName").val();
        var reg = /^[\u4e00-\u9fa5]{2,6}$/;
        if(!reg.test(jQuery.trim(realName))){
          $("#txtV1").show();
          $("#realName").addClass("on-error");
          ShowHint("txtV1", "err", "请输入2~6个汉字的真实姓名!");
          return;
        }
        flah1="02";
    });
    
    
    var flah2="01";
    $("#identity").live("focus", function () {
         inputColor(this,null);
         $("#txtV2").hide();
         $("#identity").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("填写身份证号");
          $("#txtV2").show();
          ShowHint("txtV2", "err", "请填写身份证号");
          $("#identity").addClass("on-error");
          return;
        }
        var identity = $("#identity").val();
        var reg = /^[1-9]([0-9]{14}|[0-9|X|x]{17})$/;
        if(!reg.test(jQuery.trim(identity))){
          $("#txtV2").show();
          $("#identity").addClass("on-error");
          ShowHint("txtV2", "err", "请输入15位或18位有效身份证号码！");
          return;
        }
        flah2="02";
    });
    
    
    
   var flagh="01";
   $("#txtAccountNo").live("focus", function () {
         $("#tishi").show();
         inputColor(this,null);
         $("#accV").hide();
         $("#txtAccountNo").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function() {
        var txtAccountNo = $("#txtAccountNo").val();
        if(txtAccountNo==""){
          inputColor(this,"black");
          $(this).val("填写银行预留手机号码");
          $("#accV").show();
          $("#txtAccountNo").addClass("on-error");
          ShowHint("accV", "err", "手机号码不能为空！");
          return;
        }
        var reg = /^0{0,1}(1[0-9])[0-9]{9}$/;
	    if (!reg.test(txtAccountNo)) {
            $("#accV").show();
            $("#txtAccountNo").addClass("on-error");
            ShowHint("accV", "err", "请输入正确手机的手机号码！");
            return false;
	     }
        flagh="02";
        $("#tishi").hide();
   });
   

   $("#cardSubBank").live("focus", function () {
         inputColor(this,null);
         $("#cardSubBank").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function() {
          var cardSubBank = $("#cardSubBank").val();
          if(cardSubBank==""||cardSubBank==null){
           inputColor(this,"black");
           $(this).val("请填写支行名称");
           return;
          }
   });
    $("#inputBank").live("focus", function () {
         inputColor(this,null);
          
    }).live("blur", function() {
          var inputBank = $("#inputBank").val();
          if(inputBank==""||inputBank==null){
           inputColor(this,"black");
           return;
          }
   });
    function Json() {}
    var choseFlag;
    //添加银行卡
    function AddBankAccount() {
          var txtAccountName = $("#txtAccountName").val();
          var txtAccountNo = $("#txtAccountNo").val();
          var cardSubBank = $("#cardSubBank").val();
          cardSubBank = blankTrim(cardSubBank);
          var isRealName = $("#isRealName").val();
          var realName = $("#realName").val();
          var identity = $("#identity").val();
          var random =$("#random").val(); 
          if(flah!="02"){
             $("#txtV").show();
             $("#txtAccountName").addClass("on-error");
             if(txtAccountName==$("#txtAccountName").attr("defaultval")){
                ShowHint("txtV", "err", "银行卡号不能为空");
             }else{
                ShowHint("txtV", "err", "请输入合法的银行卡号(13~19位数字组成)");
             }
            return;
          }
          if(flagh!="02"){
              $("#accV").show();
	          $("#txtAccountNo").addClass("on-error");
	          if(txtAccountNo==$("#txtAccountNo").attr("defaultval")){
	            ShowHint("accV", "err", "手机号码不能为空！");
	          }else{
	             ShowHint("accV", "err", "请输入正确手机的手机号码！");
	          }
            return;
          }
          
          
          if("1"!=isRealName){
	          if(flah1!="02"){
	             $("#txtV1").show();
	             $("#realName").addClass("on-error");
	             if(realName==$("#realName").attr("defaultval")){
	                ShowHint("txtV1", "err", "真实姓名不能为空！");
	             }else{
	                ShowHint("txtV1", "err", "请输入2~6个汉字的真实姓名!");
	             }
	            return;
	          }
	          if(flah2!="02"){
	             $("#txtV2").show();
	             $("#identity").addClass("on-error");
	             if(identity==$("#identity").attr("defaultval")){
	                ShowHint("txtV2", "err", "身份证号不能为空");
	             }else{
	                ShowHint("txtV2", "err", "请输入15位或18位有效身份证号码!");
	             }
	            return;
	          }
	          
	         var ko = isCnNewID(identity);
	         if(!ko){
	            warnMsg("您的身份证号码输入错误,请重新输入！","关闭");
	            return;
	         }
	         var ageData = getBirthdayFromIdCard(identity)//获得出生日期
	         if(!checkAgeData(ageData)){                  //判断年龄是否大于18岁
	           warnMsg("您输入的身份证号当前未满18岁，暂时不能进行实名认证","关闭");
	           return;
	         }
	          
	          realName = strEnc(realName,'${key}');
	          //identity = strEnc(identity,'${key}');
          }
          
          var selectedCity = $('#province option:selected').val();  // 省
	      var selectedCityCode = $('#city option:selected').val();  // 市
	      var provinceName = $('#province option:selected').text();  // 省名
	      var cityName = $('#city option:selected').text();  // 市名
	      if("请选择"==selectedCity||"请选择"==provinceName){
	            warnMsg("请选择省份！","关闭");
	            return;
	      }
           var autoIn = $("#autoIn").html();
           var sonBank="0";
           var   bankName = $('#oldBank option:selected').text();
           var  bankCode = $('#oldBank option:selected').val();
               
           
           var subBankSpan = $("#subBankSpan").html();
	         if("切换自动选择"==subBankSpan){
	           var reg = /^[\u4e00-\u9fa5]{4,25}$/;
		       $("#cardSubBank").addClass("on-error");
		       if(cardSubBank==$("#cardSubBank").attr("defaultval")){
		          warnMsg("支行名称不能为空！","关闭");
		          return;
		       }else if(!reg.test(cardSubBank)){
		          warnMsg("请输入合法的支行名称(4~25位汉字组成)！","关闭");
		           return;
		       }
	         }else if("切换手动输入"==subBankSpan){
	            cardSubBank =  $('#cardSubBankInput option:selected').text();
	            if(""==cardSubBank){
	              errorMsg("支行名称不能为空！","关闭");
	              return;
	            }
	        }
	        $("#cardSubBank").removeClass("on-error");
	        $("#sendSubmit").val("绑卡中...");
	        $("#sendSubmit").attr("disabled","disabled");
            $.ajax({
	            type: "post",
	            async: false,
	            url: '${ctx}/account/addBank',
	         /*     "BankAccountName=" + strEnc(txtAccountName,'${key}')+ "&BankAccountNo=" + strEnc(txtAccountNo,'${key}')
                    + "&BankCode=" +  strEnc(bankCode,'${key}')+ "&BankName=" + strEnc(bankName,'${key}')+"&cardSubBank="+strEnc(cardSubBank,'${key}')
                    + "&BankCity=" + selectedCity + "&BankCityCode=" + selectedCityCode+"&ageData="+ageData
                    + "&cityName="+cityName+"&provinceName="+provinceName+"&identity="+identity+"&realName="+realName+"&random="+random,
                 */
                 data: {"BankAccountName":txtAccountName,"BankAccountNo":txtAccountNo,"BankCode":bankCode,
	            	 "BankName":bankName,"cardSubBank":cardSubBank,"BankCity":selectedCity,"BankCityCode":selectedCityCode,
	            	 "ageData":ageData,"cityName":cityName,"provinceName":provinceName,"identity":identity,"realName":realName
                    },
            error: function (err) {
            },
            success: function (result) {
               if("1"==result){
                    $("#showBank").show();
                    $("#hideBank").hide();
                    $("#hideBanks").hide();
                    choseFlag="1";
                 }else{
                    var countErr;
                    if("2"==result){
                      countErr="您当前绑定的银行卡已有10张,不允许继续绑定！";
                    }else if("3"==result){
                      countErr= "您提交的银行卡账号已绑定，请添加其他账号！";
                    }else if("4"==result){
                      countErr="绑卡失败，换张卡试试";
                    }else if("9"==result){
                      countErr="您已连续绑卡多次，请30分钟后再次绑定！";
                    }else{
                      countErr= "绑卡失败，换张卡试试";
                    }
                    $("#errCount").html(countErr);
                    $("#yinBank").html(bankName);
                    $("#errBank").show();
                    $("#hideBank").hide();
                    $("#hideBanks").hide();
                    $("#showBank").hide();
                    choseFlag="1";
                 }
                 $("#sendSubmit").val("确  认");
                 $("#sendSubmit").attr("disabled",false);
            }
        });
    };

   function  ShowHint(id, iocType, msg) {
         var ctrl = $("#" + id);
        $(ctrl).removeClass("tips-error");
        $(ctrl).removeClass("tips-ok");
        $(ctrl).removeClass("ui-tips-text");
        if (iocType == "ok") {
            $(ctrl).addClass("tips-ok");
        }
        else if (iocType == "err") {
            $(ctrl).addClass("tips-error");
         }
        else if (iocType == "note") {
            $(ctrl).addClass("ui-tips-text");
        }
        $(ctrl).html(msg);
    }
    function ShowInputHint(ctrl, hintType) {
        $(ctrl).removeClass("on-focus");
        $(ctrl).removeClass("on-error");
        if (hintType == "foc") {
            $(ctrl).addClass("on-focus");
        } else if (hintType == "err") {
            $(ctrl).addClass("on-error");
        }
    }
    function SetInputFont(ctrl, ftType) {
        $(ctrl).removeClass("f-6");
        if (ftType == 'black') {
            $(ctrl).addClass("f-6");
        }
    }
    function queding(){
      window.location.href='${ctx}/account/mybankcard';
    }
    
    function closeWindow(){
        $(".prompt_box").hide()
        $(".blackBg").hide()
        
       $("#accV").hide();
	   $("#txtV").hide();
	   $("#accB").hide();
	   $("#txtAccountName").removeClass("on-error");
	   $("#txtAccountNo").removeClass("on-error");
	   $("#cardSubBank").removeClass("on-error");
	   $("#txtAccountName").val($("#txtAccountName").attr("defaultval")); 
	   $("#txtAccountNo").val($("#txtAccountNo").attr("defaultval"));
	   $("#cardSubBank").val($("#cardSubBank").attr("defaultval"));
	   if("1"==choseFlag){
	     queding();
	   }
	   
	   reloadPage();
    }
    
    function  cardSubBankInput(){
       var subBankSpan = $("#subBankSpan").html();
       if("切换手动输入"==subBankSpan){
         $("#cardSubBankInput").hide(); 
         $("#cardSubBank").show();
         $("#subBankSpan").html("切换自动选择");
       }else{
         $("#cardSubBankInput").show();
         $("#cardSubBank").hide();
         $("#subBankSpan").html("切换手动输入");
       }
    }
    
    function checkSubBank(){
        var subBankSpan = $("#subBankSpan").html();
        var  bankName = $('#oldBank option:selected').text();
       
        var cityName = $('#city option:selected').text();  // 市名
        if(""!=cityName){
	        var cityStr = "";
	        $.ajax({
	            async: false,
	            type: "post",
	            data:"bankName="+bankName+"&cityName="+cityName,
	            url: '${ctx}/account/queryContactNumber',
	            success: function (msg) {
	            	for(var i=0,l=msg.length;i<l;i++){
	            		cityStr+="<option id="+msg[i].accountName+" value="+msg[0].accountName+">"+msg[i].accountName+"</option>";
	            	}
	            	$("#cardSubBankInput").empty();
	            	$("#cardSubBankInput").append(cityStr);
	            }
		     });
	     }
    }
    
    function inputColor(ctrl,ftType){
        $(ctrl).css({"color":"#666"});
        if (ftType == 'black') {
          $(ctrl).css({"color":"#ccc"});
        }
    }
    
    var bank;
    function delBank(arg){
        bank =arg;
        if(confirm("确定解绑该银行卡?")){
          dBank();
        }
    }
    function dBank(arg){
      $.ajax({
            async: false,
            type: "post",
            url: '${ctx}/account/delBank',
            data:"bankId="+bank,
            success: function (msg) {
               if("2"==msg){
                 alert("银行卡解绑成功！","关闭");
               }else{
                 alert("银行卡解绑失败，请稍后重试！","关闭");
               }
            }
		});
		location.reload(true);
		bank="";
    }
    
</script>

	<%@ include file="../index/header.jsp" %>
	    <input type="hidden"   id="isRealName" name="isRealName">
	    <input type="hidden" id="random" name="random" value="${random}"/>
		<div class="warp" style="padding-top:44px;background:url(${resource_dir}/images/account_bg.png) center 0 no-repeat;">
			<div class="container">
				<div class="mod-wrap mod-assets">
					<div class="mod-contnet my-center">
						<div class="ui-icon ui-user">
							<IMG name=头像 alt=头像 src="${resource_dir}/images/my_pic.png">
							<A href="javascript:void(0)"></A>
						</div>
						<div class="ui_left">
							<div class=user-info>
								<SPAN class=f-left><span id="newCurrentTime">欢迎您</span>，${mobile}</SPAN>
								    <A id="phone"   class="ui-icon ui-mail-p<c:if test="${baseInfo.mobliePhon!=''}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"	 alt="已绑定手机"></A>
									<A id="idCard"  class="ui-icon ui-mobile<c:if test="${baseInfo.realName!=null}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="<c:if test="${baseInfo.realName!=null}">已</c:if><c:if test="${baseInfo.realName==null}">未</c:if>实名认证"></A>
 							</div>
							<div class="investment-time">
								<P class="clear">
									上次登录时间：${baseInfo.ordeDdate}
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
				<input id="BankAccountN_Hidden" type="hidden" value="0">
				<div class="ui-main">
					<div class="ui-plate-sidebar">
						 
						<!--侧栏菜单-->
						<ul class="sidebar-nav">
							<li class="first-nav-item">
								<A href="javascript:void(0)">我的账户</A>
								<ul>
									<li>
										<a href="${ctx}/account/myassets"><i class="nav-icon1"></i>我的资产</a>
									</li>
									<li>
										<a href="${ctx}/account/investment_newList"><i class="nav-icon2"></i>投资记录</a>
									</li>
									<li>
										<a class="current" href="${ctx}/account/mybankcard"><i class="nav-icon3"></i>我的银行卡</a>
									</li>
									<li>
										<a  href="${ctx}/account/personInfo"><i	class="nav-icon4"></i>个人信息</a>
									</li>
 
									<li>
										<a  href="${ctx}/account/informationCenter"><i class="nav-icon6"></i>我的消息</a>
									</li>
									<li>
										<A  href="${ctx}/account/toMyInvited"><I class=nav-icon7></I>我的推荐</A>
									</li>
									<li>
										<A   href="${ctx}/account/toMyGold"><I class=nav-icon8></I>我的金币</A>
									</li>
								</ul>
							</li>
						</ul>
						<!--侧栏菜单结束-->
						<input id="tabIndexHidden" type="hidden" value="3">
					</div>
					<div class=ui-plate-main>
						<h3 class=my-account-title>
							<span class=title>我的银行卡</span>
						</h3>
						<div class=main-content>
							<div class=bank-tips-text>
								（温馨提示：您所添加的银行账户将用于平台项目投资支付、未来投资本金及收益回款。）
							</div>
							 <ul class="bankcard-list">
							    <c:forEach var="perSonAcIn" items="${personAcc}">
								  <li>
					            	<h3>${perSonAcIn.bankName}</h3>
					            	<i></i>
					                <p>
					                	<span class="banknum">${perSonAcIn.cardNumber}</span><em>${perSonAcIn.accountName}</em>
					                </p>
					                <div onclick="delBank('${perSonAcIn.id}');" style="cursor: pointer; position:absolute;right:5px;bottom:10px;">
					                    <img src="${resource_dir}/images/221.png" />
					                </div>
					            </li>		 
        						</c:forEach>
								<li class="addbank" style="position:relative;">
									<a onclick="addBankAccountOnClick();" id="addBankAccount_li" class="bank-card-add openWindow" href="javascript:void(0)"><em style="position:absolute;bottom:50px;left:85px;">添加银行卡</em></a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
<div class="blackBg"></div>
  <div id=bankadd class=prompt_box>
	<div class="ck_1  prompt_inner ui-window-1">
	      <h3 class=title><span style="PADDING-LEFT: 0px">绑定银行卡</SPAN><A class=close 
	href="javascript:void(0)" onclick="closeWindow();" close-ui="bankadd"></A> </H3>
	      <DIV class=bank-add-title2 id="hideBanks" ><SPAN class=span-1 style="padding-left:30px;">支付/回款账户资料（<FONT>本次投资回收的本金和利息到期后将汇入此账户</FONT>） </SPAN></DIV>
<!--  -->	<div class="conent"  id="hideBank" style="padding: 0 20px">
			<table width="100%" border="0" cellspacing="5" cellpadding="0" class="table_5">
				<tbody>
					<tr>
						<th><span class="red">*</span><span class="ui-icon" style="color: #333;">真实姓名：</span></th>
						<td><div class="ui-out-box" id="realName1">
								<div class="ui-input-box" id="realName11">
									<input type="text" maxlength="19" id="realName"  oncopy="return false;" onpaste="return false"  value="填写真实姓名" defaultval="填写真实姓名" class="ui-input w-150" style="border-radius:3px;height: 35px; line-height: 35px; width: 250px; color: rgb(204, 204, 204);"/>
								    <span id="txtV1" style="color: rgb(255, 17, 0); padding-left: 25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>
                    <tr>
						<th><span class="red">*</span><span class="ui-icon" style="color: #333;">身份证号：</span></th>
						<td><div class="ui-out-box" id="identity2">
								<div class="ui-input-box" id="identity22">
									<input type="text" maxlength="18" id="identity"  oncopy="return false;" onpaste="return false"  value="填写身份证号" defaultval="填写身份证号" class="ui-input w-150" style="border-radius:3px;height: 35px; line-height: 35px; width: 250px; color: rgb(204, 204, 204);"/>
								    <span id="txtV2" style="color: rgb(255, 17, 0); padding-left: 25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>
					
					<tr>
						<th width="28%"> <span class="red">*</span><span class="ui-icon" style="color: #333;">开户银行：</span> </th>
						<td width="70%">
							 <select  style="border-radius:3px;height: 35px; line-height: 35px; width: 250px;" onchange="checkSubBank();"  name="oldBank" id="oldBank">
							 </select>
						</td>
					</tr>
					
					<tr>
						<th> <span class="red">*</span><span class="ui-icon" style="color: #333;">银行卡号：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
									<input type="text" maxlength="19" id="txtAccountName"  oncopy="return false;" onpaste="return false"  value="填写储蓄卡银行卡号" defaultval="填写储蓄卡银行卡号" class="ui-input w-150" style="border-radius:3px;height: 35px; line-height: 35px; width: 250px; color: rgb(204, 204, 204);"/>
								    <span id="txtV" style="color: rgb(255, 17, 0); padding-left: 25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>					<tr>
						<th> <span class="red">*</span><span class="ui-icon" style="color: #333;">确认卡号：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box" style="font-size:16px;font-weight: bold;" id="determineHtml">
								    <span style='color: rgb(204, 204, 204);font-weight:normal;'>请核对卡号信息</span>
								</div>
							</div></td>
					</tr>
					<tr>
						<th> <span class="red">*</span><span class="ui-icon" style="color: #333;">手机号码：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
									<input type="text" id="txtAccountNo" maxlength="11" oncopy="return false;" onpaste="return false" value="填写银行预留手机号码" defaultval="填写银行预留手机号码" class="ui-input w-150"  style="border-radius:3px;height: 35px; line-height: 35px; width: 250px; color: rgb(204, 204, 204);"/>
								    <span id="accV" style="color: rgb(255, 17, 0); padding-left:25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>
					<tr id="tishi" style="display: none;">
		              <th> </th>
		              <td style="padding-top:0;"><div class="ui-out-box">
		                  <div class="ui-input-box" style="line-height:18px;font-size:10px;color:#999;">
		                         请填写您在银行预留的手机号码，以验证银行卡是否属于您本人
		                  </div>
		                </div>
		                </td>
		            </tr>
					<tr>
						<th align="right" valign="middle">
									<div class="text-zd">
										<span class="red">*</span><span class="ui-icon" style="color: #333;">开户省市：</span> 
									</div>
								</th>
								<td width="70%">
									<select class="ddlProvince" name="Province" id="province"
										style="height: 35px;width:130px;border-radius:3px;" onchange="toggleProvince()">
										<option selected="selected" value="">
											请选择省
										</option>
									</select>
									<select name="City" id="city" onchange="checkSubBank();"  style="border-radius:3px;width:117px;height: 35px; display: none;"></select>
						</td>
					  <tr>
						<th><span class="red">*</span><span class="ui-icon" style="color: #333;">支行名称：</span> </th>
						<td>
						    <div class="ui-out-box">
								<div class="ui-input-box">
								 	<select style="display: none;border-radius:3px;height: 35px; width: 250px;"  name="cardSubBankInput" id="cardSubBankInput">
								     <option value="-1">请选择</option>
								    </select>
								 	<input maxlength="25" type="text" id="cardSubBank"  value="请填写支行名称" defaultval="请填写支行名称" class="ui-input w-150"  style="height: 35px; line-height: 35px; width: 250px; color: rgb(204, 204, 204);border-radius:3px;"/>
								    <a href="javascript:void(0)" onclick="cardSubBankInput();" style="display:inline-block;line-height:35px;"><span class="ui-icon" id="subBankSpan" style="padding-left: 10px;font-size:14px;">切换自动选择</span></a>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<DIV class="calculator-btn" style="margin-top:25px;">
	          <INPUT type=submit style="background:#f18d01" value=确&nbsp;&nbsp;认  onclick="AddBankAccount()" id="sendSubmit" name="sendSubmit"  save-ui-bank="isrefresh"/>
	          <INPUT class=reset type=button onclick="closeWindow();" value=取&nbsp;&nbsp;消 close-ui="bankadd"/>
           </DIV></div>
	   	<div class="conent" id="showBank" style="display: none;padding: 0 80px 0 130px; background: url('${resource_dir}/images/sucess_icon.png') no-repeat 190px 0 ; ">
			<p style="line-height:70px; font-size:28px; margin-top:150px;  text-align:center;">恭喜，您已绑卡成功！</p>
			<p style="line-height:30px; font-size:14px; margin-bottom:20px;text-align:center; color:#F00;">温馨提示：建议您不要随意注销该银行卡！</p>
		    <div class="calculator-btn" style="margin-top:10px;" >
		      <input type="submit"  style="background:#f18d01;" onclick="queding();" value="确&nbsp;&nbsp;认" save-ui-bank="isrefresh"/>
		     </div>
	    </div>
	    
	    <div class="card_lose" id="errBank" style="display: none;">
 		    <i><img src="${resource_dir}/images/lose_icon.png"/></i>
		    <h3 id="errCount" style="font-weight: bold;"></h3>
		    <div class="lose_main">
		    	<div class="lose_left">
		             <!--  	<p class="red">注：<span id="yinBank"></span>储蓄卡需先开通银联无卡支付业务</p>
		            <p class="red">请去银行营业网点开通，或使用其他卡绑定.</p>  -->
		            
		            		<p>成功绑卡小贴士：</p>
					        <p>1、绑定银行卡时只能绑定借记卡，不能绑定贷记卡（透支卡），每个账户最多支持绑定10张银行卡；</p>
					        <p>2、绑定银行卡时填写的手机号需和当时在银行办理银行卡时的预留手机号码一致。预留手机号可以去办卡行重新设置哦；</p>
					        <p>3、若未开通无卡支付功能，则需要到银行开通无卡支付功能，同时需要对无卡支付额度进行设置。</p>
		            
		        </div>
		    </div>
	    </div>
	    
	    
    </div>
</div>
<P class="mouseTips"><I></I></P>
        <%@ include file="../index/foot.jsp" %>
	</BODY>
</HTML>