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
	 
	
	
//验证手机号
    var isSendSMSable = true;
    function CheckMobile(Mobile) {
	        var HintCtrl_Id = "Hint_Mobile";
	        if (Mobile == null || Mobile == "" || Mobile == $("#Mobile").attr("defaultval")) {
	            ShowHint(HintCtrl_Id, "err", "*手机号不能为空！");
	            ShowInputHint($("#Mobile"), "err");
	            $("#Mobile").focus();
	            return false;
	        }
	        var reg = /^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
	        if (!reg.test(Mobile)) {
	            ShowHint(HintCtrl_Id, "err", "*请输入正确的手机号");
	            ShowInputHint($("#Mobile"), "err");
	            //$("#Mobile").focus();
	            return false;
	        }
	            //ShowInputHint($("#Mobile"), null);
	        return true;
    }
    $("#Mobile").live("focus", function () {
		       SetInputFont(this, "black");
		       ShowInputHint(this, "foc");
		       ShowHint("Hint_Mobile", null, "");
		       if ($(this).val() == $(this).attr("defaultval")) {
		           $(this).val("");
		       }
    }).live("blur", function ()
		{
				var HintCtrl_Id = "Hint_Mobile";
				var Mobile = $.trim($(this).val());
				if (Mobile == null || Mobile == "") {
					SetInputFont(this, null);
					ShowHint(HintCtrl_Id, "err", "*手机号不能为空！");
					ShowInputHint($("#Mobile"), "err");
					return;
				}
				else if (Mobile == $(this).attr("defaultval")) {
					$(this).val($(this).attr("defaultval"));
					ShowHint(HintCtrl_Id, null, null);
					ShowInputHint(this, null);
					SetInputFont(this, null);
					return;
				}

				if (!CheckMobile($(this).val())) {
					return;
				}

				//$("#btn_Register").attr("disabled", "0");
				ShowHint(HintCtrl_Id, null, "");
				isSendSMSable = true;
				//验证手机
				$.ajax({
				
				    type: "post",
					dataType: "text",
					url: '${ctx}/baseInfo/check',
					data: "phone=" + Mobile,
					error: function (msg) { ShowHint(HintCtrl_Id, "err", "很抱歉，您的网络似乎有点问题,请重试！"); ShowInputHint($("#Mobile"), "err"); },
					success: function (msg) {
						if (msg == "") {
							ShowHint(HintCtrl_Id, "ok", "");
							ShowInputHint($("#Mobile"), null);
						}
						else {
							//此手机已经被注册
							isSendSMSable = false;
							ShowHint(HintCtrl_Id, "err", msg);
							ShowInputHint($("#Mobile"), "err");
						}
					}
				});
    });
	
	
 
//	验证密码
function  CheckPassword(Password) {
        var HintCtrl_Id = "Hint_Password";
        if (Password == null || Password == "") {
            ShowHint(HintCtrl_Id, "err", "*密码不能为空");
            ShowInputHint($("#txt_Password"), "err");
            //$("#txt_Password").focus();
            return false;
        }

        var Password2 = $.trim($("#txt_Password2").val());
        var reg = /^^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@#$%^&]))[\dA-Za-z!@#$%^&]{6,16}/;
        if (!reg.test(Password) || Password.length < 6 || Password.length > 16) {
            ShowHint(HintCtrl_Id, "err", "*密码必须为6-16位数字、字母、符号的组合！");
            ShowInputHint($("#txt_Password"), "err");
            return false;
        }
        else if (Password2 != "") {
            ShowHint(HintCtrl_Id, "ok", "");
            ShowInputHint($("#txt_Password"), null);
            return CheckPassword2(Password2);
        }
        else {
            ShowHint(HintCtrl_Id, "ok", "");
            ShowInputHint($("#txt_Password"), null);
            return true;
        }
    }
    $("#txt_Password").live("focus", function () {
        ShowInputHint(this, "foc");
        ShowHint("Hint_Password", "note", "*密码为6~16位字符的字母、数字、符号的组合");
        if ($(this).val() == "") {
            $("#spn_PasswordNote").html("");
        }
    }).live("blur", function () {
        var HintCtrl_Id = "Hint_Password";
        SetInputFont(this, "black");
        $("#spn_PasswordNote").removeClass("f-6");
        var Password = $.trim($(this).val());
        if (Password == null || Password == "") {
            ShowHint(HintCtrl_Id, "err", "*密码不能为空！");
            ShowInputHint($("#txt_Password"), "err");
            $(this).val("");
            //$("#spn_PasswordNote").html($("#spn_PasswordNote").attr("defaultval"));
            //$("#spn_PasswordNote").addClass("f-6");
            //$("#spn_PasswordNote")("display", "");
            //$("#txt_Password").focus();
            return;
        }
        //         if (Password == "") {
        //             ShowHint("Hint_Password", null, "");
        //             ShowInputHint(this, null);
        //             SetInputFont(this, null);
        //             $("#spn_PasswordNote").html($("#spn_PasswordNote").attr("defaultval"));
        //             $("#spn_PasswordNote")("display", "");
        //             return;
        //         }

        if (!CheckPassword($(this).val())) {
            return;
        }

        ShowInputHint(this, null);
    });
    //验证确认密码
    function CheckPassword2(Password2) {
        var HintCtrl_Id = "Hint_Password2";
        if (Password2 == null || Password2 == "") {
            ShowHint(HintCtrl_Id, "err", "*确认密码不能为空！");
            ShowInputHint($("#txt_Password2"), "err");
            //$("#txt_Password2").focus();
            return false;
        }

        var Password = $.trim($("#txt_Password").val());
        if (Password != Password2) {
            ShowHint(HintCtrl_Id, "err", "*两次输入密码需要一致！");
            ShowInputHint($("#txt_Password2"), "err");
            return false;
        }
        else {
            //ShowHint(HintCtrl_Id, "ok", "");
            var Password2 = $.trim($("#txt_Password2").val());
            if (Password2 != null && Password2 != "") {
                if (Password != Password2) {
                    ShowHint(HintCtrl_Id, "err", "*两次输入密码需要一致！");
                    ShowInputHint($("#txt_Password2"), "err");
                    //$("#txt_Password2").focus();
                    return false;
                }
                else {
                    ShowHint("Hint_Password2", "ok", "");
                }
            }
            ShowInputHint($("#txt_Password2"), null);
            return true;
        }
    }
    $("#txt_Password2").live("focus", function () {
        SetInputFont(this, "black");
        ShowInputHint(this, "foc");
        ShowHint("Hint_Password2", null, "");
        if ($(this).val() == "") {
            //$(".reg-Password2 .login-tips-text").empty();
            $("#spn_PasswordNote2").html("");
        }
    }).live("blur", function () {
        var Password = $.trim($("#txt_Password").val());
        var Password2 = $.trim($(this).val());
        if (Password == "") {
            if (Password2 != "") {
                ShowHint("Hint_Password", "err", "*请先输入密码！");
                ShowInputHint($("#txt_Password"), "err");
                $("#txt_Password").focus();
            }
            else {
                ShowHint("Hint_Password2", null, "");
                ShowInputHint(this, null);
                SetInputFont(this, null);
                $(this).val("");
                $("#spn_PasswordNote2").html($("#spn_PasswordNote2").attr("defaultval"));
                $("#spn_PasswordNote2")("display", "");
            }

            return;
        }

        if (!CheckPassword2($(this).val())) {
            return;
        }
        ShowInputHint(this, null);
    });
	
	
//进行验证码验证
	function CheckMobileCheckCode(MobileCheckCode) {
        var HintCtrl_Id = "Hint_MobileCheckCode";
        var reg = /^\d{6}$/;
        if (MobileCheckCode == null || MobileCheckCode == "" || MobileCheckCode == $("#txt_MobileCheckCode").attr("defaultval")) {
            //验证码
            //$("#txt_MobileCheckCode").focus();
            ShowHint(HintCtrl_Id, "err", "*验证码不能为空！");
            ShowInputHint($("#txt_MobileCheckCode"), "err");
            //QT_Tip.MsgAlert("验证码不能为空");
            return false;
        }
        else if (!reg.test(MobileCheckCode)) {
            ShowHint(HintCtrl_Id, "err", "*验证码错误！");
            ShowInputHint($("#txt_MobileCheckCode"), "err");
            //QT_Tip.MsgAlert("验证码错误");
            return false;
        }

        //ShowHint(HintCtrl_Id, "ok", "");
        return true;
    }
    $("#txt_MobileCheckCode").live("focus", function () {
        SetInputFont(this, "black");
        ShowInputHint(this, "foc");
        ShowHint("Hint_MobileCheckCode", null, "");
        if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
        }
    }).live("blur", function () {
        var HintCtrl_Id = "Hint_MobileCheckCode";
        var MobileCheckCode = $.trim($(this).val());
        if (MobileCheckCode == null || MobileCheckCode == "") {
            ShowHint(HintCtrl_Id, "err", "*验证码不能为空！");
            ShowInputHint(this, "err");
            $(this).val("");
            return;
        }
        if (MobileCheckCode == $(this).attr("defaultval")) {
            //$(this).val($(this).attr("defaultval"));
            ShowHint($(this).attr("id"), null, null);
            ShowInputHint(this, null);
            SetInputFont(this, null);
            return;
        }

        if (!CheckMobileCheckCode($.trim($(this).val()))) {
            return;
        }

        ShowInputHint(this, null);
    });
    
	
 
 	
//进行邀请码验证	
function CheckInviteCode(InviteCode) {
        var HintCtrl_Id = "Hint_InviteCode";
        var reg = /^[a-z][0-9]{1,5}$/;
        if (InviteCode == null || InviteCode == "" || InviteCode == $("#txt_InviteCode").attr("defaultval")) {
            //可以没有邀请码
            ShowHint(HintCtrl_Id, null, "");
            ShowInputHint($("#txt_InviteCode"), null);
            $("#txt_InviteCode").val($("#txt_InviteCode").attr("defaultval"));
            return true;
        }
        else if (!reg.test(InviteCode)) {
            // $("#txt_InviteCode").focus();
            ShowHint(HintCtrl_Id, "err", "*邀请码错误！");
            ShowInputHint($("#txt_InviteCode"), "err");
            return false;
        }

        return true;
    }
    $("#txt_InviteCode").live("focus", function () {
        SetInputFont(this, "black");
        ShowInputHint(this, "foc");
        ShowHint("Hint_InviteCode", null, "");
        if ($(this).val() == $(this).attr("defaultval")) {
            $(this).val("");
        }
    }).live("blur", function () {
        var InviteCode = $.trim($(this).val());
        var HintCtrl_Id = "Hint_InviteCode";
        if (InviteCode == null || InviteCode == "" || InviteCode == $(this).attr("defaultval")) {
            $(this).val($(this).attr("defaultval"));
            ShowHint(HintCtrl_Id, null, "");
            ShowInputHint(this, null);
            SetInputFont(this, null);
            return;
        }
        if (!CheckInviteCode(InviteCode)) {
            return;
        }

$.ajax({
            async: true,
            type: "post",
            url: 'IsValidInviteCode',
            data: "InviteCode=" + InviteCode,
            dataType: "json",
            error: function (result) { ShowHint(HintCtrl_Id, "err", "您的网络视乎有问题，请稍后重试！"); ShowInputHint($("#txt_InviteCode"), "err"); },
            success: function (result) {
                if (result.IsSuccess) {
                    ShowHint(HintCtrl_Id, "ok", "");
                    ShowInputHint($("#txt_InviteCode"), null);
                }
                else {
                    ShowInputHint($("#txt_InviteCode"), "err");
                    ShowHint(HintCtrl_Id, "err", result.Message);
                }
            }
        });
    });
 
 
 //获取验证码	
function sendMobileCheckCode() {
        if (!isSendSMSable) {
            return;
        }

        var Mobile = $.trim($("#Mobile").val());
        if (!CheckMobile(Mobile)) {
            return;
        }

        iPoint = window.setInterval("setTime()", 1000);
        $("#spTime").show();
        $("#btnSendMobileCode").attr("disabled", "disabled"); $("#btnSendMobileCode").hide();
        $("#sp_mobile").parent().show();
        $("#sp_mobile").text(Mobile);
        //验证手机
        $.ajax({
            async: true,
            type: "post",
            url:  'SendMobileCheckCode',
            dataType: "text",
            data: "mobile=" + Mobile + "&SessionName=MobileCheckCode&SendMsg=&SmsType=1&ContentType=0",
            success: function (msg) {
                if (msg != "true") {
                    window.clearInterval(iPoint);
                    $("#spTime").hide();
                    $("#spTime").val("60秒后获取");
                    $("#btnSendMobileCode").removeAttr("disabled");
                    $("#btnSendMobileCode").show();
                    //QT_Tip.MsgAlert("获取验证码：" + msg);
                    ShowHint("Hint_MobileCheckCode",   "err", msg);
                }
            },
            complete: function () {

            }
        });
    }
 
       

if (document.addEventListener) {// 如果是Firefox
	document.addEventListener("keypress", fireFoxHandler, true);
} else {
	document.attachEvent("onkeypress", ieHandler);
}

function fireFoxHandler(evt) {
	// firefox
	if (evt.keyCode == 13) {
		doCheckSubmit();
	}
}

function ieHandler(evt) {
	// IE
	if (evt.keyCode == 13) {
		doCheckSubmit();
	}
}