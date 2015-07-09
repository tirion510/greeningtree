package com.greeningtree.dao.ecom;

import com.greeningtree.domain.ecom.AfAccountOasis;

public interface AfAccountOasisDao {
	public AfAccountOasis getAccountOasisByAccountId(String accountId);
	public AfAccountOasis saveAccountOasis(AfAccountOasis accountOasis);
	public void updateAccountOasis(AfAccountOasis accountOasis);
}
