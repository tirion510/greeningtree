package com.greeningtree.framework.datasource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicDataSource extends AbstractRoutingDataSource{

	private static final Logger logger = LoggerFactory.getLogger(DynamicDataSource.class);  
	
    @Override  
    protected Object determineCurrentLookupKey() {   
    	logger.debug("Routing to DataSource(DBKey="+DbContextHolder.getDbKey()+")");
        return DbContextHolder.getDbKey();   
    }

//	public java.util.logging.Logger getParentLogger()
//			throws SQLFeatureNotSupportedException {
//		return null;
//	} 
}
