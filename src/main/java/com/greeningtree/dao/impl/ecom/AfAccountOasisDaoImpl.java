package com.greeningtree.dao.impl.ecom;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.ecom.AfAccountOasisDao;
import com.greeningtree.domain.ecom.AfAccountOasis;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("accountOasisDao")
public class AfAccountOasisDaoImpl  extends BaseHibernateDaoSupport implements AfAccountOasisDao{
	public AfAccountOasis getAccountOasisByAccountId(String accountId) {
		List list = null;
		String sql = " from AfAccountOasis where accountId=:accountId";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setString("accountId", accountId);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfAccountOasis)list.get(0);
		}
		return null;
	}

	public AfAccountOasis saveAccountOasis(AfAccountOasis accountOasis) {
		try {
			getSessionFactory().getCurrentSession().save(accountOasis);
			return accountOasis;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateAccountOasis(AfAccountOasis accountOasis) {
		try {
			getSessionFactory().getCurrentSession().update(accountOasis);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
