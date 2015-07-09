package com.greeningtree.framework.token;

import java.lang.reflect.Method;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.controller.BaseController;
import com.greeningtree.framework.annotation.LoginCookieValid;
import com.greeningtree.framework.annotation.Token;
import com.greeningtree.service.common.AfAccountService;
import com.greeningtree.util.UrlUtils;

@Controller
public class TokenHandlerInterceptor extends BaseController implements HandlerInterceptor{
	@Resource
	private AfAccountService accountService;
	 
    public void afterCompletion(HttpServletRequest arg0,
            HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
    }
 
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
            Object arg2, ModelAndView arg3) throws Exception {
    	HandlerMethod handlerMethod = (HandlerMethod) arg2;
        Method method = handlerMethod.getMethod();
        Token annotation = method.getAnnotation(Token.class);
        if (annotation != null) {
        	arg3.addObject("token", TokenHandler.getSessionToken(request));
        }
    }
 
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
            Object arg2) throws Exception {
    	HandlerMethod handlerMethod = (HandlerMethod) arg2;
        Method method = handlerMethod.getMethod();
        Token annotation = method.getAnnotation(Token.class);
        if (annotation != null) {
        	TokenHandler.generateGUID(request.getSession());
        }
        if(method.getAnnotation(LoginCookieValid.class) != null){
        	if(!accountService.loginByLoginCookie(getClientHostIp(), response)){
    			response.sendRedirect(UrlUtils.redirectUrl("login.shtml"));
    			return false;
    		}
        }
        return true;
    }
 
}
