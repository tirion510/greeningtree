
<%@page import="com.gotobus.common.JUtility"%><%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*, com.gotobus.config.*" %>
<%@ include file="/include/i18n.jsp"%>

<%
	String contextPath = request.getContextPath();//-->/tour
	String path = request.getContextPath();
	String port_str = ":" + request.getServerPort();
	int port = request.getServerPort();
	if(port == 80 || port == 443){
		port_str = "";
	}
	String scheme = request.getScheme();
	String basePath = scheme + "://"
	+ request.getServerName() + port_str
	+ path + "/";
	
	String title = (String) request.getAttribute("page_title");
	String h_keywords = (String) request.getAttribute("page_keywords");
	String h_desc = (String) request.getAttribute("page_description");
	title = title != null ? title : "";
	h_keywords = h_keywords!=null ? h_keywords : "";
	h_desc = h_desc!=null ? h_desc : "";
	String version = AppInitConstants.getJsVersion();
	String mainDomain = AppInitConstants.domain();

	String mainSecureDomain = AppInitConstants.secureDomain();
	if(JUtility.isHttps(request))
	{
		mainDomain = mainSecureDomain;
	}
	String imgDomain = AppInitConstants.imgDomain();
	String siteTopPage;
	String siteBottomPage;
	if(AppInitConstants.website_filter_key().equals("zijiqu")){
		siteTopPage = "../search/common/tour/"+language+"/zijiqu_site_top.jsp";
		siteBottomPage = "../search/common/tour/"+language+"/zijiqu_site_bottom.jsp";
	}else {
		siteTopPage = "../search/common/tour/"+language+"/tour_site_top.jsp";
		siteBottomPage = "../search/common/tour/"+language+"/tour_site_bottom.jsp";
	}
	if(AppInitConstants.is_bus_site()){
		siteTopPage = "../search/index/top.jsp";
		siteBottomPage = "../search/index/bottom.jsp";
	}
	String proxyDomain = AppInitConstants.proxyDomain();
	String ico = AppInitConstants.getPropertiesValue("ico");
	String searchBox = "";
	if(AppInitConstants.website_filter_key().equals("zijiqu")){
		searchBox = "../search/common/tour/" + language + "/zijiqu_search_box.jsp";
	}
	if(AppInitConstants.website_filter_key().equals("taketours") || AppInitConstants.website_filter_key().equals("cntaketours") ){
		searchBox = "../search/common/tour/dwr_filter.jsp";
	}	
	String jsLanguage = "";
	if(language.equals("en")){
		jsLanguage = "en";
	} else {
		if(AppInitConstants.is_traditional()){
			jsLanguage = "big5";
		} else if (AppInitConstants.website_filter_key().equals("zijiqu")) {
			jsLanguage = "zijiqu";
		} else {
			jsLanguage = "cn";
		}
	}
%>