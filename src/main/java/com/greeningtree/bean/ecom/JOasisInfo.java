package com.greeningtree.bean.ecom;

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.greeningtree.bean.common.JObject;
import com.greeningtree.domain.ecom.AfOasisType;

@XmlRootElement(name="oasisInfo")
@XmlAccessorType(XmlAccessType.FIELD)
public class JOasisInfo extends JObject {
	@XmlElement(name="oasis_type_id")
	private Integer oasisTypeId;
	
	private Integer status;
	
	@XmlElement(name="focus_date")
	private Date focusDate;
	
	private Integer point;
	
	private AfOasisType oasisType;

	public Integer getOasisTypeId() {
		return oasisTypeId;
	}

	public void setOasisTypeId(Integer oasisTypeId) {
		this.oasisTypeId = oasisTypeId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getFocusDate() {
		return focusDate;
	}

	public void setFocusDate(Date focusDate) {
		this.focusDate = focusDate;
	}

	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public AfOasisType getOasisType() {
		return oasisType;
	}

	public void setOasisType(AfOasisType oasisType) {
		this.oasisType = oasisType;
	}
	
	public String objectToXml()
	{
		this.oasisType = null;
		return super.objectToXml();
	}

	public JOasisInfo(){

	}

	public JOasisInfo(Integer oasisTypeId){
		this.oasisTypeId = oasisTypeId;
		this.status = 1;
		this.focusDate = new Date();
		this.point = 0;
	}
}
