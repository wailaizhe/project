<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>绑定银行卡</title>
<link href="${resource_dir}/css/public.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/index.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/main.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/register.css" rel="stylesheet" type="text/css">
<link href="${resource_dir}/css/jquery.autocomplete.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${resource_dir}/css/easydialog.css"/>
<script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/json2.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
<script type="text/javascript" src="${resource_dir}/js/jquery.autocomplete.js"></script>  	
</head>
<script type=text/javascript>
    var datasJson;
	$(document).ready(function () {
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
        
        openBankS();
        jointProvinceStr("");   
	});
	
	function openBankS(){
	    $.ajax({
             type: "POST",
             contentType: "application/json",
             url: "${ctx}/account/queryBank",
             data: "{}",
             dataType: "json",
             async: false,
             success: function (msg) {
             datasJson=eval(msg);
                $('#inputBank').AutoComplete({
                 'data':msg,
                 'width': 355,
                 'mustMatch ':true,
                 'autoFill': true,
                 'autoFocus':true,
                 'scrollHeight':50
                 }).AutoComplete('show'); 
              }
         });
	}
    //刷新页面
    function reloadPage() {
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
          $(this).val("填写银行卡号");
          $("#txtV").show();
          ShowHint("txtV", "err", "银行卡号不能为空");
          $("#txtAccountName").addClass("on-error");
          return;
        }
        var txtAccountName = $("#txtAccountName").val();
        var reg = /^\d{13,19}$/;
        if(!reg.test(jQuery.trim(txtAccountName))){
          $("#txtV").show();
          $("#txtAccountName").addClass("on-error");
          ShowHint("txtV", "err", "请输入合法的银行卡号(13~19位数字组成)！");
          return;
        }
        flah="02";
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
        var reg = /^0{0,1}(13[0-9]|17[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
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
		       $("#cardSubBank").addClass("on-error");
		       ShowHint("accB", "err", "支行名称不能为空！");
	           return;
          }
   });
   
   
   
    function jointProvinceStr(obj){
			var provinceStr = "";
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
   
 
   	//添加银行卡
    function addBankAccount() {
         var txtAccountName = $("#txtAccountName").val();
         var txtAccountNo = $("#txtAccountNo").val();
         var cardSubBank = $("#cardSubBank").val();
         var userName = $("#userNameInput").val();
         var IDCard = $("#IDCardInput").val();
         if(flagD=="01"){
             $("#userNameInput_note").show();
             $("#userNameInput").addClass("on-error");
             ShowHint("userNameInput_note", "err", "请输入2~6个汉字的真实姓名!");
             return;
         }
         if(flagI=="01"){
            $("#IDCardInput_note").show();
            $("#IDCardInput").addClass("on-error");
            ShowHint("IDCardInput_note", "err", "请输入15位或18位有效身份证号码！");
            return;
         }
         var ko = isCnNewID(IDCard);
         if(!ko){
            warnMsg("您的身份证号码输入错误,请重新输入！","关闭");
            return;
         }
         var ageData = getBirthdayFromIdCard(IDCard)//获得出生日期
         if(!checkAgeData(ageData)){  // 判断年龄是否大于18岁
           warnMsg("您输入的身份证号当前未满18岁，暂时不能进行实名认证","关闭");
           return;
         } 
         if(flah!="02"){
             $("#txtV").show();
             $("#txtAccountName").addClass("on-error");
             if(txtAccountName==$("#txtAccountName").attr("defaultval")){
                ShowHint("txtV", "err", "账号不能为空");
             }else{
                ShowHint("txtV", "err", "请输入合法的银行账号(13~19位数字组成)");
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
	      if(selectedCity==""){
            warnMsg("请选择省份！","关闭");
            return;
	      }
           var autoIn = $("#autoIn").html();
           var bankName;
           var sonBank="0";
           var bankCode;
           if("手动输入"==autoIn){
               bankName = $('#oldBank option:selected').text();
               bankCode = $('#oldBank option:selected').val();
               
           }else{
              bankName =  $('#inputBank').val(); 
              $.each(datasJson, function(i) {
	              if(datasJson[i].label==bankName){
	                sonBank =  "1";
	                bankCode=datasJson[i].code;
	              } 
	           }); 
	           if("0"==sonBank){
	              errorMsg("您输入的开户行名称有误，请重新输入！","关闭");
	              return;
	           }
           }
           
            var subBankSpan = $("#subBankSpan").html();
	         if("自动选择"==subBankSpan){
		       var reg = /^[\u4e00-\u9fa5]{4,18}$/;
		       if(cardSubBank==$("#cardSubBank").attr("defaultval")){
		          warnMsg("支行名称不能为空！","关闭");
		          return;
		       }else if(!reg.test(cardSubBank)){
		          warnMsg("请输入合法的支行名称(4~18位汉字组成)！","关闭");
		           return;
		       }
	         }else if("手动输入"==subBankSpan){
	            cardSubBank =  $('#cardSubBankInput option:selected').text();
	            if(""==cardSubBank||"请选择"==cardSubBank){
	              errorMsg("请选择支行名称！","关闭");
	              return;
	            }
	        }
          
            
            $.ajax({
            type: "post",
            async: false,
            url: '${ctx}/arcOrder/realNameAndBank',
            data: "BankAccountName=" + txtAccountName + "&BankAccountNo=" + txtAccountNo
                    + "&BankCode=" + bankCode + "&BankName=" + bankName+"&realName="+userName+"&identityCard="+IDCard
                    + "&userBirthday="+ageData+"&cardSubBank="+cardSubBank
                    + "&BankCity=" + selectedCity + "&BankCityCode=" + selectedCityCode
                    + "&cityName="+cityName+"&provinceName="+provinceName,
            dataType: "json",
            error: function (err) {
            },
            success: function (result) {
                 if("1"==result){
                    registerhrsuc();
                 }else if("2"==result){
                    warnMsg("您当前绑定的银行卡已有10张,不允许继续绑定！","关闭");
                 }else if("3"==result){
                    warnMsg("您提交的银行卡账号已绑定，请添加其他账号！","关闭");
                 }else if("4"==result){
                    errorMsg("请核实您的填入信息，如若无误，请稍后重试！！","关闭");
                 }else if("5"==result){
                    warnMsg("实名认证失败,请重新输入！","关闭");
                 }else if("6"==result){
                    warnMsg("该身份证号已被其他账户实名认证！","关闭");
                 }
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
    
    function clickInput(){
       var autoIn = $("#autoIn").html();
       if("手动输入"==autoIn){
         $("#oldBank").hide();
         $("#inputBank").show();
         $("#autoIn").html("自动选择");
       }else{
         $("#oldBank").show();
         $("#inputBank").hide();
         $("#autoIn").html("手动输入");
       }
    }
    
    
    var flagD="01";
    $("#userNameInput").live("focus", function () {
           inputColor(this,null);
           $("#userNameInput_note").hide();
           $("#userNameInput").removeClass("on-error");
           if($(this).val() == $(this).attr("defaultval")){
              $(this).val('');
           }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入真实姓名");
          $("#userNameInput_note").show();
          ShowHint("userNameInput_note", "err", "真实姓名不能为空!");
          $("#userNameInput").addClass("on-error");
          return;
        }
        if($(this).val()!=""){
            var reg = /^[\u4e00-\u9fa5]{2,6}$/;
            if(!reg.test($(this).val())) {
                $("#userNameInput_note").show();
                $("#userNameInput").addClass("on-error");
                ShowHint("userNameInput_note", "err", "请输入2~6个汉字的真实姓名!");
                return;
            }
            if($(this).val().length<2){
                $("#userNameInput_note").show();
                $("#userNameInput").addClass("on-error");
                ShowHint("userNameInput_note", "err", "请输入2~6个汉字的真实姓名!");
                return;
            }
        
        }
        flagD="02";
    });
    
    var flagI="01";
    $("#IDCardInput").live("focus", function () {
           inputColor(this,null);
           $("#IDCardInput_note").hide();
           $("#IDCardInput").removeClass("on-error");
           if($(this).val() == $(this).attr("defaultval")){
              $(this).val('');
           }
    }).live("blur", function () {
        if($(this).val()==""){
          inputColor(this,"black");
          $(this).val("请输入身份证号");
          $("#IDCardInput_note").show();
          ShowHint("IDCardInput_note", "err", "身份证号不能为空!");
          $("#IDCardInput").addClass("on-error");
          return;
        }
        
        if($(this).val()!=""){
            var IDCard = $("#IDCardInput").val();
            var reg = /^[1-9]([0-9]{14}|[0-9|X|x]{17})$/;
            if (!reg.test(IDCard)) {
                $("#IDCardInput_note").show();
	            $("#IDCardInput").addClass("on-error");
	            ShowHint("IDCardInput_note", "err", "请输入15位或18位有效身份证号码！");
	            return;
            }
        }
        flagI="02";
    });
    
    function registerhrsuc(){
        window.location.href = "${ctx}/baseInfo/registerhrsuc";
    }
   
   function  cardSubBankInput(){
       var subBankSpan = $("#subBankSpan").html();
       if("手动输入"==subBankSpan){
         $("#cardSubBankInput").hide(); 
         $("#cardSubBank").show();
         $("#subBankSpan").html("自动选择");
       }else{
         $("#cardSubBankInput").show();
         $("#cardSubBank").hide();
         $("#subBankSpan").html("手动输入");
       }
    } 
   
   function checkSubBank(){
        var subBankSpan = $("#subBankSpan").html();
        var bankName = selectBank();
        if("err"==bankName){
          errorMsg("您输入的开户行名称有误，请重新输入！","关闭");
          return;
        }
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
  
  function selectBank(){
      var autoIn = $("#autoIn").html();
      var bankName;
      var sonBank="0";
      var bankCode;
      if("手动输入"==autoIn){
          bankName = $('#oldBank option:selected').text();
          return  bankName;
      }else{
         bankName =  $('#inputBank').val(); 
         $.each(datasJson, function(i) {
          if(datasJson[i].label==bankName){
            sonBank =  "1";
            bankCode=datasJson[i].code;
          } 
       }); 
       if("0"==sonBank){
          return  "err";
       }else{
         return bankName;
       }
      }
   }
   
    
   function inputColor(ctrl,ftType){
        $(ctrl).css({"color":"#666"});
        if (ftType == 'black') {
          $(ctrl).css({"color":"#ccc"});
        }
    }
</script>
<body>
<%@ include file="../header.jsp" %>       
<div class="reg_section">
	<h3 class="reg">
    	<i><img src="${resource_dir}/images/username.png"/></i>
          <em>用户注册：</em>
    </h3>
    <div class="reg_head1">
    	<h3></h3>
    </div>
    <div class="reg_main">
			<table width="100%" border="0" cellspacing="5" cellpadding="0" class="table_5" style="margin-left:70px;">
				<tbody>

                    <tr>
						<th> <span class="red">*</span><span class="ui-icon"> 真实姓名：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
									<input type="text" maxlength="19" id="userNameInput"  oncopy="return false;" onpaste="return false"  value="请输入真实姓名" defaultval="请输入真实姓名" class="ui-input w-150" style="height: 40px; line-height: 40px; width: 355px;border-radius:3px; color: rgb(204, 204, 204);"/>
								    <span id="userNameInput_note" style="color: rgb(255, 17, 0); padding-left: 25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>
                    <tr>
						<th> <span class="red">*</span><span class="ui-icon"> 身份证号：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
									<input type="text" maxlength="19" id="IDCardInput"  oncopy="return false;" onpaste="return false"  value="请输入身份证号" defaultval="请输入身份证号" class="ui-input w-150" style="height: 40px; line-height: 40px; width: 355px;border-radius:3px; color: rgb(204, 204, 204);"/>
								    <span id="IDCardInput_note" style="color: rgb(255, 17, 0); padding-left:25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>
					
				</tbody>
				<tbody>
					<tr>
						<th> <span class="red">*</span><span class="ui-icon"> 银行卡号：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
									<input type="text" maxlength="19" id="txtAccountName"  oncopy="return false;" onpaste="return false"  value="填写银行卡号" defaultval="填写银行卡号" class="ui-input w-150" style="height: 40px; line-height: 40px; width: 355px;border-radius:3px; color: rgb(204, 204, 204);"/>
								    <span id="txtV" style="color: rgb(255, 17, 0); padding-left:25px;display:inline-block; margin:5px 10px 0 6px;"></span>
								</div>
							</div></td>
					</tr>
					<tr>
						<th> <span class="red">*</span><span class="ui-icon"> 手机号码：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
									<input type="text" id="txtAccountNo" maxlength="11" oncopy="return false;" onpaste="return false" value="填写银行预留手机号码" defaultval="填写银行预留手机号码" class="ui-input w-150" style="height: 40px; line-height: 40px; width: 355px;border-radius:3px; color: rgb(204, 204, 204);"/>
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
						<th width="10%"> <span class="red">*</span><span class="ui-icon"> 开户银行：</span> </th>
						<td width="70%">
								 <select style="height: 40px; line-height: 40px; width: 355px;border-radius:3px;" onchange="checkSubBank();"  name="oldBank" id="oldBank">
								      <option value="1539">山西省农村信用社</option>
								      <option value="1506">晋城商业银行</option>
								      <option value="102">中国工商银行</option>
								      <option value="103">中国农业银行</option>
								      <option value="105">中国建设银行</option>
								      <option value="301">交通银行</option>
								      <option value="308">招商银行</option>
								      <option value="104">中国银行</option>
								      <option value="100">中国邮政储蓄银行</option>
								      <option value="303">中国光大银行</option>
								      <option value="302">中信银行</option>
								      <option value="305">中国民生银行</option>
								      <option value="307">平安银行</option>
								      <option value="304">华夏银行</option>
								      <option value="403">北京银行</option>
								      <option value="310">浦发银行</option>
								      <option value="440">徽商银行</option>
								      <option value="408">宁波银行</option>
								      <option value="447">兰州银行</option>
								      <option value="450">青岛银行</option>
								      <option value="401">上海银行</option>
								 </select>
							<input   style="border-radius:3px;border:0;height: 40px; width: 355px; display: none;border:1px solid #ccc;"  type="text" id="inputBank"/>
							<a href="javascript:void(0)" onclick="clickInput()" style="display:inline-block;line-height:35px;"><span class="ui-icon" id="autoIn" style="padding-left: 10px;font-size:14px;">手动输入</span></a>
						</td>
					</tr>
					
					<tr>
					     <th> <span class="red">*</span><span class="ui-icon"> 开户省市：</span> </th>
							<td width="70%">
											<select class="ddlProvince" name="Province" id="province"
												style="height: 35px;width:177px;border-radius:3px;" onchange="toggleProvince()">
												<option selected="selected" value="">
													请选择省
												</option>
											</select>
											<select name="City" id="city" onchange="checkSubBank();" style="width:177px;height: 35px;border-radius:3px; display: none;"></select>
							</td>
				   </tr>
					<tr>
						<th> <span class="red">*</span><span class="ui-icon"> 支行名称：</span> </th>
						<td><div class="ui-out-box">
								<div class="ui-input-box">
								 	<select style="height: 35px;width:355px;display:none;"  name="cardSubBankInput" id="cardSubBankInput">
								     <option value="-1">请选择</option>
								    </select>
								 	<input type="text" id="cardSubBank" name="cardSubBank" value="请填写支行名称" defaultval="请填写支行名称" class="ui-input w-150"  style="width: 355px;border-radius:3px;height: 35px; line-height: 35px;color: rgb(204, 204, 204);">
								    <a href="javascript:void(0)" onclick="cardSubBankInput();" style="display:inline-block;line-height:35px;"><span class="ui-icon" id="subBankSpan" style="padding-left: 10px;font-size:14px;">自动选择</span></a>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		<DIV class="calculator-btn">
          <INPUT type="submit" onclick="addBankAccount();" value="立即绑定" style="width:355px;height:50px;margin-left:116px;font-size:20px;"save-ui-bank="isrefresh">
          <span onclick="registerhrsuc();">暂不绑定银行卡，<a>跳过！</a></span>
        </DIV>
</div>
</div>
		<%@ include file="../foot.jsp" %>		
	</body>
</html>