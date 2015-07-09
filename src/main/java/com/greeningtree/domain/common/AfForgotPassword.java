package com.greeningtree.domain.common;

import java.util.Date;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="af_forgot_password")
public class AfForgotPassword implements java.io.Serializable{
	@Id
	@GenericGenerator(name = "generator", strategy = "native")
	@GeneratedValue(generator = "generator")
	private Integer id;	
	@Column(name = "account_id")
	private String accountId;
	@Column(name = "new_account_id")
	private String newAccountId;
	private String content;
	@Column(name = "create_time")
	private Date createTime;
	private int status;
	private String uuid;
	public AfForgotPassword(){
		
	}
	public AfForgotPassword(String accountId, String newAccountId, String content){
		this.accountId = accountId;
		this.newAccountId = newAccountId;
		this.content = content;
		this.createTime = new Date();
		this.status = 1;
		this.uuid = UUID.randomUUID().toString();
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
	public String getNewAccountId() {
		return newAccountId;
	}
	public void setNewAccountId(String newAccountId) {
		this.newAccountId = newAccountId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
}
