package com.greeningtree.dao.impl.ecom;


import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.ecom.AfAccountMissionDao;
import com.greeningtree.domain.ecom.AfAccountMission;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("accountMissionDao")
public class AfAccountMissionDaoImpl  extends BaseHibernateDaoSupport implements AfAccountMissionDao{
	public void deleteAccountMission(int id) {
		try {
			String queryString = "delete from AfAccountMission where id = " + id;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public AfAccountMission saveAccountMission(AfAccountMission accountMission) {
		try {
			getSessionFactory().getCurrentSession().save(accountMission);
			return accountMission;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateAccountMission(AfAccountMission accountMission) {
		try {
			getSessionFactory().getCurrentSession().update(accountMission);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
