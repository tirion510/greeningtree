package com.greeningtree.domain.ecom;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name="af_oasis")
public class AfOasis implements java.io.Serializable{
	@Id
	@GenericGenerator(name = "generator", strategy = "native")
	@GeneratedValue(generator = "generator")
	private Integer id;	
	@Column(name = "oasis_id")
	private String oasisId;
	@Column(name = "oasis_name")
	private String oasisName;
	@Column(name = "oasis_type")
	private Integer oasisType;
	@Column(name = "create_time")
	private Date createTime;
	@Column(name = "create_account")
	private String createAccount;
	@Column(name = "oasis_state")
	private Integer oasisState;
	@Column(name = "oasis_index")
	private Integer oasisIndex;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOasisId() {
		return oasisId;
	}
	public void setOasisId(String oasisId) {
		this.oasisId = oasisId;
	}
	public String getOasisName() {
		return oasisName;
	}
	public void setOasisName(String oasisName) {
		this.oasisName = oasisName;
	}
	public Integer getOasisType() {
		return oasisType;
	}
	public void setOasisType(Integer oasisType) {
		this.oasisType = oasisType;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCreateAccount() {
		return createAccount;
	}
	public void setCreateAccount(String createAccount) {
		this.createAccount = createAccount;
	}
	public Integer getOasisState() {
		return oasisState;
	}
	public void setOasisState(Integer oasisState) {
		this.oasisState = oasisState;
	}
	public Integer getOasisIndex() {
		return oasisIndex;
	}
	public void setOasisIndex(Integer oasisIndex) {
		this.oasisIndex = oasisIndex;
	}
}
