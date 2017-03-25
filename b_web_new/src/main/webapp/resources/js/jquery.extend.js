
///该文件定义了一些jQuery扩展

/// Created By  daniel
/// <reference path="jquery-1.4.1.min.js" />
///	<summary>
///    jQuery原型扩展，重新封装Ajax请求WebServeice
///	</summary>
///	<param name="url" type="String">
///     处理请求的地址
///</param>
///	<param name="dataMap" type="String">
///     参数，json格式的字符串
///</param>
///	<param name="fnSuccess" type="function">
///     请求成功后的回调函数
///</param>
//有滚动条
$.AjaxWebService = function (url, dataMap, fnSuccess, isjsontype, isasync) {//异步
    var _isasync = isasync == null || isasync == undefined ? true : isasync; //application/x-www-form-urlencoded  application/json; charset=utf-8
    var _contenttype = isjsontype == true ? "application/json; charset=utf-8" : "application/x-www-form-urlencoded";
    $.ajax({
        beforeSend: function () {
            //调用前要执行的方法
        },
        type: "POST",
        cache: true,
        //contentType: "application/json; charset=utf-8",
        contentType: _contenttype,
        url: url,
        data: dataMap,
        async: _isasync,
        dataType: "json",
        complete: function () {
            //完成要执行的方法
        },
        error: function (e) {
            //调用错误要执行的方法
        },
        success: function (result) {
            if (result.IsSuccess) {
                setTimeout("$('.publiclblmsg').hide();", 3000);
            }
            //调用成功要执行的方法
            fnSuccess(result);
        }
    });

}



//cookie存值
jQuery.cookie = function (key, value, options) {
    // key and value given, set cookie...
    if (arguments.length > 1 && (value === null || typeof value !== "object")) {
        options = jQuery.extend({}, options);
        if (value === null) {
            options.expires = -1;
        }
        if (typeof options.expires === 'number') {
            var days = options.expires, t = options.expires = new Date();
            t.setDate(t.getDate() + days);
        }
        return (document.cookie = [
encodeURIComponent(key), '=',
options.raw ? String(value) : encodeURIComponent(String(value)),
options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
options.path ? '; path=' + options.path : '',
options.domain ? '; domain=' + options.domain : '',
options.secure ? '; secure' : ''
].join(''));
    }
    // key and possibly options given, get cookie...
    options = value || {};
    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
};




