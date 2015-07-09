package com.greeningtree.org.springframework.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringContextUtils {
	
	private static ApplicationContext context = null;
	private final static String applicationContextFilePath = "META-INF/applicationContext.xml";
	//private final static String jmsContextFilePath = "META-INF/spring-jms.xml";
	
	private static String[] pathArr = new String[]{applicationContextFilePath};
	//http://dayang2001911.iteye.com/blog/248213
	
	/**
	 * @return	ApplicationContext
	 */
	public static ApplicationContext getContext(){
		//Spring put Bean in the container, when necessary, with getBean method
		context = new ClassPathXmlApplicationContext(pathArr);
		return context;
	}
	/**
	 * @param beanId
	 * @return Get the applicationContext Bean in the container
	 */
//	public static Object getBean(String beanId){
//		return context.getBean(beanId);
//	}
}
