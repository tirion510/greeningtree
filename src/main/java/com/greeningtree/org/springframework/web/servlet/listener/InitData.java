package com.greeningtree.org.springframework.web.servlet.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

public class InitData extends HttpServlet implements ServletContextListener {
	public void contextDestroyed(ServletContextEvent sce) {

	}

	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("**************  Project Start...****************");
	}

}
