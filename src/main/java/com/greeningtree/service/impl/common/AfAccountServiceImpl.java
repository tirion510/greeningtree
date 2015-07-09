package com.greeningtree.service.impl.common;


import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.greeningtree.bean.ecom.JSettingProfile;
import com.greeningtree.bean.ecom.JUser;
import com.greeningtree.dao.common.AfAccountDao;
import com.greeningtree.dao.common.AfAccountLogDao;
import com.greeningtree.dao.ecom.AfAccountOasisDao;
import com.greeningtree.domain.common.AfAccount;
import com.greeningtree.domain.ecom.AfAccountOasis;
import com.greeningtree.service.common.AfAccountService;
import com.greeningtree.util.CacheManager;
import com.greeningtree.util.CookieUtils;
import com.greeningtree.util.JUtility;
import com.greeningtree.util.UrlUtils;

@Service("accountService")
public class AfAccountServiceImpl implements AfAccountService {
	@Resource
	private AfAccountDao accountDao;
	
	@Resource
	private AfAccountLogDao accountLogDao;
	
	@Resource
	private AfAccountOasisDao accountOasisDao;
	
	private static int initDataCount = 1;
	
	public AfAccount login(JUser jUser, String ip) {
		if(checkAccountPassword(jUser.getEmail(), jUser.getPassword())){
			String accountId = JUtility.strToMD5(jUser.getEmail());
			AfAccount account = getAccount(accountId);
			if(account.getLoginCookie() != null){
				CacheManager.getInstance().removeAccountLoginCookieCache(account.getLoginCookie());
			}
			account.setLoginCookie(UUID.randomUUID().toString());
			CacheManager.getInstance().putAccountLoginCookieCache(account.getLoginCookie(), accountId);
			account.setLastActiveTime(new Date());
			account.setLastActiveIp(ip);
			createAccountInitData(account.getAccountId());
			accountLogDao.saveAccountLog(accountId, ip, 2);
			return account;
		}
		return null;
	}

	public AfAccount register(JUser jUser, String ip) {
		if(isExistEmail(jUser.getEmail()) || isExistUsername(jUser.getUsername())){
			return null;
		}
		AfAccount account = new AfAccount(jUser.getEmail(), jUser.getUsername(), jUser.getPassword());
		account.setLastActiveIp(ip);
		account = accountDao.saveAccount(account);
		CacheManager.getInstance().putAccountCache(account.getAccountId(), account);
		createAccountInitData(account.getAccountId());
		accountLogDao.saveAccountLog(account.getAccountId(), ip, 1);
		return account;
	}

	public AfAccount getAccount(String accountId) {
		if(CacheManager.getInstance().getAccountCache(accountId)==null){
			AfAccount account = accountDao.getAccount(accountId);
			CacheManager.getInstance().putAccountCache(accountId, account);
		}
		return CacheManager.getInstance().getAccountCache(accountId);
	}
	

	public boolean loginByLoginCookie(String ip, HttpServletResponse response) {
		String loginCookie = (String) UrlUtils.request().getSession().getAttribute("loginCookie");
		if(loginCookie == null){
			loginCookie = CookieUtils.getLoginCookie();
		}
		if(loginCookie != null){
			String accountId = CacheManager.getInstance().getAccountLoginCookieCache(loginCookie);
			if(accountId != null){
				AfAccount account = CacheManager.getInstance().getAccountCache(accountId);
				if(account != null){
					if(ip.equals(account.getLastActiveIp()) && (new Date().getTime() - account.getLastActiveTime().getTime()) < 3600000){
						account.setLastActiveTime(new Date());
						String accountIdCookie = CookieUtils.getAccountId();
						String usernameCookie = CookieUtils.getUsername();
						if(accountIdCookie == null || !accountIdCookie.equals(account.getAccountId()) || usernameCookie== null || !usernameCookie.equals(account.getUsername())){
							CookieUtils.makeLoginCookie(account, response);
						}
						return true;
					}
				}
			}
		}
		return false;
	}
	
	public boolean checkAccountPassword(String accountId,String password){
		accountId = JUtility.strToMD5(accountId);
		password = JUtility.strToMD5(password);
		AfAccount account = getAccount(accountId);
		if(account != null && account.getPassword() != null && account.getPassword().equals(password)){
			return true;
		}else{
			return false;
		}
	}
	
	public boolean isExistAccount(String accountId){
		return accountDao.getAccount(accountId)!=null;
	}

	public void updatePassword(String ip,String accountId, String password) {
		getAccount(accountId).setPassword(JUtility.strToMD5(password));
		accountDao.updateAccount(getAccount(accountId));
		accountLogDao.saveAccountLog(accountId, ip, 3);
	}

	public boolean isExistEmail(String email) {
		return accountDao.getAccountByEmail(email) != null;
	}

	public boolean isExistUsername(String username) {
		return accountDao.getAccountByUsername(username) != null;
	}

	public void updateAccount(AfAccount account) {
		accountDao.updateAccount(account);
	}

	public AfAccount settingProfile(JSettingProfile jSettingProfile) {
		AfAccount account = getAccount(CookieUtils.getAccountId());
		updateAccount(jSettingProfile.updateAccount(account));
		return account;
	}

	public void createAccountInitData(String accountId) {
		// 1-oasis
		AfAccount account = getAccount(accountId);
		JSONObject initDataFlagJson = JSONObject.fromObject(account.getInitDataFlag());
		JSONObject newInitDataFlagJson = JSONObject.fromObject(initDataFlagJson);
		if(initDataFlagJson.size() != initDataCount){
			if(initDataFlagJson.isEmpty() || initDataFlagJson.getInt("1") != 1){
				AfAccountOasis accountOasis = new AfAccountOasis(accountId);
				accountOasisDao.saveAccountOasis(accountOasis);
				newInitDataFlagJson.element("1", 1);
			}
			account.setInitDataFlag(newInitDataFlagJson.toString());
			updateAccount(account);
		}
	}
}
