package com.greeningtree.dao.ecom;

import java.util.List;

import com.greeningtree.domain.ecom.AfMission;

public interface AfMissionDao {
	public AfMission getMission(int missionId);
	public AfMission saveMission(AfMission mission);
	public void updateMission(AfMission mission);
	public void deleteMission(int missionId);
	public List<AfMission> getMissionList(String accountId, int type, int status, int page, boolean desc);
}
