package com.greeningtree.util;

import java.util.Date;
import com.opensymphony.oscache.base.NeedsRefreshException;
import com.opensymphony.oscache.general.GeneralCacheAdministrator;

public class BaseCache extends GeneralCacheAdministrator {     
	
    private int refreshPeriod; //unit:second    

    private String keyPrefix;        

    private static final long serialVersionUID = -4397192926052141162L;        

    public BaseCache(String keyPrefix,int refreshPeriod){    
        super();    
        this.keyPrefix = keyPrefix;    
        this.refreshPeriod = refreshPeriod;    
    }    

    //add cache object
    public void put(String key,Object value){    
        this.putInCache(this.keyPrefix+"_"+key,value);    
    }    

    //delete cache object
    public void remove(String key){    
        this.flushEntry(this.keyPrefix+"_"+key);    
    }    

    //delete all cache object
    public void removeAll(Date date){    
        this.flushAll(date);    
    }           

    public void removeAll(){    
        this.flushAll();    
    }    

    //get cache object
    public Object get(String key) throws NeedsRefreshException{    
        try{    
            return this.getFromCache(this.keyPrefix+"_"+key,this.refreshPeriod);    
        } catch (NeedsRefreshException e) {    
            this.cancelUpdate(this.keyPrefix+"_"+key);   
            throw e;    
        }      
    }    
}   

