var QT_Tip = {};
QT_Tip.MsgAlertCount = 0;
QT_Tip.MsgAlert = function (options) {
    QT_Tip.MsgAlertCount++;
    var curId = QT_Tip.MsgAlertCount;
    var win = $("#winOperateTip");
    var defaults = {
        title: "提醒您",
        message: "请设置提示信息",
        ico: "ok",
        okFn: function () { QT_Tip.MsgAlertClose(); },
        okTitle: "确定",
        cancelFn: null,
        cancelTitle: "取消",
        closeFn: function () { QT_Tip.MsgAlertClose(); },
        btnstmpl: "#tmpl_winOperateTip_btns_default",
        messageCss: "font_1",
        openBtn: null,
        autoClose: false,
        autoCloseTime: 3000,
        autoCloseFn: null
    };
    var config = null;

    if (IsString(options)) {
        defaults.message = options;
        config = defaults;
    } else {
        config = $.extend(defaults, options);
    }

    if (config.message.length > 18)
        config.messageCss = "";
    win.html($("#tmpl_winOperateTip").tmpl(config));
    $("#opwin_btns").html($(config.btnstmpl).tmpl(config));

    var btnOk = $("#opwin_btn_ok");
    var btnCancel = $("#opwin_btn_cancel");
    var btnClose = $("#opwin_btn_close");
    if (config.okFn) {
        btnOk.css("display", "");
        btnOk.die("click").live("click", function () { config.okFn(); });
    } else
        btnOk.css("display", "none");

    if (config.cancelFn) {
        btnCancel.css("display", "");
        btnCancel.die("click").live("click", function () { config.cancelFn(); });
    } else
        btnCancel.css("display", "none");

    if (config.closeFn)
        btnClose.die("click").live("click", function () { config.closeFn(); });

    if (config.autoClose == true && config.autoCloseTime >= 1000) {
        QT_Tip.IsAutoClose = true;
        if (config.autoCloseFn) {
            setTimeout(function () { if (curId == QT_Tip.MsgAlertCount) config.autoCloseFn(); }, config.autoCloseTime);
        } else {
            setTimeout(function () { if (curId == QT_Tip.MsgAlertCount) config.okFn(); }, config.autoCloseTime);
        }
    }
    QT_Tip.TryShowAlertInFrame(config.openBtn, win);
};
QT_Tip.MsgAlertClose = function () {
    var bg = $(".blackBg");
    var win = $("#winOperateTip");
    bg.hide();
    win.hide();
};
QT_Tip.TryShowAlertInFrame = function (btn, targetWin) {
    var html = '<div id="alertBlackBg"></div>';
    var alertBg = $(".blackBg");
    if (!alertBg.length) {
        $(html).appendTo($(document.body));
        alertBg = $(".blackBg");
    }
    if (window.IsInFrame) {
        targetWin.parent(".prompt_box").removeClass("prompt_box");
        var offset_top = 349;
        var offset_left = 500;
        if (btn) {
            offset_top = btn.offset().top - 200;
        }
        var w = targetWin.width();
        if (targetWin.width() > 100)
            offset_left = (980 - w) / 2;

        if (offset_top < 300)
            offset_top = 300;
        targetWin.css({
            left: offset_left,
            top: offset_top,
            display: "block"
        })

    }
    alertBg.show();
    //targetWin.css("z-index", 999999);
    targetWin.show();
    if (window.IsInFrame) {
        FocusTop(targetWin);
    }
};
QT_Tip.TryShowInFrame = function (btn, targetWin) {
    if (window.IsInFrame) {
        targetWin.parent(".prompt_box").removeClass("prompt_box");
        var offset_top = 349;
        var offset_left = 640;
        if (btn) {
            offset_top = btn.offset().top - 200;
        }
        var w = targetWin.width();
        if (w > 100)
            offset_left = (980 - w) / 2;
        if (offset_top < 100)
            offset_top = 100;
        targetWin.css({
            left: offset_left,
            top: offset_top,
            display: "block"
        });
    }
    $(".blackBg").show();
    targetWin.show();
    if (window.IsInFrame) {
        FocusTop(targetWin);
    }
    var txtCtl = targetWin.find("textarea");
    if (txtCtl.length > 0) {
        txtCtl.focus();
    }
};