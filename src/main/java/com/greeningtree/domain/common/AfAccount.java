package com.greeningtree.domain.common;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.greeningtree.util.JUtility;
@Entity
@Table(name="af_account")
public class AfAccount implements java.io.Serializable{
	@Id
	@GenericGenerator(name = "generator", strategy = "native")
	@GeneratedValue(generator = "generator")
	private Integer id;	
	@Column(name = "account_id")
	private String accountId;
	private String email;
	private String username;
	private String password;
	@Column(name = "register_time")
	private Date registerTime;
	private int exp;
	private int role;
	private int status;
	private String mobile;
	private int sex;
	private String area;
	@Column(name = "register_type")
	private int registerType;
	@Column(name = "afforest_tree")
	private String afforestTree;
	private int afb;
	@Column(name = "real_name")
	private String realName;
	@Column(name = "id_card")
	private String idCard;
	private String zhifubao;
	@Column(name = "interest_in")
	private String interestIn;
	@Column(name = "login_cookie")
	private String loginCookie;
	@Column(name = "last_active_time")
	private Date lastActiveTime;
	@Column(name = "last_active_ip")
	private String lastActiveIp;
	@Column(name = "init_data_flag")
	private String initDataFlag;
	public AfAccount(){
		
	}
	public AfAccount(String email, String username, String password){
		this.accountId = JUtility.strToMD5(email);
		this.username = username;
		this.registerType = 1;
		if(registerType == 1){
			this.email = email;
		}else if(registerType == 2){
//			this.mobile = accountId;
		}
		this.password = JUtility.strToMD5(password);
		this.registerTime = new Date();
		this.sex = 0;
		this.exp = 0;
		this.role = 1;
		this.status = 1;
		this.afforestTree = "[]";
		this.afb = 0;
		this.interestIn = "[]";
		this.lastActiveTime = new Date();
		this.initDataFlag = "{}";
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	public int getExp() {
		return exp;
	}
	public void setExp(int exp) {
		this.exp = exp;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public int getRegisterType() {
		return registerType;
	}
	public void setRegisterType(int registerType) {
		this.registerType = registerType;
	}
	public String getAfforestTree() {
		return afforestTree;
	}
	public void setAfforestTree(String afforestTree) {
		this.afforestTree = afforestTree;
	}
	public int getAfb() {
		return afb;
	}
	public void setAfb(int afb) {
		this.afb = afb;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getZhifubao() {
		return zhifubao;
	}
	public void setZhifubao(String zhifubao) {
		this.zhifubao = zhifubao;
	}
	public String getInterestIn() {
		return interestIn;
	}
	public void setInterestIn(String interestIn) {
		this.interestIn = interestIn;
	}
	public String getLoginCookie() {
		return loginCookie;
	}
	public void setLoginCookie(String loginCookie) {
		this.loginCookie = loginCookie;
	}
	public Date getLastActiveTime() {
		return lastActiveTime;
	}
	public void setLastActiveTime(Date lastActiveTime) {
		this.lastActiveTime = lastActiveTime;
	}
	public String getLastActiveIp() {
		return lastActiveIp;
	}
	public void setLastActiveIp(String lastActiveIp) {
		this.lastActiveIp = lastActiveIp;
	}
	public String getInitDataFlag() {
		return initDataFlag;
	}
	public void setInitDataFlag(String initDataFlag) {
		this.initDataFlag = initDataFlag;
	}
}
