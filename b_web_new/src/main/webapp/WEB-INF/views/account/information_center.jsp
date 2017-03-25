<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>p"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<TITLE>蒲公英金融服务平台——我的消息</TITLE>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<META content="text/html; charset=utf-8" http-equiv=Content-Type>
		<META name=keywords content=蒲公英金融服务平台,消息中心>
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css">
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/public.css" />
	    <script type="text/javascript" src="${resource_dir}/js/jquery-1.7.2.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/json2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	</HEAD>
<script  type="text/javascript">
	
	$(document).ready(function () {
           
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
		
		$("#ccp").html(FormatDigital($("#ccps").val()));
		$("#inc").html(FormatDigital($("#incs").val()));
           
	});
	
	
		
</script>	
	<BODY>
	<%@ include file="../header.jsp" %>	

		<DIV class=warp>
		    <DIV class=breadcrumb>
				<A href="${ctx}/item/index">首&nbsp;页</A>&nbsp;&gt;&nbsp;我的消息
			</DIV>
			<DIV class=container>
				<DIV class="mod-wrap mod-assets">
					<DIV class="mod-contnet my-center">
						<DIV class="ui-icon ui-user">
							<IMG name=头像 alt=头像 src="${resource_dir}/images/my_pic.png">
							<A href="javascript:void(0)"></A>
						</DIV>
						<div class="ui_left">
							<DIV class=user-info>
								<SPAN class=f-left><span id="newCurrentTime">欢迎您</span>，<span id="mobilePhon">${mobliePhon}</span></SPAN>
									<A id="phone"   class="ui-icon ui-mail-p<c:if test="${mobliePhon!=''}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"	 alt="已绑定手机"></A>
									<A id="idCard"  class="ui-icon ui-mobile<c:if test="${realName!=null}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="<c:if test="${realName!=null}">已</c:if><c:if test="${realName==null}">未</c:if>实名认证"></A>
 							</DIV>
							<DIV class=investment-time>
								<P class=clear>
									上次登录时间：${ordeDdate }
								</P>
							</DIV>
						</div>
						
						<div class="ui_right">
		                	<p>持有资产(元)<i></i></p>
		                    <h3 id="ccp"></h3>
		                    <input type="hidden" id="ccps" value="${capital }"/>
		                    <div class="ui_money">
		                    	<span>预估到期可获得收益：<em id="inc"></em>元</span>
		                    </div>
		                    <input type="hidden" id="incs" value="${income }"/>
						</div>
						
						
					</DIV>
				</DIV>
				<DIV class=ui-main>
					<DIV class=ui-plate-sidebar>
						<LINK rel=stylesheet type="text/css"	href="${resource_dir}/css/account.css">
 
						<!--侧栏菜单-->
						<UL class=sidebar-nav>
							<LI class=first-nav-item>
								<A href="javascript:void(0)">我的账户</A>
								<UL>
									<LI>
										<A href="${ctx}/account/myassets"><I class=nav-icon1></I>我的资产</A>
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
										<A class="current" href="${ctx}/account/informationCenter"><I class=nav-icon6></I>我的消息</A>
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
					</DIV>
				 <div class="ui-plate-main">
			        <h3 class="my-account-title"><span class="title">我的消息</span></h3>
			      
			        <table class="table_info"  cellpadding="0" cellspacing="0">
			          <c:forEach var="messContent" items="${messCont}">
			             <tr>
				            <td ><img alt="" src="${resource_dir}/images/icon_service.png" name="" height="65" width="65"></td>
				            <td ><p > ${messContent.creatDate } </p>
				              <p class="text-2"> ${messContent.contentFree}</p></td>
			            </tr>
			          </c:forEach>
			        </table>
			        
			         <c:if test="${messCont=='[]'}">
						<div class="can-not-find0" style="background:url(${resource_dir}/images/empty_box.jpg) no-repeat center; text-align:center; font-size:18px; line-height:24px; padding-top:200px;"><p>暂无消息</p></div>
                     </c:if>
			        
			      </div>
				  </div>
				</div>
			</div>
		<!--弹窗背景及解释Tips-->
		<div class=blackBg></div>
<P class=mouseTips><I></I></P>		
<%@ include file="../foot.jsp" %>
	</BODY>
</HTML>
