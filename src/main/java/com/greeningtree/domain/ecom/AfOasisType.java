package com.greeningtree.domain.ecom;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name="af_oasis_type")
public class AfOasisType implements java.io.Serializable{
	@Id
	@GenericGenerator(name = "generator", strategy = "native")
	@GeneratedValue(generator = "generator")
	private Integer id;	
	@Column(name = "oasis_type_id")
	private String oasisTypeId;
	@Column(name = "oasis_type_name")
	private String oasisTypeName;
	@Column(name = "create_time")
	private Date createTime;
	@Column(name = "oasis_type_index")
	private Integer oasisTypeIndex;
	private Integer status;
	private String icon;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOasisTypeId() {
		return oasisTypeId;
	}
	public void setOasisTypeId(String oasisTypeId) {
		this.oasisTypeId = oasisTypeId;
	}
	public String getOasisTypeName() {
		return oasisTypeName;
	}
	public void setOasisTypeName(String oasisTypeName) {
		this.oasisTypeName = oasisTypeName;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getOasisTypeIndex() {
		return oasisTypeIndex;
	}
	public void setOasisTypeIndex(Integer oasisTypeIndex) {
		this.oasisTypeIndex = oasisTypeIndex;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
}
