function clearDefault(jel) {
    if (jel.val() == jel.attr("defaultText")) {
        jel.val("");
    }
}
function setDefault(jel) {
    if (jel.val() == "") {
        jel.val(jel.attr("defaultText"));
    }
}
jQuery.validator.addMethod("mobile", function (value, element) {
    return this.optional(element) || /^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/.test(value);
}, "请输入正确的手机号码");
jQuery.validator.addMethod("account", function (value, element, params) {
    return this.optional(element) || /^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/.test(value) || /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(value);
}, "请输入注册的手机号码或者邮箱");
//扩展密码强度验证
jQuery.validator.addMethod("password", function (value, element) {
    return this.optional(element) || /^[\@A-Za-z0-9\~\!@\#\$\%\^\&\*\.\(\)\{\}]*$/.test(value);
}, "请输入6-12位数字或字母组合作为登录密码");

jQuery.validator.addMethod("noteq", function (value, element) {
    return this.optional(element) || value != $(element).attr("defaulttext");
}, "");
$(function () {
    $.metadata.setType("attr", "validate");
    fValidator = $(document.forms).validate({
        onkeyup: false,
        showErrors: function (errorMap, errorList) {
            validateHelper.hideErrors(fValidator.currentElements);
            validateHelper.showErrors(errorMap, errorList);
            //都成功
            if (errorList.length == 0) {
                validateHelper.success(fValidator.currentElements);
            }
        }
    });

});
//包含错误信息的td必须设置class="errorMsg"
var validateHelper =
		{
		    showErrors: function (errorMap, errorList) {
		        if (errorList.length > 0) {
		            var tdElement = this.hideError(errorList[0].element);
		            $("#show_error").html("<div ><b class=\"icon-error\"></b>" + errorList[0].message + "</div>")
		        }
		    },
		    hideErrors: function (elements) {
		        $("#show_error").html('');
		    },
		    hideError: function (element) {
		        $("#show_error").html('');
		        return element;
		    },
		    success: function (elements) {
		        for (var i = 0; i < elements.length; i++) {
		            this.successone(elements[i]);
		        }
		    },
		    successone: function (element) {
		        $("#show_error").html("");

		    }
		}
$(function () {
    $(document.forms).each(function () {
        $(":input[defaultText]").live("focus", function () {
            clearDefault($(this));
        }).live("blur", function () {
            setDefault($(this));
        });
    });
});
function UrlParamsToObject() {
    var URLParams = {};
    var aParams = window.location.search.substr(1).split('&');
    for (i = 0; i < aParams.length; i++) {
        var p = aParams[i].split('=');
        URLParams[p[0]] = decodeURIComponent(p[1]);
    }
    return URLParams;
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
$("[qiantu_txtpwd=Qiantu]").live("focus", function () {
    SetInputFont(this, "black");
    ShowInputHint(this, "foc");
    if ($(this).val() == "") {
        $(".lg-password .login-note").empty();
    }
}).live("blur", function () {
    var l_Type = $(this).attr("L_Type");
    ShowInputHint(this, null);
    if ($.trim($(this).val()) == "") {
        window.document.getElementById("loginview_hint").innerHTML = "输入密码";
        SetInputFont(this, null);
        return;
    }

    var reg = /^^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@@#$%^&]))[\dA-Za-z!@@#$%^&]{6,16}/;
    if (!reg.test($(this).val()) || $(this).val().length<6 || $(this).val().length>16) {
        ShowErrorMsg(l_Type, "请输入正确的密码");
        ShowInputHint($("[qiantu_txtpwd=Qiantu]"), "err");
        return;
    }

    $("[show_error=Qiantu]").hide();
});
$("[Qiantu_TxtUsername=Qiantu]").live("focus", function () {
    SetInputFont(this, "black");
    ShowInputHint(this, "foc");
}).live("blur", function () {
    ShowInputHint(this, null);
    var txt = $(this);
    var l_Type = $(txt).attr("L_Type");
    var show_error = $("[show_error=Qiantu]");

    if ($.trim(txt.val()) == "" ||
        $.trim(txt.val()) == "用户名 / 手机号") {
        SetInputFont(this, null);
        return;
    }

    if (!UcsValidate.Account_MobileValidate(txt.val())) {

        ShowErrorMsg(l_Type, "账户或密码输入不正确");
        ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), "err");
        //$("[Qiantu_TxtUsername=Qiantu]").addClass("on-error")
        return;
    } else {
        $(show_error).hide();
        ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), null);
        //$("[Qiantu_TxtUsername=Qiantu]").removeClass("on-error");
    }

//    var submitData = {};
//    submitData.targetAction = "CheckUserName";
//    submitData.UserName = txt.val();
//    RenderTmpl({
//        Data: submitData,
//        Async: false,
//        SucessFn: function (result) {
//            $(show_error).hide();
//            ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), null);
//            //$("[Qiantu_TxtUsername=Qiantu]").removeClass("on-error");
//        },
//        ErrorFn: function (result) {
//            ShowErrorMsg(l_Type, result.Message);
//            ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), "err");
//            //  $(this).focus();
//            //$("[Qiantu_TxtUsername=Qiantu]").addClass("on-error");
//            return false;
//        }
//    });
});
$("[Qiantu_BtnLogin=Qiantu]").live("click", function () {
    var btn = $(this);
    var l_Type = $(btn).attr("L_Type");
    var show_error = $("[show_error=Qiantu]");

    var userName = $("[Qiantu_TxtUsername=Qiantu]").val();
    var pwd = $("[Qiantu_TxtPwd=Qiantu]").val();
    var chkbox = $("[Qiantu_Chkbox=Qiantu]").attr("checked");
    var code = $.trim($("#txtCode").val());
    var url = UrlParamsToObject()["RequestUrl"];

    if (!UcsValidate.Account_MobileValidate(userName)) {
        ShowErrorMsg(l_Type, "账号不能为空");
        //$("[Qiantu_TxtPwd=Qiantu]").addClass("on-error")
        ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), "err");
        return;
    } else {
        //$("[Qiantu_TxtPwd=Qiantu]").removeClass("on-error")
        ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), null);
    }
    if (!pwd || pwd == "") {
        //$("[Qiantu_TxtPwd=Qiantu]").addClass("on-error")
        ShowInputHint($("[Qiantu_TxtPwd=Qiantu]"), "err");
        ShowErrorMsg(l_Type, "请输入密码");
        return;
    }
    else 
    {
        ShowInputHint($("[Qiantu_TxtPwd=Qiantu]"), null);
    }
    //    if (!code || code == "") {
    //        ShowErrorMsg(l_Type, "请输入验证码！");
    //        return;
    //    }

    var submitData = {};
    submitData.targetAction = "AccountLogin";
    submitData.UserName = userName;
    submitData.Pwd = pwd;
    submitData.VidateCode = code;
    submitData.RequestUrl = url;
    submitData.Chkbox = chkbox;
    $("#btnLogin").attr("disabled", "1");
    $("#btnLogin").addClass("lg-submit-btn2");
    $("#btnLogin").attr("value", "登 录 中 ...");

    RenderTmpl({
        Data: submitData,
        Async: false,
        SucessFn: function (result) {
            if (result.DicData != null) {
                window.location.href = result.DicData.RequestUrl;
            }
            else {
                window.location.href = "../home/index.htm";
            }
        },
        ErrorFn: function (result) {
            ShowErrorMsg(l_Type, result.Message);
            ShowInputHint($("[Qiantu_TxtUsername=Qiantu]"), "err");
            ShowInputHint($("[Qiantu_TxtPwd=Qiantu]"), "err");
            if (result.DicData != null) {
                $.ajax({
                    url: 'LoginSendEmail',
                    type: 'post',
                    data: result.DicData,
                    dataType: 'text',
                    error: function (err) {
                        ShowErrorMsg(l_Type, "请求异常");

                        QT_Tip.MsgAlert("当前网络异常，请稍后再试(ajax error)：" + err.statusText);
                        location.href = location.href;
                    },
                    success: function (result) {
                        $("[show_error=Qiantu]").hide();
                    }
                });
            }
            return false;
        }
    });
})
function ShowErrorMsg(l_Type, msg) {
    $("#btnLogin").removeAttr("disabled");
    $("#btnLogin").removeClass("lg-submit-btn2");
    $("#btnLogin").attr("value", "登   录");
    var show_error = $("[show_error=Qiantu]");
    if (l_Type == "0") {
        $(show_error).html("<div ><b class=\"icon-error\"></b>" + msg + "</div>");
    }
    else {
        $(show_error).html('<em ></em><span class="error-text">' + msg + '</span>');
    }
    $(show_error).show();
}