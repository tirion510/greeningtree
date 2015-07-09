package com.greeningtree.dao.impl.common;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.common.AfAccountDao;
import com.greeningtree.domain.common.AfAccount;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("accountDao")
public class AfAccountDaoImpl  extends BaseHibernateDaoSupport implements AfAccountDao{
	
	public AfAccount getAccount(String accountId)
	{
		List list = null;
		String sql = " from AfAccount where accountId=:accountId";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setString("accountId", accountId);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfAccount)list.get(0);
		}
		return null;
	}
	
	public AfAccount getAccountByEmail(String email)
	{
		List list = null;
		String sql = " from AfAccount where email=:email";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setString("email", email);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfAccount)list.get(0);
		}
		return null;
	}
	
	public AfAccount getAccountByUsername(String username)
	{
		List list = null;
		String sql = " from AfAccount where username=:username";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setString("username", username);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfAccount)list.get(0);
		}
		return null;
	}

	public AfAccount saveAccount(AfAccount account) {
		try {
			getSessionFactory().getCurrentSession().save(account);
			return account;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void deleteAccount(String accountId) {
		try {
			String queryString = "delete from AfAccount where accountId = "+accountId;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateAccount(AfAccount account) {
		try {
			getSessionFactory().getCurrentSession().update(account);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
