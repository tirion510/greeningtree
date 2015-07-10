package com.greeningtree.service.system;

import net.spy.memcached.MemcachedClient;

import javax.servlet.http.HttpServletRequest;

public interface MemcachedService {

    public boolean addMemcached(String key, Object value);

    public boolean addMemcached(HttpServletRequest request, String key, int millseconds, Object value);

    public boolean addMemcached(String key, int millseconds, Object value);

    public boolean replaceMemcached(String key, Object value);

    public boolean delete(String key);

    public boolean delete(HttpServletRequest request, String key);

    public Object getValue(String key);

    public Object getValue(HttpServletRequest request, String key);

    public boolean checkMemcacheClient();

    public MemcachedClient getMemcachedClient();

    public void setMemcachedClient(MemcachedClient memcachedClient);
}
