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
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/jquery.autocomplete.css"/>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/polaris.css"/>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
        <script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/json2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/jquery.metadata.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/jquery.validate.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/jquery.autocomplete.js"></script>
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
                     countErr="系统无法验证您的绑定卡，请更换绑定卡或稍后再试！";
                    }else if("9"==result){
                     countErr="您已连续绑卡多次，请30分钟后再次绑定！";
                    }else{
                     countErr= result;
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
    	if($(box).attr("checked")=="checked"){
    	    $("#xieYiMsg").hide();
    	    if("0"==$("#aHE").val()){
    	      window.open('${ctx}/help/helpCenter/investorServiceAgreement.jsp','_blank');
    	      $("#aHE").val('1');
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
    	if($(box).attr("checked")=="checked"){
    	    $("#xieYiMsg1").hide();
    	    if("0"==$("#aHO").val()){
    	      window.open('${ctx}/help/helpCenter/fastPaymentProtocol.jsp','_blank');
    	      $("#aHO").val('1');
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
        var bankCode = $("#div_AddBink_BankSelectedK").find("span").attr("code");
        if(bankCode==""||bankCode==null){
           // warnMsg("请选择银行卡！","关闭");
           addBankAccountOnClick();
           return;
        }
        //勾选协议提示
	  	if($("#chk_AgreeProtocol").attr("checked") != "checked"){
	  		$("#xieYiMsg").html('请阅读并勾选协议');
	  		$("#xieYiMsg").show();
	  		return false;
	  	}
	  	if("1"==$("#quickHide").val()){
		  	 //勾选协议提示
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
          $.ajax({
            type: "post",
            async: false,
	        url:'${ctx}/arcOrder/queryPayCount',
	        data:'bankCode='+bankCode+'&fkItemId='+fkItemId+"&capital="+capital+"&income="+income+"&serialNumber="+serialNumber,
	        success: function(data){
                 flagSize = data;
                 $("#titleCount").html(flagSize.titleCount);
		         $("#div_Mobile").html(flagSize.bankMonliePhone);
		         $("#td_Amount").html(FormatDigital($("#txt_InvestAmount").val()));
	          }
		   });
		   if("04"==flagSize.stateCon){
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
   
   // 支付提交订单
   function submitOrder(){
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
	   function reloadUrl(){
		   location.reload(true);
	   }
	  // 快捷支付
	  function quickPay(){
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
    var isNewBank="1";
    var isNewBanks;
    function showBankLisk(){
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
 
 function closeWin1(){
     window.location.href="${ctx}/item/gotoInvestmentList";
 }
    
$(document).ready(function () {
     
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
});

    function aHreH(arg){
       $("#aHE").val(arg);
    }
    
    function aHreO(arg){
       $("#aHO").val(arg);
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
										<th width="14%"> 预期收益： </th> <span id="minAmout" style="display: none;">${itemInfo.investUnitFee*itemInfo.minInvestAmount}</span>
										<td width="86%"><p> <span class="ui-currency"></span><b class="fz-24 red" id="lblFullInterest">${income}</b> 元</p></td>
									</tr>
									<tr>
										<th> <p> 投标金额：</p>
										</th>
										<td>    <span id="formatCapital">${capital}</span> 元
												<input type="hidden"  class="textFild" autocomplete="off" id="FinanCount" onlynumber="FinanCount" onpaste="return false" oncontextmenu="return false" oncopy="return false"  min="1"  value="1" name="PartsCount">
												<input id="txt_InvestAmount" type="hidden" maxlength="20"  class="textFild textFild-2" name="" value="${capital}">
											<span style="float: left; line-height: 35px; margin-left: 40px;display: none;" class="red">(该项目您最多可投
											      <span id="surplus" style="display: none">${total}</span><span id="totCount">${total}</span>
											元)</span></td>
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
                                         
                                        <c:forEach var="bankIcon" items="${bankIcon}">
                                              <li>
	                                            <input type="radio" />
	                                            <label class="radioBox" id="" ><span class="bank-card ${bankIcon.encoding}" code="${bankIcon.code}" title="${bankIcon.text}"></span></label>
	                                            <div class="support">
	                                                 <span style="font-size:10px;">${bankIcon.max_limit}</span>
                                                 </div>
                                              </li>
										</c:forEach>
                                        <li onclick="addBankAccountOnClick();" ><span code="7"></span><a href="javascript:void(0)">更多银行</a></li>
                                    </ul>
                                    
                                    
                                    <ul class="twoC">
                                         <c:forEach var="bankIcon" items="${bankIcon}">
                                            <c:if test="${bankIcon.code!=1539}">
                                              <li>
	                                            <input type="radio" />
	                                            <label class="radioBox" id="" ><span class="bank-card ${bankIcon.encoding}" code="${bankIcon.code}" title="${bankIcon.text}"></span></label>
	                                            <div class="support">
	                                                 <span style="font-size:10px;">${bankIcon.max_limit}</span>
                                                 </div>
                                              </li>
                                            </c:if>
										</c:forEach>
                                    </ul>
                                    
                            </div>
						</div>
						<span style="padding-left:65px;display:inline-block;padding-bottom: 10px;">* 温馨提示： 山西省农村信用社联合社储蓄卡，快捷支付限额：单笔5万，日限额10万。</span>
					   <div class="mod-bottom">
						<div class="info-agm">
							<span>
							<span> <b>
								<input type="checkbox"   onclick="verfythisBox(this)" class="ui-checkbox" name="agree" id="chk_AgreeProtocol" seed="JIndexForm-JAgree" smartracker="on">
								</b><label for="chk_AgreeProtocol">我已阅读并同意</label>
								<a href="${ctx}/help/helpCenter/investorServiceAgreement.jsp" target="_blank" class="a-line"style="color:#0090e6;" onclick="aHreH('1')">【互联网金融综合服务平台】服务协议</a>
								<span id="spn_OpenDirect"></span></sapn>
								<span id="xieYiMsg" style="color:red;display:none;"></span>
							</span>
							</span>
							<c:if test="${bankList!='[]'}">
								<span style="margin-left:30px;display:inline-block;" id="quickPayProtocol1">
							    <sapn> <b>
									<input type="checkbox" onclick="quickPayProtocol(this)" class="ui-checkbox" name="agree" id="quickPayProtocol" seed="JIndexForm-JAgree" smartracker="on">
									</b><label for="quickPayProtocol">我已阅读并同意</label>
									<a href="${ctx}/help/helpCenter/fastPaymentProtocol.jsp" target="_blank" class="a-line" style="color:#0090e6;" onclick="aHreO('1')">《快捷支付服务协议》</a>
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
	      <div class=bank-add-title2 id="hideBanks" ><SPAN class=span-1 style="padding-left:30px;">支付/回款账户资料（<FONT>本次投资回收的本金和利息到期后将汇入此账户</FONT>）<a href="${ctx}/help/helpCenter/questionlist11.jsp" target="_blank" class="blue">绑卡遇到问题？</a></SPAN></div>
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
	   	<div class="conent"  id="showBank" style="padding: 0 90px 0 130px; background: url('${resource_dir}/images/sucess_icon.png') no-repeat 150px 0 ; ">
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
		    	<div class="lose_left">
		        	<p class="red">注：<span id="yinBank"></span>储蓄卡需先开通银联无卡支付业务</p>
		            <p class="red">请去银行营业网点开通，或使用其他卡绑定.</p>
		        </div>
		    	<div class="lose_right">
		        	<a href="${ctx}/help/helpCenter/questionlist11.jsp" target="_blank">如何开通？</a>
		        </div>
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
<div class="blackBg"></div>
     <%@ include file="../foot.jsp" %>
	</body>
</html>