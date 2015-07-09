package com.greeningtree.org.springframework.web.servlet.i18n;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

public class I18NAcceptHeaderLocaleResolver extends AcceptHeaderLocaleResolver{
	
	private Locale myLocal;
	
	@Override
	public Locale resolveLocale(HttpServletRequest request) { 
		myLocal = new Locale("zh", "CN");
		request.getLocale().setDefault(myLocal);
		return myLocal==null?request.getLocale():myLocal; 
	} 
	
	@Override
	public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) { 
		myLocal = locale; 
	}
}
