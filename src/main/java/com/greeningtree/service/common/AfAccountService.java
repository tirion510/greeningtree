package com.greeningtree.service.common;

import javax.servlet.http.HttpServletResponse;

import com.greeningtree.bean.ecom.JSettingProfile;
import com.greeningtree.bean.ecom.JUser;
import com.greeningtree.domain.common.AfAccount;


public interface AfAccountService {
	
	public AfAccount login(JUser jUser, String ip);
	
	public AfAccount register(JUser jUser, String ip);
	
	public AfAccount getAccount(String accountId);
	
	public boolean loginByLoginCookie(String ip, HttpServletResponse response);
	
	public boolean checkAccountPassword(String accountId, String password);
	
	public boolean isExistAccount(String accountId);
	
	public void updateAccount(AfAccount account);
	
	public void updatePassword(String ip, String accountId, String password);
	
	public boolean isExistEmail(String email);
	
	public boolean isExistUsername(String username);
	
	public AfAccount settingProfile(JSettingProfile jSettingProfile);
	
	public void createAccountInitData(String accountId);
}
