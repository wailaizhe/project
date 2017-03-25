(function($){
	$.fn.tab = function(options){
		var defaults = {
				trigger:"mouseenter", //触发事件，mouseenter | click
				navId:".tab-nav",  //tab的ID
				selCss:"act", //选中时的css
				conId:".tab-list-wrap", //内容id的包围
		}
		var options = $.extend(defaults, options);
		this.each(function(){
				var tab = $(this);
				//绑定事件
				tab.find(options.navId).children().eq(0).addClass(options.selCss); //触发第一项
				tab.find(options.conId).children().eq(0).show();  //显示第一个内容
				tab.find(options.navId).children().bind(options.trigger, function(){
					$(this).addClass(options.selCss).siblings().removeClass(options.selCss);
					var index = $(this).index();
					tab.find(options.conId).children().eq(index).show().siblings().hide();
				});
		});
	};
})(jQuery);