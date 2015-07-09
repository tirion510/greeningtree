package com.greeningtree.service.impl.common;


import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.stereotype.Service;

import com.greeningtree.dao.common.AfCityDao;
import com.greeningtree.domain.common.AfCity;
import com.greeningtree.service.common.AfCityService;

@Service("cityService")
public class AfCityServiceImpl implements AfCityService {
	@Resource
	private AfCityDao cityDao;

	public void getCityCache() {
		List<AfCity> cityList = cityDao.getAllCityList();
		Map allCityMap = new LinkedMap();
		Map<String,Map<String,List<String>>> groupCityMap = new LinkedMap();
		for(AfCity city : cityList){
			allCityMap.put(city.getId(), city.getName());
			if(city.getId().endsWith("0000")){
				if(!groupCityMap.containsKey(city.getId())){
					Map provinceMap = new LinkedMap();
					groupCityMap.put(city.getId(), provinceMap);
				}
			}else if(city.getId().endsWith("00")){
				String provinceId = city.getId().substring(0, 2) + "0000";
				if(!groupCityMap.containsKey(provinceId)){
					Map provinceMap = new LinkedMap();
					groupCityMap.put(city.getId(), provinceMap);
				}
				if(!groupCityMap.get(provinceId).containsKey(city.getId())){
					List townList = new LinkedList();
					groupCityMap.get(provinceId).put(city.getId(), townList);
				}
			}else{
				String provinceId = city.getId().substring(0, 2) + "0000";
				String townId = city.getId().substring(0, 4) + "00";
				if(!groupCityMap.containsKey(provinceId)){
					Map provinceMap = new LinkedMap();
					groupCityMap.put(city.getId(), provinceMap);
				}
				if(!groupCityMap.get(provinceId).containsKey(townId)){
					List townList = new LinkedList();
					groupCityMap.get(provinceId).put(city.getId(), townList);
				}
				if(!groupCityMap.get(provinceId).get(townId).contains(city.getId())){
					groupCityMap.get(provinceId).get(townId).add(city.getId());
				}
			}
		}
//		File file = new File("D://111/4.txt");
//		FileWriter fw;
//		try {
//			fw = new FileWriter(file);
//			fw.write("var allCityMap = new Object();");
//			fw.write("\r\n");
//			fw.write("allCityMap = {");
//			for(Object o : allCityMap.keySet()){
//				fw.write("   '"+o.toString()+"' : '"+allCityMap.get(o).toString()+"',\r\n");
//			}
//			fw.close();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
//		File file = new File("D://111/4.txt");
//		FileWriter fw;
//		try {
//			fw = new FileWriter(file);
//			fw.write("var groupCityMap = new Object();\r\n");
//			fw.write("groupCityMap = {\r\n");
//			for(Object o : groupCityMap.keySet()){
//				fw.write("   '"+o.toString()+"' : {\r\n");
//				int j = 0;
//				for(Object q:groupCityMap.get(o).keySet()){
//					j++;
//					fw.write("      '"+q.toString()+"' : [");
//					for(int i = 0 ;i<groupCityMap.get(o).get(q).size();i++){
//						fw.write("'"+groupCityMap.get(o).get(q).get(i)+"'");
//						if(i != groupCityMap.get(o).get(q).size()-1){
//							fw.write(",");
//						}
//					}
//					fw.write("]");
//					if(j < groupCityMap.get(o).size()){
//						fw.write(",");
//					}
//					fw.write("\r\n");
//				}
//				fw.write("   }");
//				fw.write(",");
//				fw.write("\r\n");
//			}
//			fw.write("}");
//			fw.close();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		var allCityMap = new Object(); 
//		allCityMap = {
//			'110000' : '北京市',
//			'110100' : '市辖区',
//			'110101' : '东城区',
//			'110102' : '西城区',
//			'110105' : '朝阳区',
//			'110106' : '丰台区',
//			'110107' : '石景山区',
//			'110108' : '海淀区',
//			'110109' : '门头沟区',
//			'110200' : '县',
//			'110228' : '密云县',
//			'110229' : '延庆县',
//			'120000' : '天津市'
//		}
//		var groupCityMap = new Object(); 
//		  groupCityMap = {
//		  '110000' : {
//		    '110100'    : ['110101','110102','110105','110106','110107','110108','110109'],
//		    '110200'    : ['110228','110229']
//		    },
//		  '120000' : {}
//		  }
	}
}
