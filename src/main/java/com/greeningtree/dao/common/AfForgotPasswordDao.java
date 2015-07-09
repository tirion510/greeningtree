package com.greeningtree.dao.common;

import java.util.Date;
import java.util.List;

import com.greeningtree.domain.common.AfForgotPassword;

public interface AfForgotPasswordDao {
	public AfForgotPassword saveForgotPassword(AfForgotPassword forgotPassword);
	public AfForgotPassword getForgotPassword(int id);
	public void deleteForgotPassword(int id);
	public void updateForgotPassword(AfForgotPassword forgotPassword);
	public List<AfForgotPassword> getForgotPasswordList(String accountId, int status, Date startTime, Date endTime);
}
