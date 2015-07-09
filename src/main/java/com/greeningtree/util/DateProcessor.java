package com.greeningtree.util;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.TimeZone;

public class DateProcessor {

	private static String weekEndDay = "Fri;Sat;Sun";
	private static String utc = "America/New_York";

	public static String addByTransDate(String filterDate, int num)
			throws ParseException {
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		TimeZone zone = TimeZone.getTimeZone(utc);
		dd.setTimeZone(zone);
		date = dd.parse(filterDate);
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		String sdate = format1.format(new Date(date.getTime()
				+ (long) (num * 24 * 60 * 60 * 1000 + 5 * 60 * 60 * 1000)));
		return sdate;
	}

	public static String reduceByTransDate(String filterDate, int num)
			throws ParseException {
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		TimeZone zone = TimeZone.getTimeZone(utc);
		dd.setTimeZone(zone);
		date = dd.parse(filterDate);
		String sdate = dd.format(new Date(date.getTime() - num * 24 * 60 * 60
				* 1000));
		return sdate.toString();
	}

	public static String getWeekDayName(String strDate) {
		String mName[] = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
		int iWeek = getWeekDay(strDate);
		iWeek = iWeek - 1;
		return mName[iWeek];
	}

	public static String getMonthName(String strDate) {
		String mName[] = { "Jan", "Feb", "Mar", "Apr", "May ", "Jun", "Jul",
				"Aug", "Sept", "Oct", "Nov", "Dec " };
		int mm = Integer.parseInt(strDate.substring(5, 7)) - 1;
		return mName[mm];
	}

	public static int getWeekDay(String strDate) {
		Calendar cal = parseDateTime(strDate);
		return cal.get(Calendar.DAY_OF_WEEK);
	}

	public static Calendar parseDateTime(String baseDate) {
		Calendar cal = null;
		cal = new GregorianCalendar();
		int yy = Integer.parseInt(baseDate.substring(0, 4));
		int mm = Integer.parseInt(baseDate.substring(5, 7)) - 1;
		int dd = Integer.parseInt(baseDate.substring(8, 10));
		int hh = 0;
		int mi = 0;
		int ss = 0;
		if (baseDate.length() > 12) {
			hh = Integer.parseInt(baseDate.substring(11, 13));
			mi = Integer.parseInt(baseDate.substring(14, 16));
			ss = Integer.parseInt(baseDate.substring(17, 19));
		}
		cal.set(yy, mm, dd, hh, mi, ss);
		return cal;
	}

	public static int getDay(String strDate) {
		Calendar cal = parseDateTime(strDate);
		return cal.get(Calendar.DATE);
	}
	
	public static String[] getNextMontDaysRange() {
		String strDate = currentTime();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = parseDateTime(strDate);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)+1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String startDate = df.format(cal.getTime());
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)+1);
		cal.set(Calendar.DAY_OF_MONTH, 0);
		String endDate = df.format(cal.getTime());
		String[] rangeDate = new String[2];
		rangeDate[0] = startDate;
		rangeDate[1] = endDate;
		return rangeDate;
	}
	
	public static String[] getThisMontDaysRange() {	
		String strDate = currentTime();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = parseDateTime(strDate);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)+1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String endDate = df.format(cal.getTime());
		try {
			endDate = reduceByTransDate(endDate, 1);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String[] rangeDate = new String[2];
		rangeDate[0] = strDate;
		rangeDate[1] = endDate;
		return rangeDate;
	}
	
	public static String[] getNextWeekDaysRange()
	{		
		String[] dates = getCurrentWeekDaysRange();
		String startDate = dates[1];
		try {
			startDate = addByTransDate(startDate, 1);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String endDate = "";
		try {
			endDate = addByTransDate(startDate, 6);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String[] rangeDate = new String[2];
		rangeDate[0] = startDate;
		rangeDate[1] = endDate;
		return rangeDate;
	}
	
	public static String[] getCurrentWeekDaysRange()
	{
		String strDate = currentTime();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String[] rangeDate = new String[2];
		int iWeek = getWeekDay(strDate);
		iWeek = iWeek - 1;
		rangeDate[0] = strDate;
		String endDate = "";
		if(iWeek == 0)
		{
			endDate = strDate;
		}
		else
		{
			int d_iWeek = 7 - iWeek;
			try {
				endDate = addByTransDate(strDate, d_iWeek);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		rangeDate[1] = endDate;
		return rangeDate;
	}

	public static int compareToCurrentTime(String date) throws ParseException {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		TimeZone zone = TimeZone.getTimeZone(utc);
		df.setTimeZone(zone);
		String currentTime = currentTime();
		Date dt = df.parse(date.toString());
		Date ct = df.parse(currentTime.toString());
		return dt.compareTo(ct);
	}

	public static String currentTime() {
		Date dateNow = new Date();		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		TimeZone zone = TimeZone.getTimeZone(utc);
		dateFormat.setTimeZone(zone);
		String dateNowStr = dateFormat.format(dateNow).toString();
		return dateNowStr.toString();
	}

	public static String tomrrowTime() throws ParseException {
		String current_time = currentTime();
		String t_time = addByTransDate(current_time, 1);
		return t_time;
	}
	
	public static String yestodayTime() throws ParseException {
		String current_time = currentTime();
		String t_time = addByTransDate(current_time, -1);
		return t_time;
	}

	public static String getDateStringAfterHours(int hours) throws ParseException {
		TimeZone zone = TimeZone.getTimeZone(utc);
		Date dateNow = new Date();
		try {
			SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dd.setTimeZone(zone);
			String dateNowStr = dd.format(dateNow).toString();
			Date date;
			date = dd.parse(dateNowStr);
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			df.setTimeZone(zone);
			String sdate = df.format(new Date(date.getTime() + hours * 60 * 60
					* 1000));
			return sdate.toString();
		} catch (Exception e) {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			df.setTimeZone(zone);
			String sdate = df.format(dateNow);
			return sdate.toString();
		}
	}

	public static int compareTime(String date, String date_2) throws ParseException {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		TimeZone zone = TimeZone.getTimeZone(utc);
		df.setTimeZone(zone);
		Date dt = df.parse(date.toString());
		Date ct = df.parse(date_2.toString());
		return dt.compareTo(ct);
	}

	public static String getFilterDate(String date) throws ParseException {
		if (date.indexOf("today") >= 0 || date == null || date.equals("")) {
			return currentTime();
		} else if (date.indexOf("tomorrow") >= 0) {
			return tomrrowTime();
		} else if (date.indexOf("next") >= 0) {
			try {
				String string_hours = date.replace("next", "");
				int hours = Integer.parseInt(string_hours);
				return getDateStringAfterHours(hours);
			} catch (Exception e) {
				return currentTime();
			}
		}
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date dt = df.parse(date);
			String sdate = df.format(dt);
			return sdate.toString();

		} catch (ParseException e) {
			return currentTime();
		}
	}

	public static String isDepartWeekEnd(String depart_date) {
		if (depart_date == null || depart_date.equals("") || depart_date == "") {
			return "0";
		} else {
			String weekday = getWeekDayName(depart_date);
			if (weekEndDay.indexOf(weekday) >= 0) {
				return "1";
			} else {
				return "0";
			}
		}
	}

	public static String isReturnWeekEnd(String return_date) {
		if (return_date == null || return_date.equals("") || return_date == "") {
			return "0";
		} else {
			String weekday = getWeekDayName(return_date);
			if (weekEndDay.indexOf(weekday) >= 0) {
				return "1";
			} else {
				return "0";
			}
		}
	}

	public static Double getTime() {
		try {
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			int hour = cal.get(Calendar.HOUR);
			int minute = cal.get(Calendar.MINUTE);
			double t_hour = hour;
			double t_minute = minute;
			Double time = t_minute / 60 + t_hour;
			BigDecimal des = new BigDecimal(time);
			des = des.setScale(4, BigDecimal.ROUND_HALF_EVEN);
			time = des.doubleValue();
			return time;
		} catch (Exception e) {
			return 0.00;
		}
	}

	public static Date getCurrentDate() {
		String fromFormat = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat format = new SimpleDateFormat(fromFormat);
		SimpleDateFormat format1 = new SimpleDateFormat(fromFormat);
		Date myDate = new Date();
		TimeZone zone = TimeZone.getTimeZone(utc);
		format.setTimeZone(zone);
		String dateString = format.format(myDate);
		try {
			return format1.parse(dateString);
		} catch (ParseException e) {
			return new Date();
		}
	}

	public static String getDateString(String baseDate) {
		if (baseDate != null && !baseDate.equals("")) {
			try {
				String wek = getWeekDayName(baseDate);
				String monthString = getMonthName(baseDate);
				int day = getDay(baseDate);
				StringBuffer builder = new StringBuffer();
				builder.append(wek);
				builder.append(", ");
				builder.append(monthString);
				builder.append(" ");
				builder.append(day);
				return builder.toString();

			} catch (Exception e) {
				return "";
			}

		}
		return "";
	}

	private static final Calendar calendar = Calendar.getInstance();

	public static Date modify(Date date, int field, int interval) {
		if (date != null) {
			calendar.setTime(date);
		} else {
			calendar.setTime(new Date());
		}
		calendar.add(field, interval);
		return calendar.getTime();
	}

	public static List<Date> getDuration(Date start, Date end, int field,
			int interval, boolean closure) {
		List<Date> list = new ArrayList<Date>();
		if (start != null && end != null && start.before(end)) {
			Date date = start;
			if (closure) {
				do {
					list.add(date);
					date = modify(date, field, interval);
				} while (!date.after(end));
			} else {
				do {
					date = modify(date, field, interval);
					list.add(date);
				} while (date.before(end));
			}
		}
		return list;
	}

	public static int[] getDateSplit(String strDate) {

		String[] str = strDate.split("-");
		if (str.length > 0) {
			String year = str[0];
			String month = str[1];
			String day = str[2];
			int i_year = Integer.parseInt(year);
			int i_month = Integer.parseInt(month);
			int i_day = Integer.parseInt(day);
			int[] i_array = { i_year, i_month, i_day };
			return i_array;
		}
		return new int[3];

	}
	
	public static int getNights(String startDate, String endDate) {
		String[] startStrings = startDate.split(" ");
		String[] endStrings = endDate.split(" ");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		int field = Calendar.DATE; 
		int interval = 1; 
		boolean closure = true;
		Date start = null;
		try {
			start = dateFormat.parse(startStrings[0]);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date end = null;
		try {
			end = dateFormat.parse(endStrings[0]);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List list = getDuration(start, end, field,interval, closure);
		if(list != null)
		{
			return list.size()-1;
		}
		return 1;
	}

	public static List<String> getDatesBetweenTwoDays(String startDay,String endDay) throws ParseException{
		List<String> datesList=new ArrayList<String>();
		
		 Date dateTemp = new SimpleDateFormat("yyyy-MM-dd").parse(startDay);
	     Date dateTemp2 = new SimpleDateFormat("yyyy-MM-dd").parse(startDay);
	     Calendar calendarTemp = Calendar.getInstance();
         calendarTemp.setTime(dateTemp);
         while (calendarTemp.getTime().getTime()!= dateTemp2.getTime()) {
        	 datesList.add(new SimpleDateFormat("yyyy-MM-dd").format(calendarTemp.getTime()));
             calendarTemp.add(Calendar.DAY_OF_YEAR, 1);
         }
		return datesList;
	}
	
	public static String currentTimeStamp() {
		Date dateNow = new Date();		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		TimeZone zone = TimeZone.getTimeZone(utc);
		dateFormat.setTimeZone(zone);
		String dateNowStr = dateFormat.format(dateNow).toString();
		return dateNowStr.toString();
	}
	
	public static int getYear()
	{
		Date d = getCurrentDate();
		GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();  
		gc.setTime(d);  
		int year = gc.get(Calendar.YEAR); 
		return year;
	}
	
	
	
}
