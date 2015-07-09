package com.greeningtree.mav;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.config.AppInitConstants;
import com.greeningtree.util.CookieUtils;



public class BaseModelAndView extends ModelAndView {
	private String metaTitle;
	private String metaKeywords;
	private String metaDescription;
	@SuppressWarnings("unchecked")
	List jsList;
	@SuppressWarnings("unchecked")
	List cssList;
	@SuppressWarnings("unchecked")
	public List getCssList() {
		if(this.cssList == null)
		{
			cssList = new ArrayList<String>();
			this.setCssList(cssList);
		}
		return cssList;
	}
	@SuppressWarnings("unchecked")
	public void setCssList(List cssList) {
		this.cssList = cssList;
		this.addObject("cssList", cssList);
	}
	@SuppressWarnings("unchecked")
	public List getJsList() {
		if(this.jsList == null){
			jsList = new ArrayList<String>();
			this.setJsList(jsList);
		}		
		return jsList;
	}
	@SuppressWarnings("unchecked")
	public void setJsList(List jsList) {
		this.jsList = jsList;
		this.addObject("jsList", jsList);
	}
	public String getMetaTitle() {
		if(metaTitle == null){
			this.setMetaTitle(AppInitConstants.getI18nValue("website_name"));
		}
		return metaTitle;
	}
	public void setMetaTitle(String metaTitle) {
		this.metaTitle = metaTitle;
		this.addObject("title", AppInitConstants.getI18nValue(metaTitle));
	}
	public String getMetaKeywords() {
		if(metaKeywords == null){
			this.setMetaKeywords(AppInitConstants.getI18nValue("metaKeywords"));
		}
		return metaKeywords;
	}
	public void setMetaKeywords(String metaKeywords) {
		this.metaKeywords = metaKeywords;
		this.addObject("keywords", metaKeywords);
	}
	public String getMetaDescription() {
		if(metaDescription == null){
			this.setMetaDescription(AppInitConstants.getI18nValue("metaDescription"));
		}
		return metaDescription;
	}
	public void setMetaDescription(String metaDescription) {
		this.metaDescription = metaDescription;
		this.addObject("description", metaDescription);
	}
	
	public BaseModelAndView(String name){
		super(name); 
		baseData();
		Map<Object,Object> map = this.request().getParameterMap();
		Set keSet=map.entrySet();
		Map<String, String> requestMap = new HashMap<String, String>();		
		for(Iterator itr=keSet.iterator();itr.hasNext();){
			Map.Entry me = (Map.Entry)itr.next();
			Object ok = me.getKey(); 
		    Object ov = me.getValue(); 
		    requestMap.put(ok.toString(), ov.toString());
	    }
		this.addObject("reqestParametersMap", requestMap);
	}
	
	public void baseData(){
		this.addObject("ico", AppInitConstants.ico());
		this.addObject("cssList", this.getCssList());
		this.addObject("version", AppInitConstants.getJsVersion());	
		this.addObject("charset", AppInitConstants.getEncoding());
		this.addObject("language", AppInitConstants.getLanguage());
		this.addObject("websiteFilterKey", AppInitConstants.website_filter_key());
		this.addObject("jsList", this.getJsList());
		this.addObject("basePath", this.request().getContextPath()+"/");
		if(CookieUtils.getUsername() != null){
			this.addObject("username", CookieUtils.getUsername());
		}
		this.getMetaTitle();
		this.getMetaKeywords();
		this.getMetaDescription();
	}
	
	public HttpServletRequest request(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
	}
}
