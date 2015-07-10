package com.greeningtree.service.impl.system;

import com.greeningtree.service.system.MemcachedService;
import net.spy.memcached.MemcachedClient;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Future;

@Service("memcachedService")
@Scope("singleton")
public class MemcachedServiceImpl implements MemcachedService {

    public boolean addMemcached(String key, Object value) {
        if (!checkMemcacheClient()) return false;
        try {
            if(noMemcacheMode){
                memCache.put(key,value);
                return true;
            }
            memcachedClient.add(key, 30000, value);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addMemcached(HttpServletRequest request, String key, int millseconds, Object value) {
        String realKey = request.getSession().getId() + "_" + key;
        if (!checkMemcacheClient()) return false;
        try {
            if(noMemcacheMode){
                memCache.put(realKey,value);
                return true;
            }
            memcachedClient.add(realKey, millseconds, value);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addMemcached(String key, int millseconds, Object value) {
        if (!checkMemcacheClient()) return false;
        try {
            if(noMemcacheMode){
                memCache.put(key,value);
                return true;
            }
            memcachedClient.add(key, millseconds, value);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean replaceMemcached(String key, Object value) {
        if (!checkMemcacheClient()) return false;
        try {
            if(noMemcacheMode){
                memCache.put(key,value);
                return true;
            }
            memcachedClient.replace(key, 30000, value);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(String key) {
        if (!checkMemcacheClient()) return false;
        try {
            if(noMemcacheMode){
                memCache.remove(key);
                return true;
            }
            Future<Boolean> funture = memcachedClient.delete(key);
            return funture.get();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(HttpServletRequest request, String key) {
        if (!checkMemcacheClient()) return false;
        String realKey = request.getSession().getId() + "_" + key;
        try {
            if (noMemcacheMode) {
                memCache.remove(realKey);
                return true;
            }
            Future<Boolean> funture = memcachedClient.delete(key);
            return funture.get();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public Object getValue(String key) {
        if (!checkMemcacheClient()) return null;
        try {
            if(noMemcacheMode){
                return memCache.get(key);
            }
            return memcachedClient.get(key);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public Object getValue(HttpServletRequest request, String key) {
        if (!checkMemcacheClient()) return null;
        String realKey = request.getSession().getId() + "_" + key;
        try {
            if (noMemcacheMode) {
                return memCache.get(realKey);
            }
            return memcachedClient.get(realKey);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public boolean checkMemcacheClient() {
        if(noMemcacheMode) return true;
        return memcachedClient != null;
    }


    private Map<String,Object> memCache = new HashMap<String,Object>();
    private boolean noMemcacheMode = false;
    @Resource
    private MemcachedClient memcachedClient;

    public MemcachedClient getMemcachedClient() {
        return memcachedClient;
    }

    public void setMemcachedClient(MemcachedClient memcachedClient) {
        this.memcachedClient = memcachedClient;
    }
}
