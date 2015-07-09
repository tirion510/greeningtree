package com.greeningtree.framework.token;

import java.lang.reflect.Method;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.framework.annotation.TokenValid;
import com.greeningtree.service.common.AfAccountService;


public class TokenValidInterceptor implements HandlerInterceptor{
	@Resource
	private AfAccountService accountService; 
	
    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object arg2, Exception arg3)
            throws Exception {
    }
 
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
            Object arg2, ModelAndView arg3) throws Exception {
         
    }
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
            Object arg2) throws Exception {
    	HandlerMethod handlerMethod = (HandlerMethod) arg2;
        Method method = handlerMethod.getMethod();
        TokenValid annotation = method.getAnnotation(TokenValid.class);
        if (annotation != null) {
        	if(!TokenHandler.validToken(request)){
        		response.sendRedirect(Constants.DEFAULT_TOKEN_MSG_JSP);
	            return false;
	        }
        }
    	return true;
    }
 
}
