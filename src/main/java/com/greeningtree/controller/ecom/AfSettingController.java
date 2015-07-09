package com.greeningtree.controller.ecom;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.bean.ecom.JSettingOasis;
import com.greeningtree.bean.ecom.JSettingProfile;
import com.greeningtree.controller.BaseController;
import com.greeningtree.domain.common.AfAccount;
import com.greeningtree.domain.ecom.AfAccountOasis;
import com.greeningtree.domain.ecom.AfOasisType;
import com.greeningtree.framework.annotation.LoginCookieValid;
import com.greeningtree.mav.BaseModelAndView;
import com.greeningtree.service.common.AfAccountService;
import com.greeningtree.service.ecom.AfOasisService;
import com.greeningtree.util.CookieUtils;
import com.greeningtree.util.UrlUtils;


@Controller
public class AfSettingController extends BaseController {
	@Resource
	private AfAccountService accountService;
	
	@Resource
	private AfOasisService oasisService;
	
	@RequestMapping("setting.shtml")
	public ModelAndView settingPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		response.sendRedirect(UrlUtils.redirectUrl("setting/profile.shtml"));
		return null;
	}
	
	@LoginCookieValid
	@RequestMapping("setting/profile.shtml")
	public ModelAndView settingProfilePageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		AfAccount account = accountService.getAccount(CookieUtils.getAccountId());
		JSettingProfile jSettingProfile = new JSettingProfile(account);
		BaseModelAndView mv = baseModelAndView("setting/profile");
		mv.setMetaTitle("profile");
		mv.addObject("profile", jSettingProfile);
		return mv;
	}
	
	@LoginCookieValid
	@RequestMapping("setting/profile.do")
	public ModelAndView settingProfileRequest(HttpServletRequest request,HttpServletResponse response,JSettingProfile jSettingProfile) throws Exception {
		AfAccount account = accountService.settingProfile(jSettingProfile);
		CookieUtils.makeLoginCookie(account, response);
		response.sendRedirect(UrlUtils.redirectUrl("setting/profile.shtml"));
		return null;
	}
	
	@LoginCookieValid
	@RequestMapping("setting/myOasis.shtml")
	public ModelAndView settingMyOasisPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		AfAccountOasis accountOasis = oasisService.getAccountOasisById(CookieUtils.getAccountId());
		List<AfOasisType> oasisTypeList = oasisService.getAllOasisTypeList();
		AfAccount account = accountService.getAccount(CookieUtils.getAccountId());
		BaseModelAndView mv = baseModelAndView("setting/my_oasis");
		mv.setMetaTitle("MyOasis");
		JSettingOasis settingOasis = new JSettingOasis(oasisTypeList, accountOasis.getAccountOasisInfo());
		mv.addObject("settingOasis", settingOasis);
		return mv;
	}
	
	@LoginCookieValid
	@RequestMapping("setting/focus_oasis_type.do")
	public ModelAndView focusOasisTypeRequest(HttpServletRequest request,HttpServletResponse response,String oasis_type_id) throws Exception {
		String oasisTypeId = oasis_type_id;
		List<AfOasisType> oasisTypeList = oasisService.getAllOasisTypeList();
		if(oasisTypeId != null){
			AfAccount account = accountService.getAccount(CookieUtils.getAccountId());
			oasisService.focusOasisType(account.getAccountId(), oasis_type_id);
		}
		response.sendRedirect(UrlUtils.redirectUrl("setting/myOasis.shtml"));
		return null;
	}
}
