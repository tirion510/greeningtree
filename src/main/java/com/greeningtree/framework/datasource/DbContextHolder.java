package com.greeningtree.framework.datasource;

public class DbContextHolder {

	private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();   
	  
    public static void setDbKey(String dbKey) {   
        contextHolder.set(dbKey);   
    }   
  
    public static String getDbKey() {   
        return (String) contextHolder.get();   
    }   
  
    public static void clearDbKey() {   
        contextHolder.remove();  
    }  
}
