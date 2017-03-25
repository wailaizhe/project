//标签切换
$(".tap-label li").live("click", function () {
    $(this).siblings("li").removeClass("current");
    $(this).addClass("current");
    $(this).closest(".tap-label").siblings(".labelContent").hide();
    $(this).closest(".tap-label").siblings(".labelContent").eq($(this).attr("value") - 1).show();
});
//浮动客服
function InitFloatTips() {
    var tips = document.getElementById('divQQbox');
    //$(tips).show();
    var theTop = 160/*这是默认高度,越大越往下*/;
    var old = theTop;
    var timerID;
    var thisNum = 0;
    var nextNum;
    var bigNum = $(".num ul").children().length - 1;
    var tt = 50;
    if (window.innerHeight) {
        pos = window.pageYOffset
    } else if (document.documentElement && document.documentElement.scrollTop) {
        pos = document.documentElement.scrollTop
    } else if (document.body) {
        pos = document.body.scrollTop;
    }
    pos = pos - tips.offsetTop + theTop;
    pos = tips.offsetTop + pos / 10;
    if (pos < theTop) pos = theTop;
    if (pos != old) {
        tips.style.top = pos + "px";
        tt = 10;
    }
    old = pos;
    setTimeout(InitFloatTips, tt);
    //InitFloatTips();
}

//鼠标拖拽元素
function DrawNow(val) {
    var $div = val;
    /* 绑定鼠标左键按住事件 */
    $div.bind("mousedown", function (event) {
        /* 获取需要拖动节点的坐标 */
        var offset_x = $(this)[0].offsetLeft; //x坐标
        var offset_y = $(this)[0].offsetTop; //y坐标
        /* 获取当前鼠标的坐标 */
        var mouse_x = event.pageX;
        var mouse_y = event.pageY;

        /* 绑定拖动事件 */
        /* 由于拖动时，可能鼠标会移出元素，所以应该使用全局（document）元素 */
        $(document).bind("mousemove", function (ev) {
            /* 计算鼠标移动了的位置 */
            var _x = ev.pageX - mouse_x;
            var _y = ev.pageY - mouse_y;

            /* 设置移动后的元素坐标 */
            var now_x = (offset_x + _x) + "px";
            var now_y = (offset_y + _y) + "px";
            /* 改变目标元素的位置 */
            $div.css({
                top: now_y,
                left: now_x
            });
        });
    });
    /* 当鼠标左键松开，接触事件绑定 */
    $(document).bind("mouseup", function () {
        $(this).unbind("mousemove");
    });
}

//弹窗
$("[open_win]").live("click", function () {
    var _top
    var parameters = $(this).attr("open_win");
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

})

//右上角关闭按钮
$("[close-ui]").live("click", function () {
    $("#" + $(this).attr("close-ui")).hide();
    $(".blackBg").hide();
    $(".jieshi-2").live("mousemove", function (e) {
        var postX = e.pageX;
        var postY = e.pageY;
        var myText = $(this).attr("alt");
        $(".jianjie-2").css({ "left": postX - 10, "top": postY + 20, "display": "block" })
        $(".jianjie-2").html(myText + "<i></i>");

    })

});

//右上角关闭按钮
$("[float-close-ui]").live("click", function () {
    $.cookie('closecustom', '1', { expires: 1, path: 'default.htm', secure: false });
    $("#" + $(this).attr("float-close-ui")).hide();
    $(".blackBg").hide();
});
////解释标签
//$("[jieshi]").live("mouseover", function (e) {
//    var postX = e.pageX;
//    var postY = e.pageY;
//    var myText = $(this).attr("alt");
//    var p = $(this).attr("jieshi"),
//        px = parseInt(p.split(',')[0]) || 0,
//        py = parseInt(p.split(',')[1]) || 0;
//    $(".mouseTips").html(myText + "<i></i>");
//    $(".mouseTips").css({ "left": postX + px, "top": postY + py }).show();
//})
//$("[jieshi]").live("mouseout", function () {
//    $(".mouseTips").hide();
//});
//首页列表背景色切换
$(".project-list li").live("mouseover", function () {
    $(this).addClass("current")
});
$(".project-list li").live("mouseout", function () {
    $(this).removeClass("current")
});
//列表页行背景色切换
$(".project-item").live("mouseover", function () {
    $(this).addClass("current")
});
$(".project-item").live("mouseout", function () {
    $(this).removeClass("current")
});