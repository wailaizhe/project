// JavaScript Document
$(function(){
/*banner开始*/
	var $key=0;
       var timer=setInterval(autoplay, 2000);  
       function autoplay(){
	       	$(".banner ul li").eq($key).fadeOut(600);  
	    	$key++;  
			$key=$key%$(".banner ul li").length;  
	    	$(".banner ul li").eq($key).fadeIn(600);   
	        $(".banner ol li").eq($key).addClass('current').siblings().removeClass('current');
       }
       $(".banner").hover(function() {
          clearInterval(timer);
          timer=null;   
       }, function() {
         clearInterval(timer);  
         timer=setInterval(autoplay, 2000);  
       });
      $(".banner ol li").click(function(event) {
      	$(".banner ul li").eq($key).fadeOut(600);  
      	$key=$(this).index();
      	$(this).addClass('current').siblings().removeClass("current");
      	$(".banner ul li").eq($key).fadeIn(600); 
        });
		 
})