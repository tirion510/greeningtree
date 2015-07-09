package com.greeningtree.util;

import java.math.BigDecimal;
import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.http.HttpServletRequest;

public class JUtility {
	
	public boolean isNumber(Object value){
		if(value != null){
			return (String.valueOf(value)).matches("\\d+");
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public void processRequestAttribute(HttpServletRequest request, Map<String, Object> requestAttributeMap)
	{
		Iterator attributeIterator = requestAttributeMap.entrySet().iterator();
		while(attributeIterator.hasNext()){
			Entry entry = (Entry)attributeIterator.next();
			String key = (String)entry.getKey();
			if(entry.getKey() != null && entry.getValue() != null )
			{
				request.setAttribute(key, entry.getValue());
			}			
		}		
	}
	
	public  String upperCaseFistChar(String str) {
        if(str!=null && str!=""){
            str  = str.substring(0,1).toUpperCase()+str.substring(1);
        }
        return str;
    }
	
	public String hiddenInputHtml(String name, String id, Object value)
	{
		value = value == null ? "" : value;
		name = name == null ? "" : name;
		id = id == null ? "" : id;
		StringBuffer inputBuffer = new StringBuffer("<input type=\"hidden\" ");
		inputBuffer.append(" value=\"").append(value).append("\" ");
		if(!name.equals(""))
		{
			inputBuffer.append(" name=\"").append(name).append("\" ");
		}
		if(!id.equals(""))
		{
			inputBuffer.append(" id=\"").append(id).append("\" ");
		}
		inputBuffer.append(" />\n");		
		return inputBuffer.toString();
	}
	
	@SuppressWarnings("unchecked")
	public Map sortHashMapByValue( Map map)
    {
        Object[] keyArray = (Object[]) map.keySet().toArray();
        Object[] valueArray = (Object[]) map.values().toArray();
        int keyArrayLength = keyArray.length;
        String tmp = null;

        /*
         * Bubble sort 
         */
        for (int i = 0; i < keyArrayLength; i++)
        {
            
            for (int j = 0; j < keyArrayLength-i-1; j++)
            {
                int value1 = Integer.parseInt(String.valueOf(valueArray[j]));
                int value2 = Integer.parseInt(String.valueOf(valueArray[j+1]));
                
                if (value2 > value1)
                {
                    tmp = String.valueOf(valueArray[j+1]);
                    valueArray[j+1] = valueArray[j];
                    valueArray[j] = tmp;
                    tmp = String.valueOf(keyArray[j+1]);
                    keyArray[j+1] = keyArray[j];
                    keyArray[j] = tmp;
                }

            }
        }

        Map mapReturn = new LinkedHashMap();

        for (int i = 0; i < keyArrayLength; i++)
        {
            mapReturn.put(keyArray[i], valueArray[i]);
        }

        return mapReturn;
    } 
	
	
	public  String getMemoryUsage(){
		int kb = 1024;  
		Double percnet = 0.00;
		DecimalFormat df = new DecimalFormat("#0.00");   
        try {
        	long totalMemory = Runtime.getRuntime().totalMemory() / kb;  
	        long freeMemory = Runtime.getRuntime().freeMemory() / kb; 
	        long usedMemory=totalMemory-freeMemory;
		    percnet=(double)usedMemory/totalMemory;   	
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return df.format(percnet).toString();
	}
	
	public Double decimalFormat(Double f, int newScale)
	{
		BigDecimal bg = new BigDecimal(f);
        double f1 = bg.setScale(newScale, BigDecimal.ROUND_HALF_UP).doubleValue();
        return f1;
	}
	
	public static String escape(String src) {
		if(src == null){
			return null;
		}
        int i;  
        char j;  
        StringBuffer tmp = new StringBuffer();  
        tmp.ensureCapacity(src.length() * 6);  
        for (i = 0; i < src.length(); i++) {  
            j = src.charAt(i);  
            if (Character.isDigit(j) || Character.isLowerCase(j)  
                    || Character.isUpperCase(j))  
                tmp.append(j);  
            else if (j < 256) {  
                tmp.append("%");  
                if (j < 16)  
                    tmp.append("0");  
                tmp.append(Integer.toString(j, 16));  
            } else {  
                tmp.append("%u");  
                tmp.append(Integer.toString(j, 16));  
            }  
        }  
        return tmp.toString();  
    }  
	
	
	public static String unescape(String src) {  
        StringBuffer tmp = new StringBuffer();  
        tmp.ensureCapacity(src.length());  
        int lastPos = 0, pos = 0;  
        char ch;  
        while (lastPos < src.length()) {  
            pos = src.indexOf("%", lastPos);  
            if (pos == lastPos) {  
                if (src.charAt(pos + 1) == 'u') {  
                    ch = (char) Integer.parseInt(src  
                            .substring(pos + 2, pos + 6), 16);  
                    tmp.append(ch);  
                    lastPos = pos + 6;  
                } else {  
                    ch = (char) Integer.parseInt(src  
                            .substring(pos + 1, pos + 3), 16);  
                    tmp.append(ch);  
                    lastPos = pos + 3;  
                }  
            } else {  
                if (pos == -1) {  
                    tmp.append(src.substring(lastPos));  
                    lastPos = src.length();  
                } else {  
                    tmp.append(src.substring(lastPos, pos));  
                    lastPos = pos;  
                }  
            }  
        }  
        return tmp.toString();  
    }
	
	@SuppressWarnings("unchecked")
	public  List removeDuplicate(List list) {
		int size=list.size();
		for ( int i = 0 ; i <size- 1 ; i ++ ) {
			for ( int j = list.size() - 1 ; j > i; j -- ) {
				if (list.get(j).equals(list.get(i))) {
					list.remove(j);
				}
		    }
		}
		return list;
	}
	
	public boolean inArray(String date,List<String> dates){
		int length = dates.size();
		for(int i =0 ;i <length; i ++){
			if(dates.get(i).equals(date)){
				return true;
			}
		}
		return false;
		
	}
	
	public static String bytesToMD5(byte[] input) {
		String md5str = null;
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");		
			byte[] buff = md.digest(input);
			md5str = bytesToHex(buff);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return md5str;
	}
	
	public static String strToMD5(String str) {
		byte[] input = str.getBytes();
		return bytesToMD5(input);
	}
	
	public static String bytesToHex(byte[] bytes) {
		StringBuffer md5str = new StringBuffer();
		int digital;
		for (int i = 0; i < bytes.length; i++) {
			digital = bytes[i];
			if(digital < 0) {
				digital += 256;
			}
			if(digital < 16){
				md5str.append("0");
			}
			md5str.append(Integer.toHexString(digital));
		}
		return md5str.toString();
	}
	
	public static String getRandomNumber(int len){
		String text="";
		for(int i=0;i<len;i++){
			text+=Integer.toString((int)(Math.random()*9));
		}
		return text;
	}
	
	public static String getRemoteHost(HttpServletRequest request){
	    String ip = request.getHeader("x-forwarded-for");
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getRemoteAddr();
	    }
	    return ip.equals("0:0:0:0:0:0:0:1")?"127.0.0.1":ip;
	}
}
