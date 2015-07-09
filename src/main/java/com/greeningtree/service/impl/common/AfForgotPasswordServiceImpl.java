package com.greeningtree.service.impl.common;


import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.greeningtree.dao.common.AfForgotPasswordDao;
import com.greeningtree.domain.common.AfForgotPassword;
import com.greeningtree.service.common.AfAccountService;
import com.greeningtree.service.common.AfForgotPasswordService;
import com.greeningtree.util.JUtility;

@Service("forgotPasswordService")
public class AfForgotPasswordServiceImpl implements AfForgotPasswordService {
	@Resource
	private AfAccountService accountService;
	
	@Resource
	private AfForgotPasswordDao forgotPasswordDao;

	public void forgotPassword(String accountId, String newAccountId,
			String content) {
		AfForgotPassword forgotPassword = new AfForgotPassword(accountId, newAccountId, content);
		forgotPasswordDao.saveForgotPassword(forgotPassword);
	}

	public List<AfForgotPassword> getAfForgotPasswordList(String accountId,
			int status, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		return null;
	}

	public void getForgotPassword(int id) {
		// TODO Auto-generated method stub
		
	}

	public void handleForgotPassword(int id, int status) {
		// TODO Auto-generated method stub
		
	}

	public boolean resetPassword(String ip, int id, String uuid) {
		AfForgotPassword forgotPassword = forgotPasswordDao.getForgotPassword(id);
		if(forgotPassword != null){
			if(forgotPassword.getStatus() == 2 && forgotPassword.getUuid().equals(uuid)){
				accountService.updatePassword(ip, forgotPassword.getAccountId(), JUtility.strToMD5(uuid.substring(0, 6)));
				return true;
			}
		}
		return false;
	}
}
