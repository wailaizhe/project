// JavaScript Document
function shareto(id, s){
    var pic = "../content/images/1.jpg";
var url = "../";
var title=encodeURIComponent("【华润银行】资产交易平台");
var source=encodeURIComponent(document.title);
var content=encodeURIComponent("我今天看到了华润银行的票据投资项目，预期年化利率6到8个点，比同行产品收益增加40个百分点，而且门槛低周期短，我很有冲动购买，求大家帮忙分析分析！");

var _gaq = _gaq || [];
if (s != null && s != "") {
    content = encodeURIComponent(s);
}

if(id=="fav"){
addBookmark(document.title);
return;
}else if(id=="qzone"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'QZone', 1]);
window.open('../../sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey@url='+url+'&title='+title+'&pics='+pic+'&summary='+content,"_blank","width=615,height=505");
return;
}else if(id=="sina"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'SinaT', 1]);
//window.open('../../v.t.sina.com.cn/share/share.php@title='+title+'&url='+url+'&source=bookmark','_blank');
window.open("../../service.weibo.com/share/share.php@url="+url+"&appkey=610475664&title="+content+"&pic="+pic,"_blank","width=615,height=505");
return;
}else if(id=="baidu"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'Baidu', 1]);
window.open('../../cang.baidu.com/do/add@it='+title+'&iu='+url+'&fr=ien#nw=1','_blank','scrollbars=no,width=600,height=450,left=75,top=20,status=no,resizable=yes');
return;
}else if(id=="googlebuzz"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'GoogleBuzz', 1]);
window.open('../../www.google.com/buzz/post@url='+url+'&imageurl='+pic,'_blank');
return;
}else if(id=="douban"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'Douban', 1]);
window.open("../../www.douban.com/share/service@image="+pic+"&href="+url+"&name="+title+'&text='+content,"_blank","width=615,height=505");
return;
}else if(id=="renren"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'RenRen', 1]);
window.open('../../widget.renren.com/dialog/share@resourceurl='+url+'&srcUrl='+url+'&title='+title+'&pic='+pic+'&description='+content,"_blank","width=615,height=505");
return;
}else if(id=="xianguo"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'XianGuo', 1]);
window.open('../../xianguo.com/service/submitdigg/@link='+url+'&title='+title,'_blank');
return;
}else if(id=="mail"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'Mail', 1]);
window.open('mailto:?subject='+title+'&body='+encodeURIComponent('这是我看到了一篇很不错的文章，分享给你看看！\r\n\r\n')+title+encodeURIComponent('\r\n')+url);
return;
}else if(id=="qq"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'QQ', 1]);
window.open("../../v.t.qq.com/share/share.php@c=share&a=index&title="+content+"&appkey=5153746&url="+url+"&pic="+pic,"_blank","width=615,height=505");
return;
}else if(id=="163"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', '163', 1]);
window.open("../../t.163.com/article/user/checklogin.do@source="+source+"&info="+content+"&images="+pic,"_blank","width=615,height=500");
return;
}
else if(id=="tianya"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'tianya', 1]);
window.open("../../open.tianya.cn/widget/send_for.php@action=send-html&shareto=2&url="+url+"&title="+content+"&relateTYUserName="+content+"&picUrl="+pic,"_blank","width=615,height=550");
return;
}
else if(id=="ifeng"){
_gaq.push(['_trackEvent', 'SocialShare', 'Share', 'ifeng', 1]);
window.open("../../t.ifeng.com/interface.php@_c=share&_a=share&sourceurl="+source+"&title="+content+"&pic="+pic,"_blank","width=615,height=505");
return;
}
}

function ShareButtons(s) {
    document.write('<li><a class="sharebutton fx_2" id="share_sina" href="javascript:shareto(\'sina\', \'' + s + '\');" title="分享到新浪微博"></a></li>');
    document.write('<li><a class="sharebutton fx_9" id="share_qq" href="javascript:shareto(\'qq\', \'' + s + '\');" title="分享到腾讯微博"></a></li>');
    document.write('<li><a class="sharebutton fx_4" id="share_douban" href="javascript:shareto(\'douban\', \'' + s + '\');" title="分享到豆瓣"></a></li>');
    document.write('<li><a class="sharebutton fx_1" id="share_qzone" href="javascript:shareto(\'qzone\', \'' + s + '\');" title="分享到QQ空间"></a></li>');
    document.write('<li><a class="sharebutton fx_3" id="share_renren" href="javascript:shareto(\'renren\', \'' + s + '\');" title="分享到人人网"></a></li>');

    //document.write('<li><a class="sharebutton fx_5" id="share_googlebuzz" href="javascript:shareto(\'googlebuzz\', \''+ s +'\');" title="分享到 Google"></a></li>');
    //document.write('<li><a class="sharebutton fx_6" id="share_baidu" href="javascript:shareto(\'baidu\', \''+ s +'\');" title="收藏到 - 百度搜藏"></a></li>');
    //document.write('<li><a class="sharebutton fx_7" id="share_xianguo" href="javascript:shareto(\'xianguo\', \''+ s +'\');" title="分享到鲜果网"></a></li>');
    //document.write('<li><a class="sharebutton fx_8" id="share_mail" href="javascript:shareto(\'mail\', \''+ s +'\');" title="发送邮件分享给朋友"></a></li>');

    //document.write('<li><a class="sharebutton fx_10" id="share_163" href="javascript:shareto(\'163\', \''+ s +'\');" title="分享到网易微博"></a></li>');

    //document.write('<li><a class="sharebutton fx_11" id="share_mail" href="javascript:shareto(\'tianya\', \''+ s +'\');" title="分享到天涯社区"></a></li>');
    //document.write('<li><a class="sharebutton fx_12" id="share_mail" href="javascript:shareto(\'ifeng\', \''+ s +'\');" title="分享到凤凰微博"></a></li>');
}
