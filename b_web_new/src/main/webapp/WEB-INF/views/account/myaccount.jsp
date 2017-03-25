<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<TITLE>蒲公英金融服务平台——我的账户</TITLE>
    <link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/public.css" />
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />

 
<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	

<BODY class=gray-bg>
<SCRIPT type=text/javascript>
    
    $(function () {
         $(".jieshi").mousemove(function (e) {
			var postX = e.pageX;
			var postY = e.pageY;
			var myText = $(this).attr("alt");
			$(".mouseTips").css({ "left": postX - 10, "top": postY - 40, "display": "block" })
			$(".mouseTips").html(myText + "<i></i>");
		})
		$(".jieshi").mouseout(function () {
			var myText = $(this).attr("alt");
			$(".mouseTips").hide()
			$(".mouseTips").html(myText + "<i></i>");
		})
    })
</SCRIPT>
				
<SCRIPT type=text/javascript>
    jQuery(document).ready(function () {
        //解释标签
        $(".jieshi").mousemove(function (e) {
            var postX = e.pageX;
            var postY = e.pageY;
            var myText = $(this).attr("alt");
            $(".mouseTips").css({ "left": postX - 10, "top": postY - 40, "display": "block" })
            $(".mouseTips").html(myText + "<i></i>");
        })
        $(".jieshi").mouseout(function () {
            var myText = $(this).attr("alt");
            $(".mouseTips").hide()
            $(".mouseTips").html(myText + "<i></i>");
        })
    });  
</SCRIPT>
<%@ include file="../header.jsp" %>	
		<DIV class=breadcrumb>
			<A href="${ctx}/item/index">首&nbsp;页</A>&nbsp;&gt;&nbsp;我的账户
		</DIV>
		<DIV class=warp>
			<DIV class=container>
				<DIV class="mod-wrap mod-assets">
					<DIV class="mod-contnet my-center">
						<DIV class="ui-icon ui-user">
							<IMG name=头像 alt=头像 src="${resource_dir}/images/my_pic.png"/>
							<A href="javascript:void(0)"></A>
						</DIV>
						<DIV class=user-info>
							<SPAN class=f-left><span id="newCurrentTime">欢迎您</span>，<span id="mobilePhone">${mobliePhon}</span></SPAN>
								<A id="phone"   class="ui-icon ui-mail-p<c:if test="${mobliePhon!=''}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"	 alt="已绑定手机"></A>
								<A id="idCard"  class="ui-icon ui-mobile<c:if test="${realName!=null}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="<c:if test="${realName!=null}">已</c:if><c:if test="${realName==null}">未</c:if>实名认证"></A>
								<A id="mail"    class="ui-icon ui-lock<c:if test="${email!=null}">-ok</c:if> jieshi"	    href="${ctx}/account/personInfo"  alt="<c:if test="${email!=null}">已</c:if><c:if test="${email==null}">未</c:if>绑定邮箱"></A>
						</DIV>
						<DIV class=investment-time>
							<P class=clear>
								上次投资时间：${ordeDdate}
							</P>
						</DIV>
					</DIV>
				</DIV>
				<DIV class=ui-main>
					<DIV class=ui-plate-sidebar>
		<!--侧栏菜单-->
						<UL class=sidebar-nav>
							<LI class=first-nav-item>
								<A href="javascript:void(0)">我的账户</A>
								<UL>
									<LI>
										<A class="current" href="${ctx}/account/queryProfit"><I class=nav-icon1></I>账户总览</A>
									</LI>
									<LI>
										<A href="${ctx}/account/investment_newList"><I class=nav-icon2></I>投资记录</A>
									</LI>
									<LI>
										<A href="${ctx}/account/mybankcard"><I class=nav-icon3></I>我的银行卡</A>
									</LI>
									<LI>
										<A  href="${ctx}/account/personInfo"><I class=nav-icon4></I>个人信息</A>
									</LI>
									<LI>
										<A  href="${ctx}/account/informationCenter"><I class=nav-icon6></I>消息中心</A>
									</LI>
									<li>
										<A  href="${ctx}/account/toMyInvited"><I class=nav-icon7></I>我的推荐</A>
									</li>
									<li>
										<A   href="${ctx}/account/toMyGold"><I class=nav-icon8></I>我的金币</A>
									</li>
								</UL>
							</LI>
						</UL>
						<!--侧栏菜单结束-->
						<INPUT id=tabIndexHidden type=hidden value=1/>
					</DIV>
					<DIV class=ui-plate-main>
						<UL class=investment-money>
							<LI>
								<SPAN>
								  <c:if test="${noMap.principal==null}"><B>0.00</B></c:if>
								  <c:if test="${noMap.principal!=null}"><B>${noMap.principal}</B></c:if>
								</SPAN>
								<P>
									已回收本金(元)
								</P>
							</LI>
							<LI>
								<SPAN>
								  <c:if test="${noMap.Profit==null}"><B>0.00</B></c:if>
								  <c:if test="${noMap.Profit!=null}"><B>${noMap.Profit}</B></c:if>
								</SPAN>
								<P>
									已实现收益(元)
								</P>
							</LI>
							<LI>
								<SPAN>
								  <c:if test="${noMap.unPrincipal==null}"><B>0.00</B></c:if>
								  <c:if test="${noMap.unPrincipal!=null}"><B>${noMap.unPrincipal}</B></c:if>
								</SPAN>
								<P>
									待回收本金(元)
								</P>
							</LI>
							<LI style="BORDER-RIGHT-STYLE: none">
								<SPAN>
								  <c:if test="${noMap.unProfit==null}"><B>0.00</B></c:if>
								  <c:if test="${noMap.unProfit!=null}"><B>${noMap.unProfit}</B></c:if>
								
								</SPAN>
								<P>
									预期收益总额(元)
								</P>
							</LI>
						</UL>
						<DIV class=number-form>
							<P>
								您的投资收益累计
								<c:if test="${noMap.principalCount==null}"><B>0.00</B></c:if>
								<c:if test="${noMap.principalCount!=null}"><B>${noMap.principalCount}</B></c:if>
								元
							</P>
							
						</DIV>
					</DIV>
				</DIV>
			</DIV>
		</DIV>

<P class=mouseTips><I></I></P>
	  <%@ include file="../foot.jsp" %>
	</BODY>
</HTML>


