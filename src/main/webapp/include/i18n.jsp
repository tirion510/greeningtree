<%@page import="com.gotobus.framework.util.StringUtils,com.gotobus.config.AppInitConstants"%>

<%
	String language = AppInitConstants.getLanguage();
	if (StringUtils.isNotEmpty(language) && "cn".equals(language)) {
		if(AppInitConstants.is_traditional()){
			request.setCharacterEncoding("big5");
			response.setCharacterEncoding("big5");
		}else{
			request.setCharacterEncoding("gbk");
			response.setCharacterEncoding("gbk");
		}
	} else {
		request.setCharacterEncoding("iso-8859-1");
		response.setCharacterEncoding("iso-8859-1");
	}
%>

