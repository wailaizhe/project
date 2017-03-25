﻿<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WebContent/common/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html public "-//w3c//dtd html 4.01 transitional//en" "http://www.w3.org/tr/html4/loose.dtd">
<HTML>
	<HEAD>
		<TITLE>蒲公英金融服务平台——投资记录</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/header_footer.css" />
    <link rel=stylesheet type=text/css	 href="${resource_dir}/css/public.css">
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/account.css" />
	<link rel="stylesheet" type="text/css" href="${resource_dir}/css/jc_easydialog.css"/>
	<script type="text/javascript" src="${resource_dir}/js/jquery-1.8.0.min.js"></script>	
	<script type="text/javascript" src="${resource_dir}/js/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/common.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/json2.js"></script>
	<script type="text/javascript" src="${resource_dir}/js/easydialog.min.js"></script>
</head>
<script type="text/javascript">
 $(document).ready(function () {
 		getStatus();
	 var startdate=new Date().getHours();
     var startMin=new Date().getMinutes();
        if(startdate>=12&&startdate<19&&startMin>=0){
	    $("#newCurrentTime").html("下午好");               
        }else if(startdate>6&&startdate<12&&startMin>=0){
            $("#newCurrentTime").html("上午好");
        }else{
            $("#newCurrentTime").html("晚上好");
        }
        
        
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
	 
	 $("#orMoney").html(FormatDigital($("#orMoney1").val())+" 元");
	 $("#orCapital").html(FormatDigital($("#orCapital1").val()));
	 var dedu = $("#dedu").val();
	 $("#deductionFee").html(FormatDigital(dedu/10));
	 $('#demoBtn1').click(function(){
        var chks = $('#tan').html();
        easyDialog.open({
            container : {
                header : ' ',
                content :chks,
            },
            fixed : false
        });
    });
    
    $('#demoBtn2').click(function(){
        var chks = $('#xieyi2').html();
        easyDialog.open({
            container : {
                header : ' ',
                content :chks,
            },
            fixed : false
        });
    });
	 
});

	function getStatus()
	{
		var status=$("#pay_status").val();
		var newDate = document.getElementById("newDate").value; 
		var createDate= document.getElementById("createDate").value// 系统时间
     	var createTime= new Date(Date.parse(createDate.replace(/-/g,   "/")));//订单创建时间
		var nowTime= new Date(Date.parse(newDate.replace(/-/g,   "/")));//当前服务器时间
        var t =nowTime.getTime() - createTime.getTime();//得到毫秒数
        var obj=$("#emBox");
		if(status=='02'){
	        if(Math.floor(t)>=Math.floor(2*1000*60*60)){//订单创建超过2个小时
	        	obj.html("未支付");
	        }else{//订单未超过2个小时
	        	obj.html("待系统确认");
	        }
        }else if(status=='01'){
         	if(Math.floor(t)>=Math.floor(1000*60*30)){//订单创建超过30分钟
	        	obj.html("交易成功");
	        }else{//订单未超过30分钟
	        	obj.html("支付成功，交易确认中");
	        }
        }else if(status=='06'){
        	var endDateTime=$("#endDateTime").val();//项目结束时间
        	endDateTime= new Date(Date.parse(endDateTime.replace(/-/g,   "/")));//项目结束时间
        	var t =nowTime.getTime() - endDateTime.getTime();//得到毫秒数	
        	var ed2=Math.ceil(t/1000/60/60/24-3);
		    if(ed2>0){
	          obj.html("<em style='font-size:16px;'>已成功兑付</em>");
	        }else{
	         obj.html("<em style='font-size:16px;'>已兑付，3个工作日内到账</em>");
	        }
        }
        
	}
	
</script>

<body class="gray-bg">
     <input type="hidden" id="newDate"  name="newDate" value="${newDate}"/>
     <input type="hidden" id="endDateTime"  name="endDateTime" value="${oredr[0].endDateTime}"/>
    
     <input type="hidden" id="createDate"  name="createDate" value='<fmt:formatDate value="${oredr[0].create_date}" pattern="yyyy/MM/dd HH:mm:ss"/>'   />
<%@ include file="../header.jsp" %>
<div class="warp">
    <div class="breadcrumb">
	<a href="${ctx}/item/index">首&nbsp;页</a>&nbsp;&gt;&nbsp;投资记录
	</div>
	<div class="container">
		<div class="mod-wrap mod-assets">
			<div class="mod-contnet my-center">
				<div class="ui-icon ui-user">
					<img alt="头像" src="${resource_dir}/images/my_pic.png" name="头像"> <a href="javascript:void(0)"></a>
				</div>
					<div class="ui_left">
					<div class="user-info">
						  <span class=f-left><span id="newCurrentTime">上午好</span>，${mobliePPhon}</span>
						 	<A id="phone"   class="ui-icon ui-mail-p<c:if test="${mobliePhon!=''}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="已绑定手机"></A>
							<A id="idCard"  class="ui-icon ui-mobile<c:if test="${realName!=null}">-ok</c:if> jieshi" 	href="${ctx}/account/personInfo"  alt="<c:if test="${realName!=null}">已</c:if><c:if test="${realName==null}">未</c:if>实名认证"></A>
 					</div>
					<div class="investment-time">
						<P class=clear>
									上次登录时间：${ordeDdate}
						</P>
					</div>
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
				
			</div>
		</div>
		<div class="ui-main">
			<div class="ui-plate-sidebar">
				
				<!--侧栏菜单-->
				<ul class="sidebar-nav">
					<li class="first-nav-item"> <a href="javascript:void(0)">我的账户</a>
						<ul>
							<LI>
								<a href="${ctx}/account/myassets"><i class=nav-icon1></i>我的资产</a>
								</li>
								<li>
									<A class="current" href="${ctx}/account/investment_newList"><I class=nav-icon2></I>投资记录</A>
								</li>
								<li>
									<A  href="${ctx}/account/mybankcard"><I class=nav-icon3></I>我的银行卡</A>
								</li>
								<li>
									<A  href="${ctx}/account/personInfo"><I class=nav-icon4></I>个人信息</A>
								</li>
								<li>
									<A  href="${ctx}/account/informationCenter"><I class=nav-icon6></I>我的消息</A>
								</li>
								<li>
									<A  href="${ctx}/account/toMyInvited"><I class=nav-icon7></I>我的推荐</A>
								</li>
								<li>
									<A  href="${ctx}/account/toMyGold"><I class=nav-icon8></I>我的金币</A>
								</li>
						</ul>
					</li>
				</ul>
			</div>
	     
	     <div class="ui-plate-main">
				<div class="mod-contnet">
					<div class="my-account-title">
						<span>投资记录</span>
						<div class="export" style="width:50px;">
							<a href="${ctx}/account/investment_newList">返 回</a>
						</div>
					</div>
                    <div class="main-content" style="overflow:hidden;">
                    	<div class="investmain">
                        	<ul>
                            	<li>
                                    项目名称：<em>${oredr[0].item_prefix}${oredr[0].item_name}</em>                             
							    </li>
                                <li>
                                    交易状态：<em id="emBox">
                                    	<input type="hidden" value="${oredr[0].pay_status}" id="pay_status" name="pay_status">
                                           <c:if test="${oredr[0].pay_status=='01'}">支付成功</c:if>
										   <c:if test="${oredr[0].pay_status==null}">未支付</c:if>
										   <c:if test="${oredr[0].pay_status=='03'}">超募</c:if>
										   <c:if test="${oredr[0].pay_status=='04'}">已退款</c:if>
										   <c:if test="${oredr[0].pay_status=='05'}">超募</c:if>
										   <c:if test="${oredr[0].pay_status=='06'}">已兑付，3个工作日内到账</c:if>
										   <c:if test="${oredr[0].pay_status=='07'}">订单处理中</c:if>
										   <c:if test="${oredr[0].pay_status=='08'}">支付失败</c:if>
										   <c:if test="${oredr[0].pay_status=='09'}">超募</c:if>
										   <c:if test="${oredr[0].pay_status=='10'}">支付成功</c:if>
                                      </em>
                                </li>
                                <li>
                                    投资金额：<em id="orCapital"></em> 元
                                    <input type="hidden" value="${oredr[0].capital}" id="orCapital1"/>
                                </li>
                                <li>
                                    预期收益：<em>${oredr[0].income}</em> 元
                                </li>
                                <li>
                                    抵扣金额：<em id="deductionFee"></em>元
                                    <input type="hidden" value="${oredr[0].deduction_fee}" id="dedu"/>
                                </li>
                                <li>
                                    项目发行规模：<em id="orMoney"></em>
                                <input type="hidden" value="${oredr[0].max_finance_money}" id="orMoney1"/>
                                </li>
                                <li>
                                         年化收益率：<em>${oredr[0].invester_year_rate}</em>%
                                </li>
                                <li>
                                        期限：<em>${oredr[0].finance_period}</em>天
                                </li>
                                <li>
                                    项目起息日：<em>${oredr[0].startDate}</em>
                                </li>
                                <li>
                                    项目到期日：<em>${oredr[0].endDate}</em>
                                </li>
                            </ul>
                        </div>
                        <ul class="bankcard-list" style="width:250px;">
                         <c:forEach var="perSonAcIn" items="${personAcc}">
                                           <li>
								            	<h3>${perSonAcIn.bankName}</h3>
								                <p>
								                	<span class="banknum">${perSonAcIn.cardNumber}</span><em>${perSonAcIn.accountName}</em>
								                </p>
								                <i></i>
								            </li>	 
        						    </c:forEach>
                        </ul>
                        <c:if test="${(oredr[0].pay_status=='01'||oredr[0].pay_status=='06')&& oredr[0].repay_source_type!='07'}">
                               <a class="xieyi showbtn" id="demoBtn1">《借款协议》</a>
                        </c:if>
                        
                        <c:if test="${(oredr[0].pay_status=='01'||oredr[0].pay_status=='06')&& oredr[0].repay_source_type=='07'}">
                               <a class="xieyi showbtn2" id="demoBtn2">《借款协议》</a>
                        </c:if>
                        
                        <div id="tan" class="buy_tan" style="display:none;">
	                        <h3>借款协议</h3>
	                        <p style="display:block;text-align:right;margin-right:100px;">协议编号：${oredr[0].contract_number}</p>
	                        <p>借出人：${realNa}</p>
	                        <p>身份证号码：${identityCard}</p>
	                        <p class="margin">投资申请号：${oredr[0].order_number }</p>
	                        <p>借入人：${finaceName}</p>
	                        <p>身份证号码（组织机构代码）：${orgNameNumber}</p>
	                        <p class="margin">借款申请号：${oredr[0].loan_apply_number}</p>
	                        <p class="margin">经互联网金融综合服务平台（下称“平台”）的撮合，借出人同意向借入人提供借款，借入人同意向借出人借款。经各方协商一致，现就上述借款事宜订立如下协议，以期共同遵守：</p>
	                        <p>一、定义</p>
	                        <p>除非缔约方另有约定，本协议下列术语定义如下：</p>
	                        <p>1.1	平台：指[ 晋城农商银行 ]互联网金融综合服务平台（网址为：[ https://e.jcnsh.com ]），向借出人和借入人提供投融资信息发布与管理、投融资交易管理、交易资金结算（由平台指定的第三方支付机构提供）等服务的金融信息中介服务平台。 </p>
	                        <p>1.2	借出人：指经平台撮合，向在平台发布融资需求的借入人提供借款的自然人。</p>
	                        <p>1.3	借入人：指直接或间接在平台发布融资需求、并在满足本协议约定条件时获得募资的自然人或法人。</p>
	                        <p>1.4	第三方支付机构：指由平台指定、为平台用户提供交易资金结算等服务的机构。本协议项下提供前述服务的机构为[中金支付有限公司]。</p>
	                        <p>1.5	指定银行账户：指借出人和借入人分别在银行开立的、以接受第三方支付机构提供的查询、划转本协议项下款项等交易资金结算服务的账户。</p>
	                        <p>1.6	第三方支付平台账户：指第三方支付机构在银行开立且资金独立于第三方支付机构、用于借出人和借入人之间的资金划转、结算的账户。</p>
	                        <p>1.7	借款总额：是指借入人直接或间接在平台发布借款需求时所设定的所有借款金额。借款总额以平台具体展示及记录为准。借款总额包括但可能不仅限于本协议项下的借款金额。</p>
	                        <p>1.8	最小借款单位：由借入人所设置的借出人的最低借款金额，借出人可按照该限额的整数倍增加借款金额。</p>
	                        <p>1.9	募集期：是指借入人直接或间接在平台发布借款需求时所设定的筹资期限，该期限以平台具体展示及记录为准。募集期可由平台根据具体情况延长1-3日。</p>
	                        <p>1.10	平台服务费：指借入人使用平台服务而向蜂向公司支付的费用。</p>
	                        <p>二、	借款基本信息</p>
	                        <div class="mes">
	                        	<table>
	                            	<tbody>
	                                	<tr>
	                                    	<td class="tit">借款总额</td>
	                                    	<td>${oredr[0].max_finance_money}元人民币</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">最小借款单位</td>
	                                    	<td>${oredr[0].invest_unit_fee}元人民币</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">借款期限</td>
	                                    	<td>${oredr[0].finance_period}天</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">借款期间</td>
	                                    	<td>${oredr[0].startDate}~${oredr[0].endDate}</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">起息日</td>
	                                    	<td>${oredr[0].startDate}</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">借款利率</td>
	                                    	<td>${oredr[0].invester_year_rate}%</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">借款用途</td>
	                                    	<td>${oredr[0].item_dtl_info}</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">还款方式</td>
	                                    	<td>到期一次性还本付息</td>
	                                    </tr>
	                                	<tr>
	                                    	<td class="tit">到期还款日</td>
	                                    	<td>到期还款日如遇法定节假日，则顺延至节假日后的第一个工作日。资金实际到账时间为到期还款日后的1-3个工作日。</td>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                        <p>三、	各方权利义务</p>
	                        <p>3.1	借出人的权利义务</p>
	                        <p>3.1.1	借出人承诺向第三方支付机构及平台提供的信息及时、合法、真实、有效，用于出借的资金来源合法且符合平台的要求。</p>
	                        <p>3.1.2	借出人同意以网络页面点击确认的方式签订本协议，并不以此为由拒绝履行本协议项下的义务。借出人确认，在其指定银行账户中有足够资金且其以网络页面点击确认后即视为对借入人通过平台发出的要约的全部内容（认购的借款金额除外，可以仅认购其中不低于[   ]元的一部分）进行了承诺，即本借款协议成立。借出人同意以前述方式签订本协议后即视为不可撤销及变更地授权平台根据最终撮合结果自主生成前述信息，形成最终的本借款协议。借出人进一步确认并同意，在本协议成立后，未经平台及借入人的同意，借出人不得否认本协议项下债权债务关系或以任何方式撤回、撤销本协议。 </p>
	                        <p>3.1.3	借出人理解并同意，自第三方支付机构将借款金额从其指定银行账户划转至第三方支付平台账户之日起至起息日（不含）的期间内不产生任何收益（包括但不限于利息）。借出人有权从借入人处获得借款期间内基于借款金额的约定利息收益。</p>
	                        <p>3.1.4	借出人同意并授权第三方支付机构根据本协议约定从其指定银行账户中划转借款金额至第三方支付平台账户，并最终划转至借入人的指定银行账户以履行放款义务。借出人应确保在其以网络页面点击确认的方式签订本协议之时其指定银行账户中有足够的资金转入第三方支付平台账户以完成放款，否则，借出人按照本协议第3.1.2条的约定进行的承诺为无效承诺，本借款协议不成立。</p>
	                        <p>3.1.5	借出人同意并授权第三方支付机构于借款到期后根据本协议约定将借入人偿还的借款本金及利息通过第三方支付平台账户划转至其指定银行账户，划转完成即视为借入人已履行还款义务。</p>
	                        <p>3.1.6	借出人应保证其指定银行账户状态正常，确保资金划入、划出交易的完成。</p>
	                        <p>3.1.7	借出人理解并同意，平台不承担本协议项下借出人的任何资金损失风险，但因平台及第三方支付机构原因导致借出人资金损失的除外。 </p>
	                        <p>3.2	借入人的权利义务 </p>
	                        <p>3.2.1	借入人承诺向平台及第三方支付机构提供的信息及时、合法、真实、有效。</p>
	                        <p>3.2.2	借入人应保证借款用途合法合规。借入人未经平台、借出人同意，擅自改变借款用途的，借入人应自挪用借款之日起按照挪用借款金额每日向借出人额外支付相当于本协议第二条约定的借款利率100%的罚息。</p>
	                        <p>3.2.3	借入人同意以线下签字或签章确认的方式签订本协议，即便在签订时本协议并没有借出人的信息、签订日期信息等，借入人同意将其单方签订的本协议的内容（协议编号：[${oredr[0].contract_number}]，包括本协议以及相应的《项目说明书》）作为通过平台向潜在借出人发出的要约。借入人同意以上述方式发出要约后即视为不可撤销及变更地授权平台为借入人寻找符合条件的一个或多个借出人并进行撮合，且借入人同意在任一借出人对借入人发出的要约进行承诺（即该借出人按照本协议第3.1.2条约定签署本协议）后，即视为不可撤销及变更地授权平台根据最终撮合结果自主生成前述信息，形成最终的本借款协议。借入人进一步确认并同意，未经平台的同意，借入人不得随意撤销该等要约，且在本借款协议成立后，未经平台及借出人的同意，借入人不得否认本协议项下债权债务关系或以任何方式撤回、撤销本协议。 </p>
	                        <p>3.2.4	借入人同意并授权第三方支付机构根据本协议约定将借款金额通过第三方支付平台账户划转至借入人的指定银行账户即视为借出人履行完毕放款义务。</p>
	                        <p>3.2.5	借入人应保证其指定银行账户状态正常，确保资金划入、划出交易的完成。如因前述指定银行账户不正常导致的所有损失（如借款资金无法及时入账、还款资金无法划转等）应由其自行承担。</p>
	                        <p>3.2.6	借入人应按照本协议的约定到期还款并按约支付利息。</p>
	                        <p>3.2.7	借入人应按照本协议第4.2条的约定向蜂向公司支付平台服务费。</p>
	                        <p>3.2.8	当借入人的资信状况及还款能力出现重大不利影响时，借入人应及时通知平台、借出人或其受托人。</p>
	                        <p>四、	借款发放、还款方式及逾期还款责任 </p>
	                        <p>4.1	在借出人以网络页面点击确认的方式签订本协议的同时，即授权第三方支付机构自借出人指定银行账户中划转相当于本协议项下借款金额的款项至第三方支付机构的第三方支付平台账户，第三方支付机构将根据平台的指令于起息日前将本协议对应的借款金额从第三方支付平台账户划转至借入人的指定银行账户。</p>
	                        <p>4.2	自第三方支付机构将本协议项下借款金额自第三方支付平台账户划转至借入人的指定银行账户时即视为借出人履行了放款义务。 借入人理解并同意在借款发放时，借入人委托第三方支付机构从前述借款金额中将借入人平台服务费直接扣除并划转至蜂向公司指定银行账户。即便存在前述平台服务费的扣除安排，借入人仍应按照本协议的借款金额到期偿还本金和支付利息。</p>
	                        <p>4.3	未经平台及借出人书面同意，借入人不得提前归还借款。为避免歧义，借入人在还款日前将款项支付给平台指定的第三方支付机构的行为不视为提前归还借款的行为。</p>
	                        <p>4.4	借入人按约在到期还款日14:00时前将还款金额划转至借入人的指定银行账户并不可撤销地授权见证机构或第三方支付机构代为完成还款。
									借出人理解并同意，第三方支付机构最终将本协议项下的借款本息或受偿款项划转至借出人的指定银行账户需要一定的时间，前述时间一般为到期还款日后的1-3个工作日，前述期间内不产生任何投资收益（包括但不限于利息）。</p>
							<p>4.5	借入人未按本协议约定归还借款的，除应按本协议第二条的约定支付利息外，借入人应自借款逾期之日起在逾期未付款项（包括逾期未付的本金和利息）金额上每日向借出人额外支付相当于本协议第二条约定的借款利率100%的罚息，直至清偿为止。</p>
	                        <p>4.6	除上述约定外，借入人还需承担因未按约还款所产生的一切费用，包括但不限于诉讼费、财产保全费、执行费、仲裁费、律师代理费、差旅费、评估费、拍卖费、催收费用等。</p>
	                        <p>五、	还款保障条款 </p>
	                        <p>5.1	本协议项下的还款保障方式为：</p>
	                        <p>5.1.1	由[      ]提供保证担保（担保函编号为[         ]）保障，具体为[                        ]；</p>
	                        <p>5.1.2	由[      ]提供抵押担保（合同编号为[         ]）保障，具体为[                        ]；</p>
	                        <p>5.1.3	由[      ]提供质押担保（合同编号为[         ]）保障，具体为[                        ]。</p>
	                        <p>5.2	为确保上述保障措施得以充分有效履行，借出人无条件、不可撤销及变更地授权平台以其自己的名义行使上述担保权利。</p>
	                        <p>六、	违约条款</p>
	                        <p>6.1	发生下列任何一项或几项情形的，视为借入人违约：</p>
	                        <p>6.1.1	借入人提供的资料虚假、故意隐瞒重要事实或未经平台、借出人同意擅自转让本协议项下借款债务；</p>
	                        <p>6.1.2	借入人未经平台同意，擅自撤销与平台的委托关系；</p>
	                        <p>6.1.3	借入人擅自改变借款资金用途；</p>
	                        <p>6.1.4	借入人提供的担保资产（如有）遭受查封或其他可能影响其履约能力的不利事件，且借入人不能及时提供有效补救措施的；</p>
	                        <p>6.1.5	借入人的财务状况发生巨大恶劣变化或出现其他情形且影响其履约能力，并其不能及时提供有效补救措施的。</p>
	                        <p>6.2	借入人发生上述第6.1条的违约事件，或根据借出人合理判断借入人可能发生第6.1条所述违约事件的，借出人不可撤销地委托平台采取下列任何一项或多项措施：</p>
	                        <p>6.2.1	宣布已发放借款全部提前到期；</p>
	                        <p>6.2.2	要求借入人在甲方宣布提前到期后的3日内，偿还所有借款金额、利息、逾期利息（如有）及其他相关费用（如有）；</p>
	                        <p>6.2.3	按照约定实现本协议项下的担保权利。</p>
	                        <p>6.3	借出人保留将借入人违约失信的相关信息在平台或其他媒体披露的权利。</p>
	                        <p>七、	协议的签订、成立、生效及终止</p>
	                        <p>7.1	借出人和借入人应按照本协议第3.1.2条及第3.2.3条的约定方式签订本协议。</p>
	                        <p>7.2	本协议自借出人按照本协议第3.1.2条的约定签订本协议之日成立。</p>
	                        <p>7.3	本协议为附条件生效协议，协议生效需同时满足如下条件：</p>
	                        <p>7.3.1	本协议已成立；</p>
	                        <p>7.3.2	借入人设定的借款总额在募集期已至少完成[    %]部分的募集且完成了该等借款的发放；</p>
	                        <p>7.3.3	平台根据最终撮合结果生成借出人与借入人信息、第二条与第五条信息及协议签订日期信息等要素，且本协议可在平台查询。</p>
	                        <p>若在募集期内，平台为借入人所募集的资金低于借入人所设定的借款总额但达到上述最低比例要求的，则借款金额以实际募集的金额为准；若平台为借入人所募集的资金低于上述最低比例要求的，则本协议不生效；若在募集期内，平台为借入人所募集的资金超过借入人所设定的借款总额的，则平台将根据包括本协议项下借出人在内的所有借出人的签订本协议的时间顺序，将顺序在后的借款金额/部分借款金额（即超募资金）于募集期结束日的T+1日（均为工作日，非工作日将延后至下一个工作日），通过第三方支付机构向借出人指定银行账户退款。双方确认，若本协议项下借出人的借款金额/部分借款金额根据上述约定被退款的，则本协议不发生效力或者仅在实际借款金额范围内发生效力。</p>
	                        <p>7.4	资金募集完成后，平台将通知第三方支付机构进行借款金额的划转。若未能按约完成资金募集的，平台将不会通知第三方支付机构进行借款金额划转。</p>
	                        <p>7.5	借出人与借入人同意以留存在平台的协议为准。</p>
	                        <p>7.6	本协议期限届满，或者本协议根据法律规定或双方约定被提前终止，或者借出人在本协议项下的借款金额、利息、逾期利息（如有）及其他相关费用（如有）被全部清偿完毕的，本协议终止。本协议终止后，不影响本协议项下的结算和清理条款以及保密条款的效力。</p>
	                        <p>八、	其他事项 </p>
	                        <p>8.1	到期还款日如遇法定节假日，则顺延至节假日后的第一个工作日。</p>
	                        <p>8.2	借入人须确保到期足额偿还包括本协议借款金额在内的借款总额项下所有协议项下的借款本息及其他应付款项，否则不视为还款完成，由此引起的法律后果及违约责任由借入人承担。</p>
	                        <p>8.3	借出人及借入人必须通过本协议约定的方式或平台认可的其他方式进行放款及还款,否则由此引起的法律后果及违约责任由借出人或借入人自行承担。</p>
	                        <p>8.4	本协议项下借款记录等信息均以平台生成并公布的内容为准。借出人、借入人可以通过指定银行账户登录平台查询上述信息。</p>
	                        <p>8.5	本协议项下的债权债务未经平台书面同意不得转让。经平台书面同意后，借出人有权在平台上进行债权转让，借出人进行债权的，应及时委托平台向借入人进行通知，否则由此产生的法律后果由借出人自行承担。</p>
	                        <p>8.6	本协议双方应对其他方提供的信息及本协议内容保密，未经其他方同意，任何一方不得向本协议主体之外的任何人披露，但法律、行政法规另有强制性规定，或监管、审计等有权机关另有强制性要求的除外。</p>
	                        <p>8.7	本协议各方知悉并遵守《互联网金融综合服务平台服务协议（投资人版）》、《互联网金融综合服务平台服务协议（融资人版）》、《用户注册服务协议》、《项目说明书》、《快捷支付用户协议》以及平台和第三方支付机构制定的相关规则的规定，该等协议及规定中关于借入人与借出人双方之间的法律关系的内容构成本协议不可分割的一部分，但若该等内容与本协议的约定存在不一致的，以本协议的约定为准。</p>
	                        <p>8.8	如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，则应认为该条款可与本协议相分割，并可被尽可能接近各方意图的、能够保留本协议要求的经济目的的、有效的新条款所取代，而且在此情况下，本协议的其他条款仍然完全有效并具有约束力。</p>
	                        <p>8.9	协议各方应按法律法规及相关规定各自承担与本协议相关的税费。</p>
	                        <p>九、	法律的适用和争议的解决 </p>
	                        <p>本协议受中华人民共和国法律管辖并按中华人民共和国法律解释。本协议履行中发生争议，可由各方协商解决，协商不成可向本协议签订地有管辖权的人民法院起诉。本协议签订地为[ 晋城农商银行股份有限公司 ]。</p>
	                        <p class="align">借出人签订日期：${oredr[0].payDate }</p>
	                        <p class="align">借入人签订日期：${oredr[0].loanDate}</p>
						  </div>
						  
						  
					
						  
					<div id="xieyi2" class="buy_tan" style="display:none;">
 						<h3 style="text-align:center;">借款协议</h3>
                        <p style="display:block;text-align:right;margin:40px 10px 10px 0;">协议编号：[${oredr[0].contract_number}]</p>
                        <p>借出人：${realNa}</p>
                        <p>身份证号码：${identityCard}</p>
                        <p class="margin">投资申请号：${oredr[0].order_number }</p>
                        <p>借入人：${finaceName}</p>
                        <p>身份证号码（组织机构代码）：${orgNameNumber}</p>
                        <p class="margin">借款申请号：${oredr[0].loan_apply_number}</p>
                        <p class="margin">经[ 晋城农商行       ]互联网金融综合服务平台（下称“平台”）的撮合，借出人同意向借入人提供借款，借入人同意向借出人借款。经各方协商一致，现就上述借款事宜订立如下协议，以期共同遵守：</p>
                        <p>一、定义</p>
                        <p>除非缔约方另有约定，本协议下列术语定义如下：</p>
                        <p>1.1	平台：指[  晋城农商银行  ]互联网金融综合服务平台（网址为：[ https://e.jcnsh.com  ]，及根据业务需要不时修改的其他网址），向借出人和借入人提供投融资信息发布与管理、投融资交易管理、交易资金结算（由平台指定的第三方支付机构提供）等服务的金融信息中介服务平台。</p>
                        <p>1.2	借出人：指经平台撮合，向在平台发布融资需求的借入人提供借款的自然人</p>
                        <p>1.3	借入人：指直接或间接在平台发布融资需求、并在满足本协议约定条件时获得募资的自然人或法人。 </p>
                        <p>1.4	第三方支付机构：指由平台指定、为平台用户提供交易资金结算等服务的机构。本协议项下提供前述服务的机构为[中金支付有限公司]。</p>
                        <p>1.5	指定银行账户：指借出人和借入人分别在银行开立的、以接受第三方支付机构提供的查询、划转本协议项下款项等交易资金结算服务的账户。</p>
                        <p>1.6	第三方支付平台账户：指第三方支付机构在银行开立且资金独立于第三方支付机构、用于借出人和借入人之间的资金划转、结算的账户。</p>
                        <p>1.7	借款总额：是指借入人直接或间接在平台发布借款需求时所设定的所有借款金额。借款总额以平台具体展示及记录为准。借款总额包括但可能不仅限于本协议项下的借款金额。</p>
                        <p>1.8	本协议项下的借款金额/借款金额：是指本协议项下的借出人根据本协议的约定实际有效发放的借款数额，但本协议另有约定的除外。</p>
                        <p>1.9	最小借款金额：由借入人所设置的单个借出人的最小借款金额，具体金额以平台展示的《项目说明书》为准。</p>
                        <p>1.10	最大借款金额：由借入人所设置的单个借出人的最大借款金额，具体金额以平台展示的《项目说明书》为准。</p>
                        <p>1.11	募集期：是指借入人直接或间接在平台发布借款需求时所设定的筹资期限，该期限以平台具体展示及记录为准。募集期可由平台根据具体情况延长1-3日。</p>
                        <p>1.12	平台服务费：指借入人使用平台服务而向北京蜂向信息科技有限公司（下称“蜂向公司”）支付的费用。</p>
                        <p>二、	借款基本信息</p>
                        <div class="mes">
                        	<table>
                            	<tbody>
                                	<tr>
                                    	<td class="tit">借款总额（元）</td>
                                    	<td class="jkze">${oredr[0].max_finance_money}元人民币</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">最小借款金额（元）</td>
                                    	<td id="zxjkje">${oredr[0].invest_unit_fee}元人民币</td>
                                    </tr>
                                    <tr>
                                    	<td class="tit">最大借款金额（元）</td>
                                    	<td id="zdjkje">${oredr[0].invest_unit_fee}元人民币</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款期限（天）</td>
                                    	<td id="jkqx">${oredr[0].finance_period}</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款期间</td>
                                    	<td id="jkqj">${oredr[0].startDate}~${oredr[0].endDate}</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">起息日</td>
                                    	<td id="qxr">${oredr[0].startDate}</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款利率（%，年化）</td>
                                    	<td id="jkll">${oredr[0].invester_year_rate}</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">借款用途</td>
                                    	<td id="jkyt">${oredr[0].item_dtl_info}</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">还款方式</td>
                                    	<td>到期一次性还本付息</td>
                                    </tr>
                                	<tr>
                                    	<td class="tit">到期还款日</td>
                                    	<td>到期还款日如遇法定节假日，则顺延至节假日后的第一个工作日。资金实际到账时间为到期还款日后的1-3个工作日。</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p>三、	各方权利义务</p>
                        <p>3.1	借出人的权利义务</p>
                        <p>3.1.1	借出人承诺向第三方支付机构及平台提供的信息及时、合法、真实、有效，用于出借的资金来源合法且符合平台的要求。</p>
                        <p>3.1.2	借出人同意以网络页面点击确认的方式签订本协议，并不以此为由拒绝履行本协议项下的义务。借出人确认，在其指定银行账户中有足够资金且其以网络页面点击确认后即视为对借入人通过平台发出的要约的全部内容（认购的本协议项下的借款金额之信息除外）进行了承诺，即本借款协议成立。借出人同意以前述方式签订本协议后即视为不可撤销及变更地授权平台根据最终撮合结果自主生成前述信息，形成最终的本借款协议。借出人进一步确认并同意，在本协议成立后，未经平台及借入人的同意，借出人不得否认本协议项下债权债务关系或以任何方式撤回、撤销本协议。</p>
                        <p>3.1.3	借出人理解并同意，自第三方支付机构将借款金额从其指定银行账户划转至第三方支付平台账户之日起至起息日（不含）的期间内不产生任何收益（包括但不限于利息）。借出人有权从借入人处获得借款期间内基于借款金额的约定利息收益。</p>
                        <p>3.1.4	借出人同意并授权第三方支付机构根据本协议约定从其指定银行账户中划转借款金额至第三方支付平台账户，并最终划转至借入人的指定银行账户以履行放款义务。借出人应确保在其以网络页面点击确认的方式签订本协议之时其指定银行账户中有足够的资金转入第三方支付平台账户以完成放款，否则，借出人按照本协议第3.1.2条的约定进行的承诺为无效承诺，本借款协议不成立。</p>
                        <p>3.1.5	借出人同意并授权第三方支付机构于借款到期后根据本协议约定将借入人偿还的借款本金及利息通过第三方支付平台账户划转至其指定银行账户，划转完成即视为借入人已履行还款义务。</p>
                        <p>3.1.6	借出人应保证其指定银行账户状态正常，确保资金划入、划出交易的完成。</p>
                        <p>3.1.7	借出人理解并同意，平台不承担本协议项下借出人的任何资金损失风险，但因平台及第三方支付机构原因导致借出人资金损失的除外。 </p>
                        <p>3.1.8	在借入人未按本协议约定归还借款的情况下，借出人不可撤销的地授权见证机构代为办理向借入人进行催收并向保险公司提出理赔申请，提交理赔所需文件等事宜。 </p>
                        <p>3.2	借入人的权利义务 </p>
                        <p>3.2.1	借入人承诺向平台及第三方支付机构提供的信息及时、合法、真实、有效。</p>
                        <p>3.2.2	借入人应保证借款用途合法合规。借入人未经平台、借出人同意，擅自改变借款用途的，借入人应自挪用借款之日起按照挪用借款金额每日向借出人额外支付相当于本协议第二条约定的借款利率100%的罚息。</p>
                        <p>3.2.3	借入人同意以线下签字或签章确认的方式签订本协议，即便在签订时本协议并没有借出人的信息、本协议项下的借款金额以及签订日期信息等，借入人同意将其单方签订的本协议的内容（协议编号：[         ]，包括本协议以及相应的《项目说明书》）作为通过平台向潜在借出人发出的要约。借入人同意以上述方式发出要约后即视为不可撤销及变更地授权平台为借入人寻找符合条件的一个或多个借出人并进行撮合，且借入人同意在任一借出人对借入人发出的要约进行承诺（即该借出人按照本协议第3.1.2条约定签署本协议）后，即视为不可撤销及变更地授权平台根据最终撮合结果自主生成前述信息，形成最终的本借款协议。借入人进一步确认并同意，未经平台的同意，借入人不得随意撤销该等要约，且在本借款协议成立后，未经平台及借出人的同意，借入人不得否认本协议项下债权债务关系或以任何方式撤回、撤销本协议。 </p>
                        <p>3.2.4	借入人同意并授权借出人委托第三方支付机构根据本协议约定将借款金额通过第三方支付平台账户划转至借入人的指定银行账户即视为借出人履行完毕放款义务。 </p>
                        <p>3.2.5	借入人应保证其指定银行账户状态正常，确保资金划入、划出交易的完成。如因前述指定银行账户不正常导致的所有损失（如借款资金无法及时入账、还款资金无法划转等）应由其自行承担。</p>
                        <p>3.2.6	借入人应按照本协议的约定到期还款并按约支付利息。</p>
                        <p>3.2.7	借入人应按照本协议第4.2条的约定向蜂向公司支付平台服务费。 </p>
                        <p>3.2.8	当借入人的资信状况及还款能力出现重大不利影响时，借入人应及时通知平台、借出人或其受托人。 </p>
                        <p>四、	借款发放、还款方式及逾期还款责任 </p>
                        <p>4.1	在借出人以网络页面点击确认的方式签订本协议的同时，即授权第三方支付机构自借出人指定银行账户中划转相当于本协议项下的借款金额的款项至第三方支付机构的第三方支付平台账户，第三方支付机构将根据平台的指令于起息日前将本协议项下的借款金额从第三方支付平台账户划转至借入人的指定银行账户。</p>
                        <p>4.2	自第三方支付机构将本协议项下的借款金额自第三方支付平台账户划转至借入人的指定银行账户时即视为借出人履行了放款义务。 借入人理解并同意在借款发放时，借入人委托第三方支付机构从前述借款金额中将借入人平台服务费直接扣除并划转至蜂向公司指定银行账户。即便存在前述平台服务费的扣除安排，借入人仍应按照本协议项下的借款金额到期偿还本金和支付利息。</p>
                        <p>4.3	未经平台及借出人书面同意，借入人不得提前归还借款。为避免歧义，借入人在到期还款日之前将款项支付给平台指定的第三方支付机构的行为不视为提前归还借款的行为。</p>
                        <p>4.4	借入人应在到期还款日前倒数第二个工作日14:00时前将还款金额（为免疑义，利息仍应按整个借款期限计算）划转至借入人的指定银行账户，并不可撤销地授权第三方支付机构在到期还款日当天代为完成还款。借出人理解并同意，第三方支付机构最终将本协议项下的借款本息或受偿款项划转至借出人的指定银行账户需要一定的时间，前述时间一般为到期还款日后的1-3个工作日，前述期间内不产生任何投资收益（包括但不限于利息）。</p>
						<p>4.5	借入人未按本协议约定归还借款的，除应按本协议第二条的约定支付利息外，借入人应自借款逾期之日起在逾期未付款项（包括逾期未付的本金和利息）金额上每日向借出人额外支付相当于本协议第二条约定的借款利率100%的罚息，直至清偿为止。</p>
                        <p>4.6	借入人未按本协议约定归还借款的（包括未在到期还款日前倒数第二两个工作日14:00时前将还款金额足额划转至借入人的指定银行账户的情形），则构成借入人违约，借出人理解并同意，出现该等情形时，见证机构有权依据借出人的授权向为借入人提供履约保证保险的保险公司（本协议中简称“保险公司”）申请理赔，保险公司的理赔需要一定的时间，理赔完成后，见证机构将借款本金、利息及罚息等（以保险公司实际理赔的资金为限）通过第三方支付机构划转至借出人的指定银行账户。</p>
                        <p>4.7	除上述约定外，借入人还需承担因未按约还款所产生的一切费用，包括但不限于诉讼费、财产保全费、执行费、仲裁费、律师代理费、差旅费、评估费、拍卖费、催收费用等。</p>
                        <p>五、	还款保障条款 </p>
                        <p>5.1	本协议项下的还款保障方式为：</p>
                        <p>5.1.1	由[      ]提供保证担保（担保函编号为[         ]）保障，具体为[                        ]； </p>
                        <p>5.1.2	由[      ]提供抵押担保（合同编号为[         ]）保障，具体为[                        ]；</p>
                        <p>5.1.3    由[      ]提供质押担保（合同编号为[         ]）保障，具体为[                        ]。 </p>
                        <p>5.1.4    由【    】提供履约保证保险（保险单编号为【  】）保障，具体为【                    】。 </p>
                        <p>5.2	为确保上述保障措施得以充分有效履行，借出人无条件、不可撤销及变更地授权《互联网金融综合服务平台服务协议》项下的见证机构（本协议中简称“见证机构”）以该机构自己的名义代表借出人签署担保合同/保险合同，办理相应登记（如需）并代为行使上述担保/保险权利，借入人对此予以认可。 </p>
                        <p>六、	违约条款</p>
                        <p>6.1	发生下列任何一项或几项情形的，视为借入人违约：</p>
                        <p>6.1.1	借入人提供的资料虚假、故意隐瞒重要事实或未经平台、借出人同意擅自转让本协议项下借款债务；</p>
                        <p>6.1.2	借入人未经平台同意，擅自撤销与平台的委托关系；</p>
                        <p>6.1.3	借入人擅自改变借款资金用途；</p>
                        <p>6.1.4	借入人提供的担保资产（如有）遭受查封或其他可能影响其履约能力的不利事件，且借入人不能及时提供有效补救措施的；</p>
                        <p>6.1.5	借入人的财务状况发生巨大恶劣变化或出现其他情形且影响其履约能力，并其不能及时提供有效补救措施的。</p>
                        <p>6.2	借入人发生上述第6.1条的违约事件，或根据借出人合理判断借入人可能发生第6.1条所述违约事件的，借出人不可撤销地委托平台采取下列任何一项或多项措施：</p>
                        <p>6.2.1	宣布已发放借款全部提前到期；</p>
                        <p>6.2.2	要求借入人在甲方宣布提前到期后的3日内，偿还所有借款金额、利息、逾期利息（如有）及其他相关费用（如有）；</p>
                        <p>6.2.3	按照约定实现本协议项下的担保权利。</p>
                        <p>6.3	借出人保留将借入人违约失信的相关信息在平台或其他媒体披露的权利。</p>
                        <p>七、	协议的签订、成立、生效及终止</p>
                        <p>7.1	借出人和借入人应按照本协议第3.1.2条及第3.2.3条的约定方式签订本协议。</p>
                        <p>7.2	本协议自借出人按照本协议第3.1.2条的约定签订本协议之日成立。</p>
                        <p>7.3	本协议为附条件生效协议，协议生效需同时满足如下条件：</p>
                        <p>7.3.1	本协议已成立；</p>
                        <p>7.3.2	借入人设定的借款总额在募集期已至少完成[    %]部分的募集且完成了该等借款的发放；</p>
                        <p>7.3.3	平台根据最终撮合结果生成借出人与借入人信息、第二条与第五条信息及协议签订日期信息等要素，且本协议可在平台查询。</p>
                        <p>若在募集期内，平台为借入人所募集的资金低于借入人所设定的借款总额但达到上述最低比例要求的，则借款金额以实际募集的金额为准；若平台为借入人所募集的资金低于上述最低比例要求的，则本协议不生效；若在募集期内，平台为借入人所募集的资金超过借入人所设定的借款总额的，则平台将根据包括本协议项下借出人在内的所有借出人的签订本协议的时间顺序，将顺序在后的借款金额/部分借款金额（即超募资金）于募集期结束日的T+1日（均为工作日，非工作日将延后至下一个工作日），通过第三方支付机构向借出人指定银行账户退款。双方确认，若本协议项下借出人的借款金额/部分借款金额根据上述约定被退款的，则本协议不发生效力或者仅在实际借款金额范围内发生效力。</p>
                        <p>7.4	资金募集完成后，平台将通知第三方支付机构进行借款金额的划转。若未能按约完成资金募集的，平台将不会通知第三方支付机构进行借款金额划转。</p>
                        <p>7.5	借出人与借入人同意以留存在平台的协议为准。</p>
                        <p>7.6	本协议期限届满，或者本协议根据法律规定或双方约定被提前终止，或者借出人在本协议项下的借款金额、利息、逾期利息（如有）及其他相关费用（如有）被全部清偿完毕的，本协议终止。本协议终止后，不影响本协议项下的结算和清理条款以及保密条款的效力。</p>
                        <p>八、	其他事项 </p>
                        <p>8.1	到期还款日如遇法定节假日，则顺延至节假日后的第一个工作日。</p>
                        <p>8.2	借入人须确保到期足额偿还包括本协议借款金额在内的借款总额项下所有协议项下的借款本息及其他应付款项，否则不视为还款完成，由此引起的法律后果及违约责任由借入人承担。</p>
                        <p>8.3	借出人及借入人必须通过本协议约定的方式或平台认可的其他方式进行放款及还款,否则由此引起的法律后果及违约责任由借出人或借入人自行承担。</p>
                        <p>8.4	本协议项下借款记录等信息均以平台生成并公布的内容为准。借出人、借入人可以通过指定银行账户登录平台查询上述信息。</p>
                        <p>8.5	本协议项下的债权债务未经平台书面同意不得转让。经平台书面同意后，借出人有权在平台上进行债权转让，借出人进行债权的，应及时委托平台向借入人进行通知，否则由此产生的法律后果由借出人自行承担。</p>
                        <p>8.6	本协议双方应对其他方提供的信息及本协议内容保密，未经其他方同意，任何一方不得向本协议主体之外的任何人披露，但法律、行政法规另有强制性规定，或监管、审计等有权机关另有强制性要求的除外。</p>
                        <p>8.7	本协议各方知悉并遵守《互联网金融综合服务平台服务协议（投资人版）》、《互联网金融综合服务平台服务协议（融资人版）》、《用户注册服务协议》、《项目说明书》、《快捷支付用户协议》以及平台和第三方支付机构制定的相关规则的规定，该等协议及规定中关于借入人与借出人双方之间的法律关系的内容构成本协议不可分割的一部分，但若该等内容与本协议的约定存在不一致的，以本协议的约定为准。</p>
                        <p>8.8	如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，则应认为该条款可与本协议相分割，并可被尽可能接近各方意图的、能够保留本协议要求的经济目的的、有效的新条款所取代，而且在此情况下，本协议的其他条款仍然完全有效并具有约束力。</p>
                        <p>8.9	协议各方应按法律法规及相关规定各自承担与本协议相关的税费。</p>
                        <p>九、	法律的适用和争议的解决 </p>
                        <p>本协议受中华人民共和国法律管辖并按中华人民共和国法律解释。本协议履行中发生争议，可由各方协商解决，协商不成可向本协议签订地有管辖权的人民法院起诉。本协议签订地为[ 晋城农村商业银行股份有限公司 ]。</p>
                    <p class="align">本协议项下的借款金额为：${oredr[0].capital}<span class="jkze"></span>元。</p>
                    <p class="align">借出人签订日期：  ${oredr[0].payDate } </p>
                    <p class="align">借入人签字（盖章）：${finaceName}</p>
                    <p class="align">借入人签订日期：  ${oredr[0].loanDate}</p>
                         
                   </div>
						  
                    </div>
                    <div class=bank-tips-text>（温馨提示：您所添加的银行账户将用于平台项目投资支付、未来投资本金及收益回款。）</div>
                  </div>
				</div>
			</div>
	    </div>
	</div>			 
<P class="mouseTips"><I></I></P>
<%@ include file="../foot.jsp" %>
</body>
</html>
