package com.greeningtree.service.impl.ecom;



import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.greeningtree.dao.ecom.AfAccountOasisDao;
import com.greeningtree.dao.ecom.AfOasisDao;
import com.greeningtree.dao.ecom.AfOasisTypeDao;
import com.greeningtree.domain.ecom.AfAccountOasis;
import com.greeningtree.domain.ecom.AfOasis;
import com.greeningtree.domain.ecom.AfOasisType;
import com.greeningtree.service.ecom.AfOasisService;

@Service("oasisService")
public class AfOasisServiceImpl implements AfOasisService {
	@Resource
	private AfOasisDao oasisDao;
	
	@Resource
	private AfOasisTypeDao oasisTypeDao;
	
	@Resource
	private AfAccountOasisDao accountOasisDao;
	
	public AfAccountOasis createAccountOasis(AfAccountOasis accountOasis) {
		accountOasisDao.saveAccountOasis(accountOasis);
		return accountOasis;
	}

	public AfAccountOasis getAccountOasisById(String accountId) {
		AfAccountOasis accountOasis = accountOasisDao.getAccountOasisByAccountId(accountId);
		return accountOasisDao.getAccountOasisByAccountId(accountId);
	}

	public List<AfOasis> getAllOasisList() {
		return oasisDao.getAllOasisList();
	}

	public List<AfOasisType> getAllOasisTypeList() {
		return oasisTypeDao.getAllOasisTypeList();
	}

	public List<AfOasis> getOasisListByType(int oasisType) {
		return oasisDao.getOasisListByType(oasisType);
	}

	public AfAccountOasis updateAccountOasis(AfAccountOasis accountOasis) {
		accountOasisDao.updateAccountOasis(accountOasis);
		return accountOasis;
	}

	public void focusOasisType(String accountId, String oasisTypeId) {
		List<AfOasisType> oasisTypeList = getAllOasisTypeList();
		AfOasisType currentOasisType = oasisTypeDao.getOasisType(oasisTypeId);
		if(currentOasisType != null){
			AfAccountOasis accountOasis = getAccountOasisById(accountId);
			accountOasis.focusOasisType(currentOasisType);
			accountOasisDao.updateAccountOasis(accountOasis);
		}
	}

	public void unfocusOasisType(String accountId, String oasisTypeId) {
		// TODO Auto-generated method stub
	}
}
