package com.greeningtree.controller.common;



import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.bean.ecom.JUser;
import com.greeningtree.controller.BaseController;
import com.greeningtree.domain.common.AfAccount;
import com.greeningtree.domain.common.AfForgotPassword;
import com.greeningtree.framework.annotation.Token;
import com.greeningtree.framework.annotation.TokenValid;
import com.greeningtree.mav.BaseModelAndView;
import com.greeningtree.service.common.AfAccountService;
import com.greeningtree.service.common.AfForgotPasswordService;
import com.greeningtree.util.CookieUtils;
import com.greeningtree.util.JUtility;
import com.greeningtree.util.StringUtils;
import com.greeningtree.util.UrlUtils;


@Controller
public class AfAccountController extends BaseController {
	@Resource
	private AfAccountService accountService;
	
	@Resource
	private AfForgotPasswordService forgotPasswordService;
	
	@Token
	@RequestMapping("login.shtml")
	public ModelAndView loginPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = baseModelAndView("login");
		mv.setMetaTitle("login");
		return mv;
	}
	
	@TokenValid
	@RequestMapping("login.do")
	public ModelAndView loginRequest(HttpServletRequest request,HttpServletResponse response,JUser jUser) throws Exception {
		BaseModelAndView mv = null;
		if(StringUtils.checkEmail(jUser.getEmail()) && StringUtils.checkPassword(jUser.getPassword())){
			AfAccount account = accountService.login(jUser, getClientHostIp());
			if(account != null){
				CookieUtils.makeLoginCookie(account, response);
				request.getSession().setAttribute("loginCookie", account.getLoginCookie());
				response.sendRedirect(UrlUtils.redirectUrl("index.shtml"));
				return mv;
			}
		}
		UrlUtils.addErrorCode("10000");
		response.sendRedirect(UrlUtils.redirectUrl("login.shtml"));
		return mv;
	}
	
	@RequestMapping("logout.shtml")
	public ModelAndView logoutRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = null;
		CookieUtils.removeLoginCookie(response);
		response.sendRedirect(UrlUtils.redirectUrl("login.shtml"));
		return mv;
	}
	
	@Token
	@RequestMapping("register.shtml")
	public ModelAndView registerPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = baseModelAndView("register");
		mv.setMetaTitle("register");
		return mv;
	}
	
	@TokenValid
	@RequestMapping("register.do")
	public ModelAndView registerRequest(HttpServletRequest request,HttpServletResponse response,JUser jUser) throws Exception {
		BaseModelAndView mv = null;
		if(StringUtils.checkEmail(jUser.getEmail()) && StringUtils.checkPassword(jUser.getPassword()) && jUser.getPassword().equals(jUser.getRePassword()) && StringUtils.checkUsername(jUser.getUsername())){
			String ip = getClientHostIp();
			AfAccount account =  accountService.register(jUser, ip);
			if(account != null){
				mv = (BaseModelAndView) loginRequest(request, response, jUser);
			}
		}else{
			UrlUtils.addErrorCode("10002");
			response.sendRedirect(UrlUtils.redirectUrl("register.shtml"));
		}
		return mv;
	}
	
	@RequestMapping("forgot_password.shtml")
	public ModelAndView forgotPasswordPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = baseModelAndView("forgot_password");
		mv.setMetaTitle("forgot_password");
		return mv;
	}
	
	@RequestMapping("forgot_password.do")
	public ModelAndView forgotPasswordRequest(HttpServletRequest request,HttpServletResponse response,AfForgotPassword forgotPassword) throws Exception {
		BaseModelAndView mv = null;
		if((StringUtils.checkEmail(forgotPassword.getAccountId()) || StringUtils.checkMobile(forgotPassword.getAccountId())) && StringUtils.checkEmpty(forgotPassword.getContent())){
			if(!StringUtils.checkEmpty(forgotPassword.getNewAccountId())){
				forgotPassword.setNewAccountId(forgotPassword.getAccountId());
			}
			if(StringUtils.checkEmail(forgotPassword.getNewAccountId()) || StringUtils.checkMobile(forgotPassword.getNewAccountId())){
				if(accountService.isExistAccount(JUtility.strToMD5(forgotPassword.getAccountId()))){
					forgotPasswordService.forgotPassword(forgotPassword.getAccountId(), forgotPassword.getNewAccountId(), forgotPassword.getContent());
					mv = baseModelAndView("index");
					mv.setMetaTitle("main");
					return mv;
				}
			}
		}
		response.sendRedirect(UrlUtils.redirectUrl("forgot_password.shtml"));
		return mv;
	}
	
	@RequestMapping("update_password.shtml")
	public ModelAndView updatePasswordPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = baseModelAndView("reset_password");
		mv.setMetaTitle("reset_password");
		return mv;
	}
	
	@RequestMapping("update_password.do")
	public ModelAndView updatePasswordRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String accountId = request.getParameter("accountId");
		String old_password = request.getParameter("old_password");
		String password = request.getParameter("password");
		if((StringUtils.checkEmail(accountId) || StringUtils.checkMobile(accountId)) && StringUtils.checkPassword(old_password) && StringUtils.checkPassword(password)){
			if(accountService.checkAccountPassword(accountId, old_password)){
				accountService.updatePassword(getClientHostIp(), accountId, password);
				return loginPageRequest(request, response);
			}
		}
		return updatePasswordPageRequest(request, response);
	}
	
	@RequestMapping("reset_password.do")
	public ModelAndView resetPasswordRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String uuid = request.getParameter("uuid");
		if(StringUtils.isNumber(id) && StringUtils.checkEmpty(uuid)){
			int forgotPasswordId = Integer.valueOf(id);
			if(forgotPasswordService.resetPassword(getClientHostIp(), forgotPasswordId, uuid)){
				return updatePasswordPageRequest(request, response);
			}
		}
		return null;
	}
}
