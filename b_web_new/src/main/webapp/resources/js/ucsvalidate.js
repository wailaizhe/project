var UcsValidate = {};
UcsValidate.DateTypeFn = {
    "email": function (val) {
        return UcsValidate.EmailValidate(val);
    },
    "mobile": function (val) {
        return UcsValidate.MobileValidate(val);
    },
    "account_mobile": function (val) {
        return UcsValidate.Account_MobileValidate(val);
    },
    "email_mobile": function (val) {
        return UcsValidate.Mobile_EmailValidate(val);
    },
    "phone": function (val) {
        return UcsValidate.PhoneValidate(val);
    },
    "phone_mobile": function (val) {
        return UcsValidate.Phone_MobileValidate(val);
    },
    "url": function (val) {
        return UcsValidate.UrlValidate(val);
    }
};

UcsValidate.DealValudateResult = function (errList) {
    if (errList.length > 0) {
        alert(errList[0].msg);
        errList[0].holder.focus();
    }
}

UcsValidate.AttrToObject = function (attrName) {
    var obj = { isValidate: true, data: {} };
    var errList = [];
    $("[" + attrName + "]").each(function () {
        var valueHolder = $(this);
        var vConfig = ToObject(valueHolder.attr(attrName));
        var val = valueHolder.val();
        if (vConfig.notempty) {
            if (val == "") {
                errList[errList.length] = {
                    holder: valueHolder, val: val, msg: vConfig.notempty
                };
                obj.isValidate = false;
                return;
            }
        }
        if (vConfig.dt) {
            if (UcsValidate.CheckDataType(vConfig.dt, val) == false) {
                errList[errList.length] = {
                    holder: valueHolder, val: val, msg: vConfig.dt.msg
                };
                obj.isValidate = false;
                return;
            }
        }
        obj.data[vConfig["d"]] = val;
    });
    if (obj.isValidate == false) {
        UcsValidate.DealValudateResult(errList);
    }
    return obj;
}

UcsValidate.CheckDataType = function (dtConfig, val) {
    return UcsValidate.DateTypeFn[dtConfig.type](val);
}

//注册账户名 为字母、数字或者汉字字符要求3到16字符
UcsValidate.AccountValidate = function (value) {
    var vallength = (value.replace(/[^\x00-\xff]/g, "aa")).length;
    var regdex = /^[a-zA-Z0-9\u4e00-\u9fa5]+$/
    return regdex.test(value) && vallength >= 3 && vallength <= 16;
}

//手机号码
UcsValidate.MobileValidate = function (value) {
    var length = value.length;
    var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/
    return length == 11 && mobile.test(value);
}

//电子邮箱
UcsValidate.EmailValidate = function (value) {
    var email = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    return email.test(value);
}

//注册账户名 或 手机号
UcsValidate.Account_MobileValidate = function (value) {
    return UcsValidate.AccountValidate(value) || UcsValidate.MobileValidate(value);
}

//手机号码/电子邮箱
UcsValidate.Mobile_EmailValidate = function (value) {
    return UcsValidate.MobileValidate(value) || UcsValidate.EmailValidate(value);
}

//电话号码
UcsValidate.PhoneValidate = function (value) {
    var phoneMatch = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
    var isPhone = phoneMatch.test(value);
    if (isPhone == false) {
        phoneMatch = /^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
        isPhone = phoneMatch.test(value);
    }
    return isPhone;
}

//手机号码/电话号码
UcsValidate.Phone_MobileValidate = function (value) {
    return UcsValidate.MobileValidate(value) || UcsValidate.PhoneValidate(value);
}

//网址
UcsValidate.UrlValidate = function (value) {
    var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
                + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
                + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
                + "|" // 允许IP和DOMAIN（域名）
                + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
                + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名
                + "[a-z]{2,6})" // first level domain- .com or .museum
                + "(:[0-9]{1,4})?" // 端口- :80
                + "((/?)|" // a slash isn't required if there is no file name
                + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    var re = new RegExp(strRegex);
    return re.test(value);
}
//中文，英文字母，数字
UcsValidate.CN_En_NumValidate = function (value) {
    if (/[\s><,._\。\[\]\{\}\?\/\+\=\|\'\\\":;\~\!\@@\#\*\$\%\^\&`\uff00-\uffff)(]+/.test(value)) {
        return false;
    } else {
        return true;
    }
}