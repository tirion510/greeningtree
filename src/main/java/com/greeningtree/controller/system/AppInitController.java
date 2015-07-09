package com.greeningtree.controller.system;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.greeningtree.service.common.AfCityService;
import com.greeningtree.service.system.AppInitService;


@Controller
public class AppInitController {
	@Resource
	private AppInitService appInitService;
	
	@Resource
	private AfCityService cityService;
	
	@PostConstruct
	protected void initialize() {
		appInitService.putBasePropertiesList();
		cityService.getCityCache();
	}
}
