package com.greeningtree.util;

import java.util.List;

public class PageUtils {
	public static List getListPage(List list,int page){
		if(page <= 0){
			page = 1;
		}
		int fromIndex = 0 + 10 * (page -1 );
		int toIndex = 10 * page;
		if(fromIndex > list.size()){
			return null;
		}
		if(toIndex > list.size()){
			toIndex = list.size();
		}
		return list.subList(fromIndex, toIndex);
	}
}
