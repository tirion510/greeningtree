package com.greeningtree.util;

import com.greeningtree.domain.common.AfAccount;
import com.opensymphony.oscache.base.NeedsRefreshException;

public class CacheManager {                

    private static CacheManager instance;    

    private static Object lock = new Object();     
    
    private BaseCache cacheAccount;
    private BaseCache cacheAccountLoginCookie;
    
    
    private CacheManager() {    
    	cacheAccount=new BaseCache("ca",-1);
    	cacheAccountLoginCookie=new BaseCache("clc",-1);
    }            

    public static CacheManager getInstance(){    
        if (instance == null){    
            synchronized( lock ){    
                if (instance == null){    
                    instance = new CacheManager();    
                }    
            }    
        }    
        return instance;    
    }   
    
    public void putAccountCache(String accountId, AfAccount account){
    	cacheAccount.put(accountId, account);
    }
    
    public void putAccountLoginCookieCache(String loginCookie, String accountId){
    	cacheAccountLoginCookie.put(loginCookie, accountId);
    }
    
    public AfAccount getAccountCache(String accountId){
    	try{
    		return (AfAccount) cacheAccount.get(accountId);
    	}catch (NeedsRefreshException e) {
			return null;
		}
    }
    
    public String getAccountLoginCookieCache(String loginCookie){
    	try{
    		return (String) cacheAccountLoginCookie.get(loginCookie);
    	}catch (NeedsRefreshException e) {
			return null;
		}
    }
    
    public void removeAccountCache(String accountId){
    	cacheAccount.remove(accountId);
    }
    
    public void removeAccountLoginCookieCache(String loginCookie){
    	cacheAccountLoginCookie.remove(loginCookie);
    }
    
    public void removeAllAccountCache(){
    	cacheAccount.removeAll();
    }
    
    public void removeAllAccountLoginCookieCache(){
    	cacheAccountLoginCookie.removeAll();
    }
}
