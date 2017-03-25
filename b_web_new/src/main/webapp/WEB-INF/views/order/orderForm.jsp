<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>蒲公英金融服务平台——确认投标</title>
		<meta content="text/html; charset=utf-8" http-equiv=Content-Type>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<link href="${resource_dir}/css/header_footer.css" rel="stylesheet" type="text/css"/>
		<link href="${resource_dir}/css/public.css" rel="stylesheet" type="text/css"/>
		<link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css"/>
		<link href="${resource_dir}/css/main.css" rel="stylesheet" type="text/css"/>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
        <script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/json2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/desUtil.js"></script>
	</herd>
<script type="text/javascript">

// 快捷绑卡弹出界面
function addBankAccountOnClick(arg){
     $("#oldBank").html("");
     var datasJson="";
     $("#bankadd").show();
     $(".blackBg").show();
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
	 $.ajax({
         async: false,
         type: "post",
         dataType: "json",
         url: "${ctx}/account/queryBank?now="+new Date(),
         success: function (msg) {
         	 for(var i=0,l=msg.length;i<l;i++){
         		datasJson+="<option  value="+msg[i].code+">"+msg[i].value+"</option>";
          	 } 
         	 $("#oldBank").append(datasJson);
         }
      });
      $("#oldBank").val(arg); 
  }
  
  // 查询个人信息
  function oredrPersion(){
       $.ajax({
        async: false,
        type: "post",
        url: '${ctx}/account/baseInfo',
        success: function(data) {
            if(""!=data.identityCard&&data.identityCard!=null&&""!=data.realName&&data.realName!=null){
               $("#identity2").html(data.identityCard);
               $("#realName1").html(data.realName);
               $("#userId51").html(data.identityCard);
               $("#real51").html(data.realName);
               $("#isRealName").val("1");
               $("#noRealaName").hide();
               $("#realNameK").show();
		    }else{
		       $("#noRealaName").show();
		       $("#realNameK").hide();
		    }
         }
	  });
  }
  
    var flah="01";
    $("#txtAccountName").live("focus", function () {
         inputColor(this,null);
         $("#txtV").hide();
         $("#txtAccountName").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
            $("#determineHtml").html("<span style='color: rgb(204, 204, 204);'>请核对卡号信息</span>");
         }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("填写储蓄卡银行卡号");
          $("#txtV").show();
          ShowHint("txtV", "err", "银行卡号不能为空");
          $("#txtAccountName").addClass("on-error");
          
          $("#determineHtml").html("<span style='color: rgb(204, 204, 204);'>请核对卡号信息</span>");
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
	      $("#determineHtml").html("<span style='color: rgb(204, 204, 204);'>请核对卡号信息</span>");
	    }
	    if(""==this.value){
	      $("#determineHtml").html("<span style='color: rgb(204, 204, 204);'>请核对卡号信息</span>");
	    }
    })
    
    
   var flagh="01";
   $("#txtAccountNo").live("focus", function () {
         inputColor(this,null);
         $("#tishi").show();
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
   

   var smsCodeB="01";
   $("#txt_MobileCheckCode").live("focus", function () {
         inputColor(this,null);
         $("#smsCode").hide();
         $("#txt_MobileCheckCode").removeClass("on-error");
         if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
         }
    }).live("blur", function() {
          var txt_MobileCheckCode = $("#txt_MobileCheckCode").val();
           var reg = /^\d{6}$/;
          if(""==txt_MobileCheckCode||null==txt_MobileCheckCode){
               inputColor(this,"black");
               $(this).val("输入短信验证码");
               $("#smsCode").show();
		       $("#txt_MobileCheckCode").addClass("on-error");
		       ShowHint("smsCode", "err", "短信验证码不能为空！");
	           return;
          }
          if (!reg.test(txt_MobileCheckCode)) {
               $("#smsCode").show();
		       $("#txt_MobileCheckCode").addClass("on-error");
		       ShowHint("smsCode", "err", "*短信验证码格式错误！");
	           return;
          }
          smsCodeB="02";
   });
   
   // 支行选择
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
   
    // 添加银行卡 主方法
    var choseFlag;
    function AddBankAccount() {
              dailongWinTishi();
	          var txtAccountName = $("#txtAccountName").val();
	          var txtAccountNo = $("#txtAccountNo").val();
	          var cardSubBank = $("#cardSubBank").val();
	          var isRealName = $("#isRealName").val();
	          var realName = $("#realName").val();
	          var identity = $("#identity").val();
	          var random =$("#random").val();
	          cardSubBank = blankTrim(cardSubBank); // 去掉前后空格
	          if("1"!=isRealName){ // 是否已经实名认证
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
		         if(!checkAgeData(ageData)){  // 判断年龄是否大于18岁
		           warnMsg("您输入的身份证号当前未满18岁，暂时不能进行实名认证","关闭");
		           return;
		         }
		         realName = strEnc(realName,'${key}');
		         identity = strEnc(identity,'${key}');
	          }
	          
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
	          var selectedCity = $('#province option:selected').val();  // 省
		      var selectedCityCode = $('#city option:selected').val();  // 市
		      var provinceName = $('#province option:selected').text();  // 省名
		      var cityName = $('#city option:selected').text();  // 市名
		      if("请选择"==selectedCity||"请选择"==provinceName){
		            warnMsg("请选择省份！","关闭");
		            return;
		      }
		      var bankName = $('#oldBank option:selected').text();
	          var bankCode = $('#oldBank option:selected').val();
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
	        $("#sendSubmit").attr("disabled","disabled");
	        $("#sendSubmit").val("绑卡中...");
            $.ajax({
            type: "post",
            async: false,
            url: '${ctx}/arcOrder/isBank',           
            data: "BankAccountName=" + strEnc(txtAccountName,'${key}')+ "&BankAccountNo=" + strEnc(txtAccountNo,'${key}')
                    + "&BankCode=" +  strEnc(bankCode,'${key}')+ "&BankName=" + strEnc(bankName,'${key}')+"&cardSubBank="+strEnc(cardSubBank,'${key}')
                    + "&BankCity=" + selectedCity + "&BankCityCode=" + selectedCityCode+"&ageData="+ageData
                    + "&cityName="+cityName+"&provinceName="+provinceName+"&identity="+identity+"&realName="+realName+"&random="+random,
            error: function (err) {},
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
     	
   	//省市选择
   	function jointProvinceStr(obj){
		var provinceStr = "<option>请选择</option>";
		$.ajax({
           async: false,
           type: "post",
           url: '${ctx}/dicRegion/getTopLevelRegion',
           success: function (msg) {
           	for(var i=0,l=msg.length;i<l;i++){
           		provinceStr+="<option id="+msg[i].code+" value="+msg[i].code+">"+msg[i].text+"</option>";
           	}
           	$("#province").append(provinceStr);
           }
      	});
	}
	
	//省市选择
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
            url: '${ctx}/dicRegion/findArray',
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
   
   function clickinput(){
	       var autoIn = $("#autoIn").html();
	       if("切换手动输入"==autoIn){
	         $("#oldBank").hide();
	         $("#inputBank").show();
	         $("#autoIn").html("切换自动选择");
	       }else{
	         $("#oldBank").show();
	         $("#inputBank").hide();
	         $("#autoIn").html("切换手动输入");
	       }
   }
   
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
    function ShowinputHint(ctrl, hintType) {
        $(ctrl).removeClass("on-focus");
        $(ctrl).removeClass("on-error");
        if (hintType == "foc") {
            $(ctrl).addClass("on-focus");
        } else if (hintType == "err") {
            $(ctrl).addClass("on-error");
        }
    }
    
	function openDirect(){
	    $("#win_srvprotocol").show();
	    $(".blackBg").show()
	}
 
    //关闭弹窗
   function closeWin(){
        $("#smsCode").hide();
        $("#txt_MobileCheckCode").removeClass("on-error");
        $("#win_srvprotocol").hide();
        $(".blackBg").hide();
        $("#txt_MobileCheckCode").val($("#txt_MobileCheckCode").attr("defaultval"));
        window.clearInterval(iPoint);
        $("#win_srvprotocol1").hide();
        var imgSrc = $("#imgObj");
	    var src = "${ctx}/authimg?codeType=orderType&now="+Math.random();   
	    imgSrc.attr("src",src);
	    //reloadUrl();
    }
    
    // 阅读勾选协议
    function verfythisBox(box){
    	if($("#chk_AgreeProtocol").attr("checked")=="checked"){
    	    $("#xieYiMsg").hide();
    	    if("0"==$("#aHE").val()){
	    	     easyDialog.open({
		            container : {
		                header : ' ',
		                content :$('#win_srvprotocol2').html(),
		            },
		            fixed : false
		        });
		        window.scrollTo(0,0);
	    	    $("#aHE").val('1');
	    	    dailongWin();
    	    }
    	    if("1"==$("#aHE").val()){
    	      $("#checkOrder").css({'background-color':'#d84124','box-shadowx':'0 2px #d84124'});
    	    }
    	}else{
    	  $("#xieYiMsg").html('请阅读并勾选协议');
	  	  $("#xieYiMsg").show();
    	}
    }
    
    // 阅读勾选协议
    function quickPayProtocol(box){
    	if($("#quickPayProtocol").attr("checked")=="checked"){
    	    $("#xieYiMsg1").hide();
    	    if("0"==$("#aHO").val()){
               easyDialog.open({
		            container : {
		                header : ' ',
		                content :$('#win_srvprotocol3').html(),
		            },
		            fixed : false
		        });
    	       $("#aHO").val('1');
    	       window.scrollTo(0,0);
    	       dailongWin();
    	    }
    	    if("1"==$("#aHO").val()&&"1"==$("#aHE").val()){
    	      $("#quickCheck").css({'background-color':'#d84124','box-shadowx':'0 2px #d84124'});
    	    }
    	}else{
    	  $("#xieYiMsg1").html('请阅读并勾选协议');
	  	  $("#xieYiMsg1").show();
    	}
    }
    
    // 查询超募
    function therRaised(){
         var flag;
         var itemID=$("#fkItemId").val();
         var totalMoney=$("#txt_InvestAmount").val();
         var invCode=$("#invCode").val();
         $.ajax({
            type: "post",
            async: false,
	        url: '${ctx}/arcOrder/isTherRaised',
	        data:'itemID='+itemID+'&totalMoney='+totalMoney+"&invCode="+invCode,
	        success: function(data) {
                 flag = data;
	        }
		}); 
		return flag;
    }
    
    // 确认无误 提交订单
    function  CheckOrder(){
        dailongWinTishi();
        var bankCode = $("#div_AddBink_BankSelectedK").find("span").attr("code");
        if(bankCode==""||bankCode==null){
           addBankAccountOnClick();
           return;
        }
        //勾选协议提示
	  	if($("#chk_AgreeProtocol").attr("checked") != "checked"){
	  		$("#xieYiMsg").html('请阅读并勾选协议');
	  		$("#xieYiMsg").show();
	  		return false;
	  	}
	  	if("1"==$("#quickHide").val()){  //勾选协议提示
		  	if($("#quickPayProtocol").attr("checked") != "checked"){
		  		$("#xieYiMsg1").html('请阅读并勾选协议');
		  		$("#xieYiMsg1").show();
		  		return false;
		  	}
	  	}
	  	var isRais =  therRaised();
	  	var surplus = parseInt($("#txt_InvestAmount").val()); //总投资额
	  	if("2"==surplus){
	  	  warnMsg("您的识别码错误，请选择其他项目进行投资","关闭");
	  	  return;
	  	}
	  	if("err"==isRais||"0"==surplus){
	  	  warnMsg("您投资的金额已超出剩余可投金额，请查看项目详情","关闭");
	  	  return;
	  	}
	  	if(yzmValue=="2"){
	  	    var imgObj = $("#veryCode").val();
	  	    if(imgObj==null||imgObj==""){
	  	      warnMsg("验证码不能为空！","关闭");
	  	      return;
	  	    }
	  	   var yzm =  valYzmCode();
	  	   if(yzm!="OK"){
	  	     warnMsg("您的验证码输入错误，请重新输入！","关闭");
	  	     changeImg();
	  	     $("#veryCode").val("");
	  	     return;
	  	   }
	  	}else{
		  	var  state = queryOrderSize();
		  	if("err"==state){
		  	   $("#orderYzm").show();
		  	   changeImg();
		  	   return;
		  	}else if("ok"==state){
		  	}else{
		  	   window.location.href="${ctx}/item/gotoInvestmentList";
		  	}
	  	}
        var orderBo = {
            fkAccountInfoId:bankCode,
	  		income:$("#lblFullInterest").html(),        //预期收益
	  		fkItemId:$("#fkItemId").val(),              //项目编号
	  		capital:$("#txt_InvestAmount").val(),       //投资金额
	  		deductionFee:$("#coinCount").val(),       //抵扣
	  	};
	    $("#bidData").val(JSON.stringify(orderBo));
	     var ckeck = $("#checkbox-2-1").attr("checked");
        if("checked"==ckeck){  // 判断网关还是快捷
           $("#serialNumber").val(""); // 创建新订单
           var  flagSize =  sendPayYZM();
           if(flagSize.flagSize=="2"){
             warnMsg("您在10分钟内已连续获取5次验证码，请稍后再试！","确定");
             return;
           }
           if(flagSize.serialNumber=="err"){
              warnMsg("当前网络异常请稍后再试！","确定");
              return;
           }
		   openDirect();
        }else{
           var dekou = $("#coinCount").val();
           if("0"!=dekou){
              warnMsg("网关支付暂不支持金币抵扣！","关闭");
		      return;
           }
           var bCode = $(".cash_model .twoC li .focus").children("span").attr("code");
		   if(bCode==undefined||bCode==""){
		    warnMsg("请选择网银支付银行！","关闭");
		    return;
		   }
           $.ajax({
            type: "post",
            async: false,
	        url:'${ctx}/arcOrder/gatewayPay',
	        data:'bidData='+JSON.stringify(orderBo),
	        success: function(data1){
	             if("err"==data1){
	               warnMsg("网络错误，请稍后再试！","关闭");
	             }else{
	                  if(isNewBanks!=isNewBank){
	                    showBankLisk();
	                    $(".newtop ul li").addClass('current').siblings().removeClass('current');
	                    $("#xuanz").addClass('current')
	   					$("#newmain ul").eq(1).show().siblings().hide();
	   					$("#isQuick").val("1");
	                  }
	                  if("0"==$("#isQuick").val()){
	                    $(".newtop ul li").addClass('current').siblings().removeClass('current');
	                    $("#xuanz").addClass('current')
	   					$("#newmain ul").eq(1).show().siblings().hide();
	   					$("#isQuick").val("1");
	   					$(".radioBox").removeClass("focus");
	                  }
		             $.ajax({
		             type: "post",
		             async: false,
		             url: '${ctx}/arcOrder/orderTransmission',
				     data: "orderNumber="+data1+"&bankCode="+bCode,
		             success: function (result) {
		                  if("err" ==result.err){
		                     warnMsg("网络错误，请稍后再试！","关闭");
		                  }else if("full" ==result.flag){
		                      warnMsg("您投资的金额已超出剩余可投金额，请查看项目详情","关闭"); 
		                  }else if("goldNull" ==result.flag){
		                      warnMsg("您抵扣金币不足，请重新下单","关闭"); 
		                  }else{
		                     $("#message").val(result.message);
			                 $("#signature").val(result.signature);
			                 $("#paymentNo").val(result.paymentNo);
			                 $(".blackBg").show()
			  		         $("#win_srvprotocol1").show();
			  		         $("#pay").show();
					         $("#succ").hide();
					         $("#failure").hide(); 
			                 document.orderPay.action=result.url;
			  		         document.orderPay.submit();
		                  }
			           }
			        });
		         }
	          }
		   });
        } 
    }
   
   // 发送短信支付验证码
   var  iPoint;
   function sendPayYZM(){
          var bankCode = $("#div_AddBink_BankSelectedK").find("span").attr("code");
          var  flagSize;
          var fkItemId = $("#fkItemId").val();
          var capital = $("#txt_InvestAmount").val();
          var income = $("#lblFullInterest").html();
          var serialNumber = $("#serialNumber").val();
          var coinCount = $("#coinCount").val();
          $.ajax({
            type: "post",
            async: false,
	        url:'${ctx}/arcOrder/queryPayCount',
	        data:'bankCode='+bankCode+'&fkItemId='+fkItemId+"&capital="+capital+"&income="+income+"&serialNumber="+serialNumber+"&coinCount="+coinCount,
	        success: function(data){
                 flagSize = data;
                 $("#titleCount").html(flagSize.titleCount);
		         $("#div_Mobile").html(flagSize.bankMonliePhone);
		         $("#td_Amount").html($("#shifu").html());
	          }
		   });
		   if("04"==flagSize.stateCon){
		      dailongWinTishi();
              warnMsg("您投资的金额已超出剩余可投金额，请查看项目详情","关闭");
	  	      return;
           }
          $("#serialNumber").val(flagSize.serialNumber);
          $("#spTime").val("120秒后重新获取");
          iPoint = window.setInterval("setTimeIdentity()", 1000);
          $("#spTime").show();
          $("#btnSendMobileCode").attr("disabled", "disabled");
          $("#btnSendMobileCode").hide();
		  return  flagSize;
   } 
   
    //实名认证 发验证码倒数
    function setTimeIdentity() {
         var TimeNow = $("#spTime").val() == "" ? 120 : parseInt($("#spTime").val());
         $("#spTime").val((TimeNow - 1) + "秒后重新获取");
         if (TimeNow <= 0) {
             window.clearInterval(iPoint);
             $("#spTime").hide();
             $("#spTime").val("120秒后重新获取");
             $("#btnSendMobileCode").removeAttr("disabled");
             $("#btnSendMobileCode").show();
         }
     } 
   
	   //支付提交订单
	   function submitOrder(){
	        dailongWinTishi();
	        var phoneYZM = $("#txt_MobileCheckCode").val();
	        var serialNumber = $("#serialNumber").val();
	        var bankCodek = $("#div_AddBink_BankSelectedK").find("span").attr("code");
	        if($("#txt_MobileCheckCode").attr("defaultval")==phoneYZM){
	           $("#smsCode").show();
		       $("#txt_MobileCheckCode").addClass("on-error");
		       ShowHint("smsCode", "err", "短信验证码不能为空！");
	           return;
	        }else{
		        if("02"==smsCodeB){
		          $("#btnConfirmPay").val("支付中..");
		          $("#btnConfirmPay").attr("disabled","disabled");
		          $.ajax({
		          type: "POST",
		          async: false,
		          url: '${ctx}/arcOrder/queryPayCode',
		          data: "phoneYZM="+phoneYZM+"&bankCodek="+bankCodek+"&serialNumber="+serialNumber,
		          error: function (err) {},
		          success: function (result) {
		             if("0"==result.YZMflag){
		               document.submitForm.action='${ctx}'+result.pathUrl;
		               document.submitForm.submit();
		             }else if("3"==result.YZMflag){
		                   $("#smsCode").show();
					       $("#txt_MobileCheckCode").addClass("on-error");
					       ShowHint("smsCode", "err", "验证码已过期，请重新获取！");
					       $("#btnConfirmPay").val("确认支付");
                           $("#btnConfirmPay").attr("disabled",false);
		             }else if("link"==result.YZMflag){
		                   $("#smsCode").show();
					       $("#txt_MobileCheckCode").addClass("on-error");
					       ShowHint("smsCode", "err", "本次短信验证码尝试次数过多，请重新获取验证码！");
					       $("#btnConfirmPay").val("确认支付");
                           $("#btnConfirmPay").attr("disabled",false);
		             }else if("full"==result.YZMflag){
		                   warnMsg("您投资的金额已超出剩余可投金额，请查看项目详情","关闭");
		                   $("#btnConfirmPay").val("确认支付");
                           $("#btnConfirmPay").attr("disabled",false);
		             }else if("goldNull"==result.YZMflag){
		                   warnMsg("您抵扣金币不足，请重新下单","关闭");
		                   $("#btnConfirmPay").val("确认支付");
                           $("#btnConfirmPay").attr("disabled",false);
		             }else{
			               $("#smsCode").show();
						   $("#txt_MobileCheckCode").addClass("on-error");
						   ShowHint("smsCode", "err", "验证码错误，确认后重新输入！");
						   $("#btnConfirmPay").val("确认支付");
	                       $("#btnConfirmPay").attr("disabled",false);
		             }
		          }});
	         }
         }
       }
	   function reloadUrl(){   // 重新加载页面
		   location.reload(true);
	   }
	 
	  function quickPay(){  // 快捷支付
	      if("1"==$("#isQuick").val()){
	        $("#checkbox-2-1").attr("checked",false);
	      }
	      if("0"==$("#isQuick").val()){
	        $("#checkbox-2-1").attr("checked",true);
	      }
	      if($("#checkbox-2-1").attr("checked") != "checked"){
	          $("#quickCheck").hide();
	          $("#checkOrder").show();
	          $("#shouDing").removeClass("doing");
	          $("#fast").removeClass("fastk");
	          $("#quickPayProtocol1").hide();
	          $("#quickHide").val('2');
	      }else{
	          $("#checkOrder").hide();
	          $("#quickCheck").show();
	          $("#shouDing").addClass("doing");
	          $("#fast").addClass("fastk");
	          $("#quickPayProtocol1").show();
	          $("#quickHide").val('1');
	      }
	  }
	  
	  // 查询订单次数
	  function queryOrderSize(){
	         var flag;
	         $.ajax({
	            type: "post",
	            async: false,
		        url: '${ctx}/arcOrder/querOrderTime',
		        success: function(data) { flag = data;}
			}); 
			return flag;
	  }
	  var yzmValue="1";
	  function changeImg(){
	        var imgSrc = $("#imgObj");
		    var src = "${ctx}/authimg?codeType=orderType&now="+Math.random();   
		    imgSrc.attr("src",src);  
		    yzmValue="2"; 
	  }
      
      // 校验图片验证码
	  function valYzmCode(){
	      var statefla;
	      var code = $("#veryCode").attr("value");    
	      code = "c=" + code+"&codeType=orderType";    
	      $.ajax({
			async: false,
			type: "post",
			url: '${ctx}/authcode/validate',
			data: code,
			success: function (msg) {statefla = msg;}
		   });
		   return statefla;
	  }
     
    // 关闭页面
	function clearDate(){
	   $("#bankadd").hide();
	   $(".blackBg").hide()
	   $("#accV").hide();
	   $("#txtV").hide();
	   $("#accB").hide();
	   $(".ac").hide();
	   $("#txtAccountName").removeClass("on-error");
	   $("#txtAccountNo").removeClass("on-error");
	   $("#cardSubBank").removeClass("on-error");
	   $("#txtAccountName").val($("#txtAccountName").attr("defaultval")); 
	   $("#txtAccountNo").val($("#txtAccountNo").attr("defaultval"));
	   $("#cardSubBank").val($("#cardSubBank").attr("defaultval"));
	   $(".radioBox").removeClass("focus");
	   $(".radioBox").siblings().removeClass("focus");
	   if("1"==choseFlag){
		   reloadUrl();
	   }
	}
	
	// 切换输入
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
  
  // 支行选择
  function checkSubBank(){
        var subBankSpan = $("#subBankSpan").html();
        var bankName = $('#oldBank option:selected').text();
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
    
    // 文本框字体颜色
    function inputColor(ctrl,ftType){
        $(ctrl).css({"color":"#666"});
        if (ftType == 'black') {
          $(ctrl).css({"color":"#ccc"});
        }
    }
    
    var isNewBank="1";
    var isNewBanks;
    function showBankLisk(){ // 添加银行卡下拉效果
       $(".newadd").animate({ height: 'toggle', opacity: 'toggle' }, "slow");
       if(isNewBank==isNewBanks){
         isNewBanks="2";
       }else{
        isNewBanks="1";
       }
    }
    
   function completePay(arg){
      var  paymentNo = $("#paymentNo").val();
	  $.ajax({
             type: "post",
             async: false,
             url: '${ctx}/arcOrder/completePay',
		     data: "paymentNo="+paymentNo,
             success: function (result) {
               if(result=="err"||result=="no"){
                    if("2"==arg){
                        $(".blackBg").hide();
				        $("#win_srvprotocol1").hide();
				        $(".radioBox").removeClass("focus");
						$(".radioBox").siblings().removeClass("focus")
                    }else if(arg=="1"){
                      $("#win_srvprotocol1").hide();
                      $(".blackBg").hide();
                    }else if(result=="err"){
                      $("#pay").hide();
                      $("#succ").show();
                    }else if(result=="no"){
                      $("#pay").hide();
                      $("#failure").show();
                    }
                    var imgSrc = $("#imgObj");
				    var src = "${ctx}/authimg?codeType=orderType&now="+Math.random();   
				    imgSrc.attr("src",src);
               }else{
                  window.location.href="${ctx}/arcOrder/succPage?paymentNo="+paymentNo;
                }
	         }
	   });
   }
 
 function closeWin1(){ // 关闭页面
     window.location.href="${ctx}/item/gotoInvestmentList";
 }
    
 $(document).ready(function () { // 初始化方法
    $("#formatCapital").html(FormatDigital($("#formatCapital").html()));
	$(".cash_model ul li").hover(function(){
		$(this).find(".support").show();
		},function(){
		$(this).find(".support").hide();
	})
	//选择银行
	$(".radioBox").click(function(){
		$(".radioBox").removeClass("focus");
		$(this).addClass("focus")
		$(".radioBox").siblings().removeClass("focus");
		if("0"==$("#isQuick").val()){
		  var bCode = $(".cash_model .focus").children("span").attr("code");
		  if(bCode==undefined||bCode==""){
		    return;
		  }
		  addBankAccountOnClick(bCode);
		}
	 })
	 
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
        temp.siblings(".bank-select").append($(this).clone())
        temp.hide()
        $(".bank-select").removeClass("bank-select-current")
    });
    oredrPersion();
    var bankCode = $("#div_AddBink_BankSelectedK").find("span").attr("code");
    if(bankCode!=null){
	  $("#checkbox-2-1").attr("checked",true);
	  $("#quickTitle").show();
	  $("#fast").addClass("fastk");
	  $("#shouDing").addClass("doing");
   }
   
   $("#totCount").html(FormatDigital($("#surplus").html()));
   $(".newtop ul li").click(function(){
       if("1"==$(this).index()){
          $("#yinlian").show();
          $("#kuaijie").hide();
          $("#checkbox-2-1").attr("checked",false);
       }else{
          $("#checkbox-2-1").attr("checked",true);
          $("#kuaijie").show();
          $("#yinlian").hide();
       }
       $(this).addClass('current').siblings().removeClass('current');
	   $("#isQuick").val($(this).index());
	   $("#newmain ul").eq($(this).index()).show().siblings().hide();
       quickPay();
    });
    var income11 = $("#txt_InvestAmount").val();
    var coinCount = $("#coinCount").val();
    $("#shifu").html(FormatDigital(income11-coinCount/10));
});

  function aHreH(arg){
    easyDialog.open({
         container : {
             header : ' ',
             content :$('#win_srvprotocol2').html(),
         },
         fixed : false
     });
     $("#aHE").val(arg);
     dailongWin();
  }
  
  function aHreO(arg){
      easyDialog.open({
         container : {
             header : ' ',
             content :$('#win_srvprotocol3').html(),
         },
         fixed : false
     });
     $("#aHO").val(arg);
     dailongWin();
  }
  
  // 协议页面弹出框隐藏
  function hideXiyiWin(){
     $("#win_srvprotocol2").hide();
     $("#win_srvprotocol3").hide();
     $(".blackBg").hide();
  }
  
  // 控制弹出框样式
  function dailongWin(){
     $("#easyDialogBox").css({"top":"100px","width":"1000px","left":"50%","margin-left":"-500px"});
     $(".easyDialog_wrapper").css({"width":"1000px","border":"0"});
     $(".easyDialog_wrapper .easyDialog_title").css("background-color","#fff");
     $(".easyDialog_text").css("padding","30 50");
     $("#closeBtn").css("color","black");
  }
  
  // 控制弹出框样式 tips 提示
  function dailongWinTishi(){
     $("#easyDialogBox").css({"top":"100px","width":"500px","height":"129","left":"50%","margin-left":"-500px"});
     $(".easyDialog_wrapper").css({"width":"500px","border":"0","height":"129"});
     $(".easyDialog_wrapper .easyDialog_title").css("background-color","#fff");
     $(".easyDialog_text").css("padding","30 50");
     $("#closeBtn").css("color","black");
  }
  
</script>
<body class="gray-bg">
	<%@ include file="../header.jsp" %>
	<form name="submitForm" method="post" action="">
	   <input type="hidden" name="bidData" id=bidData>
	</form>
	 <form name="orderPay" method="post" action="" target="_blank">
		<input id="message" name="message" type="hidden" />
		<input id="signature" name="signature" type="hidden" />
	</form>
	<input type="hidden" name="aHE" id="aHE" value="0">
	<input type="hidden" name="aHO" id="aHO" value="0">
	<input type="hidden" name="OrderNo" id="hidOrderNo" value="">
	<input type="hidden" name="investerYearRate" id="investerYearRate" value="${itemInfo.investerYearRate}">
	<input type="hidden" name="financePeriod" id="financePeriod" value="${itemInfo.financePeriod}">
	<input type="hidden" name="fkItemId" id="fkItemId" value="${itemInfo.id}">
	<input type="hidden" name="quickHide" id="quickHide" value="1">
	<input type="hidden" name="investUnitFee" id="investUnitFee" value="${itemInfo.investUnitFee}">
	<input type="hidden" name="serialNumber" id="serialNumber">
	<input type="hidden" name="serialNumber" id="serialNumber">
	<input type="hidden" name="invCode" id=invCode value="${invCode}">
	<input type="hidden" name="isRealName" id="isRealName">
	<input type="hidden" name="isQuick" id="isQuick" value="0">
	<input type="hidden" name="paymentNo" id="paymentNo">
	<input type="hidden" id="random" name="random" value="${random}"/>
	<input type="hidden" id="coinCount" name="coinCount" value="${coinCount}"/>
	
	<div class="warp">
		<div class="container">
			<div class="ui-content">
				<div class="breadcrumb">
						<a href="${ctx}/item/index">首&nbsp;页</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="${ctx}/item/gotoInvestmentList">惠赚钱</a>&nbsp;
						<span>&gt;</span>&nbsp;
						<a href="${ctx}/arcOrder/findDetail?itemId=${itemInfo.id}">项目详情</a>&nbsp;
						<span>&gt;</span>&nbsp;确认投标金额
					</div>
					<h2 class="mod-object-title"  id="conventionTitle">
								<div id="sflex03" class="stepflex ">
									<dl class="first doing ">
										<dt class="s-num">1</dt>
										<dd class="s-text">确认投标金额<s></s><b></b></dd>
										<dd></dd>
									</dl>
									<dl class="normal" id="shouDing">
										<dt class="s-num">2</dt>
										<dd class="s-text">确认支付<s></s><b></b></dd>
									</dl>
									<dl class="normal">
										<dt class="s-num">3</dt>
										<dd class="s-text">投资结果<s></s><b></b></dd>
									</dl>
								</div>
					</h2>
				   <div class="module">
					<div class="mod-wrap mod-bid-box">						
						<h2 class="mod-title"> <span>确认投标金额</span></h2>
						<div class="mod-content">
							<table border="0" cellspacing="0" cellpadding="0" class="ui-table-4">
								<tbody>
									<tr>
										<th><p>投标金额：</p>
										</th>
										<td>    <span id="formatCapital">${capital}</span> 元
												<input type="hidden"  class="textFild" autocomplete="off" id="FinanCount" onlynumber="FinanCount" onpaste="return false" oncontextmenu="return false" oncopy="return false"  min="1"  value="1" name="PartsCount">
												<input id="txt_InvestAmount" type="hidden" maxlength="20"  class="textFild textFild-2" name="" value="${capital}">
											<span style="float: left; line-height: 35px; margin-left: 40px;display: none;" class="red">(该项目您最多可投
											      <span id="surplus" style="display: none">${total}</span><span id="totCount">${total}</span>
											元)</span></td>
									</tr>
									<tr>
									   <th><p>实付金额：</p> </th>
								       <td><span id="shifu"></span> 元</td>
									</tr>
									<tr>
										<th width="14%"> 预期收益： </th> <span id="minAmout" style="display: none;">${itemInfo.investUnitFee*itemInfo.minInvestAmount}</span>
										<td width="86%"><p> <span class="ui-currency"></span><b class="fz-24 red" id="lblFullInterest">${income}</b> 元</p></td>
									</tr>
									
								</tbody>
							</table>
						</div>
						<h2 class="mod-title"><span>实名认证</span></h2>
							<div class="personal-info-text">
								<div id="realNameK" style="padding-left:40px;">
								    <p>真实姓名：<span style="color:#999; margin-left:15px" id="real51"></span></p>
								    <p>身份证号：<span style="color:#999; margin-left:15px" id="userId51"></span></p>
								</div>
								
								<div id="noRealaName" style="padding-left:40px;">
								    <p>真实姓名：您还未进行<span style="color:#999; margin-left:15px" >实名认证</span></p>
								    <p>身份证号：您还未进行<span style="color:#999; margin-left:15px" >实名认证</span></p>
								</div>
							</div>
							<h2 class="mod-title">
								<span>支付</span>
								<div class="ui-tips">
									<img src="${resource_dir}/images/arrow_left_03.png">
									<i></i>温馨提示，若您尚未开通无卡支付功能请到当地银行卡服务处开通功能&nbsp;
								</div>
							</h2>
							<c:if test="${bankList!='[]'}">
							<div class="mod-content" style="position: relative; z-index: 6;">
								<div class="confirmation clearfix" style="margin-bottom: 20px;margin-left: 10px;" id="fast">
								     <label class="ui-label f-left">
								       <span class="ui-icon">
                                        <input style="display:none;" type="checkbox" style="width:27px; height:27px;border-color:blue;vertical-align:middle;"  id="checkbox-2-1" onclick="quickPay();"  />
                                        <img  id="kuaijie" src="${resource_dir}/images/kuaijie.png"></img>
                                        <img  style="display: none;" id="yinlian" src="${resource_dir}/images/yinlian.png"></img>
                                       </span>
                                   </label>					
									 <div class="ui-bank" id="selectBank" style="width:345px;">
										<div class="bank-select" id="div_AddBink_BankSelectedK"
											style="height: 35px;width:345px;">
											<c:forEach var="perSonAc" items="${bankList}"
												varStatus="status">
												<c:if test="${status.index==0}">
													<span code="${perSonAc.id}" style="color: blue;">&nbsp;&nbsp;${perSonAc.bankName}&nbsp;&nbsp;</span>
													<span>${perSonAc.cardNumber }&nbsp;&nbsp;
														${perSonAc.accountName}</span>
												</c:if>
											</c:forEach>
										</div>
										<div class="bank-list" id="banklist" style="top: 35px;">
											<ul>
												<c:forEach var="perSonAcIn" items="${bankList}">
													<li value="0">
														<span code="${perSonAcIn.id}" style="color: blue;">&nbsp;&nbsp;${perSonAcIn.bankName}&nbsp;&nbsp;</span>
														<span>${perSonAcIn.cardNumber }&nbsp;&nbsp;
															${perSonAcIn.accountName}</span>
													</li>

												</c:forEach>
											</ul>
										</div>
									</div>
									<div class="ui-bank" id="div_selectedbank"
										style="display: none;">
										<div class="bank-select">
											<span title="" code="" bankid="" class="bank-logo "> </span>
											<span class="bank-number"><b>|</b> </span>
										</div>
										<div class="bank-list">
											<ul id="ul_bankaccountlist">
											</ul>
										</div>
									</div>
									<div class="ui-link add-bank f-left" id="div_AddBink">
										<a onclick="showBankLisk();"
											href="javascript:void(0)" id="lnk_AddBink">使用新银行卡</a>  <em style="padding-left: 20px;">( 回款账户 )</em> 
									</div>
								</div>
								<div class="clear">
								</div>
							</c:if>
							
						 
                          
                            <!--新版添加银行卡-->
                            <div class="newadd" style="display: <c:if test="${bankList!='[]'}">none;</c:if><c:if test="${bankList=='[]'}">block;</c:if>">
                            	<div class="newtop">
                                	<ul>
                                    	<li class="current" style="cursor: pointer;">快捷绑卡</li>
                                    	<li style="cursor: pointer;" id="xuanz">网银支付</li>
                                    </ul>
                                </div>
                                <div class="cash_model" id="newmain">
                                    <ul style="display:block;" class="oneC">
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-sx" code="1539" title="山西省农村信用社"></span></label>
                                            <div class="support">
                                                <span>单笔5万 日限额10万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-icbc" code="102" title="中国工商银行"></span></label>
                                            <div class="support">
                                               <span>单笔5万 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-abc" code="103" title="农业银行"></span></label>
                                            <div class="support">
                                               <span>单笔20万 日限额20万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-ccb" code="105" title="建设银行"></span></label>
                                            <div class="support">
                                               <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-comm" code="301" title="交通银行"></span></label>
                                            <div class="support">
                                              <span>单笔2万 日限额2万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-cmmb" code="308" title="招商银行"></span></label>
                                            <div class="support">
                                               <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-zgb" code="104" title="中国银行"></span></label>
                                            <div class="support">
                                              <span>单笔5万 日限额20万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-psbc" code="100" title="中国邮政储蓄银行"></span></label>
                                            <div class="support">
                                               <span>单笔5万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-ecitic" code="302" title="中信银行"></span></label>
                                            <div class="support">
                                               <span>单笔5千 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" id="" />
                                            <label class="radioBox"><span class="bank-card bank-cebbank" code="303" title="光大银行"></span></label>
                                        <div class="support">
                                          <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-cmbc" code="305" title="民生银行"></span></label>
                                        <div class="support">
                                             <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-qdccb" code="450" title="青岛银行"></span></label>
                                        <div class="support">
                                             <span>单笔1千 日限额1千</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-shbc" code="401" title="上海银行"></span></label>
                                        <div class="support">
                                             <span>单笔5千 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-bankofbeijing" code="403" title="北京银行"></span></label>
                                        <div class="support">
                                              <span>单笔5千 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-spdb" code="310" title="浦发银行"></span></label>
                                            <div class="support">
                                               <span>仅支持储蓄卡</span>
                                            </div>
                                        </li>
                                         
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-pab" code="307" title="平安银行"></span></label>
                                        <div class="support">
                                            <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-hssb" code="440" title="徽商银行"></span></label>
                                       <div class="support">
                                             <span>单笔10万 日限额50万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-lzzb" code="447" title="兰州银行"></span></label>
                                        <div class="support">
                                              <span>单笔1万 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-hxb" code="304" title="华夏银行"></span></label>
                                            <div class="support">
                                               <span>仅支持储蓄卡</span>
                                            </div>
                                        </li>
                                        <li onclick="addBankAccountOnClick();" ><span code="7"></span><a href="javascript:void(0)">更多银行</a></li>
                                    </ul>
                                    
                                    
                                    <ul class="twoC">
                                         <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-icbc" code="102" title="中国工商银行"></span></label>
                                            <div class="support">
                                               <span>单笔5万 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-abc" code="103" title="农业银行"></span></label>
                                            <div class="support">
                                               <span>单笔20万 日限额20万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-ccb" code="105" title="建设银行"></span></label>
                                            <div class="support">
                                               <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-comm" code="301" title="交通银行"></span></label>
                                            <div class="support">
                                               <span>单笔2万 日限额2万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-cmmb" code="308" title="招商银行"></span></label>
                                            <div class="support">
                                               <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-zgb" code="104" title="中国银行"></span></label>
                                            <div class="support">
                                               <span>单笔5万 日限额20万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-psbc" code="100" title="中国邮政储蓄银行"></span></label>
                                            <div class="support">
                                               <span>单笔5万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-ecitic" code="302" title="中信银行"></span></label>
                                            <div class="support">
                                               <span>单笔5千 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" id="" />
                                            <label class="radioBox"><span class="bank-card bank-cebbank" code="303" title="光大银行"></span></label>
                                            <div class="support">
                                               <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-cmbc" code="305" title="民生银行"></span></label>
                                            <div class="support">
                                               <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-qdccb" code="450" title="青岛银行"></span></label>
                                            <div class="support">
                                               <span>单笔1千 日限额1千</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-shbc" code="401" title="上海银行"></span></label>
                                            <div class="support">
                                               <span>单笔5千 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-bankofbeijing" code="403" title="北京银行"></span></label>
                                            <div class="support">
                                              <span>单笔5千 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-spdb" code="310" title="浦发银行"></span></label>
                                            <div class="support">
                                               <span>单笔5万 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-hxb" code="304" title="华夏银行"></span></label>
                                            <div class="support">
                                               <span>仅支持储蓄卡</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-pab" code="307" title="平安银行"></span></label>
                                            <div class="support">
                                              <span>单笔100万 日限额100万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-hssb" code="440" title="徽商银行"></span></label>
                                            <div class="support">
                                              <span>单笔10万 日限额50万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-lzzb" code="447" title="兰州银行"></span></label>
                                            <div class="support">
                                              <span>单笔1万 日限额5万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-nnbb" code="408" title="宁波银行"></span></label>
                                            <div class="support">
                                              <span>单笔10万 日限额50万</span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="radio" />
                                            <label class="radioBox" id="" ><span class="bank-card bank-cib" code="309" title="兴业银行"></span></label>
                                             <div class="support">
                                              <span>单笔5万 日限额5万</span>
                                            </div>
                                        </li>
                                    </ul>
                            </div>
						</div>
						
						<span style="padding-left:65px;display:inline-block;padding-bottom: 10px;">* 温馨提示： 山西省农村信用社联合社储蓄卡，快捷支付限额：单笔5万，日限额10万。</span>  
					    <span style="margin-left:10px;margin-bottom:10px;"><a href="${ctx}/help/helpCenter/paymentLimit.jsp" target="_blank" style="color:#0090e6;">查看其它银行快捷支付限额</a></span>
					    
					    
					   <div class="mod-bottom">
						<div class="info-agm">
							<span>
							<span> <b>
								<input type="checkbox"   onclick="verfythisBox()" class="ui-checkbox" id="chk_AgreeProtocol"/>
								</b><label for="chk_AgreeProtocol">我已阅读并同意</label>
								<a href="#" class="a-line" style="color:#0090e6;" onclick="aHreH('1')">【互联网金融综合服务平台】服务协议</a>
								<span id="spn_OpenDirect"></span></sapn>
								<span id="xieYiMsg" style="color:red;display:none;"></span>
							</span>
							</span>
							<c:if test="${bankList!='[]'}">
								<span style="margin-left:10px;display:inline-block;" id="quickPayProtocol1">
							    <sapn> <b>
									<input type="checkbox" onclick="quickPayProtocol(this)" class="ui-checkbox" id="quickPayProtocol"/>
									</b><label for="quickPayProtocol">我已阅读并同意</label>
									<a href="#" class="a-line" style="color:#0090e6;" onclick="aHreO('1')">《快捷支付服务协议》</a>
									<span id="spn_OpenDirect1"></span> </sapn>
									<span id="xieYiMsg1" style="color:red;display:none;"></span>
								</span>
							</c:if>
						</div>
						<div class="confirmation clearfix" id="orderYzm"  style="display: none;margin-top:20px;">
											<div class="ui-input-box f-left" style=" position: relative;"id="phone">
											  <label class="ui-label f-left">  验证码：</label> <input style="width:100px;" maxlength="4" id="veryCode" name="veryCode" type="text"/>  
												 <img id="imgObj"  style="position: absolute; top:5px; left:225px;"   src="${ctx}/authimg?codeType=orderType"/>      
				                                 <a style="position: absolute; top:3px; left:295px; width: 80px;"   href="javascript:void(0);" onclick="changeImg()">换一张</a>
				                                 <span style="color: red;position: absolute; top:3px; left:345px; width: 480px;  ">（您10分钟内已经进行多次订单提交，本次订单提交需要填写验证码...）</span>  
											</div>
						</div>
						<div class="submit-btn">
							<a href="javascript:void(0)" style="display: none; box-shadow:0 0px #ccc;" class="ui-button-text ui-button-2" onclick="CheckOrder();" financingid="6dbef7dc-1af0-4315-b9a8-bc418245f7d7" is-back="True" name="checkOrder" id="checkOrder">确认并跳转至网银支付</a>
						    <a href="javascript:void(0)" style="box-shadow:0 0px #ccc;"  class="ui-button-text ui-button-2"  onclick="CheckOrder();" financingid="6dbef7dc-1af0-4315-b9a8-bc418245f7d7" is-back="True" name="quickCheck" id="quickCheck">确认无误，支付</a>
						</div>
						<div class="other-info">
							<p> <span class="red">*</span> 免责声明：预期投资收益仅供参考，具体以实际发生收益为准。</p>
							<p> <span class="red">*</span> 温馨提示：建议选择使用IE或者带IE内核的浏览器进行投资支付。</p>
						</div>
					</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
<!-- 添加银行卡弹出框开始 -->
  <div id="bankadd" class="prompt_box"  style="top:60px;">
	<div class="ck_1  prompt_inner ui-window-1" style="left:-400px;width:800px;height:605px;">
	      <H3 class=title><SPAN style="PADDING-LEFT: 0px">绑定银行卡</SPAN><A class=close href="javascript:void(0)" onclick="clearDate();" close-ui="bankadd"></A> </H3>
	      <div class=bank-add-title2 id="hideBanks" ><SPAN class=span-1 style="padding-left:30px;">支付/回款账户资料（<FONT>本次投资回收的本金和利息到期后将汇入此账户</FONT>）</SPAN></div>
	      <div class="conent" id="hideBank" style="padding: 0 20px">
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
						<th width="28%"><span class="red">*</span><span class="ui-icon" style="color: #333;">开户银行：</span> </th>
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
								    <span id="accV" style="color: rgb(255, 17, 0); padding-left: 25px;display:inline-block; margin:5px 10px 0 6px;"></span>
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
								style="border-radius:3px;height: 35px;width:130px;border-radius:3px;" onchange="toggleProvince()">
								<option selected="selected" value="">请选择省</option>
							</select>
							<select name="City" id="city" onchange="checkSubBank();" style="border-radius:3px;border-radius:3px;width:117px;height: 35px; display: none;"></select>
						</td>
					</tr>
					<tr>
						<th> <span class="red">*</span><span class="ui-icon" style="color: #333;">支行名称：</span> </th>
						<td>
							<div class="ui-out-box">
								<div class="ui-input-box">
								 	<select style="display: none;border-radius:3px;height: 35px; width: 250px;"  name="cardSubBankInput" id="cardSubBankInput">
								       <option value="-1">请选择</option>
								    </select>
								 	<input type="text" id="cardSubBank" name="cardSubBank" value="请填写支行名称" defaultval="请填写支行名称" class="ui-input w-150"  style="border-radius:3px;height: 35px; line-height: 35px; width: 250px; color: rgb(204, 204, 204);">
								    <a href="javascript:void(0)" onclick="cardSubBankInput();" style="display:inline-block;line-height:35px;"><span class="ui-icon" id="subBankSpan" style="padding-left: 10px;font-size:14px;color:blue;">切换自动选择</span></a>
								</div>
							</div>
						</td>
					</tr>	
				</tbody>
			</table>
			<div class="calculator-btn"  style="margin-top:10px; margin-left:200px;">
	          <input style="background:  #fa552f;" type=submit value=确&nbsp;&nbsp;认  onclick="AddBankAccount()"  id="sendSubmit" name="sendSubmit"  save-ui-bank="isrefresh">
	          <input class=reset type=button onclick="clearDate();" value=取&nbsp;&nbsp;消 close-ui="bankadd">
            </div>
		</div>
	   	<div class="conent"  id="showBank" style="display: none;padding: 0 90px 0 130px; background: url('${resource_dir}/images/sucess_icon.png') no-repeat 150px 0 ; ">
		<p style="line-height:70px; font-size:28px; margin-top:150px;  text-align:center;">恭喜，您已绑卡成功！</p>
		<p style="line-height:30px; font-size:14px; margin-bottom:20px;text-align:center; color:#F00;">温馨提示：建议您不要随意注销该银行卡！</p>
		    <div class="calculator-btn" style="margin-top:10px; margin-left:210px;" >
		      <input type="submit" style="background:#fa552f;"  onclick="reloadUrl();" value=确&nbsp;&nbsp;认 save-ui-bank="isrefresh">
		    </div>
	    </div>
	    <div class="card_lose" id="errBank" style="display: none;">
 		    <i><img src="${resource_dir}/images/lose_icon.png"/></i>
		    <h3 id="errCount" style="font-weight: bold;"></h3>
		    <div class="lose_main">
		    	<!-- <div class="lose_left">
		        	<p class="red">注：<span id="yinBank"></span>储蓄卡需先开通银联无卡支付业务</p>
		            <p class="red">请去银行营业网点开通，或使用其他卡绑定.</p>
		        </div>
		    	<div class="lose_right">
		        	<a href="${ctx}/help/helpCenter/questionlist11.jsp" target="_blank">如何开通？</a>
		        </div>  -->
		        
		        	<p>成功绑卡小贴士：</p>
			        <p>1、绑定银行卡时只能绑定借记卡，不能绑定贷记卡（透支卡），每个账户最多支持绑定10张银行卡；</p>
			        <p>2、绑定银行卡时填写的手机号需和当时在银行办理银行卡时的预留手机号码一致。预留手机号可以去办卡行重新设置哦；</p>
			        <p>3、若未开通无卡支付功能，则需要到银行开通无卡支付功能，同时需要对无卡支付额度进行设置。</p>
		        
		        
		    </div>
	    </div>
	    
    </div>
</div>
<!-- 添加银行卡弹出框结束 -->
<div class="prompt_box" id="win_srvprotocol" style="top: 100px;">
   <div style="width: 700px; height: 440px; left: -350px;" class="prompt_inner  ui-window-0">
        <h3 class="title">支付确认<a href="javascript:void()" class="close" onclick="closeWin();"></a></h3>
        <div class="conent" style="padding: 40px 100px">
            <table class="ui-table-7" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <th colspan="2" align="center"><h4 class="obj-title" id="titleCount"></h4></th>
                    </tr>                     
                    <tr>
                        <th align="right" valign="top"  width="85px">付款金额：</th>
                        <td><span id="td_Amount"></span> 元</td>
                    </tr>
                    <tr>
                        <th align="right"  width="85px">手机号码：</th>
                        <td>
                            <div class="ui-out-box">
                                <div class="ui-input-box" id="div_Mobile"></div>
                                <div class="ui-input-box">
                                    <input style="display: block;" value="发送验证码" id="btnSendMobileCode" onclick="sendPayYZM()" class="ui-code-btn button-yzm" type="button">
                                    <input id="spTime" style="display: none;" value="120秒后重新获取" class="ui-code-btn ui-disabled" type="button">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th align="right" valign="top"  width="85px"><div class="text-zd">验 证 码：</div></th>
                        <td>
                            <div class="ui-out-box">
                                <div class="ui-input-box">
                                    <input id="txt_MobileCheckCode" class="ui-input w-150" maxlength="6" value="输入短信验证码" defaultval="输入短信验证码" style="width: 150px; color: #ccc;" onkeydown="if(event.keyCode==13){return false;}" type="text">
                                    <span id="smsCode" style="color: rgb(255, 17, 0); padding-left:25px;display:inline-block; margin:5px 5px 0 6px;font-size: 10px;"></span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th align="right" valign="top" width="85px">&nbsp;</th>
                        <td>
                            <div id="div_PayWaiting" style="font-size:16px; margin-top:25px;display:none;"> </div>
                            <div id="div_PayOperate" class="calculator-btn" style="text-align:left;">
                                <input id="btnConfirmPay" value="确认支付" class="submit" onclick="submitOrder();" onkeydown="if(event.keyCode==13){submitOrder();}" type="button">
                                <input style="margin-left: 20px;" value="取  消" class="reset" onclick="closeWin();" type="button">
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!--支付弹窗开始-->
<div class="prompt_box" id="win_srvprotocol1" style="top: 150px;">
   <div style="width: 700px; height: 340px; left: -350px;" class="prompt_inner  ui-window-0">
         <div class="prompt_inner" id="pay">
				<h3 class="title">
					温馨提醒您
					<a href="javascript:void(0)" class="close" onclick="completePay('1');"></a>
				</h3>
				<div class="bank-alter-text">
					<p class="note-content">
						请你到新打开的网银页面进行支付，支付完成前请不要关闭该窗口
					</p>
					帮助：
					<a href="${ctx}/help/helpCenter/questionlist6.jsp" target="_blank" class="blue">支付遇到问题了？</a>
				</div>
				<div class="calculator-btn" style=" margin-left:220px;">
					<input style="width: 140px;" type="button" onclick="completePay();" value="已完成支付" />
					<input style="width: 145px;" type="button" class="alter" onclick="completePay('2')" value="修改付款银行" />
				</div>
			</div>
			
			  <div class="prompt_inner " id="succ" style="display: none">
			    <h3 class="title">温馨提醒您<a href="javascript:void(0)" onclick="closeWin();" class="close"></a></h3>
			      <h1><i class="false_btn"></i>您的订单正在处理中</h1>
			      <p>请检查您的银行卡是否已经扣款!</p>
			      <input class="gb" type="button"  onclick="closeWin();" value="关闭"/>
			  </div>
			  <div class="prompt_inner " id="failure" style="display: none">
			       <h3 class="title">温馨提醒您<a href="javascript:void(0)" onclick="closeWin1();" class="close"></a></h3>
			      <h1><i class="false_btn"></i>购买超募!</h1>
			      <p style="padding-left: 70px;">超募资金将在1-3个工作日内返回至您的银行卡!</p>
			      <input class="gb" type="button"  onclick="closeWin1();" value="关闭"/>
			  </div>
    </div>
</div>
<!--支付弹窗结束-->

<!--服务协议-->
<div id="win_srvprotocol2" class="buy_tan" style="display: none">
      <h2 style="font-size: 14px;text-align: center;margin: 20 0;">【互联网金融综合服务平台】服务协议</h2>
        <h3>一、重要提示</h3>
        <div style="text-decoration:underline;">
        <p>1.	【互联网金融综合服务平台】 (下称"本平台")所提供的服务包含本平台网站体验和使用、互联网金融信息中介服务以及本平台提供的任何其他特色功能、内容或应用程序(合称"平台服务")。</p>
        <p>2.	"本平台"的使用者，即通过注册手续，浏览"本平台"有关信息，使用有关服务的用户（以下简称“用户”）。选择并签署本协议的，视为用户接受本平台的服务时必须受本协议约束。若用户不接受，请勿使用本平台相关服务。</p>
        <p>3.	如果用户使用本平台及其各种平台服务，请务必认真阅读本协议，其中包括用户使用本平台服务所享有的权利、承担的义务和使用本平台服务的业务流程、隐私及保密条款等，尤其请注意其中所涉及的免除及限制本平台责任的条款、对会员用户权利限制的条款等加粗显示的内容。</p>
        </div>
        <h3>二、本平台服务</h3>
        <p>1.	融资服务是由本平台向自然人或企业用户提供的服务，具体服务内容主要包括：融资交易信息发布、交易撮合、由本平台指定的第三方支付机构进行交易资金划付等，具体详情以本平台当时提供的服务内容为准。</p>
        <p>2.	本平台作为用户之间交易的居间撮合角色存在，不涉及用户的交易内容及其交易资金管理服务。用户的交易约定内容和风险应由约定双方各自承担；交易资金管理服务由本平台指定的第三方支付机构提供。</p>
        <p>3.	北京蜂向信息科技有限公司（下称“蜂向公司”）作为本平台的运营服务提供商，代表本平台与用户签署本协议，享有在本协议项下的权利并履行本协议项下的义务。</p>
        <h3>三、本平台交易</h3>
        <p>（一）	交易主体 </p>
        <p>本平台交易过程，将涉及如下四方，定义如下： </p>
        <p>1.	融资人：通过本平台发布融资项目需求，并受到本协议规定约束的用户。确认本协议并使用本平台服务的融资人必须注册为平台用户，同时经见证机构（具体见证机构见《项目说明书》，以下简称“见证机构”）见证符合平台融资条件。不符合上述条件的，不能成为本协议所称融资人。</p>
        <p>2.   根据自身交易目标、交易期限、风险承受能力和资产状况等，在本平台上对融资人发布的融资项目，自有资金进行投资，获得投资收益，自行承担投资风险，并受到本协议约束的用户。确认本协议并使用本平台服务的投资人必须注册为平台用户，同时必须为中华人民共和国境内具备完全民事行为能力的公民。不符合上述条件的，不能成为本协议所称投资人。</p>
        <p>3.	本平台：为融资人提供发布融资项目需求通道，为投资人提供投资项目机会，并实现双方的信息和投资交易撮合的互联网信息平台。</p>
        <p>4.	第三方支付机构：具有中国人民银行支付牌照的第三方支付公司，对投资人和融资人在本平台上的借贷、债权转让、票据收益权转让、其他资产收益权转让等交易过程实现资金保管、划拨、还款等资金交易行为。本协议指定的第三方支付机构见融资项目《项目说明书》（简称“《项目说明书》”）。本平台对第三方支付机构的支付性能不承担责任。</p>
        <p>（二）	融资交易条款（适用于用户作为融资人时）</p>
        <p>1. 	平台交易</p>
        <p>1.1	融资人通过本平台发布融资需求，并接受本平台撮合的投资人的出资。融资人将通过本平台指定的第三方支付机构进行资金交易行为，如获取投资人的投资款以及向投资人进行还款或支付其他款项等。自借款协议/债权转让协议/票据收益权转让协议/其他资产收益权转让交易文件（以下简称“具体交易文件”）生效之日起，视同投资人和融资人正式确立交易关系。投融资双方的权利义务关系双方的交易行为、本协议及其他平台交易规则所共同确认。</p>
        <p>1.2	融资项目中投资人和融资人的真实身份、双方关系的确立及具体内容以本平台的交易记录、本协议、具体交易文件及《项目说明书》等为准，投资人和融资人对此均无异议。</p>
        <p>1.3	融资人通过和使用第三方支付机构进行资金的划转、存放，在任何情况下均不产生任何形式的孳息。</p>
        <p>1.4	为保障投资人权益，融资人将提供一定的担保措施，具体担保措施以具体交易文件的约定为准。</p>
        <p>2. 	融资发布 </p>
        <p>2.1	融资人通过本平台发布融资需求前，应向本平台提交必要的自然人身份信息或者企业名称、企业工商注册号、办公地址、企业人民银行征信信息、企业法人姓名、证明、企业开户行及账号等信息，或本平台认为必要的其他信息。平台有权根据融资人具体情况予以拒绝发布或临时撤销。
                  融资人发布的融资项目需求信息，以借贷项目为例，一般包括但不仅限于以下内容： 
        </p>
        <p>a.	借款总额：指融资人所发布项目所需的融资上限金额。</p>
        <p>b.	实际融资金额：指融资人实际接受的所有投资人支付的投资金额之和，实际融资金融小于或等于融资金额。</p>
        <p>c.	年化利率：由融资人发布的借款利率，以年化利率表示。（月利率=年化利率/12，日利率=年化利率/360）。</p>
        <p>d.	还款方式：指融资人还款的方式，包括但不限于“一次性到期还本付息”或“每月等额还款”等方式，投资人将按照融资人的还款方式获得不同收益。</p>
        <p>e.	最小出资金额：本次交易，由融资人所设置的单个投资人的最小出资限额。</p>
        <p>f.	最大出资金额：本次交易，由融资人所设置的单个投资人的最大出资限额。</p>
        <p>g.   起息日/放款日：指本次交易，融资款项通过第三方支付机构发放至融资人银行账户之日。起息日/放款日为中国的银行工作日。 </p>
        <p>h.	融资期限：融资期限是指自起息日起至到期日止的期间（包括起息日与到期日在内）。</p>
        <p>i.	还款日：还款日是指融资人在融资需求中列明的根据约定的还款方式所确定的还款日期，为融资人支付利息或/和本金的日期；如当月无该日期，则以当月的最后一日为还款日，还款日如遇法定节假日，则顺延至节假日后的第一个工作日。融资的到期日为最后一期的还款日。还款日为中国的银行工作日。</p>
        <p>j.	到期日：指本次交易，融资项目的融资期限届满之日，即全部或最后一期融资款项本金和利息的还款日。</p>
        <p>融资人确认：上述融资信息中除a、g、h外，其他项目均由本平台代为发布；融资人亦同意本平台可代为发布全部融资信息。</p>
        
        <p>2.2	除借贷项目外，关于债权转让、票据收益权转让、其他资产收益权转让等其他融资项目的需求信息，以本平台届时的具体要求为准。</p>
        <p>2.3	融资人和本平台确认，融资人在本平台发布的融资信息为本协议不可分割的组成部分。如融资人和投资人的交易关系最终成立的，融资人通过本台发布的融资信息同样成为该具体交易文件不可分割的组成部分</p>
        
        <p>3. 	融资实现</p>
        <p>3.1	融资人同意使用本平台指定的第三方支付机构所提供的交易资金管理服务。第三方支付机构将根据平台发送的交易指令进行资金支付、接收、保管、退款、发放、代扣平台服务费、划转出资本息收益等服务，并为资金在所有过程中的安全性提供保障。</p>
        <p>3.2	融资人了解并同意：本平台将通过多种方式操作（包括不仅限于一位或多位投资人投标）来实现单一或多个项目的融资需求。</p>
        <p>3.3	融资人了解并同意：投资人同意投标的，应在投标期间内将投资资金支付给指定第三方支付机构，在第三方支付机构将上述投资资金划转至融资人银行账户前，投资人所支付投资资金由指定第三方支付机构保管并保证其安全。</p>
        <p>3.4	融资人了解并同意：募集期结束后，如所有投资人投标金额之和大于等于融资金额的一定比例，第三方支付机构将按照平台指令，在募集期结束后将投资人的投资资金支付至融资人所指定的银行账户。如募集期结束后，所有投资人投标金额之和小于上述比例，平台可延长募集期1-3天。若延长募集期结束后，所有投资人投资金额之和仍小于上述比例的，则项目撤销，募集资金退回投资人（有关具体比例，由见证机构和融资人另行协议约定）。但若融资人在项目中并未对融资金额设置该等比例的（如债权转让交易），则项目不撤销，融资金额以所有投资人的实际投标金额为准。自具体交易文件生效之日起，将视同投资人和融资人正式确立交易关系。融资人未经平台书面同意，不得单方面撤销融资项目。 
                  投标结束后，如产生超募（即项目实际募集资金大于融资金额），平台将根据投资人的投资时间顺序将顺序在后的投资资金/部分投资资金通过第三方支付机构对超募资金进行退款处理。超募资金将被退至投资人在投标时指定的银行账户。</p>
        <p>3.5	融资项目如在本平台成功撮合（即融资人与投资人之间的具体交易文件生效），融资人需根据实际融资金额向蜂向公司支付平台服务费。
				借贷项目/各类资产收益权转让类项目中平台服务费收取的具体标准如下：
				平台服务费=项目实际融资金额×费率×融资期限
				平台服务费由融资人授权第三方支付机构根据平台的指令从投资人的投资金额（即实际融资金额）中直接扣除。融资人确认该平台服务费的扣除不影响融资人根据实际融资金额向投资人支付融资利息。 
				上述平台服务费公式中的“费率”根据融资人与见证机构所签订的《互联网金融综合服务平台融资服务合同》的内容进行确定。
        </p>
        <p>3.6	如本平台未成功撮合融资人和投资人的交易，融资人无需向蜂向公司/本平台缴纳平台服务费。</p>
        <p>4. 	还款（适用于借贷项目）  </p>
        <p>4.1	融资人有义务根据实际融资金额、利率、还款方式、融资期限等，向投资人偿还本金和利息。若融资人逾期还款，应向投资人支付逾期利息。</p>
        <p>4.2	还款日当天14：00前/还款日的前一个工作日，融资人将还款资金足额支付至本平台指定的第三方支付机构的，视为融资人正常还款。第三方支付机构将按照指令，将融资人的应付本息划拨至投资人指定的银行账户。融资人在还款日的前一个工作日还款的，仍按照本协议约定的融资期限支付融资利息。 </p>
        <p>4.3	未经平台书面同意，融资人不得提前归还融资。为避免歧义，融资人在还款日前将还款金额支付给本平台指定的第三方支付机构不视为提前归还融资。 </p>
        <p>5.   逾期（适用于借贷项目）</p>
        <p>5.1.	融资人未按照本协议的约定足额还款的，则视为融资人发生逾期还款。</p>
        <p>5.2.	融资人逾期还款的，融资人应向投资人支付逾期利息。</p>
        <p>5.3.	逾期利息按照逾期款项中的应还金额（本金）自逾期之日起按本协议约定利率的100%按日计收，直至清偿完毕之日。逾期罚息不计复息。</p>
        <p>5.4.	平台有权对融资人进行到期提醒及逾期催收。</p>
        <p>5.5.	融资人在发生逾期后进行还款的，如融资人的还款金额不足以足额清偿全部到期应付款项的，平台将按如下顺序指令第三方支付机构向投资人支付应付款项：</p>
        <p>（1） 单期还款：当融资人仅有一期应付款项未按时全额支付时，其还款顺序依次为：A.截止到该还款日的逾期罚息；B.利息；C.本金。 </p>
        <p>（2） 多期还款：当融资人存在多期应付款项未按时全额支付时，其还款资金须优先偿还其所欠的多期罚息和利息（总和），并从拖欠时间最长的本金罚息和利息开始偿还；罚息和利息支付完毕后，其剩余还款资金应根据应付款项拖欠的时间，从拖欠时间最长的应付款项开始偿还，依次（期）偿还；同一期应付款项的偿还顺序均为： A.截止到该还款日的逾期利息；B.利息；C.本金。 </p>
        <p>5.6.	对发生逾期的融资人，本平台可通知见证机构冻结其信贷额度，或将其列入平台黑名单，不再提供本协议项下所有或部分服务。</p>
        <p>（三）	投资交易条款（适用于用户作为投资人时）</p>
        <p>1. 	平台交易 </p>
        <p>1.1.	投资人登录到本平台，对融资人所发布的融资需求进行确认投资，并通过本平台指定的第三方支付机构进行投资资金支付。自具体交易文件生效之日起，视同投资人和融资人正式确立交易关系，本平台将上述相关事宜通过电子邮件、手机短信或平台公示等任一方式向双方予以告知。 </p>
        <p>1.2.	融资项目中投资人和融资人的真实身份、双方交易关系的确立及具体内容以本平台的交易记录、本协议、具体交易文件及《项目说明书》等为准，投资人和融资人对此均无异议。 </p>
        <p>1.3.	投资人通过和使用第三方支付机构进行资金的划转、存放，在任何情况下均不产生任何形式的孳息。</p>
        <h3>1.4.投资人同意：如融资人和投资人的交易关系最终成立的，融资人通过平台发布的融资信息即成为该具体交易文件不可分割的组成部分。 </h3>
        <p>1.5.	投资人同意见证机构为投资人的代理人，代理投资人办理相应手续，包括但不限于：（1）代理投资人办理与投资和投资内容有关的手续（代理签署具体交易文件及附属担保合同等并予以保管相关法律文件等），以使投资人依法获得投资项下权益；（2）对融资人进行融资到期提示；（3）融资逾期的情况下，代理投资人进行逾期催清收。</p>
        <p>2. 	投资</p>
        <p>投资人可在本平台，根据融资人提供的年化利率、还款方式等项目信息自主进行投资。项目信息，以借贷项目为例，一般包括但不限于以下内容：</p>
        <p>a.	融资金额：指融资人所发布项目所需的融资上限金额。 </p>
        <p>b.	投资金额：指本次交易，由投资人成功支付并与融资人达成有效交易的本金金额。</p>
        <p>c.	年化利率：指本次交易，由融资人发布的借款利率，以年化利率表示。（月利率=年化利率/12，日利率=年化利率/360 ） </p>
        <p>d.	还款方式：指融资人还款的方式，包括不仅限于"一次性到期还本付息"或"每月等额还款"等方式，投资人将按照融资人的还款方式获得收益。</p>
        <p>e.	最小投资金额：指本次交易，投资人最小出资限额。 </p>
        <p>k.   最大投资金额：指本次交易，投资人最大出资限额。</p>
        <p>f.	起息日/放款日：指本次交易，所需融资款项通过第三方支付机构发放至融资人银行账户之日。起息日/放款日为中国的银行工作日。</p>
        <p>g.	期限：指自起息日起至到期日止的期间（包括起息日与到期日在内）。</p>
        <p>h.	投标期间：投资人投标的起止时间。</p>
        <p>i.	还款日：还款日是指融资人在融资需求中列明的根据约定的还款方式所确定的还款日期，为融资人支付利息或/和本金的日期；如当月无该日期，则以当月的最后为还款日，还款日如遇法定节假日，则顺延至节假日后的第一个工作日。融资的到期日为最后一期的还款日。还款日为中国的银行工作日。</p>
        <p>j.	到期日：指本次交易，融资项目的融资期限届满之日，即全部或最后一期融资款项本金和利息的还款日。</p>
        <p>除借贷项目外，融资人发布的关于债权转让、票据收益权转让、其他资产收益权转让等其他融资项目的需求信息，以本平台届时的具体要求为准。</p>
        <p>3. 	支付</p>
        <p>3.1	投资人同意并认可使用本平台指定的第三方支付机构提供的交易资金管理服务。第三方支付机构将根据平台发送的交易指令进行投资资金支付、接收、保管、退款、发放、代扣平台服务费、划转投资本息等服务，并为资金在所有过程中的安全性提供保障。</p>
        <p>3.2	投资人同意投标的，应将投资资金支付给指定第三方支付机构。在第三方支付机构将上述投资资金划转至融资人银行账户前，投资人所支付投资资金由指定第三方支付机构保管并保证其安全。</p>
        <p>3.3  投资人了解并同意：投标结束后，如所有投资人投资金额之和大于等于融资金额的一定比例，第三方支付机构将按照平台指令，在募集期结束后将投资人的投资资金支付至融资人所指定的银行账户。如募集期结束后，所有投资人投标金额之和小于上述比例，平台可延长募集期1-3天。若延长募集期结束后，所有投资人投资之和仍小于上述比例的，则项目撤销，募集资金退回投资人（有关具体比例，由见证机构和融资人另行协议约定）。但若融资人在项目中并未对融资金额设置该等比例的（如债权转让交易），则项目不撤销，融资金额以所有投资人的实际投标金额为准。自具体交易文件生效之日起，投资人和融资人正式确立交易关系。</p>
        <p>3.4	投标结束后，如产生超募（即项目实际募集资金大于融资金额），平台将于所投项目募集期结束日的T+1日（均为工作日，非工作日将延后至下一个工作日）根据投资人的投资时间顺序将顺序在后的投资资金/部分投资资金通过第三方支付机构对超募资金进行退款处理。超募资金将被退至投资人在投标时指定的银行账户。同意并接受超募资金不产生任何形式的孳息。 </p>
        <p>4. 	投资回收  </p>
        <p>4.1.	投资人在成功支付后，可通过本平台查看投资及投资回收等详细情况。 </p>
        <p>4.2.	投资人有权在项目融资成功后，根据自己的投资金额，按照具体交易文件的约定进行投资资金本金回收，并获得相应的投资收益。 </p>
        <p>4.3.	在融资项目投资人为多方的情况下，投资人按照各自投资金额占实际融资金额的比例分配投资本金和收益等。 </p>
        <p>4.4.	以借贷项目为例，在还款日当天14：00前（含当天）向第三方支付机构足额划转融资本息的，视为融资人正常还款。投资人理解并同意，第三方支付机构最终将本协议项下的借款本息或受偿款项划转至投资人的指定银行账户需要一定的时间，前述时间一般为还款日后的1-3个工作日，前述期间内不产生任何融资利息或其它孳息，融资利息仍按照本协议约定的融资期限计算。</p>
        <p>4.5.	投资人投资所取得的收入，应当由投资人按照所适用法律法规自行缴纳相应的税费。 </p>
        <p>5. 	回收逾期（以借贷项目为例） </p>
        <p>5.1.	融资人未在还款日当天14：00前（含当天）向第三方支付机构足额划转的融资本息的，则视为融资人发生逾期还款。 </p>
        <p>5.2.	融资人逾期还款的，投资人有权要求其支付逾期利息，即罚息。 </p>
        <p>5.3.	罚息按照逾期款项中的投资金额（本金部分）自逾期之日起按本协议约定利率的100%按日计收，直至清偿完毕之日。逾期利息不计复息。 </p>
        <p>5.4.	融资人在发生逾期后进行还款的，如融资人的还款金额不足以足额清偿全部到期应付款项的，平台将按如下顺序指令第三方支付机构向投资人支付应付款项： </p>
        <p>（1）	单期还款：当融资人仅有一期应付款项未按时全额支付时，其还款顺序依次为：A．截止到该还款日的逾期利息；B. 利息；C. 本金。 </p>
        <p>（2）	多期还款：当融资人存在多期应付款项未按时全额支付时，其还款资金须优先偿还其所欠投资人的多期罚息和利息（总和），并从拖欠时间最长的罚息和利息开始偿还；罚息和利息支付完毕后，其剩余还款资金应根据应付款项拖欠的时间，从拖欠时间最长的应付款项开始偿还，依次（期）偿还；同一期应付款项的偿还顺序均为： A.截止到该还款日的逾期利息；B.利息；C.本金。</p>
        <p>6. 	费用及其他  </p>
        <p>6.1.	投资人可以免费享受本平台服务中的上述投资交易服务，无需就其通过本平台向融资人进行投资之事宜向蜂向公司/本平台缴纳平台服务费。 </p>
        <p>6.2. 但若融资项目中的借贷项目在本平台成功撮合（即融资人与投资人之间的借款协议生效）后，投资人拟转让其在借款协议项下的债权的，则在投资人与债权受让人之间的债权转让协议生效后，投资人需向蜂向公司支付平台服务费，具体标准如下：
				平台服务费=【实际转让金额×费率×项目剩余期限/360】。
				平台服务费由融资人授权第三方支付机构根据平台的指令从债权受让人支付的转让价款中直接扣除。</p>
        <p style="text-decoration:underline;">6.3.	投资人必须遵守本协议及相关法律法规。投资人不得利用本平台进行信用卡套现、洗钱或其他不正当交易行为，否则应依法独立承担法律责任。</p>
        	<h3>四、协议文本</h3>
            <p>(一)	在本平台交易需订立的协议采用电子协议方式。用户使用其在本平台注册的账户登录后，根据本平台的相关规则通过点击确认或类似方式签署的电子协议即视为用户的真实意愿并以用户的名义签署的协议，具有法律效力。用户应妥善保管自己的账户密码等账户信息，用户通过前述方式订立的电子协议对合同各方具有法律，用户不得以账户密码等账户信息被盗用或其他理由否认已订立的协议的效力或不按照该等协议履行相关义务。 </p>
            <p>(二)	用户根据本协议以及本平台的相关规则签署电子协议后，不得擅自修改该协议。本平台向用户提供电子协议的备案、查看、核对等服务，如对电子协议真伪或电子的内容有任何疑问，用户可通过本平台的相关系统板块查阅有关协议并进行核对。如对此有任何争议，应以本平台记录的协议为准。</p>
            <p>(三)	用户不得私自仿制、伪造在本平台上签订的电子协议或印鉴，不得用伪造的协议进行招摇撞骗或进行其他非法使用，否则用户应自行承担责任。 </p>
            <p>(四)	用户确认并同意，本平台有权对本协议项下的资金、利息、逾期罚息等任何金额进行计算；本平台对本协议项下任何金额的任何证明或确定，应作为该金额有关事项的终局证明。</p>
            <h3>五、隐私及保密</h3>
            <p>(一)	本平台对于用户提供的、本平台自行收集的、经认证的个人信息将按照本协议予以保护、使用或者披露。</p>
            <p>(二)	本平台收集个人资料的主要目的在于向用户提供一个顺利、有效和度身订造的交易经历。本平台仅收集本平台认为就此目的及达成该目的所必须的关于用户的个人资料。</p>
            <p>(三)	本平台可能通过公开或私人资料来源收集用户的额外资料，以更好地了解用户的需求，并为用户度身订造服务、解决争议并有助确保在本平台进行安全交易。 </p>
            <p>(四)	本平台有权按照用户在平台上的行为自动追踪关于用户的某些资料。在不透露用户个人的隐私资料的前提下，本平台有权对整个用户数据库进行分析并对用户数据库进行商业上的利用。</p>
            <p>(五)	本平台有权在本平台的某些网页上使用诸如“Cookies”的资料收集装置。</p>
            <p>(六)	本平台对于用户提供的、本平台自行收集到的、经认证的个人信息将按照本协议及有关规则予以保护、使用或者披露。本平台设有严格的数据安全系统，对用户信息进行同步记录和高强加密，防止未经授权的任何人、包括本公司的员工获取用户信息，严格保护用户的财务隐私和用户信息，但鉴于技术限制，本平台不能确保用户的全部私人通讯及其他个人资料不会通过本协议中未列明的途径泄露出去。</p>
            <p>(七)	本平台可根据有关法律要求向司法机关和政府部门提供用户的个人资料。在用户未能按照与本平台签订的服务协议或者与本平台其他用户签订的具体交易文件的约定履行自己应尽的义务时，本平台有权根据自己的判断或者与该笔交易有关的其他用户的请求披露用户的个人资料，并做出评论。</p>
            <p>(八)	如果用户严重违反本平台的相关规则或违反相关具体交易文件的条款的，本平台有权对用户提供的及本平台自行收集的用户的个人信息和资料编辑入平台黑名单，并依法依规将该黑名单报送相关征信机构或向第三方披露。</p>
            <p>(九)	因服务需要，本平台有权将用户提交的或本平台自行收集的用户的个人资料和信息与第三方进行数据共享，以便本平台和第三方催收逾期借款及对用户的其他申请进行审核之用，如果由此造成用户的经济损失，本平台无需承担法律责任。</p>
            <p>(十)	在本平台提供的交易活动中，用户承诺对所取得的相关交易相对人信息只用于与交易相关的合法、合理用途。用户无权要求本平台提供其他用户的个人资料，除非符合以下任一条件： </p>
            <p>a)	用户已向法院起诉其他用户的在本平台活动中的违约行为且法院已受理立案；</p>
            <p>b)	接受其他用户融资的融资人逾期未归还融资本息； </p>
            <p>c)	其他有碍于用户收回融资本息或其他合法权益的情形。</p>
            <p>(十一)	用户同意并授权本平台在其他任何用户符合上述任一条件时，将用户的个人资料提供给该其他用户。</p>
            <p>(十二)	用户不得对本平台服务的任何部分或全部以及通过本平台取得的任何形式的信息，进行复制、拷贝、出售、转售或用于任何其它商业目的。</p>
        <h3>六、修改及变更</h3>
        <p>用户了解并同意，本平台有权在通知用户后，对本协议项下的相关服务可进行暂时或永久修改，对此，用户如不接受相关修改的，应不再使用本协议项下服务；用户在平台通知发出后继续使用平台服务的，视为用户接受平台对服务的修改。</p>
        <p>本平台可能在服务过程中根据有关文件、协议和/或本平台页面的相关规则、说明等收取必要的服务或管理费用，其具体内容、比例、金额等事项请参见有关具体协议文件及本平台相关页面的规则和说明。用户同意，本平台有权不时调整前述服务或管理费用的类型或金额等具体事项并根据本协议和相关规则进行公告、修改。</p>
        <div style="text-decoration:underline;">
        <h3>七、责任</h3>
        <p>(一)	本平台仅对本协议中所列明的本平台应承担相关责任的义务承担责任。 </p>
        <p>(二)	用户确认因交易而产生的任何风险应由交易双方承担。</p>
        <p>(三)	用户信息是由用户自行发布，本平台无法保证用户信息的真实、及时和完整，用户应对用户的判断承担全部责任。</p>
        <p>(四)	本平台服务的合作单位，所提供的服务品质及内容由该合作单位自行负责。</p>
        <p>(五)	用户自本平台及本平台工作人员或经由本平台服务取得的建议或资讯，无论其为书面或口头，均不构成本平台对本平台服务的任何保证。</p>
        <p>(六)	用户同意，基于互联网的特殊性，本平台不担保服务不会中断，也不担保服务的及时性和/或安全性。系统因相关状况无法正常运作，使用户无法使用任何本平台服务或使用任何本平台服务时受到任何影响时，本平台对用户或第三方不负任何责任，前述状况包括但不限于： </p>
        <p>1.	本平台系统停机维护期间。 </p>
        <p>2.	电信设备出现故障不能进行数据传输的。  </p>
        <p>3.	由于黑客攻击、网络供应商技术调整或故障、网站升级、银行方面的问题等原因而造成的本平台服务中断或延迟。</p>
        <p>4.	因台风、地震、海啸、洪水、停电、战争、恐怖袭击等不可抗力之因素，造成本平台系统障碍不能执行业务的。 </p>
        <p>(七)	在法律允许的情况下，本平台对于与本协议有关或由本协议引起的，或者，由于使用本平台、或由于其所包含的或以其它方式通过本平台提供给用户的全部信息、材料、产品（包括软件）和服务、或购买和使用产品引起的任何间接的、惩罚性的、特殊的、派生的损失（包括但不限于业务损失、收益损失、利润损失、使用数据或其他经济利益的损失），不论是如何产生的，也不论是由对本协议的违约（包括违反保证）还是由侵权造成的，均不负有任何责任，即使其事先已被告知此等损失的可能性。另外即使本协议规定的排他性救济没有达到其基本目的，也应排除本平台对上述损失的责任。</p>
        <p>(八)	除本协议另有规定外，在任何情况下，本平台对本协议所承担的违约赔偿责任总额不超过向用户收取的当次本平台服务费用总额。</p>
     </div>
        <h3>八、用户的守法义务及承诺 </h3>
        <p>(一)	用户承诺绝不为任何非法目的或以任何非法方式使用本平台服务，并承诺遵守中国相关法律、法规及一切使用互联网之国际惯例，遵守所有与本平台服务有关的网络协议、规则和程序。</p>
        <p>(二)	用户同意并保证不得利用本平台服务从事侵害他人权益或违法之行为，若有违反者应负所有法律责任。上述行为包括但不限于：</p>
        <p>1.	反对宪法所确定的基本原则，危害国家安全、泄漏国家秘密、颠覆国家政权、破坏国家统一的。</p>
        <p>2.	侵害他人名誉、隐私权、商业秘密、商标权、著作权、专利权、其他知识产权及其他权益。 </p>
        <p>3.	违反依法律或合约所应负之保密义务。</p>
        <p>4.	冒用他人名义使用本平台服务。</p>
        <p>5.	从事任何不法交易行为，如贩卖枪支、毒品、禁药、盗版软件或其他违禁物。</p>
        <p>6.	提供赌博资讯或以任何方式引诱他人参与赌博。 </p>
        <p>7.	涉嫌洗钱、套现或进行非法集资活动的。 </p>
        <p>8.	从事任何可能含有电脑病毒或是可能侵害本平台服务系統、资料等行为。</p>
        <p>9.	利用本平台系统进行可能对互联网或移动网正常运转造成不利影响之行为。 </p>
        <p>10.	侵犯本平台的商业利益，包括但不限于发布非经本平台许可的商业广告。 </p>
        <p>11.	利用本平台服务上传、展示或传播虚假的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、庸俗淫秽的或其他任何非法的信息资料。</p>
        <p>12.	其他本平台有正当理由认为不适当之行为。</p>
        <p>(三)	本平台保有依其单独判断删除本平台内各类不符合法律政策或不真实或不适当的信息内容而无须通知用户的权利，并无需承担任何责任。 若用户未遵守以上规定的，本平台有权作出独立判断并采取暂停或关闭用户账号等措施，而无需承担任何责任。 </p>
        <p>(四)	用户同意，由于用户违反本协议，或违反通过援引并入本协议并成为本协议一部分的文件，或由于用户使用本平台服务违反了任何法律或侵害第三方的权利而造成任何第三方进行或发起的任何补偿申请或要求（包括律师费用），用户须对该违约行为所造成损失给予全额补偿。</p>
        <h3>九、一般性条款</h3>
        <p>(一)	本协议构成用户与本平台之间的正式协议，并用于规范用户的投融资业务流程。用户确认，用户的具体投融资交易所适用的本协议的具体条款取决于用户在该个交易中的法律地位（即作为融资人或投资人参与投融资交易），在一个投融资交易中适用融资人的相关，不排除在另一个投融资交易中适用投资人的相关条款。在用户使用本平台服务、使用第三方提供的服务时，在遵守本协议的基础上，亦应遵守与该等服务、内容有关附加条款及条件。</p>
        <p>(二)	本协议以及用户与本平台之间的关系，均受到中华人民共和国法律管辖。</p>
        <p>(三)	用户确认，用户与本平台就服务本身、本协议或其它有关事项发生的争议，应通过友好协商解决。协商不成的，应向平台运营商所在地有管辖权的人民法院提起诉讼。平台运营商所在地为北京市丰台区。</p>
        <p>(四)	本平台未行使或执行本协议设定、赋予的任何权利，不构成对该等权利的放弃。</p>
        <p>(五)	本协议中的任何条款因与中华人民共和国法律相抵触而无效，并不影响其它条款的效力。</p>
        <p>(六)	使用协议的标题仅供方便阅读而设，如与协议内容存在矛盾，以协议内容为准。</p>
        <p>(七)	本协议与用户注册协议不一致的，依本协议执行；本协议未规定的双方权利义务，依据用户在注册时所签订的注册协议执行。</p>
 
</div>

<!--快捷支付服务协议-->
<div class="prompt_box" id="win_srvprotocol3" >

        <h2 style="font-size: 14px;text-align: center;margin: 20 0;">快捷支付用户协议</h2>
        <p>1.您确认，在您使用本快捷支付服务（以下简称“本服务“）时，您是具有中华人民共和国法律规定的完全民事权利能力和民事行为能力的，能够独立承担民事责任的自然人（中华人民共和国境内（香港、澳门除外）的用户应年满18周岁），或者是在中国大陆地区合法开展经营活动或其他业务的或其他组织；本协议内容不受您所属国家或地区法律的排斥。不具备前述条件的，您应立即终止使用本服务。</p>
        <p>2.本协议条款与您的权益具有或可能具有重大关系，请您在同意接受本服务前确认，您已经充分阅读、理解并接受本协议的全部内容，一旦您选择本服务，即表示您同意遵循本协议的所有约定。 </p>
        <p>3.您知晓，您选择使用的本服务要求您提供个人的支付信息，您需保证您所提供的所有信息是真实的、合法的、正确的、完整的。本协议所指支付信息是指您使用本服务时需要提供的个人信息，包括但不限于账户名、密码、个人姓名、身份证号码、银行卡号等。</p>
        <p>4.您同意，为了提供本服务的技术需要，本公司有权采集、获取或在系统内保存您的部分支付信息。</p>
        <p>5.本公司将严格确保您的个人信息和支付信息的安全。 </p>
        <p>6.您知晓，您在使用本服务时应当认真确认交易信息，包括且不限于产品名称、份数、金额等，并按平台业务流程发出符合《快捷支付协议》约定的指令。您认可和同意：确认交易信息已不可撤销地向本公司的支付系统发出指令，本公司有权根据您的指令委托银行或第三方从您绑定的银行卡中将您确认的交易资金划扣给收款人。您不应以非本人意愿交易或其他任何原因要求退款或承担其他责任。 </p>
        <p>7.您承诺，对使用本服务过程中您发出的所有指令的真实性、有效性承担全部责任；本公司依照您的指令进行操作的一切风险由您自行承担。</p>
        <p>8.您认可，您使用本服务所涉及的账户的使用记录数据、交易金额数据等均以本公司系统平台记录的数据为准。 </p>
         <p>9.您保证，不向其他任何人泄露该支付信息。您知晓，您应妥善保管银行卡、卡号、密码以及您的账号、密码、数字证书等与银行卡或与您的支付账户有关的一切信息。如您遗失银行卡、泄露账户密码或相关信息的，您应及时通知发卡行及/或本公司，以减少可能发生的损失。因泄露密码、数字、丢失银行卡等导致的损失需由您自行承担。 </p>
        <p>10.您认可，在本公司有合理理由怀疑您提供的资料错误、不实、过时或不完整的情况下，本公司有权暂停或终止向您提供部分或全部本服务，您将承担因此产生的一切责任，本公司对此不承担任何责任。</p>
        <p>11.您认可，如果您违反本协议的约定；或违反本网站或其他关联公司网站的条款、协议、规则、通告等相关规定，而被终止提供服务的，本公司有权暂停或终止向您提供部分或全部本服务，您将承担因此产生的一切责任，本公司对此不承担任何责任。 </p>
        <p>12.如您发现有他人冒用或盗用您的账户及密码或任何其他未经合法授权之情形时，应立即以书面方式通知本公司并要求本公司暂停本。本公司将积极响应您的要求，但您理解，对您的要求采取行动需要合理期限，在此之前，本公司对已执行的指令及(或)所导致的您的损失不承担任何责任。 </p>
        <p>13.若您的支付信息变更而您未及时更新资料，导致本服务无法提供或提供时发生任何错误，您不得将此作为取消交易、拒绝付款的理由，您将承担因此产生的一切后果，本公司不承担任何责任。</p>
        <p>14.您使用本服务时同意并认可，可能由于银行本身系统问题、银行相关作业网络连线问题或其他不可抗拒因素，造成本服务无法提供。您确保您所输入的您的资料无误，如果因资料错误造成本公司于上述异常状况发生时，无法及时通知您相关交易后续处理方式的，本公司不承担任何损害赔偿责任。</p>
        <p>15.您同意，基于运行和交易安全的需要，本公司有权暂停提供或者限制本服务部分功能,或提供新的功能，在减少、增加或者变化任何功能时，只要您仍然使用本服务，表示您仍然同意本协议或者变更后的协议。 </p>
        <p>16.您同意，本公司有权随时对本协议内容进行单方面的变更，并以在本网站公告的方式予以公布，无需另行单独通知您；若您在本协议内容公告变更后继续使用本服务的，表示您已充分阅读、理解并接受修改后的协议内容，也将遵循修改后的协议内容使用本服务；若您不同意修改后的协议内容，您应停止使用本服务。</p>
    	<p>17.本协议之效力、解释、变更、执行与争议解决均适用中华人民共和国法律，没有相关法律规定的，参照通用国际商业惯例和（或）行业惯例。 </p>
    	<p>18.因平台提供服务所产生的争议均适用中华人民共和国法律，并由平台运营商所在地有管辖权的人民法院管辖。平台运营商所在地为北京市丰台区。  </p>
 
</div>
<div class="blackBg"></div>
     <%@ include file="../foot.jsp" %>
</body>
<style>
.xieyiP p{font-size: 14px;text-align: left;}
.xieyiP{padding:0 20px;}
</style>
</html>