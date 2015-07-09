package com.greeningtree.service.ecom;

public interface AfMissionService {
	public void issueMission(String accountId, String title, int type, int needCount, String endTime, String subId, String content, String files);
	
	public void applyMission(String accountId, int missionId, String describe);
}
