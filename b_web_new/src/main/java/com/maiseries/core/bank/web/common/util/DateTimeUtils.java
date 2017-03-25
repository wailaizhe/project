package com.maiseries.core.bank.web.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateTimeUtils {
	private static StringBuffer buffer = new StringBuffer();
	private static String ZERO = "0";
	public static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat format2 = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	private static Logger log = LoggerFactory.getLogger(DateTimeUtils.class);

	/**
	 * 得到指定日期的一天的的最后时刻23:59:59
	 * 
	 * @param date
	 * @return
	 */
	public static void main(String[] args) {
		Date date=getCurrentDateTime();
		System.out.println(timeToString2(date));
	}
	public static Date getFinallyDate(Date date) {
		String temp = format1.format(date);
		temp += " 23:59:59";
		try {
			return format1.parse(temp);
		} catch (ParseException e) {
			return null;
		}
	}
	public static Date getCurrentDateTime() {
		String temp = format2.format(new Date());
		try {
			return format2.parse(temp);
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 得到指定日期的一天的开始时刻00:00:00
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartDate(Date date) {
		String temp = format1.format(date);
		temp += " 00:00:00";
		try {
			return format1.parse(temp);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 获取date周后的第amount周的最后时间（这里星期日为一周的最后一天）
	 * 
	 * @param amount
	 *            可正、可负
	 * @return
	 */
	public static Date getSpecficWeekEnd(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 设置一周的第一天为星期一 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		return getFinallyDate(cal.getTime());
	}

	public static Date getSpecficDateStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DAY_OF_YEAR, amount);
		return getStartDate(cal.getTime());
	}

	public static String getSpecficDateStart2(Date date, int amount) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_YEAR, amount);
		buffer.delete(0, buffer.capacity());
		buffer.append(getYear(calendar) + "-");

		if (getMonth(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getMonth(calendar) + "-");

		if (getDate(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getDate(calendar));
		return buffer.toString();
	}

	/**
	 * 获取date年后的amount年的第一天的开始时间
	 * 
	 * @param amount可正
	 *            、可负
	 * @return
	 */
	public static Date getSpecficYearStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.YEAR, amount);
		cal.set(Calendar.DAY_OF_YEAR, 1);
		return getStartDate(cal.getTime());
	}

	/**
	 * 获取date年后的amount年的最后一天的终止时间
	 * 
	 * @param amount可正
	 *            、可负
	 * @return
	 */
	public static Date getSpecficYearEnd(Date date, int amount) {
		Date temp = getStartDate(getSpecficYearStart(date, amount + 1));
		Calendar cal = Calendar.getInstance();
		cal.setTime(temp);
		cal.add(Calendar.DAY_OF_YEAR, -1);
		return getFinallyDate(cal.getTime());
	}

	/**
	 * 获取date月后的amount月的第一天的开始时间
	 * 
	 * @param amount可正
	 *            、可负
	 * @return
	 */
	public static Date getSpecficMonthStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, amount);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		return getStartDate(cal.getTime());
	}

	/**
	 * 获取当前自然月后的amount月的最后一天的终止时间
	 * 
	 * @param amount可正
	 *            、可负
	 * @return
	 */
	public static Date getSpecficMonthEnd(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getSpecficMonthStart(date, amount + 1));
		cal.add(Calendar.DAY_OF_YEAR, -1);
		return getFinallyDate(cal.getTime());
	}

	/**
	 * 获取date周后的第amount周的开始时间（这里星期一为一周的开始）
	 * 
	 * @param amount可正
	 *            、可负
	 * @return
	 */
	public static Date getSpecficWeekStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 设置一周的第一天为星期一 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		return getStartDate(cal.getTime());
	}

	public static int getYearsBetweenDate(Date begin, Date end) {
		int bYear = getDateField(begin, Calendar.YEAR);
		int eYear = getDateField(end, Calendar.YEAR);
		return eYear - bYear;
	}

	public static int getMonthsBetweenDate(Date begin, Date end) {
		int bMonth = getDateField(begin, Calendar.MONTH);
		int eMonth = getDateField(end, Calendar.MONTH);
		return eMonth - bMonth;
	}

	public static int getWeeksBetweenDate(Date begin, Date end) {
		int bWeek = getDateField(begin, Calendar.WEEK_OF_YEAR);
		int eWeek = getDateField(end, Calendar.WEEK_OF_YEAR);
		return eWeek - bWeek;
	}

	public static int getDaysBetweenDate(Date begin, Date end) {
		int bDay = getDateField(begin, Calendar.DAY_OF_YEAR);
		int eDay = getDateField(end, Calendar.DAY_OF_YEAR);
		return eDay - bDay;
	}

	public static String getNowTimeString() {
		Calendar calendar = getCalendar();
		buffer.delete(0, buffer.capacity());
		buffer.append(getYear(calendar) + "-");

		if (getMonth(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getMonth(calendar) + "-");

		if (getDate(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getDate(calendar) + " ");
		if (getHour(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getHour(calendar) + ":");
		if (getMinute(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getMinute(calendar) + ":");
		if (getSecond(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getSecond(calendar));
		return buffer.toString();
	}

	public static String getNowDateString() {
		Calendar calendar = getCalendar();
		buffer.delete(0, buffer.capacity());
		buffer.append(getYear(calendar) + "-");

		if (getMonth(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getMonth(calendar) + "-");

		if (getDate(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getDate(calendar));
		return buffer.toString();
	}

	public static String timeToString(Date date) {
		if (date != null) {
			return format1.format(date).toString();
		} else {
			return "";
		}
	}

	public static String timeToString2(Date date) {
		if (date != null) {
			return format2.format(date).toString();
		} else {
			return "";
		}
	}

	/**
	 * 
	 * 方法说明：返回最近的检查时间
	 *
	 * @param lastCheckTime
	 * @param curCheckTime
	 * @return
	 */
	public static String getLastDate(String lastCheckTime, String curCheckTime) {
		if (lastCheckTime == null) {
			lastCheckTime = curCheckTime;
		} else {
			lastCheckTime = lastCheckTime.compareTo(curCheckTime) > 0 ? lastCheckTime
					: curCheckTime;
		}
		return lastCheckTime;
	}

	public static Date parseDate(String date) {
		try {
			return format1.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return new Date();
		}
	}

	public static Date parseDate2(String date) {
		try {
			return format2.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return new Date();
		}
	}

	public static String formatDate(String date, String format) {
		try {
			if (date != null) {
				SimpleDateFormat f = new SimpleDateFormat(format);
				return f.format(f.parse(date));
			} else {
				return date;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return date;
		}
	}

	/**
	 * 两个时间段的天数
	 */
	public static long getDays(String begin, String end) {
		long t = 0;
		try {
			Date dt1 = format1.parse(begin);
			Date dt0 = format1.parse(end);
			if (dt0.getTime() >= dt1.getTime()) {
				long l = dt0.getTime() - dt1.getTime();
				t = l / (3600 * 24 * 1000);
			}
			t = t + 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return t;
	}

	public static long getDays(Date begin, Date end) {
		long t = 0;
		try {
			long d0 = end.getTime();
			long d1 = begin.getTime();
			if (d0 >= d1) {
				long l = d0 - d1;
				t = l / (3600 * 24 * 1000);
			}
			t = t + 1;
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return t;
	}

	public static long getDays(String begin) {
		long t = 0;
		Date d = new Date();
		try {
			if (begin != null) {
				Date dt1 = format1.parse(begin);
				long l = d.getTime() - dt1.getTime();
				t = l / (3600 * 1000 * 24);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return t;
	}

	public static long getDays(Date begin) {
		long t = 0;
		Date d = new Date();
		try {
			long l = d.getTime() - begin.getTime();
			t = l / (3600 * 1000 * 24);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return t;
	}

	/**
	 * 获取月龄
	 * 
	 * @param birth
	 * @return
	 */
	public static int getMonths(Date birth) {
		int y = 0;
		Date d = new Date();
		try {
			y = getDiffMonth(birth, d);
			Calendar cal = Calendar.getInstance();
			cal.setTime(d);
			int dayOfMonthDate = cal.get(Calendar.DAY_OF_MONTH);
			cal.setTime(birth);
			int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
			if (dayOfMonthBirth > dayOfMonthDate) {
				y--;
			}

		} catch (Exception e) {
			log.error(e.getMessage());

		}
		return y;
	}

	public static int getMonths(String birth) {
		int y = 0;
		Date d = new Date();
		try {
			Date dt1 = format1.parse(birth);
			Date dt0 = format1.parse(format1.format(d));
			// long l = d.getTime() - dt1.getTime();
			// long t = l / (3600 * 24 * 1000);
			y = getDiffMonth(dt1, dt0);
			Calendar cal = Calendar.getInstance();
			cal.setTime(d);

			int dayOfMonthDate = cal.get(Calendar.DAY_OF_MONTH);
			cal.setTime(dt1);
			int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
			if (dayOfMonthBirth > dayOfMonthDate) {
				y--;
			}

		} catch (Exception e) {
			log.error(e.getMessage());

		}
		return y;
	}

	public static int getMonths(String birth, String date) {
		int y = 0;
		try {
			Date dt1 = format1.parse(birth);
			Date dt0 = format1.parse(date);
			if (dt0.getTime() >= dt1.getTime()) {
				/*
				 * long l = dt0.getTime() - dt1.getTime(); long t = l / (3600 *
				 * 24 * 1000);
				 */
				y = getDiffMonth(dt1, dt0);

			}
			Calendar cal = Calendar.getInstance();
			cal.setTime(dt0);

			int dayOfMonthDate = cal.get(Calendar.DAY_OF_MONTH);
			cal.setTime(dt1);
			int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
			if (dayOfMonthBirth > dayOfMonthDate) {
				y--;
			}
		} catch (Exception e) {
			log.error(e.getMessage());

		}
		return y;

	}

	/*
	 * public static int getMonths(Date begin, Date end) { int y = 0; try { if
	 * (end.getTime() >= begin.getTime()) { long l = end.getTime() -
	 * begin.getTime(); long t = l / (3600 * 24 * 1000); y = (int) (t / 30); } }
	 * catch (Exception e) { e.printStackTrace(); } return y; }
	 */
	public static int getDiffMonth(Date beginDate, Date endDate) {
		Calendar calbegin = Calendar.getInstance();
		Calendar calend = Calendar.getInstance();
		calbegin.setTime(beginDate);
		calend.setTime(endDate);
		int m_begin = calbegin.get(Calendar.MONTH) + 1;
		int m_end = calend.get(Calendar.MONTH) + 1;

		int checkmonth = m_end - m_begin
				+ (calend.get(Calendar.YEAR) - calbegin.get(Calendar.YEAR))
				* 12;

		return checkmonth;
	}

	// 计算年龄
	/*@SuppressWarnings({ "rawtypes" })
	public static Map getNowAge(String birth, String date) {
		try {
			Date birthday = null;
			Date nowDate = null;
			if (null != birth && birth.length() > 0) {
				birthday = DateUtils.parseDate(birth,
						new String[] { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"  });
			}
			if (null != date && birth.length() > 0) {
				nowDate = DateUtils.parseDate(date, new String[] {
						"yyyy-MM-dd", "yyyy-MM-dd HH:mm" });
			}
			return getNowAge(birthday, nowDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			return null;
		}
	}*/

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Map<String, Object> getNowAge(Date birth, Date date) {
		int day = 0, month = 0, year = 0;long days = 0;
		String str = "";

		if (null != birth) {
			Calendar birthday = Calendar.getInstance();
			birthday.setTime(birth);
			Calendar now = Calendar.getInstance();
			if (null != date) {
				now.setTime(date);
			}
			// 忽略时分秒
			birthday.set(Calendar.HOUR_OF_DAY, 0);
			birthday.set(Calendar.MINUTE, 0);
			birthday.set(Calendar.SECOND, 0);
			now.set(Calendar.HOUR_OF_DAY, 0);
			now.set(Calendar.MINUTE, 0);
			now.set(Calendar.SECOND, 0);
			if (now.compareTo(birthday) < 0) {
				// 避免数据库中错误数据影响查询的情况，有些儿童体检时间比出生时间还小
				now.setTime(new Date());
				// throw new IllegalArgumentException("报错了，出生日期大于当前日期!");
			}
			day = now.get(Calendar.DAY_OF_MONTH)
					- birthday.get(Calendar.DAY_OF_MONTH);
			month = now.get(Calendar.MONTH) - birthday.get(Calendar.MONTH);
			year = now.get(Calendar.YEAR) - birthday.get(Calendar.YEAR);
			// 按照减法原理，先day相减，不够向month借；然后month相减，不够向year借；最后year相减。
			if (day < 0) {
				month -= 1;
				// birth 距离多少天月底 + date 天数
				day = birthday.getActualMaximum(Calendar.DAY_OF_MONTH) + day;
			}
			if (month < 0) {
				month = (month + 12) % 12;
				year--;
			}
			if (year > 0) {
				str += year + "岁";
			}
			if (month > 0) {
				str += month + "月";
			}
			str += day + "天";

			long sec1 = now.getTimeInMillis();
			long sec2 = birthday.getTimeInMillis();
			days = Long.parseLong(Long.toString((sec1 - sec2) / 1000 / 60
					/ 60 / 24));

		}

		Map m = new HashMap();
		m.put("currentAge", str);
		m.put("monthAge", month + 12 * year);
		m.put("yearAge", year);
		m.put("dayAge", days);

		int totalMonth = 0;
		totalMonth=year*12+month;
		m.put("totalMonthAge", totalMonth);//用于新增体格检查使用
		int totalDay = 0;
		totalDay =totalMonth*30+day;
		m.put("totalDayAge", totalDay);//用于新增体格检查使用
		return m;

	}

	public static int getDayOfWeek() {
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.DAY_OF_WEEK);
	}

	public static int getDayOfMonth() {
		Calendar cal = Calendar.getInstance();
		int end = cal.get(Calendar.DAY_OF_MONTH);
		return end - 1;
	}

	public static int getDayOfMonth(int amount) {
		Calendar cal = Calendar.getInstance();
		Date begin = cal.getTime();
		cal.add(Calendar.MONTH, amount);
		Date end = cal.getTime();
		long l = begin.getTime() - end.getTime();
		int t = (int) (l / (3600 * 24 * 1000));
		return t;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map getWeek(String d) {
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTime(format1.parse(d));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		int day = cal.get(Calendar.DAY_OF_WEEK);
		String[] weekday = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
		String isZm = "";
		if (day == 1 || day == 7) {
			isZm = "1";
		} else {
			isZm = "0";
		}
		Map result = new HashMap();
		result.put("isZm", isZm);
		result.put("week", weekday[day - 1]);
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map getWeekDay(String begin, String end) {
		long days = getDays(begin, end);
		int week = (int) (days / 7);
		int day = (int) (days % 7);
		Map result = new HashMap();
		result.put("week", week);
		result.put("day", day);
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map getWeekDay(Date begin, Date end) {
		long days = getDays(begin, end);
		int week = (int) (days / 7);
		int day = (int) (days % 7);
		Map result = new HashMap();
		result.put("week", week);
		result.put("day", day);
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map getWeekDay(Date begin) {
		long days = getDays(begin);
		int week = (int) (days / 7);
		int day = (int) (days % 7);
		Map result = new HashMap();
		result.put("week", week);
		result.put("day", day);
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map getWeekDay(String begin) {
		long days = getDays(begin);
		int week = (int) (days / 7);
		int day = (int) (days % 7);
		Map result = new HashMap();
		result.put("week", week);
		result.put("day", day);
		return result;
	}

	/*
	 * 获取n天后的日期
	 */
	public static String getDateAfterDays(String date, int n) {
		Calendar c = Calendar.getInstance();
		try {
			c.setTime(format1.parse(date));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		c.add(Calendar.DATE, n);
		return format1.format(c.getTime());
	}

	private static int getYear(Calendar calendar) {
		return calendar.get(Calendar.YEAR);
	}

	private static int getMonth(Calendar calendar) {
		return calendar.get(Calendar.MONTH) + 1;
	}

	private static int getDate(Calendar calendar) {
		return calendar.get(Calendar.DATE);
	}

	private static int getHour(Calendar calendar) {
		return calendar.get(Calendar.HOUR_OF_DAY);
	}

	private static int getMinute(Calendar calendar) {
		return calendar.get(Calendar.MINUTE);
	}

	private static int getSecond(Calendar calendar) {
		return calendar.get(Calendar.SECOND);
	}

	private static Calendar getCalendar() {
		return Calendar.getInstance();
	}

	private static int getDateField(Date date, int field) {
		Calendar c = getCalendar();
		c.setTime(date);
		return c.get(field);
	}

	/**
	 * 获得系统日期(年/月/日) 参数 ： 无 返回值： 格式日期：年/月/日
	 **/
	public static String getToday() {
		String strReturn = "";
		int intYear = Calendar.getInstance().get(Calendar.YEAR);
		int intMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
		int intDate = Calendar.getInstance().get(Calendar.DATE);
		strReturn = "" + intYear;

		if (intMonth < 10)
			strReturn += "-" + "0" + intMonth;
		else
			strReturn += "-" + intMonth;

		if (intDate < 10)
			strReturn += "-" + "0" + intDate;
		else
			strReturn += "-" + intDate;
		return strReturn;
	}

	// 获取当前日期
	public static Date getNowDate() {
		Calendar calendar = getCalendar();
		return calendar.getTime();
	}

	/**
	 * 获得系统时间(yyyy-MM-dd HH:mm:ss)
	 **/
	public static String getNowTime() {
		return format2.format(new Date());
	}

	/**
	 * 获得系统日期(yyyy-MM-dd)
	 * 
	 * @return
	 */
	public static String getTodayStr() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		return dateFormat.format(new Date());
	}

	public static String getTodayStr(String format) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		return dateFormat.format(new Date());
	}

	/**
	 * 判断一个日期是否在两个日期之间 包括当前日期。
	 * 
	 * @param beginDate
	 * @param endDate
	 * @param middleDate
	 * @return
	 */
	public static boolean innerData(String beginDate, String endDate,
			String middleDate) {
		boolean flag = false;
		if (middleDate.equals(beginDate) || middleDate.equals(endDate)) {
			flag = true;
		}
		try {
			Date bdate = format1.parse(beginDate);
			Date edate = format1.parse(endDate);
			Date mdate = format1.parse(middleDate);
			if (bdate.before(mdate) && edate.after(mdate)) {
				flag = true;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return flag;
	}

	public static String getDateBeforYear(Date datas, int n) {
		String sdatas = DateTimeUtils.format1.format(datas);
		String[] dss = sdatas.split("-");
		int year = Integer.parseInt(dss[0]);
		return (year - n) + "-" + dss[1] + "-" + dss[2];
	}

	/**
	 * 当日期格式为“2011-09-10 20:09:19”时用此方法（用第一个日期减去第二个） 返回毫秒
	 * 
	 * @param one
	 * @param two
	 * @return2011/09/10
	 */
	public static long diffDays(Date end, Date begin) {
		long between = 0;
		try {
			between = (end.getTime() - begin.getTime());// 得到两者的毫秒数
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return between;
	}

	public static String appendEndTimeOfDate(String date) {
		if (date != null && !date.isEmpty()) {
			if (date.length() >= 10) {

				return date = date.substring(0, 10) + " 23:59:59";
			}
		}
		return "";
	}

//	public static void main(String[] args) {
//		System.out.println(DateTimeUtils.getCurrentDateTime());
//	}
}
