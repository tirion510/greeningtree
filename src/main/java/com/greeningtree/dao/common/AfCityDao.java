package com.greeningtree.dao.common;

import java.util.List;

import com.greeningtree.domain.common.AfCity;

public interface AfCityDao {
	
	public AfCity getCity(String cityId);
	public AfCity saveCity(AfCity city);
	public List<AfCity> getAllCityList();
}
