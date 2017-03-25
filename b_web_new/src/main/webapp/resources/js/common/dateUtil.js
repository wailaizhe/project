//返回某个日期的星期几
function getDayOfWeek(dayValue) {
	var day = new Date(Date.parse(dayValue.replace(/-/g, '/'))); // 将日期值格式化
	var today = [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" ];
	return today[day.getDay()]; // day.getDay();根据Date返一个星期中的某一天，其中0为星期日
}

// 根据Date返一个星期中的某一天，其中0为星期日
function getWeekDay(dayValue) {
	var day = new Date(Date.parse(dayValue.replace(/-/g, '/'))); // 将日期值格式化
	return day.getDay();
}

// 返回当前日期某几天之后的日期
function getNextDay(days) {
	var nowDate = new Date();
	var tmpYear = nowDate.getFullYear();
	var tmpMonth = nowDate.getMonth() + 1;
	if (tmpMonth < 10) {
		tmpMonth = "0" + tmpMonth;
	}

	var tmpDay = nowDate.getDate();
	if (tmpDay < 10) {
		tmpDay = "0" + tmpDay;
	}

	var date = new Date(tmpYear, tmpMonth - 1, tmpDay);
	var temp = new Number(days);
	date.setDate(date.getDate() + days);
	return changeTime(date);
}

// 返回某个日期某几天之后的日期
function getNextDate(datestr, days) {
	var nowDate = new Date(datestr);
	var tmpYear = nowDate.getFullYear();
	var tmpMonth = nowDate.getMonth() + 1;
	if (tmpMonth < 10) {
		tmpMonth = "0" + tmpMonth;
	}

	var tmpDay = nowDate.getDate();
	if (tmpDay < 10) {
		tmpDay = "0" + tmpDay;
	}

	var date = new Date(tmpYear, tmpMonth - 1, tmpDay);
	var temp = new Number(days);
	date.setDate(date.getDate() + days);
	return changeTime(date);
}

function changeTime(str) {
	var fullDate = "";
	var tmpMonth = "";
	var tmpDay = "";
	var tmpYear = "";
	tmpMonth = str.getMonth() + 1;
	if (tmpMonth < 10) {
		tmpMonth = "0" + tmpMonth;
	}
	tmpDay = str.getDate();
	if (tmpDay < 10) {
		tmpDay = "0" + tmpDay;
	}
	tmpYear = str.getFullYear();
	return (tmpYear + "-" + tmpMonth + "-" + tmpDay);
}
//返回两个时间差的天数
function dateDiffTime(beginDateStr, endDateStr) {
	// beginDate和endDate都是2007-8-10格式
	var Date1 = new Date(Date.parse(beginDateStr.replace(/-/g, '/')));
	var Date2 = new Date(Date.parse(endDateStr.replace(/-/g, '/')));
	// 转换为天数
	var iDays = parseInt(Math.abs(Date1 - Date2) / 1000 / 60 / 60 );
	if(iDays==0){
		iDays = 1;
	}
	return iDays;
}
// 返回两个时间差的天数
function dateDiff(beginDateStr, endDateStr) {
	// beginDate和endDate都是2007-8-10格式
	var Date1 = new Date(Date.parse(beginDateStr.replace(/-/g, '/')));
	var Date2 = new Date(Date.parse(endDateStr.replace(/-/g, '/')));
	// 转换为天数
	var iDays = parseInt(Math.abs(Date1 - Date2) / 1000 / 60 / 60 / 24);
	if(iDays==0){
		iDays = 1;
	}
	return iDays;
}

//返回两个时间差的月数
function dateDiffMonth(beginDateStr, endDateStr) {
	// beginDate和endDate都是2007-8-10格式
	var Date1 = new Date(Date.parse(beginDateStr.replace(/-/g, '/')));
	var Date2 = new Date(Date.parse(endDateStr.replace(/-/g, '/')));
	// 转换为天数
	var iDays = parseInt(Math.abs(Date1 - Date2) / 1000 / 60 / 60 / 24);
	var m = parseInt(iDays/30);
	return m;
}

//返回两个时间差的月数，超过15天算一个月
function dateDiffMonth2(beginDateStr, endDateStr){
    var sDate = new Date(Date.parse(beginDateStr.replace(/-/g, "/"))); //转化成日期对象
    var eDate = new Date(Date.parse(endDateStr.replace(/-/g, "/")));

    //获得各自的年、月、日
    var sY    = sDate.getFullYear();     
    var sM    = sDate.getMonth()+1;
    var sD    = sDate.getDate();
    var eY    = eDate.getFullYear();
    var eM    = eDate.getMonth()+1;
    var eD    = eDate.getDate();
    
    
    //var flagD = 0;   //日期标记：
    var flagM = 0;    //月份进/减位标记
    var flagY = 0;    //年份进/减位标记
    var months = 0;   //相隔约数，返回值
    
    var d = eD - sD;  //日期相差天数
    if(d>0&&d>=15)  //如果为正，且大于15天，月份进一
    {
     flagM = 1;
    }
    if(d<0&&30+d<15)  //如果为负，且相隔天数<15，月份减一
    {
     flagM = -1;
    }
    
    var m = eM + flagM - sM;   //相隔月数 = 结束月份 + 月份进/减位标记 - 开始月份
    if(m<0)                    //如果小于0，年数减一，月数为12减去相隔月数
    {    
        flagY = -1;
        m = 12 + m;
    }
    
    var y = eY + flagY - sY;  //相隔年数 = 结束年份 + 年份进/减位标记 - 开始年份
      
    if(y>=0)                 //如果大于等于0，则返回值为年份数*12 + 月份数，否则返回0
        months = y*12 + m;

    return months;
}

// 返回今天时间日期
function getToday() {
	var today = new Date();
	//alert(today.format('Y-m-d'));
	return today.format('Y-m-d');
	
//	var yesterday = getNextDay(0);
//	var tmpYear = yesterday.substring(6, 10);
//	var tmpMonth = yesterday.substring(0, 2);
//	var tmpDay = yesterday.substring(3, 5);
//	return tmpYear + "-" + tmpMonth + "-" + tmpDay;
}
//返回当天日期，格式如:2014-01-01
function getTodayDate(){	
	Date.prototype.format = function(format){
		var o = {
			"M+" : this.getMonth()+1, //month 
			"d+" : this.getDate(), //day 
			"h+" : this.getHours(), //hour 
			"m+" : this.getMinutes(), //minute 
			"s+" : this.getSeconds(), //second 
			"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
			"S" : this.getMilliseconds() //millisecond 
		};
		if(/(y+)/.test(format)) { 
			format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
		} 
		for(var k in o) { 
			if(new RegExp("("+ k +")").test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
			} 
		} 
		return format; 
	}; 
	var todayDate = new Date(); 
	var todayDateStr = todayDate.format("yyyy-MM-dd"); 
	return todayDateStr;
}
// 计算孕周
function getYWeek(beginDate, endDate) {
	var day = dateDiff(beginDate, endDate);
	var w = (day / 7).toString().split('.')[0];
	var d = day % 7;
	return [ w, d ];
}

//获得月龄

function getMonthAge(checkDate,birthday)
{
	//根据出生日期和检查日期计算月龄
	/*dayAge_=dateDiff(checkDate,birthday);
	var year=0;
	
	var months = parseInt(dayAge_/ 30);
	var day = parseInt(dayAge_ % 30);
	
	var str = "";
	if (months < 12) {
		str = months + "月";
	} else {
		var year = parseInt(months / 12);
		var mon = months % 12;
		str = year + "岁";
		if (mon > 0) {
			str += mon + "月";
		}
	}
	if (day > 0) {
		str += day + "天";
	}
	return str;*/
	var by,bm,bd;//出生的年月日
	by = parseInt(birthday.substr(0,4));
	bm = parseInt(birthday.substr(5,2));
	bd = parseInt(birthday.substr(8,2));
	 var date = new Date();
	//取到当前的年月日
	y = parseInt(checkDate.substr(0,4));//当前的年
	var m = parseInt(checkDate.substr(5,2));//当前的月份
	var d = parseInt(checkDate.substr(8,2));//当前的日
	if(by>y ||(by==y &&bm>m) || (by>=y && bm==m && bd>=d))
		{
		return "0月";
		}
	if(by <= y){
	if(y%4==0&&y%100!=0){//闰年
	if(bm<m){//出生的月份比现在的月份小
	cy = y-by;//总年数
	cm=m-bm;//总月数
	
	if(bd<=d){//出生日比当前的日小
	
	cd=d-bd;//总天数
	}else{
	var cd = bd;
	var lastbm = m;
	if (m==1)
		{
		lastbm = 12;
		}
	else
		{
		 lastbm--;
		}
	
	var sd = 0;
	switch(lastbm){//不同月份的天数不同
	case 1: sd=31;
	break;
	case 2: sd=29;
	break;
	case 3: sd=31;
	break;
	case 4: sd=30;
	break;
	case 5: sd=31;
	break;
	case 6: sd=30;
	break;
	case 7: sd=31;
	break;
	case 8: sd=31;
	break;
	case 9:  sd=30;
	break;
	case 10: sd=31;
	break;
	case 11:  sd=30;
	break;
	case 12: sd=31;
	break;
	}
	cd =sd-bd+d;//总的天数
	cm = cm-1;//总月数
	}
	}
	else
		{
		//出生的月份比现在的月份大
		cy = y-by-1;//总年数
		cm=12-bm+m;//总月数
		if(bd<=d){//出生日比当前的日小
		
		cd=d-bd;//总天数
		}else{
			var cd = bd;
			var lastbm = m;
			if (m==1)
				{
				lastbm = 12;
				}
			else
				{
				 lastbm--;
				}
			
			var sd = 0;
			switch(lastbm){//不同月份的天数不同
			case 1: sd=31;
			break;
			case 2: sd=29;
			break;
			case 3: sd=31;
			break;
			case 4: sd=30;
			break;
			case 5: sd=31;
			break;
			case 6: sd=30;
			break;
			case 7: sd=31;
			break;
			case 8: sd=31;
			break;
			case 9:  sd=30;
			break;
			case 10: sd=31;
			break;
			case 11:  sd=30;
			break;
			case 12: sd=31;
			break;
			}
			cd =sd-bd+d;//总的天数
			cm = cm-1;//总月数
			}
		if(cm==12)
	    {cm=0;
	     cy++;
	    }
		}
	}else{//不是闰年
	if(bm<m){//出生的月份比现在的月份小
	cy = y-by;//总年数
	cm=m-bm;//总月数

	if(bd<=d){//出生日比当前的日小

	cd=d-bd;//总天数
	}else{
		cy = y-by;//总年数
		var cd = bd;
		var lastbm = m;
		if (m==1)
			{
			lastbm = 12;
			}
		else
			{
			 lastbm--;
			}
		
		var sd = 0;
		switch(lastbm){//不同月份的天数不同
		case 1: sd=31;
		break;
		case 2: sd=29;
		break;
		case 3: sd=31;
		break;
		case 4: sd=30;
		break;
		case 5: sd=31;
		break;
		case 6: sd=30;
		break;
		case 7: sd=31;
		break;
		case 8: sd=31;
		break;
		case 9:  sd=30;
		break;
		case 10: sd=31;
		break;
		case 11:  sd=30;
		break;
		case 12: sd=31;
		break;
		}
		cd =sd-bd+d;//总的天数
		cm = cm-1;//总月数
		}
	}else{////出生的月份比现在的月份大
		cy = y-by-1;//总年数
		cm=12-bm+m;//总月数
		
		if(bd<=d){//出生日比当前的日小
		
		cd=d-bd;//总天数
		}else{
			var cd = bd;
			var lastbm = m;
			if (m==1)
				{
				lastbm = 12;
				}
			else
				{
				 lastbm--;
				}
			
			var sd = 0;
			switch(lastbm){//不同月份的天数不同
			case 1: sd=31;
			break;
			case 2: sd=29;
			break;
			case 3: sd=31;
			break;
			case 4: sd=30;
			break;
			case 5: sd=31;
			break;
			case 6: sd=30;
			break;
			case 7: sd=31;
			break;
			case 8: sd=31;
			break;
			case 9:  sd=30;
			break;
			case 10: sd=31;
			break;
			case 11:  sd=30;
			break;
			case 12: sd=31;
			break;
			}
			cd =sd-bd+d;//总的天数
			cm = cm-1;//总月数
			}
		if(cm==12)
	    {cm=0;
	     cy++;
	    }
	}
	}
	}
	var str = "";
	   if(cy>0)
		   {
		str = cy + "岁";
		   }
		if (cy>0&&cm > 0) {
			str += cm + "月";
		}
		else if(cy<=0 && cm>=0)
			{
			str+=cm + "月";
			}
	
	if (cd > 0) {
		str += cd + "天";
	}
	return str;
}