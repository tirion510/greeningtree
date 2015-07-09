package com.greeningtree.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.greeningtree.config.AppInitConstants;
import com.greeningtree.domain.common.AfAccount;




public class CookieUtils {
	public static void makeLoginCookie(AfAccount account, HttpServletResponse response){
		makeSimpleCookie("Af_accountId", account.getAccountId(), response);
		makeSimpleCookie("Af_username", account.getUsername(), response);
		makeSimpleCookie("Af_loginCookie", account.getLoginCookie(), response);
	}
	
	public static void removeLoginCookie(HttpServletResponse response){
		clearSimpleCookie("Af_accountId", response);
		clearSimpleCookie("Af_username", response);
		clearSimpleCookie("Af_loginCookie", response);
	}
	
	public static String getAccountId(){
		return getCookieValue("Af_accountId");
	}
	
	public static String getUsername(){
		return getCookieValue("Af_username");
	}
	
	public static String getLoginCookie(){
		return getCookieValue("Af_loginCookie");
	}
	
	public static String getCookieValue(String cookieName){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
		Cookie[] cookies = request.getCookies(); 
		if(cookies!=null){
			for(Cookie cookie:cookies){
				if(cookie.getName().equalsIgnoreCase(cookieName)){
					return JUtility.unescape(cookie.getValue());
				}
			}
		}
		return null;
	}
	
	public static void makeSimpleCookie(String key, String value, HttpServletResponse response){
		makeCookie(key, value, -1, response);
	}
	
	public static void makeCookie(String key, String value, int maxAge, HttpServletResponse response){
		Cookie cookie=new Cookie(key, JUtility.escape(value));
		cookie.setDomain(AppInitConstants.getCookieDomain());
		cookie.setPath("/");
		if(maxAge >= 0){
			cookie.setMaxAge(maxAge);
		}
		response.addCookie(cookie);
	}
	
	public static void clearSimpleCookie(String key, HttpServletResponse response){
		makeCookie(key, null, 0, response);
	}
}
