package com.greeningtree.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils {
	public static boolean isNumber(Object value){
		if(value != null){
			return (String.valueOf(value)).matches("\\d+");
		}
		return false;
	}
	
	public static boolean checkEmpty(String str){
		if(str != null && !str.trim().equals("")){
			return true;
		}
		return false;
	}
	
	public static boolean checkPassword(String password){
		if(checkEmpty(password)){
			String regex = "(?=.*\\d)(?=.*[a-zA-Z]).{6,32}";
			return checkRegex(password, regex);
		}
		return false;
	}
	
	public static boolean checkIp(String ip){
		if(checkEmpty(ip)){
			String regex = "\\b((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\b";
			return checkRegex(ip, regex);
		}
		return false;
	}
	
	public static boolean checkDatetime(String datetime){
		if(checkEmpty(datetime)){
			String regex = 	"^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$";
			return checkRegex(datetime, regex);
		}
		return false;
	}
	
	
	public static boolean checkEmail(String email){
		if(checkEmpty(email)){
			String regex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
			return checkRegex(email, regex);
		}
		return false;
	}
	
	public static boolean checkMobile(String mobile){
		if(checkEmpty(mobile)){
			String regex = "^((13[0-9])|(14[5,7])|(15[^4,\\D])|(18[0-9])|(17[0,6-8]))\\d{8}$";
			return checkRegex(mobile, regex);
		}
		return false;
	}
	
	public static boolean checkRegex(String str,String regex){
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}
	
	public static boolean checkUsername(String username){
		if(checkEmpty(username)){
			String regex = "^[A-Za-z0-9]{3,}$";
			return checkRegex(username, regex);
		}
		return false;
	}
}
