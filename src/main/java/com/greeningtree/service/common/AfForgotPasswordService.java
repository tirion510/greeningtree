package com.greeningtree.service.common;

import java.util.Date;
import java.util.List;

import com.greeningtree.domain.common.AfForgotPassword;


public interface AfForgotPasswordService {
	
	public void forgotPassword(String accountId, String newAccountId, String content);
	
	public List<AfForgotPassword> getAfForgotPasswordList(String accountId,
														  int status, Date startTime, Date endTime);
	
	public void handleForgotPassword(int id, int status);
	
	public void getForgotPassword(int id);
	
	public boolean resetPassword(String ip, int id, String uuid);
}
