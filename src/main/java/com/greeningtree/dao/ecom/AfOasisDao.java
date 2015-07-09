package com.greeningtree.dao.ecom;

import java.util.List;

import com.greeningtree.domain.ecom.AfOasis;

public interface AfOasisDao {
	public AfOasis getOasis(int id);
	public AfOasis saveOasis(AfOasis oasis);
	public void updateOasis(AfOasis oasis);
	public void deleteOasis(int id);
	public List<AfOasis> getOasisListByType(int oasisType);
	public List<AfOasis> getAllOasisList();
}
