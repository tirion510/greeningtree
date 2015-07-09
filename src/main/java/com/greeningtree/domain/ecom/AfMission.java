package com.greeningtree.domain.ecom;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name="af_mission")
public class AfMission implements java.io.Serializable{
	@Id
	@GenericGenerator(name = "generator", strategy = "native")
	@GeneratedValue(generator = "generator")
	private Integer id;	
	@Column(name = "account_id")
	private String accountId;
	private String title;
	private int type;
	@Column(name = "need_count")
	private int needCount;
	@Column(name = "create_time")
	private Date createTime;
	@Column(name = "end_time")
	private Date endTime;
	private int status;
	@Column(name = "sub_id")
	private String subId;
	private String content;
	private String files;
	public AfMission(){
		
	}
	public AfMission(String accountId,String title,int type,int needCount,Date endTime,String subId,String content,String files){
		this.accountId = accountId;
		this.title = title;
		this.type = type;
		this.needCount = needCount;
		this.createTime = new Date();
		this.endTime = endTime;
		this.status = 1;
		this.subId = subId;
		this.content = content;
		this.files = files;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getNeedCount() {
		return needCount;
	}
	public void setNeedCount(int needCount) {
		this.needCount = needCount;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
}
