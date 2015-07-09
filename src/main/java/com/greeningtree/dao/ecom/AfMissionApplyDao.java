package com.greeningtree.dao.ecom;

import com.greeningtree.domain.ecom.AfMissionApply;

public interface AfMissionApplyDao {
	public AfMissionApply saveMissionApply(AfMissionApply missionApply);
	public void updateMissionApply(AfMissionApply missionApply);
	public void deleteMissionApply(int id);
}
