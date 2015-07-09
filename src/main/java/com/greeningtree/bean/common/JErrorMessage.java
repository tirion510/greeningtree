package com.greeningtree.bean.common;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="ErrorMessage")
@XmlAccessorType(XmlAccessType.FIELD)

//x01  api user test
//x02  login user test
//>=x03 error message
public class JErrorMessage extends JObject {
	
	@XmlElement(name="error_code")
	private Integer errorCode;
	@XmlElement(name="error_message")
	private String errorMsg;
	
	public Integer getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(Integer errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
	public JErrorMessage()
	{
		super();
	}
	
	public Object xmlToObject(String xml, String name)
	{
		if(xml != null && xml.indexOf("error_code") >= 0)
		{
			xml = xml.replaceAll("<"+ name + ">", "<ErrorMessage>").replaceAll("</"+ name + ">", "</ErrorMessage>");
			xml = xml.replaceAll("<root>", "<ErrorMessage>").replaceAll("</root>", "</ErrorMessage>");
			return this.xmlToObject(xml);
		}
		return null;
		
	}
}
