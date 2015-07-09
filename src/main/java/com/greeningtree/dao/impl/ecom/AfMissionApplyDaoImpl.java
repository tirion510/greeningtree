package com.greeningtree.dao.impl.ecom;


import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.ecom.AfMissionApplyDao;
import com.greeningtree.domain.ecom.AfMissionApply;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("missionApplyDao")
public class AfMissionApplyDaoImpl  extends BaseHibernateDaoSupport implements AfMissionApplyDao{
	public void deleteMissionApply(int id) {
		try {
			String queryString = "delete from AfMissionApply where id = " + id;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public AfMissionApply saveMissionApply(AfMissionApply missionApply) {
		try {
			getSessionFactory().getCurrentSession().save(missionApply);
			return missionApply;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateMissionApply(AfMissionApply missionApply) {
		try {
			getSessionFactory().getCurrentSession().update(missionApply);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
