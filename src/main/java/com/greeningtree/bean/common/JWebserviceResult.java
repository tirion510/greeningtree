package com.greeningtree.bean.common;

public class JWebserviceResult {

	private String result;
	private JErrorMessage errorMessage;
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public JErrorMessage getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(JErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}
	
}
