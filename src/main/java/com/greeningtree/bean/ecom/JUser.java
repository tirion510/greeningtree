package com.greeningtree.bean.ecom;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.greeningtree.bean.common.JObject;

@XmlRootElement(name="JUser")
@XmlAccessorType(XmlAccessType.FIELD)

public class JUser extends JObject {
	
	@XmlElement(name="email")
	private String email;
	@XmlElement(name="username")
	private String username;
	@XmlElement(name="password")
	private String password;
	@XmlElement(name="re_password")
	private String rePassword;
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
	public String getRePassword() {
		return rePassword;
	}
	public void setRePassword(String rePassword) {
		this.rePassword = rePassword;
	}
}
