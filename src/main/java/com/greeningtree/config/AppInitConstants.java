package com.greeningtree.config;

import java.util.HashMap;

public class AppInitConstants {

	/**
	 * System configuration JVars Map - Start loading
	 */
	public static String language = DBConfig.getLanguage(); 
	public static HashMap<String,String> CONFIG_MAP = new HashMap<String,String>();
	public static HashMap<String, String> CODE_CN_MAP = new HashMap<String, String>();
	public static HashMap<String, String> ERROR_CODE_MAP = new HashMap<String, String>();
	
	public static String DBEncoding(){
		return getPropertiesValue("DBEncoding");
	}
	
	public static String getLanguage(){
		return DBConfig.language;
	}
	
	public static String getEncoding() {
		return "gbk";
	}

	public static String getPropertiesValue(String key) {
		return CONFIG_MAP.get(key);
	}
	
	public static String getI18nValue(String key) {//internationalization by key
		if(CODE_CN_MAP.containsKey(key)){
			return CODE_CN_MAP.get(key);
		}else{
			return key;
		}
	}

	public static String ico(){
		return getPropertiesValue("ico");
	}
	
	public static String getCookieDomain() {
		return getPropertiesValue("cookieDomain");
	}

	public static Object getJsVersion() {
		return getPropertiesValue("jsVersion");
	}

	public static Object website_filter_key() {
		return DBConfig.website_filter_key;
	}
	
	public static boolean errorCodeExist(String errorCodeId){
		return ERROR_CODE_MAP.containsKey(errorCodeId);
	}
}
