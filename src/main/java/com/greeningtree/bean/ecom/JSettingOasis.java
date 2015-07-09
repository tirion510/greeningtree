package com.greeningtree.bean.ecom;

import java.util.ArrayList;
import java.util.List;

import com.greeningtree.domain.ecom.AfOasisType;

public class JSettingOasis {
	private List<AfOasisType> oasisTypes;
	
	private JAccountOasisInfo accountOasisInfo;
	
	private List<AfOasisType> otherOasisTypes;

	public List<AfOasisType> getOasisTypes() {
		return oasisTypes;
	}

	public void setOasisTypes(List<AfOasisType> oasisTypes) {
		this.oasisTypes = oasisTypes;
	}

	public JAccountOasisInfo getAccountOasisInfo() {
		return accountOasisInfo;
	}

	public void setAccountOasisInfo(JAccountOasisInfo accountOasisInfo) {
		this.accountOasisInfo = accountOasisInfo;
	}
	
	public List<AfOasisType> getOtherOasisTypes() {
		return otherOasisTypes;
	}

	public void setOtherOasisTypes(List<AfOasisType> otherOasisTypes) {
		this.otherOasisTypes = otherOasisTypes;
	}

	public JSettingOasis(){
		
	}
	
	public JSettingOasis(List<AfOasisType> oasisTypes, String accountOasisInfo){
		this.oasisTypes = oasisTypes;
		JAccountOasisInfo jAccountOasisInfo = new JAccountOasisInfo();
		jAccountOasisInfo = (JAccountOasisInfo)jAccountOasisInfo.xmlToObject(accountOasisInfo);
		this.accountOasisInfo = jAccountOasisInfo;
		if(otherOasisTypes == null){
			otherOasisTypes = new ArrayList<AfOasisType>();
		}
		for(AfOasisType oasisType : oasisTypes){
			boolean isExistOasis = false;
			if(getAccountOasisInfo().getOasisInfos() != null){
				for(JOasisInfo oasisInfo : getAccountOasisInfo().getOasisInfos()){
					if(oasisInfo.getOasisTypeId() == oasisType.getId()){
						oasisInfo.setOasisType(oasisType);
						isExistOasis = true;
						break;
					}
				}
			}
			if(!isExistOasis){
				otherOasisTypes.add(oasisType);
			}
		}
	}
}
