package com.greeningtree.dao.impl.common;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.common.AfAccountLogDao;
import com.greeningtree.domain.common.AfAccountLog;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;


@Repository("accountLogDao")
public class AfAccountLogDaoImpl  extends BaseHibernateDaoSupport implements AfAccountLogDao{
	public List<AfAccountLog> getAccountLogList(String accountId,
			Date startTime, Date endTime, int length) {
		List list = null;
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" from AfAccountLog where accountId=:accountId ");
		if(startTime != null && endTime != null){
			sqlBuffer.append("and actionTime between :startTime and :endTime ");
		}
		Query query = getSessionFactory().getCurrentSession().createQuery(sqlBuffer.toString());
		query.setString("accountId", accountId);
		if(startTime != null && endTime != null){
			query.setDate("startTime", startTime);
			query.setDate("endTime", endTime);
		}
		list = query.list();
		if(list != null && list.size() > 0)
		{
			if(list.size() <= length){
				return (List<AfAccountLog>)list;
			}
			return (List<AfAccountLog>)list.subList(0, length-1);
		}
		return null;
	}

	public AfAccountLog saveAccountLog(String accountId, String actionIp, int type) {
		try {
			AfAccountLog accountLog = new AfAccountLog(accountId, actionIp, type);
			getSessionFactory().getCurrentSession().save(accountLog);
			return accountLog;
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
