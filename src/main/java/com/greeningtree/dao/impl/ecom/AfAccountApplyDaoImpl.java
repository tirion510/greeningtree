package com.greeningtree.dao.impl.ecom;


import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.ecom.AfAccountApplyDao;
import com.greeningtree.domain.ecom.AfAccountApply;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("accountApplyDao")
public class AfAccountApplyDaoImpl  extends BaseHibernateDaoSupport implements AfAccountApplyDao{
	public void deleteAccountApply(int id) {
		try {
			String queryString = "delete from AfAccountApply where id = " + id;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public AfAccountApply saveAccountApply(AfAccountApply accountApply) {
		try {
			getSessionFactory().getCurrentSession().save(accountApply);
			return accountApply;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateAccountApply(AfAccountApply accountApply) {
		try {
			getSessionFactory().getCurrentSession().update(accountApply);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
