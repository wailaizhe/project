//公用脚本
/**
*Ajax返回处理函数
**/
//获取屏幕宽度，更改页面宽度
var _windowW = $(window).width();
function setWH() {
    _windowW = $(window).width()
    if (_windowW < 1100) {
        $("notfound.html").css({ width: "960px" })

    } else {
        $("notfound.html").css({ width: "" })
    }
}
$(window).resize(function () {
    setWH()
});
$(function () {
    setWH();
});

//日期格式转换
function dealDate(dateStr){
	if(dateStr){
		var date = new Date(dateStr);
		return date.format("yyyy-MM-dd"); 
	}else{
		return "";
	}
}
//时间格式转换（到分）
function dealDateMM(dateStr){
	if(dateStr){
		var date = new Date(dateStr);
		return date.format("yyyy-MM-dd hh:mm"); 
	}else{
		return "";
	}
}
//时间格式转换
function dealDateTime(dateStr){
	if(dateStr){
		var date = new Date(dateStr);
		return date.format("yyyy-MM-dd hh:mm:ss"); 
	}else{
		return "";
	}
}
//计算投标时长（取整/天）	
function subS(sNum){
	//return sNum.toFixed(2);  //保留两位小数
	return parseInt(sNum); //取整
}

function formatMoney(mount){
	var result = "0.00";
	 if(mount!=undefined && mount!=""){
	 	mount=parseFloat(mount);
	 	if(mount%10000 != 0){
	 		result = (mount/10000).toFixed(1);
	 	}else{
	 		result = parseInt(mount/10000)+".0";
	 	}
	 }else{
	 	result = "0.00";
	 }
	 return result;
}

//$(document).ready(function () {
//    $(function () {
//        $(window).scroll(function () {
//            var top = $(window).scrollTop();
//            if (top > 100) {
//                $("#scrolltop").fadeIn();
//            } else {
//                $("#scrolltop").fadeOut();
//            }
//        });
//        $("#scrolltop").click(function () {
//            $("html,body").animate({ scrollTop: 0 });
//        });
//    });
//});
function ResultDeal(jsonResult, fnConfig) {
    var result = JSON.parse(jsonResult);
    if (result.IsDone == true) {
        if (result.Message.indexOf("Fn_") > -1) {
            if (fnConfig) {
                if (fnConfig[result.Message])
                    fnConfig[result.Message]();
                else
                    alert("未指定fn:" + result.Message)
            } else {
                eval(result.Message + "();");
            }
        }
        else {
            alert(result.Message);
        }
    }
    else {
        alert(result.Message);
    }
}

//自适应高度
function HeightChange() {
    try {
        var iframe = parent.document.getElementById("mainwin");
        var height = $(document).height();
        if (height < 650)
            height = 650;
        $(iframe).height(height);

    } catch (err) {
        //alert("自适应高错误：" + err);
    }
}

//投资记录 



function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null)
        return unescape(r[2]);
    return "";
}

//兼容苹果浏览器点击事件
function eventclick(obj) {
    if ($.browser.safari) {
        var evt = document.createEvent("MouseEvents");
        evt.initEvent("click", true, true);
        obj.get(0).dispatchEvent(evt);
    }
    else {
        obj.click();
    }
}
/**
*数据格式化
*eg:10000转10,000
**/
function FormatDigital(str) {
    var str = $.trim(str);
    var newStr = "";
    var count = 0;
    if (str.indexOf(".") == -1) {
        for (var i = str.length - 1; i >= 0; i--) {
            if (count % 3 == 0 && count != 0) {
                newStr = str.charAt(i) + "," + newStr;
            }
            else {
                newStr = str.charAt(i) + newStr;
            }
            count++;
        }
        str = newStr+".00";
    }
    else {
        for (var i = str.indexOf(".") - 1; i >= 0; i--) {
            if (count % 3 == 0 && count != 0) {
                newStr = str.charAt(i) + "," + newStr;
            }
            else {
                newStr = str.charAt(i) + newStr;
            }
            count++;
        }

        str = newStr + (str + "00").substr((str + "00").indexOf("."), 3);
    }
    return str;
}
function CreateIntArr(min, max) {
    var arr = [];
    for (var i = min; i <= max; i++)
        arr[arr.length] = i;
    return arr;
}
function GetPagerHtml(options, tagtype) {
    //判断标签类型
    var _tagtype = tagtype == null || tagtype == undefined ? "li" : tagtype;
    var pagehome = _tagtype == "li" ? "首页" : "<<";
    var pageprev = _tagtype == "li" ? "上一页" : "<";
    var pagenext = _tagtype == "li" ? "下一页" : ">";
    var pageend = _tagtype == "li" ? "尾页" : ">>";
    var pindex = options.index;
    var psize = options.size;
    var total = options.total;
    var fnName = options.fnName;
    var showpage = options.showpage;
    var defaultFn = function (pi) {
        if (showpage == undefined) {
            return fnName + "(" + pi + "," + psize + ")";
        } else {
            return fnName + "(" + pi + "," + psize + ",true)";
        }
    };
    var linkCreateFn = options.linkCreateFn || defaultFn;

    var totalPage = 0; //总页数
    var pageSize = psize; //每页显示行数
    totalPage = parseInt((total - 1) / pageSize);
    if (psize * totalPage < total)
        totalPage += 1;

    var tempHtml = $("<ul></ul>");
    if (pindex > 1) {
        tempHtml.prepend("<" + _tagtype + " class='page-home'><a  href=\"javascript:" + linkCreateFn(1) + "\">" + pagehome + "</a></" + _tagtype + ">");
    } else {
        tempHtml.prepend("<" + _tagtype + "  class='page-home'><a href=\"javascript:void(0)\">" + pagehome + "</a></" + _tagtype + ">");
    }
    if (pindex > 1) {
        tempHtml.prepend("<" + _tagtype + "  class='page-prev'><a href=\"javascript:" + linkCreateFn(pindex - 1) + "\">" + pageprev + "</a></" + _tagtype + ">");
    } else {
        tempHtml.prepend("<" + _tagtype + "  class='page-prev'><a href=\"javascript:void(0)\">" + pageprev + "</a></" + _tagtype + ">");
    }

    var linkArr = [];
    if (totalPage > 1) {
        if (totalPage < 9) {
            linkArr = CreateIntArr(1, totalPage);
        } else {
            if (pindex < 6) {
                linkArr = CreateIntArr(1, 9);
            }
            else {
                var min = pindex - 4;
                var max = pindex + 4;
                var overNum = max - totalPage;
                if (overNum > 0) {
                    min = totalPage - 8;
                    max = totalPage;
                }
                linkArr = CreateIntArr(min, max);
            }
        }
    }
    if (linkArr.length > 0) {
        for (var i = 0; i < linkArr.length; i++) {
            var index = linkArr[i];
            if (index == pindex) {
                tempHtml.prepend("<" + _tagtype + " class='num current'><a href=\"javascript:void(0)\">" + index + "</a></" + _tagtype + ">");
                continue;
            }
            tempHtml.prepend("<" + _tagtype + "><a style=\"text-decoration:underline;width:10px\" href=\"javascript:" + linkCreateFn(index) + "\">" + index + "</a></" + _tagtype + ">");
        }
    }
    if (pindex < totalPage) {
        tempHtml.prepend("<" + _tagtype + " class='page-next'><a href=\"javascript:" + linkCreateFn(pindex + 1) + "\">" + pagenext + "</a></" + _tagtype + ">");
    } else {
        tempHtml.prepend("<" + _tagtype + "  class='page-next'><a href=\"javascript:void(0)\">" + pagenext + "</a></" + _tagtype + ">");
    }
    if (pindex < totalPage) {
        tempHtml.prepend("<" + _tagtype + " class='page-end'><a href=\"javascript:" + linkCreateFn(totalPage) + "\">" + pageend + "</a></" + _tagtype + ">");
    } else {
        tempHtml.prepend("<" + _tagtype + "  class='page-end'><a href=\"javascript:void(0)\">" + pageend + " </a></" + _tagtype + ">");
    }
    //tempHtml.prepend("<ul>");
    return tempHtml.html();
}

function GetPagerHtmlSpan(options) {
    var pindex = options.index;
    var psize = options.size;
    var total = options.total;
    var fnName = options.fnName;
    var showpage = options.showpage;
    var defaultFn = function (pi) {
        if (showpage == undefined) {
            return fnName + "(false," + pi + ")";
        } else {
            return fnName + "(false," + pi + ",true)";
        }
        //        if (showpage == undefined) {
        //            return fnName + "(" + pi + "," + psize + ")";
        //        } else {
        //            return fnName + "(" + pi + "," + psize + ",true)";
        //        }
    };
    var linkCreateFn = options.linkCreateFn || defaultFn;



    var totalPage = 0; //总页数
    var pageSize = psize; //每页显示行数
    totalPage = parseInt((total - 1) / pageSize);
    if (psize * totalPage < total)
        totalPage += 1;
    var tempHtml = "";
    if (pindex > 1) {
        tempHtml += "<a class='page-num' href=\"javascript:" + linkCreateFn(1) + "\"><<</a>";
    } else {
        tempHtml += "<a class='page-num' title='首页'><<</a>";
    }
    if (pindex > 1) {
        tempHtml += "<a class='page-num' title='上一页' href=\"javascript:" + linkCreateFn(pindex - 1) + "\"><</a>"
    } else {
        tempHtml += "<a class='page-num' title='上一页'><</a>";
    }

    var linkArr = [];
    if (totalPage > 1) {
        if (totalPage < 9) {
            linkArr = CreateIntArr(1, totalPage);
        } else {
            if (pindex < 6) {
                linkArr = CreateIntArr(1, 9);
            }
            else {
                var min = pindex - 4;
                var max = pindex + 4;
                var overNum = max - totalPage;
                if (overNum > 0) {
                    min = totalPage - 8;
                    max = totalPage;
                }
                linkArr = CreateIntArr(min, max);
            }
        }
    }
    if (linkArr.length > 0) {
        for (var i = 0; i < linkArr.length; i++) {
            var index = linkArr[i];
            if (index == pindex) {
                tempHtml += "<a class='page-num current' href='javascript:void(0)'>" + index + "</a>";
                continue;
            }
            tempHtml += "<a  class='page-num' href=\"javascript:" + linkCreateFn(index) + "\">" + index + "</a>";
        }
    }
    if (pindex < totalPage) {
        tempHtml += "<a class='page-num' title='下一页' href=\"javascript:" + linkCreateFn(pindex + 1) + "\">></a>";
    } else {
        tempHtml += "<a  class='page-num' title='下一页'>></a>";
    }
    if (pindex < totalPage) {
        tempHtml += "<a class='page-num' title='末页'href=\"javascript:" + linkCreateFn(totalPage) + "\">>></a>";
    } else {
        tempHtml += "<a class='page-num' title='末页'>>></a>";
    }
    return tempHtml;
}


function GetJsType(object) {
    var _t;
    return ((_t = typeof (object)) == "object" ? object == null && "null" || Object.prototype.toString.call(object).slice(8, -1) : _t).toLowerCase();
}
function IsString(o) {
    return GetJsType(o) == "string";
}
function InitRTip() {
    $("input[rtip]").each(function () {
        var rTip = $(this).attr("rtip");
        if (rTip == null || rTip == '')
            return;
        if ($(this).val() == '') {
            $(this).val(rTip);
        }
        $(this).focus(function () {
            var tip = rTip;
            if (this.value == rTip)
                this.value = '';
        });
        $(this).blur(function () {
            var tip = rTip;
            if (this.value == '')
                this.value = rTip;
        });
    });
}
function CheckRTip() {
    $("input[rtip]").each(function () {
        var rTip = $(this).attr("rtip");
        if ($(this).val() == rTip) {
            $(this).val("");
        }
    });
}

Date.prototype.format = function (format) {
    /* 
    * format="yyyy-MM-dd hh:mm:ss"; 
    */
    var o = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S": this.getMilliseconds()
    }

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4
    - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
    ? o[k]
    : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}
function ToJson(obj) {
    return JSON.stringify(obj);
}
function ToObject(strJson) {
    return JSON.parse(strJson);
}

//strDateTime要转换的值 formattype转换格式 如:yyyy-MM-dd
function ShortDateTime(strDateTime, formattype) {
    var datetime = new Date(Date.parse(strDateTime));
    return datetime.format(formattype == undefined ? "yyyy-MM-dd" : formattype);
}
function FormatDateTime(strDateTime, strNowTime) {

    var nowtime = new Date(window.CurTime);
    var datetime = new Date(Date.parse(strDateTime));

    var seconds = parseInt((nowtime.getTime() - datetime.getTime()) / 1000);
    var days = parseInt(seconds / (24 * 60 * 60));
    var hours = parseInt(seconds / (60 * 60));
    var minutes = parseInt(seconds / 60);
    if (datetime.getYear() == nowtime.getYear()) {
        if (days < 1 && nowtime.getDay() == datetime.getDay()) {
            if (hours < 1) {
                if (minutes < 1) {
                    if (seconds < 0) {
                        return "1秒前";
                    }
                    return seconds + "秒前";
                }
                return minutes + "分钟前";
            }
            return "今天 " + datetime.format("hh:mm");
        }
        return datetime.format("MM月dd日 hh:mm");
    }
    return datetime.format("yyyy-MM-dd hh:mm:ss");
}
function FormatString(str, length, restr) {
    if (str.length < length)
        return str;
    return str.substring(0, length) + restr;
}
function StrToDate(strDate) {
    var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
    function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
    return date;
}
function ToDateTime(strDateTime) {
    return new Date(Date.parse(strDateTime));
}
function AddDays(curDate, step) {
    //可以加上错误处理
    var a = StrToDate(curDate);
    a = a.valueOf();
    a = a + step * 24 * 60 * 60 * 1000;
    a = new Date(a);
    //alert(a.getFullYear() + "年" + (a.getMonth() + 1) + "月" + a.getDate() + "日")
    return a;
}
function AddMonths(curDate, step) {
    var tempDate = new Date(curDate);
    tempDate.setMonth(tempDate.getMonth() + step);
    return tempDate;
}
function InList(left, rightList) {
    if (rightList.length < 1) {
        alert("未配置rightList");
        return false;
    }
    for (var i = 0; i < rightList.length; i++) {
        if (left == rightList[i])
            return true;
    }
    return false;
}
// /大图小图/日期/用户id-日期-毫秒-图片后缀.jpg
// /0/20130101/3-20130101-5555555-0.jpg
var _PicTypeMap_ = { "0": "jpg", "1": "jpeg", "2": "bmp", "3": "png", "4": "gif" };
var _PicDomain = "";
//picType
//0 原
//1 缩
//2 中
//3 小
function PicPath(picId, picType) {
    picId = picId || "";
    if (picId) {
        var picArr = picId.split('-');
        var picDomain = _PicDomain;
        return picDomain + '/' + picType + '/' + picArr[1] + '/' + picId + '.' + _PicTypeMap_[picArr[3]];
    } else {
        var defaultPath = "notfound.html";
        if (arguments.length > 2) {
            defaultPath = "notfound.html";
        }
        return defaultPath;
    }

}
//设置光标位置
$.fn.setSelection = function (selectionStart, selectionEnd) {
    if (this.lengh == 0) return this;
    input = this[0];

    if (input.createTextRange) {
        var range = input.createTextRange();
        range.collapse(true);
        range.moveEnd('character', selectionEnd);
        range.moveStart('character', selectionStart);
        range.select();
    } else if (input.setSelectionRange) {
        input.focus();
        input.setSelectionRange(selectionStart, selectionEnd);
    }
    return this;
}

$.fn.setCursorPosition = function (position) {
    if (this.lengh == 0) return this;
    return $(this).setSelection(position, position);
}
$.fn.focusEnd = function () {
    this.setCursorPosition(this.val().length);
}
function TryStr(str, nullStr) {
    if (str)
        return str.toString();
    else
        return nullStr;
}
function TryInt(obj, notIntStr) {
    var intVal = parseInt(obj);
    if (isNaN(intVal))
        return notIntStr;
    return intVal;
}
function InArray(arr, val) {
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] == val)
            return true;
    }
    return false;
}
function DisableEvent(el) {
    el.css("visibility", "hidden");
    // el.hide();
}
function EnableEvent(el) {
    el.css("visibility", "visible");
    //el.show();
}
function ArrayEach(arr, fn) {
    if (arr) {
        for (var i = 0; i < arr.length; i++) {
            fn(i, arr[i]);
        }
    }
}
jQuery.fn.getOuterHTML = function (s) {
    return $("<p></p>").prepend(this.clone(true)).html();
};
String.prototype.endWith = function (s) {
    if (s == null || s == "" || this.length == 0 || s.length > this.length)
        return false;
    if (this.substring(this.length - s.length) == s)
        return true;
    else
        return false;
    return true;
}
String.prototype.startWith = function (s) {
    if (s == null || s == "" || this.length == 0 || s.length > this.length)
        return false;
    if (this.substr(0, s.length) == s)
        return true;
    else
        return false;
    return true;
}
function CheckLength(txtLimit) {
    var num = txtLimit.attr("txt_limit_id");
    var limitLength = txtLimit.attr("txt_limit_length") || 140;
    var defText = txtLimit.attr("defaulttext");
    var defTextLength = 0;
    if (defText)
        defTextLength = defText.length;
    var countLabel = $("[label_numlimit_id=" + num + "]");
    var content = txtLimit.val();
    var contentLength = content.length;
    var hasDef = content.startWith(defText);
    var outLength = 0;
    if (hasDef) {
        countLabel.html(limitLength - contentLength + defTextLength);
        outLength = (contentLength - defTextLength) - limitLength;
    }
    else {
        countLabel.html(limitLength - contentLength);
        outLength = contentLength - limitLength;
    }
    if (outLength > 0) {
        countLabel.html(0);
        txtLimit.val(txtLimit.val().substr(0, contentLength - outLength));
    }
};
function IsTextEmpty(txtLimit) {
    var v = txtLimit.val();
    if (v == "")
        return true;
    var deftext = txtLimit.attr("defaulttext");
    v = v.replace(deftext, "");
    if (v == "")
        return true;
    return false;
};
function FocusTop(dom) {
    var divId = "_divFocus_";
    var $div = $("#" + divId);
    if ($div.length < 1) {
        $('<div id="' + divId + '" style="position:absolute"><input type="text" style="width: 1px; height: 1px; border: 0px;position:absolute" /></div>').prependTo($(document.body));
        $div = $("#" + divId);
    }
    var top = 0;
    if (dom) {
        var d = dom || $(document.body);
        if (d.find(".openWindow").length > 0) {
            d = d.find(".openWindow");
        }
        var po = d.offset();
        var top = po.top - d.height() + 20;
        if (top < 100)
            top = 100;
    }
    $div.css("top", top).find("input").focus();
}
function ArrayExist(arr, v) {
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] == v)
            return true;
    }
    return false;
}
function Reload() {
    window.location.href = window.location.href;
}
function TryBool(val, nullVal) {
    if (val == null || val == undefined)
        return nullVal;
    return val == true;
}
//数字负数则取0
function Nonnegative(v) {
    var num = parseInt(v);
    return num < 0 ? 0 : num
}
function NewJsGuid() {
    function S4() {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
}


//全 选开始
function checkAll(obj, tbId) {
    var bool = obj.checked;
    $("#" + tbId + " input[type='checkbox']").attr("checked", bool);
}

function BlankGoto(url) {
    var alinkId = "_aLinkBlank_";
    var $aLink = $("#" + alinkId);
    if ($aLink.length < 1) {
        $('<a id="' + alinkId + '" target="_blank" style="display:none">_aLinkBlank_</a>').prependTo($(document.body));
        $aLink = $("#" + alinkId);
    }
    $aLink.attr("href", url)[0].click();
}
//字符长度截取
function SetMaxLength(str, len) {
    return str != null ? (str.length <= len ? str : str.substr(0, len) + "..") : "";
}
function ExpandHeight(h) {
    var id = "#_ExpandHeightDiv_";
    if ($(id).length < 1) {
        $("<div id='_ExpandHeightDiv_' style='" + h + "px;'>&nbsp;</div>").appendTo($(document.body));
    }
    $(id).css("height", h);
    HeightChange();
}
function ResizeWith(objTop, objHeight, needHeight) {
    var bodyH = document.body.clientHeight;
    var hDev = (objTop + objHeight) - bodyH;
    if (hDev > 0) {
        ExpandHeight(needHeight);
    }
}
function FrameSubmit(key, submitData, url) {
    var formName = "_hidSubmitForm_" + key;
    var frameName = '_hidSubmitFrame_' + key;
    var hideForm = TryGetWithCreate("#" + formName, '<form src="about:blank"  id="' + formName + '" name="' + formName + '" style="display: none;" target="' + frameName + '" action="' + url + '"></form>');
    hideForm.html("");
    var fieldHtml = "";
    for (var k in submitData) {
        fieldHtml += "<input type='hidden' name='" + k + "' value='" + submitData[k] + "' />";
    }
    fieldHtml += '<iframe src="about:blank"  id="' + frameName + '" name="' + frameName + '" style="display: none;"></iframe>';
    hideForm.html(fieldHtml);
    alert(hideForm.getOuterHTML())
    //hideForm[0].submit();

}
function TryGetWithCreate(jKey, elStr) {
    var jObj = $(jKey);
    if (jObj.length < 1) {
        $(elStr).appendTo($(document.body));
        jObj = $(jKey);
    }
    return jObj;
}
function RunHeightChangeTimer() {
    setTimeout(function () { HeightChange(); }, 3000);
    setTimeout(function () { HeightChange(); }, 10000);
}

//加载模板
var Data = {};
function RenderTmpl(config) {
    $.ajax({
        url: config.Data.targetUrl,
        type: 'post',
        data: 'jsonStr='+JSON.stringify(config.Data.condition),
        dataType: 'json',
        async: config.Async || false,
        success: function (jsonResult) {
             if(jsonResult!=null){
                 Data.ResultList  = jsonResult.datas;
	       		 $(config.TmplTarget).html("");
	             $(config.TmplSource).tmpl().appendTo(config.TmplTarget);
	             if(config.AfterFn){
	             	config.AfterFn(jsonResult);
	             }
             }
        },
        error: function (err) {
             alert("网络繁忙！");
        }
    });
}

var branchbank = function (isClear) {
    var oBranchBank = $("#ddlBranchBank");
    var txtBranchBank = $("#selectbranck");
    if (isClear == undefined) {
        $("#ddltxtkeyword").val("请输入关键字搜索");
    }
    strhtml = "<option value=''>请选择</option>";
    txthtml = "";
    var branchbanklist;
    var isnull = false;
    var ClsCode = $.trim($("#ddlBankName option:selected").attr("value"));
    var BankName = $.trim($("#ddlBankName option:selected").text());
    var CityCode = $.trim($("#ddlcity option:selected").attr("id"));
    var ProvinceCode = $.trim($("#ddlprovince option:selected").attr("id"));
    var BranchName = $.trim($("#ddltxtkeyword").val());
    BranchName = BranchName == "请输入关键字搜索" ? "" : BranchName;
    if (ClsCode != "" && CityCode != "" && ProvinceCode != "" && $("#ddlcity").is(":visible")) {
        //$("#bankadd [type='submit']").val("加载中");
        $("#bankadd [type='submit']").attr("disabled", "disabled");
        $.AjaxWebService("Ajax/GetBranchBankInfoList", { Lname: BankName, CityCode: CityCode, BranchName: BranchName }, function (result) {
            if (result.IsSuccess) {
                branchbanklist = result.Data;
                $.each(branchbanklist, function (i, item) {
                    if (item.DrecCode != "313821050016") {
                        strhtml += "<option value='" + item.Lname + "' id='" + item.BankCode + "'>" + item.Lname + "</option>";
                        txthtml += "<a value='" + item.Lname + "' id='" + item.BankCode + "'>" + item.Lname + "</a>";
                        isnull = true;
                        //$("#ddlBranchBank").removeAttr("disabled", "disabled");
                    }
                });

                //$("#bankadd [type='submit']").val("确  认");
                $("#bankadd [type='submit']").removeAttr("disabled", "disabled");
            } else {
                alert(result.Message);
            }
        }, false, false);

    }
    if (isnull == false) {
        txthtml = "<span class='a-list-k'>无搜索结果</span>";
        //$("#ddlBranchBank").attr("disabled", "disabled");
        $("#txtBranchBank").val("");
        $("#txtBranchBank").focus();
        // return false;
    }
    //$("#ddlBranchBank").removeAttr("disabled", "disabled");
    oBranchBank.html(strhtml);
    txtBranchBank.html(txthtml);
}

//加载三级联动 省份和城市
function getprovince() {
    //定义省份和城市变量
    var provincelist;
    var citylist;
    //请求加载省份 和市
    $.AjaxWebService("Ajax/GetProvince", null, function (result) {
        if (result.IsSuccess) {
            provincelist = result.provincelist;
            citylist = result.citylist;
        } else {
            alert(result.Message);
        }
    }, false, false);

    var oProvince = $("#ddlprovince");
    var oCity = $("#ddlcity");
    var strhtml = "";
    //加载省
    var province = function () {
        strhtml = "<option value=''>请选择</option>";
        $.each(provincelist, function (i, item) {
            strhtml += "<option value='" + item.province + "' id='" + item.provinceID + "'>" + item.province + "</option>";
            oProvince.html(strhtml);
            //oProvince.css("width", item.province.length);
        });
    }
    //加载市

    var oldid = "";
    var city = function () {
        var selectprovince = $("#ddlprovince option:selected").attr("id");

        if (oldid == selectprovince) { return false; } else { oldid = selectprovince; }
        if (selectprovince != "") {
            oCity.hide();
        };
        strhtml = "<option value=''>请选择</option>";


        $.AjaxWebService("Ajax/GetCity", { id: selectprovince }, function (result) {
            if (result.IsSuccess) {
                oCity.html(result.Message);
                oCity.show();
                if (oCity.find("option").length < 2) { oCity.hide(); }
            } else {
                alert(result.Message);
            }
        }, false, false);


    }

    //选择省改变市
    oProvince.change(function () {
        clearInput();
        city();
        branchbank();

        //oBranchBank.html("<option value='请选择'>请选择</option>");
    });
    //加载支行
    oCity.change(function () {
        clearInput();
        branchbank();
    });
    $("#ddlBankName").change(function () {
        clearInput();
        branchbank();
    });
    //首先加载省份
    province();
    city();
}

function clearInput() {
    $("#txtinput").val("");
    $("#ddltxtkeyword").val("");
    $("#txtBranchBankName").empty();
    $("#txtBranchBankName").removeAttr("brdnbr");
    $("#selectbranck").empty();
}

$("#yjfk #btnFeedBack").bind("click", function () {

    var mobilereg = /^(((13[0-9]{1})|159|153|18[0-9]{1})+\d{8})$/;
    var emailreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    var feedback = {};
    feedback.Content = $.trim($("#yjfk #txtContent").val());
    //feedback.Mobile = $.trim($("#yjfk #txtTel").val());
    feedback.Email = $.trim($("#yjfk #txtEmail").val());
    //feedback.FeedBackCode = $.trim($("#yjfk #txtCode").val());
    if ($.trim(feedback.Content) == "" || $.trim(feedback.Content) == "请写下您的宝贵意见……") {
        alert("请填写意见！");
        return false;
    }
    //    if ($.trim(feedback.Mobile) == "") {
    //        alert("请填写手机号！");
    //        return false;
    //    }
    if ($.trim(feedback.Email) == "") {
        alert("请填写邮箱！");
        return false;
    }
    //    if ($.trim(feedback.FeedBackCode) == "") {
    //        alert("请填写验证码！");
    //        return false;
    //    }
    //    if (!mobilereg.test(feedback.Mobile)) {
    //        alert("手机格式错误！");
    //        return false;
    //    }
    if (!emailreg.test(feedback.Email)) {
        alert("邮箱格式错误！");
        return false;
    }
    $.ajax({
        url: 'Account/InserFeedBack',
        type: 'post',
        async: false,
        data: feedback,
        error: function (err) {
            alert("当前网络异常，请稍后再试(ajax error)：" + err);
            window.location.reload();
        },
        success: function (result) {
            if (result.IsSuccess) {
                $("#yjfk").hide();
                $("#yjfk #txtContent").val("");
                $("#yjfk #txtEmail").val("");

                var _top
                var parameters = "yjfk_suc||ui-window-1||500||300";
                var paraArr = []
                paraArr = parameters.split("||")
                $(".blackBg").show()
                $("#" + paraArr[0]).show()
                if ($.inArray("canDrag", paraArr) != -1) {
                    DrawNow($("#" + paraArr[0]).find(".prompt_inner"))
                }
                if ($.inArray("inIframe", paraArr) != -1) {
                    _top = $(this).offset().top - 80;
                } else {
                    _top = $(window).scrollTop();
                }
                if ($.inArray("absolute", paraArr) != -1) {
                    $("#" + paraArr[0]).css({ position: "absolute", top: _top + 80 })
                    $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], left: -paraArr[2] / 2 })
                } else {
                    $("#" + paraArr[0]).find(".prompt_inner").css({ width: paraArr[2], height: paraArr[3], top: -paraArr[3] / 2, left: -paraArr[2] / 2 })
                }
                $("#" + paraArr[0]).find(".prompt_inner").addClass(paraArr[1]);
                //IE6兼容
                if (! -[1, ] && !window.XMLHttpRequest) {
                    $("#" + paraArr[0]).css({ position: "absolute", top: _top + 380 })
                }

            } else {
                //$("#yjfk #plFail").show();
                alert(result.Message);
            }
        }
    });
});
function InitVilidateCode() {
    $("#yjfk #imgCode").attr("src", "account/getcheckcode@sessionname=feedbackcode&rd.jpg" + new Date());
}

function clearFeedBackInput() {
    $("#yjfk #txtContent").val("");
    $("#yjfk [type='text']").val("");
    InitVilidateCode();
    $('#lblsuccess').hide();
    $('#plMain').show();
}

//签署协议
$("#sayAfter").bind("click", function () {
    $.ajax({
        url: 'Ajax/SignPro',
        type: 'post',
        async: false,
        data: { type: 2 },
        error: function (err) {
            alert("当前网络异常，请稍后再试(ajax error)：" + err);
            window.location.reload();
        },
        success: function (result) {
            if (result != "success") {
                alert(result);
            }
            $("#plxyqd").hide();
            $(".blackBg").hide();
        }
    });
});

$("#agrPro").bind("click", function () {
    $.ajax({
        url: 'Ajax/SignPro',
        type: 'post',
        async: false,
        data: { type: 1 },
        error: function (err) {
            alert("当前网络异常，请稍后再试(ajax error)：" + err);
            window.location.reload();
        },
        success: function (result) {
            if (result != "success") {
                alert(result);
            }
            if ($("#hidIsAgree").length > 0) {
                $("#hidIsAgree").val("1");
            }
            $("#plxyqd").hide();
            $(".blackBg").hide();
        }
    });
});
/**
 * 将数值四舍五入(保留2位小数)后格式化成金额形式
 *
 * @param num 数值(Number或者String)
 * @return 金额格式的字符串,如'1,234,567.45'
 * @type String
 */
function formatCurrency(num) {
	if(num){
	    num = num.toString();
	    sign = (num == (num = Math.abs(num)));
	    num = Math.floor(num*100+0.50000000001);
	    cents = num%100;
	    num = Math.floor(num/100).toString();
	    if(cents<10)
	    cents = "0" + cents;
	    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
	    num = num.substring(0,num.length-(4*i+3))+','+
	    num.substring(num.length-(4*i+3));
	    return (((sign)?'':'-') + num + '.' + cents);
	}else{
		return 0;
	}
}
/**
 * 封装警告弹出框
 * msg：弹出框内容
 */
function warnMsg(msg,btnText,callback){
	var yesBtn = function(){
		if(callback){
			callback();
		}
	}
	easyDialog.open({
		container : {
			header : '提示信息',
			content :"<p class='tan_main'> <img src='../resources/images/icon_t.png'/>"+msg+"</p>",
			yesFn : yesBtn,
			noFn : false,
			yesText:btnText
		},
		fixed : false
	});
}
/**
 * 封装成功弹出框
 * msg：弹出框内容
 */
function successMsg(msg,btnText,callback){
	var yesBtn = function(){
		if(callback){
			callback();
		}
	}
	easyDialog.open({
		container : {
			header : '提示信息',
			content :"<p class='tan_main'> <img src='../resources/images/icon_o.png'/>"+msg+"</p>",
			yesFn : yesBtn,
			noFn : false,
			yesText:btnText
		},
		fixed : false
	});
}
/**
 * 封装确认弹出框
 * msg：弹出框内容
 */
function confirmMsg(msg,btnText,callback){
	var yesBtn = function(){
		if(callback){
			callback();
		}
	}
	easyDialog.open({
		container : {
			header : '提示信息',
			content :"<p class='tan_main'> <img src='../resources/images/icon_t.png'/>"+msg+"</p>",
			yesFn : yesBtn,
			noFn : true,
			yesText:btnText
		},
		fixed : false
	});
	$("div .easyDialog_footer").removeClass("easyDialog_footer").addClass("easyDialog_footer_new");//控制两个按钮的样式
}
/**
 * 封装成功弹出框
 * msg：弹出框内容
 */
function errorMsg(msg,btnText,callback){
	var yesBtn = function(){
		if(callback){
			callback();
		}
	}
	easyDialog.open({
		container : {
			header : '提示信息',
			content :"<p class='tan_main'> <img src='../resources/images/wrong.png'/>"+msg+"</p>",
			yesFn : yesBtn,
			noFn : false,
			yesText:btnText
		},
		fixed : false
	});
}

// js 身份证号码校验	
function isCnNewID(cid){  
    var arrExp = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];//加权因子  
    var arrValid = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2];//校验码  
    if(/^\d{17}\d|x$/i.test(cid)){    
       var sum = 0, idx;    
       for(var i = 0; i < cid.length - 1; i++){    
           // 对前17位数字与权值乘积求和    
           sum += parseInt(cid.substr(i, 1), 10) * arrExp[i];    
       } 
        // 计算模（固定算法）  
        idx = sum % 11;  
        // 检验第18为是否与校验码相等  
        return arrValid[idx] == cid.substr(17, 1).toUpperCase();  
    }else{  
        return false;  
    }
}
/**
 * 获取当前添加身份证号的出生年月
 * @param idCard
 * @return
 */
function getBirthdayFromIdCard (idCard) {  
    var birthday = "";  
    if(idCard.length == 15){  
        birthday = "19"+idCard.substr(6,6);  
    } else if(idCard.length == 18){  
        birthday = idCard.substr(6,8);  
    }  
    birthday = birthday.replace(/(.{4})(.{2})/,"$1-$2-");   
    return birthday;  
}

/**
 * 判断是否大于18岁
 * @param date
 * @return
 */
function checkAgeData(date){
	var arrDate = date.split("-");
	var jsNow= new Date();
	var jsDate = new Date(arrDate[0],arrDate[1]-1,arrDate[2]);
	nowYear= jsNow.getFullYear();    //获取完整的年份(4位,1970-????)
	nowMonth=jsNow.getMonth()+1;       //获取当前月份(0-11,0代表1月)
	nowDate=jsNow.getDate();        //获取当前日(1-31)
	
	jsYear=jsDate.getFullYear();
	jsMonth=jsDate.getMonth()+1;
	jsDate=jsDate.getDate();
	
	if(nowYear-jsYear<18){ //如果年份小于18，直接返回false
		return false;
	}else if(nowYear-jsYear==18){ //如果年份差等于18，则比较月份
		if(nowMonth<jsMonth){//年份等于18时，当前月份大于出生月份
			return false;
		}else if(nowMonth==jsMonth){//如果月份也相等，则比较日期
			if(nowDate<jsDate){ //年份等于18，月份相等时，如果当前日期小于出生日期，
				return false;
			}
		}
	}
	return true;
}

// 去除字符串前后的空格
function blankTrim(param) {
    if ((vRet = param) == '') { return vRet; }
    while (true) {
        if (vRet.indexOf (' ') == 0) {
            vRet = vRet.substring(1, parseInt(vRet.length));
        } else if ((parseInt(vRet.length) != 0) && (vRet.lastIndexOf (' ') == parseInt(vRet.length) - 1)) {
            vRet = vRet.substring(0, parseInt(vRet.length) - 1);
        } else {
            return vRet;
        }
    }
}

