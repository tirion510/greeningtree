package com.greeningtree.webservice.impl;

import javax.jws.WebService;

import com.greeningtree.webservice.AfforestTreeWebService;


@WebService(endpointInterface= "com.greeningtree.webservice.AfforestTreeWebService",targetNamespace="afWS")
public class AfforestTreeWebServiceImpl implements AfforestTreeWebService {
	
//	@SuppressWarnings("unchecked")
//	@WebMethod(action="ProductUpdateByPid",operationName="ProductUpdateByPid")
//	public String productUpdateByPid(String pid) {
//		try{
//			ConfigParam.getUpdateTaskList().add(pid);
//		}catch(Exception e){
//			return "failed";
//		}
//		return "success";
//	}
}
