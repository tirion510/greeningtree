package com.greeningtree.controller.common;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.controller.BaseController;
import com.greeningtree.framework.annotation.LoginCookieValid;
import com.greeningtree.mav.BaseModelAndView;

@Controller
public class SystemController extends BaseController {

	@LoginCookieValid
	@RequestMapping("index.shtml")
	public ModelAndView indexPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = null;
		mv = baseModelAndView("index");
		return mv;
	}
	
	@RequestMapping("re_submit.shtml")
	public ModelAndView reSubmitPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = null;
		mv = baseModelAndView("re_submit");
		return mv;
	}
	
	@RequestMapping("error.shtml")
	public ModelAndView errorPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = null;
		mv = baseModelAndView("error");
		mv.setMetaTitle("error");
		return mv;
	}
}
