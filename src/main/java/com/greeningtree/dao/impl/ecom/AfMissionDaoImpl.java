package com.greeningtree.dao.impl.ecom;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.greeningtree.dao.ecom.AfMissionDao;
import com.greeningtree.domain.ecom.AfMission;
import com.greeningtree.framework.hibernate.BaseHibernateDaoSupport;
import com.greeningtree.util.PageUtils;
import com.greeningtree.util.StringUtils;


@Repository("missionDao")
public class AfMissionDaoImpl  extends BaseHibernateDaoSupport implements AfMissionDao{
	public void deleteMission(int missionId) {
		try {
			String queryString = "delete from AfMission where id = "+missionId;
			Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
			queryObject.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public AfMission getMission(int missionId) {
		List list = null;
		String sql = " from AfMission where id=:missionId";
		Query query = getSessionFactory().getCurrentSession().createQuery(sql);
		query.setInteger("missionId", missionId);
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (AfMission)list.get(0);
		}
		return null;
	}

	public AfMission saveMission(AfMission mission) {
		try {
			getSessionFactory().getCurrentSession().save(mission);
			return mission;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void updateMission(AfMission mission) {
		try {
			getSessionFactory().getCurrentSession().update(mission);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public List<AfMission> getMissionList(String accountId, int type, int status, int page, boolean desc) {
		List list = null;
		StringBuffer sqlBuffer = new StringBuffer(" from AfMission where 1 = 1");
		if(StringUtils.checkEmpty(accountId)){
			sqlBuffer.append(" and accountId=:accountId");
		}
		if(type != 0){
			sqlBuffer.append(" and type=:type");
		}
		if(status != 0){
			sqlBuffer.append(" and status=:status");
		}
		sqlBuffer.append(" order by createTime");
		if(desc){
			sqlBuffer.append(" desc");
		}
		Query query = getSessionFactory().getCurrentSession().createQuery(sqlBuffer.toString());
		if(StringUtils.checkEmpty(accountId)){
			query.setString("accountId", accountId);
		}
		if(type != 0){
			query.setInteger("type", type);
		}
		if(status != 0){
			query.setInteger("status", status);
		}
		list = query.list();
		if(list != null && list.size() > 0)
		{
			return (List<AfMission>)PageUtils.getListPage(list, page);
		}
		return null;
	}
}
