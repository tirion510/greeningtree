package com.greeningtree.dao.ecom;

import com.greeningtree.domain.ecom.AfAccountMission;

public interface AfAccountMissionDao {
	public AfAccountMission saveAccountMission(AfAccountMission accountMission);
	public void updateAccountMission(AfAccountMission accountMission);
	public void deleteAccountMission(int id);
}
