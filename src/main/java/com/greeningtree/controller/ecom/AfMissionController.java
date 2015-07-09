package com.greeningtree.controller.ecom;



import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.greeningtree.controller.BaseController;
import com.greeningtree.mav.BaseModelAndView;
import com.greeningtree.service.common.AfAccountService;
import com.greeningtree.service.ecom.AfMissionService;


@Controller
public class AfMissionController extends BaseController {
	@Resource
	private AfAccountService accountService;
	
	@Resource
	private AfMissionService missionService;
	
	@RequestMapping("issue_mission.shtml")
	public ModelAndView issueMissionPageRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BaseModelAndView mv = baseModelAndView("issue_mission");
		mv.setMetaTitle("ISSUE MISSION");
		return mv;
	}
	
}
