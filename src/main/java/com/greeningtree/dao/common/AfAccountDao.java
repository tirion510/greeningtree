package com.greeningtree.dao.common;

import com.greeningtree.domain.common.AfAccount;

public interface AfAccountDao {
	
	public AfAccount getAccount(String accountId);
	public AfAccount getAccountByEmail(String email);
	public AfAccount getAccountByUsername(String username);
	public AfAccount saveAccount(AfAccount account);
	public void deleteAccount(String accountId);
	public void updateAccount(AfAccount account);
}
