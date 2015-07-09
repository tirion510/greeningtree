package com.greeningtree.domain.common;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="af_account_log")
public class AfAccountLog implements java.io.Serializable{
	@Id
	@GenericGenerator(name = "generator", strategy = "native")
	@GeneratedValue(generator = "generator")
	private Integer id;	
	@Column(name = "account_id")
	private String accountId;
	@Column(name = "action_time")
	private Date actionTime;
	@Column(name = "action_ip")
	private String actionIp;
	//1-register 2-login 3-changePassword
	private int type;
	public AfAccountLog(){
		
	}
	public AfAccountLog(String accountId, String actionIp, int type){
		this.accountId = accountId;
		this.actionTime = new Date();
		this.actionIp = actionIp;
		this.type = type;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public Date getActionTime() {
		return actionTime;
	}
	public void setActionTime(Date actionTime) {
		this.actionTime = actionTime;
	}
	public String getActionIp() {
		return actionIp;
	}
	public void setActionIp(String actionIp) {
		this.actionIp = actionIp;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}
