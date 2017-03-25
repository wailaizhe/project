<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WebContent/common/taglib.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<TITLE>我的好友</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type />
		<META name=keywords content="联鑫互联资产交易平台,账户中心,会员中心" />
		<META name=description	content="润银行资产交易平台账户中心,专属您的投融资专家,指引有投融资需求的用户注册登录联鑫互联资产交易平台会员中心。" />
		<META name=360-site-verification content="3b4bd975750affd00ad5fca65fad0df3" />

		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
		<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/login.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/public.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/style.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/index.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/main.css" />
		<link rel="stylesheet" type="text/css"	href="${resource_dir}/css/public.css" />
        <script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
		<script type="text/javascript" src="${resource_dir}/js/json2.min.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/ucsvalidate.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/fn_qiantu.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/easing.js"></script>
		<script type="text/javascript" src="${resource_dir}/js/operatetip.js"></script>
 
<script  type="text/javascript">
    // 初始化 页面JS    非开发人员勿动 
function SearchFriendByInputName(){ 

         // alert("224");
         var size=$("#size").val();
         if("0"==size){
             $("#friendsListDiv22").html('<div class="can-not-find can-not-find-1"><p>您目前还没有好友${resource_dir}.</p></div>');
         }
         
         var mobilePhone = $("#UserNameSearchInput").val();
	     $.ajax({
		        url: '${ctx}/account/sachFriden?mobilePhone=${mobilePhone}&lk='+mobilePhone,
		        success: function(data) {
		            // alert(data[0].id);
		             var ii="";
		             if(data!=""&&data!=null){
		              for(var i=0;i<data.length;i++){
		               ii+="<div class=friends-box><img class=user src=${resource_dir}/images/untitled.png><p><b>"+data[i].mobile_phone+"</b>上次投资时间：无</p><br><p>投资总笔数：  ︳本月投资笔数：";
					   ii+="</p><input class='openWindow' type='button' value='发送项目邀请' action-data='projectInvitationDIV||ui-window-1||730||470'>";
					   ii+="<a class='icon-delete' title='移除好友' href='javascript:void(0)' onclick=delFrent('"+data[i].id+"')></a></a></div>";
		              }
		              document.getElementById("friendsListDiv22").innerHTML =ii; 
		            }else{
		              $("#friendsListDiv22").html('<div class="can-not-find can-not-find-1"><p>抱歉，没有搜索到相关好友。</p></div>');
		            }
		        }
		    });
}

function delFrent(arg){
   	     $.ajax({
	        url: '${ctx}/account/delFriden?IDCord='+arg,
	        success: function(data) {
	           alert("删除成功！");
	           window.location.href = '${ctx}/account/myFriend?mobilePhone=${mobilePhone}';
	        }
		  });
}


function selectFriend(){
    var  state = $("#queryFriend").val();
     $.ajax({
        url: '${ctx}/account/sachFriden?mobilePhone=${mobilePhone}&lk='+mobilePhone+'&state='+state,
        success: function(data) {
            // alert(data[0].id);
             var ii="";
             if(data!=""&&data!=null){
              for(var i=0;i<data.length;i++){
                 
               ii+="<div class=friends-box><img class=user src=${resource_dir}/images/untitled.png><p><b>"+data[i].mobile_phone+"</b>上次投资时间：无</p><br><p>投资总笔数：  ︳本月投资笔数：";
			   ii+="</p><input class='openWindow' type='button' value='发送项目邀请' action-data='projectInvitationDIV||ui-window-1||730||470'>";
			   ii+="<a class='icon-delete'  href='javascript:void(0)' onclick=delFrent('"+data[i].id+"')></a></a></div>";
			   
              }
              document.getElementById("friendsListDiv22").innerHTML =ii; 
            }else{
              $("#friendsListDiv22").html('<div class="can-not-find can-not-find-1"><p>抱歉，没有搜索到相关好友。</p></div>');
            }
        }
	});
}


$(document).ready(function () {
	 GoSearch(false, 1);
});

function selectProfitList(){
    GoSearch(false, 1);
}
function GoSearch(flag, pi) {
    var submitData = {};
    submitData.targetUrl = "${ctx}/account/investment_Data";
    //查询条件 开始
    submitData.condition={};
    submitData.condition.PageIndex = pi; //控制第几页
    submitData.condition.PageSize = 3;   //控制每页显示条数
    
    submitData.condition.state = $("#queryProfitList").val();
    submitData.condition.startDate = $("#d4311").val();    
    submitData.condition.endDate = $("#d4312").val();    
   
    //查询条件 结束
    RenderTmpl({
            Data: submitData,
            TmplSource: "#tmpl_projectList",    // 需要显示的模板列表
            TmplTarget: "#projectList_search",  // 需要显示的分页控件
            AfterFn:function (result) {
                
                if (result.totalCount < 1) {
                    $("#projectList_search").html('<div class="no-content"><p>您暂无投标项目！</p></div>');
                    $("#pagerHolder").html("");
                    $(".table_head").hide();
                }else if(result.totalCount < submitData.condition.PageSize) {
                    $("#pagerHolder").html("");
                    $(".table_head").show();
                }else{
                    $("#pagerHolder").html(GetPagerHtmlSpan({
                        index: submitData.condition.PageIndex,
                        size:  submitData.condition.PageSize,
                        total: result.totalCount,
                        fnName: "GoSearch"
                    }));
                    $(".table_head").show();
                 }
                
            }
        });
}






</script>		  




		
<BODY class=gray-bg>
<%@ include file="../header.jsp" %>	
		<DIV class=breadcrumb>
			<A href="http://e.crbank.com.cn/">首&nbsp;页</A>&nbsp;&gt;&nbsp;我的好友
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
							<SPAN class=f-left>下午好，<span id="mobilePhone1">${mobilePhon}</span></SPAN>
							<A class="ui-icon ui-mail-p-ok jieshi"
								href="http://e.crbank.com.cn/Center/Info_IndividualUser"
								alt="已绑定手机"></A><A class="ui-icon ui-mobile jieshi"
								href="http://e.crbank.com.cn/Center/Info_IndividualUser"
								alt="未实名认证"></A><A class="ui-icon ui-lock jieshi"
								href="http://e.crbank.com.cn/Center/Info_IndividualUser"
								alt="邮箱待激活"></A><A class="ui-icon ui-bindingbank jieshi"
								href="http://e.crbank.com.cn/Center/MyBankAccount_IndividualUser"
								alt="未绑定银行卡"></A>
						</DIV>
						<DIV class=investment-time>
							<P class=clear>
								上次投资时间：${ordeDdate}
							</P>
						</DIV>
					</DIV>
				</DIV>
				<INPUT id=BankAccountN_Hidden type=hidden value=0 />
				
				<DIV class=ui-main>
					<DIV class=ui-plate-sidebar>

						<!--侧栏菜单-->
						<UL class=sidebar-nav>
							<LI class=first-nav-item>
								<A href="javascript:void(0)">我的账户</A>
								<UL>
									<LI>
										<A href="${ctx}/account/queryProfit"><I class=nav-icon1></I>账户总览</A>
									</LI>
									<LI>
										<A href="${ctx}/account/investment_list"><I class=nav-icon2></I>投资记录</A>
									</LI>
									<LI>
										<A href="${ctx}/account/mybankcard"><I class=nav-icon3></I>我的银行卡</A>
									</LI>
									<LI>
										<A  href="${ctx}/account/personInfo"><I class=nav-icon4></I>个人信息</A>
									</LI>
									<LI>
										<A class="current" href="${ctx}/account/myFridenList"><I class=nav-icon5></I>我的好友</A>
									</LI>
									<LI>
										<A   href="${ctx}/account/informationCenter"><I class=nav-icon6></I>消息中心</A>
									</LI>
								</UL>
							</LI>
						</UL>
						<!--侧栏菜单结束-->
						<INPUT id=tabIndexHidden type=hidden value=5/>
					</DIV>
					<DIV class=ui-plate-main>
						<DIV class=mod-contnet>
							<DIV class=my-account-title>
								<SPAN>我的好友邀请码</SPAN>
								<STRONG id="mobilePhone">${baseInfo[0].inviteCode}</STRONG>
								<DIV class=f-right>
									<A href="http://e.crbank.com.cn/HelpCenter/QuestionList17">了解更多</A>
								</DIV>
							</DIV>
							<DIV class=step_friends>
								<img src="${resource_dir}/images/step_friends.png" title="" alt="">
							</DIV>
							<DIV class=my-account-title>
								<SPAN>已有<B class=red >${size}</B>位好友</SPAN>
							</DIV>
							<DIV class=project-date>
									<select onChange="selectFriend();" id="queryFriend" style="height:27px;margin-top:9px;color:#999;font-size:14px;width:200px;border-color:#CCC">
										<option value="">所有好友</option>
										<option value="numbe">按投资笔数排序</option>
										<option value="startDate">按成为好友时间排序</option>
										<option value="Launch">按最近发起项目排序</option>
									</select>
									<DIV class="friends-search f-right mynewfriend_search">
									  <INPUT id=UserNameSearchInput size=25 	value=输入好友会员名查找>
									  <A onclick=SearchFriendByInputName() href="javascript:void(0)"><img src="${resource_dir}/images/fangdajing.png" style="margin-top:2px"></A>
									</DIV>
							</DIV>
							
							<DIV id="friendsListDiv22">
							    <c:forEach var="baseIn" items="${baseInfo}"> 
								<div class="friends-box">
								 
									<img title="" class="user" alt="" src="${resource_dir}/images/untitled.png">         
									<p>
									 <b>${baseIn.mobilePhone}</b>上次投资时间：无</p><br><p>投资总笔数：  ︳本月投资笔数：
									</p>        
									<input class="openWindow" type="button" value="发送项目邀请" action-data="projectInvitationDIV||ui-window-1||730||470">
								      <a class="icon-delete" title="移除好友" href="javascript:void(0)" onclick="delFrent('${baseIn.id}')"></a>
								</div>
								 </c:forEach>
							</DIV>
							
							
							<DIV class=friends-con>
								
							</DIV>
							<!--分页-->
							<DIV id=pagerHolder class=mod-page></DIV>
							<!--分页结束-->
						</DIV>
					</DIV>
				</DIV>
			</DIV>
		</DIV>
		<!--弹窗背景及解释Tips-->
		<DIV class=blackBg></DIV>
		<P class=mouseTips>
			<I></I>
		</P>
		<INPUT id=orderByInput_hidden type="hidden"/>
		<INPUT id=FriendID_hidden type="hidden"/>
		<INPUT id=FriendName_hidden type="hidden"/>
		<INPUT id=UserID_hidden type="hidden"	value=414bdeed-5972-4054-97ff-88b82728c783/>
		<INPUT id="size" type="hidden" value="${size}"/>
<%@ include file="../foot.jsp" %>
	</BODY>
</HTML>
