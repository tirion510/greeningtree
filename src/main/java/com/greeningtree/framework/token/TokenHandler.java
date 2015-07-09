package com.greeningtree.framework.token;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TokenHandler {
	private static Logger logger = LoggerFactory.getLogger(TokenHandler.class);
	 
    static Map<String, String> springmvc_token = null;
    @SuppressWarnings("unchecked")
    public synchronized static String generateGUID(HttpSession session) {
        String token = "";
        try {
        	token = UUID.randomUUID().toString();
            getSpringmvcTokenMap().put(Constants.DEFAULT_TOKEN_NAME + "." + token,token);
            session.setAttribute(Constants.DEFAULT_TOKEN_NAME, token);
            Constants.TOKEN_VALUE = token;
        } catch (IllegalStateException e) {
            logger.error("generateGUID() mothod find bug,by token session...");
        }
        return token;
    }

    //验证表单token值和session中的token值是否一致
    @SuppressWarnings("unchecked")
    public static boolean validToken(HttpServletRequest request) {
        String inputToken = getInputToken(request);
        if (inputToken == null) {
            logger.warn("token is not valid!inputToken is NULL");
            return false;
        }
        HttpSession session = request.getSession();
        String tokenSession = (String) session.getAttribute(Constants.DEFAULT_TOKEN_NAME);
        if(tokenSession == null || !tokenSession.equals(inputToken)){
        	return false;
        }
        if(!tokenSession.equals(getSpringmvcTokenMap().get(Constants.DEFAULT_TOKEN_NAME + "." + tokenSession))){
        	return false;
        }
//        if (tokenMap == null || tokenMap.size() < 1) {
//            logger.warn("token is not valid!sessionToken is NULL");
//            return false;
//        }
//        String sessionToken = tokenMap.get(Constants.DEFAULT_TOKEN_NAME + "."
//                + inputToken);
//        if (!inputToken.equals(sessionToken)) {
//            logger.warn("token is not valid!inputToken='" + inputToken
//                    + "',sessionToken = '" + sessionToken + "'");
//            return false;
//        }
//        tokenMap.remove(Constants.DEFAULT_TOKEN_NAME + "." + inputToken);
//        session.setAttribute("SPRINGMVC.TOKEN", tokenMap);
        getSpringmvcTokenMap().remove(Constants.DEFAULT_TOKEN_NAME + "." + tokenSession);
        session.removeAttribute(Constants.DEFAULT_TOKEN_NAME);
        return true;
    }
 
    //获取表单中token值
    @SuppressWarnings("unchecked")
    public static String getInputToken(HttpServletRequest request) {
        Map params = request.getParameterMap();
 
        if (!params.containsKey("token")) {
            logger.warn("Could not find token name in params.");
            return null;
        }
        
        String[] tokens = (String[]) (String[]) params
                .get("token");
 
        if ((tokens == null) || (tokens.length < 1)) {
            logger.warn("Got a null or empty token name.");
            return null;
        }
 
        return tokens[0];
    }
    
    @SuppressWarnings("unchecked")
    public static String getSessionToken(HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	return (String) session.getAttribute(Constants.DEFAULT_TOKEN_NAME);
    }
    
    public static Map<String, String> getSpringmvcTokenMap(){
    	if(springmvc_token == null){
    		springmvc_token = new HashMap<String, String>();
    	}
    	return springmvc_token;
    }
}
