package com.greeningtree.service.ecom;

import java.util.List;

import com.greeningtree.domain.ecom.AfAccountOasis;
import com.greeningtree.domain.ecom.AfOasis;
import com.greeningtree.domain.ecom.AfOasisType;


public interface AfOasisService {
	
	public List<AfOasisType> getAllOasisTypeList();
	
	public List<AfOasis> getAllOasisList();
	
	public List<AfOasis> getOasisListByType(int oasisType);
	
	public AfAccountOasis getAccountOasisById(String accountId);
	
	public AfAccountOasis updateAccountOasis(AfAccountOasis accountOasis);
	
	public AfAccountOasis createAccountOasis(AfAccountOasis accountOasis);
	
	public void focusOasisType(String accountId, String oasisTypeId);
	
	public void unfocusOasisType(String accountId, String oasisTypeId);
}
