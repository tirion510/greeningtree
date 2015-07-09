package com.greeningtree.dao.impl.ecom;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.ecom.AfOasisDao;
import com.greeningtree.domain.ecom.AfOasis;
import com.greeningtree.domain.ecom.AfOasisType;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("oasisDao")
public class AfOasisDaoImpl  extends BaseHibernateDaoSupport implements AfOasisDao{
	public void deleteOasisType(int id) {
		try {
			String queryString = "delete from AfOasisType where id = "+ id;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public List<AfOasisType> getAllOasisTypeList() {
		String sql = " from AfOasisType where 1=1";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		List list = query.list();
		return list;
	}

	public AfOasisType getOasisType(int id) {
		List list = null;
		String sql = " from AfOasisType where id=:id";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setInteger("id", id);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfOasisType)list.get(0);
		}
		return null;
	}

	public AfOasisType saveOasisType(AfOasisType oasisType) {
		try {
			getSessionFactory().getCurrentSession().save(oasisType);
			return oasisType;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateOasisType(AfOasisType oasisType) {
		try {
			getSessionFactory().getCurrentSession().update(oasisType);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void deleteOasis(int id) {
		try {
			String queryString = "delete from AfOasis where id = "+ id;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public List<AfOasis> getAllOasisList() {
		String sql = " from AfOasis where 1=1";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		List list = query.list();
		return list;
	}

	public AfOasis getOasis(int id) {
		List list = null;
		String sql = " from AfOasis where id=:id";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setInteger("id", id);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfOasis)list.get(0);
		}
		return null;
	}

	public List<AfOasis> getOasisListByType(int oasisType) {
		List list = null;
		String sql = " from AfOasis where oasisType=:oasisType";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setInteger("oasisType", oasisType);
		list = query.list();
		return list;
	}

	public AfOasis saveOasis(AfOasis oasis) {
		try {
			getSessionFactory().getCurrentSession().save(oasis);
			return oasis;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateOasis(AfOasis oasis) {
		try {
			getSessionFactory().getCurrentSession().update(oasis);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
