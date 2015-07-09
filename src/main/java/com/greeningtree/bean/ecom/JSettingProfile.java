package com.greeningtree.bean.ecom;

import com.greeningtree.domain.common.AfAccount;
import com.greeningtree.util.StringUtils;

public class JSettingProfile {
	private String username;
	
	private String province;
	
	private String city;
	
	private String region;
	
	private String defaultArea;
	
	private int sex;
	
	private String realName;
	
	private String idCard;
	
	private String zhifubao;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getDefaultArea() {
		return defaultArea;
	}

	public void setDefaultArea(String defaultArea) {
		this.defaultArea = defaultArea;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
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

	public AfAccount updateAccount(AfAccount account){
		if(StringUtils.checkEmpty(this.username)){
			account.setUsername(username);
		}
		if(StringUtils.checkEmpty(this.region)){
			account.setArea(this.region);
		}else if(StringUtils.checkEmpty(this.city)){
			account.setArea(this.city);
		}else if(StringUtils.checkEmpty(this.province)){
			account.setArea(this.province);
		}else{
			account.setArea("");
		}
		account.setSex(this.sex);
		if(StringUtils.checkEmpty(this.idCard)){
			account.setIdCard(idCard);
		}
		if(StringUtils.checkEmpty(this.realName)){
			account.setRealName(realName);
		}
		if(StringUtils.checkEmpty(this.zhifubao)){
			account.setZhifubao(zhifubao);
		}
		return account;
	}
	
	public JSettingProfile(){}
	
	public JSettingProfile(AfAccount account){
		this.username = account.getUsername();
		this.defaultArea = account.getArea();
		this.sex = account.getSex();
		this.realName = account.getRealName();
		this.idCard = account.getIdCard();
		this.zhifubao = account.getZhifubao();
	}
}
