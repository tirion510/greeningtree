package com.greeningtree.org.springframework.web.servlet.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;

/**
 * @author Administrator
 * The life cycle
 */
public class ServletContextLifeListener implements ServletContextListener{
	
	private static final Log logger = LogFactory.getLog(ServletContextLifeListener.class);
	
	private ServletContext context;
	private WebApplicationContext springContext;
	/**
	 */
	public void contextDestroyed(ServletContextEvent event) {
		context = event.getServletContext();
		context.getAttribute("");
		if(context == null && "".equals(context))
			System.out.println("ServletContext is Destroyed ----------------------------");
	}
	public void contextInitialized(ServletContextEvent event) {
		context = event.getServletContext();
		String rootName = context.getInitParameter("webAppRootKey");
		logger.info(":"+rootName);
		if(context != null && !"".equals(context))
			System.out.println("ServletContext is Initialized ----------------------------");
		WebApplicationContext webApplicationContext = (WebApplicationContext) context.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		//springContext = WebApplicationContextUtils.getWebApplicationContext(context); 
		
		//setApplicationAttribute(webApplicationContext);
	}
	private void setApplicationAttribute(WebApplicationContext springContext){
		springContext.getBean("");
		context.setAttribute("", "");
	}
}
