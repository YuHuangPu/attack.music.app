package com.ama.data.info;

public class UserInfo {
	
	public final static String ID 			= "Id";
	public final static String ACCOUNT 		= "Account";
	public final static String PASSWORD 	= "Password";
	public final static String STATUS		= "Status";
	public final static String EMAIL 		= "Email";
	public final static String REMARK		= "Remark";
	public final static String CREATE_DATE 	= "CreateDate";
	
	private String Id 			= "Id";
	private String Account 		= "Account";
	private String Password 	= "Password";
	private String Status		= "Status";
	private String Email 		= "Email";
	private String Remark		= "Remark";
	private String Create_date 	= "CreateDate";
	
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public String getAccount() {
		return Account;
	}
	public void setAccount(String account) {
		Account = account;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getRemark() {
		return Remark;
	}
	public void setRemark(String remark) {
		Remark = remark;
	}
	public String getCreate_date() {
		return Create_date;
	}
	public void setCreate_date(String create_date) {
		Create_date = create_date;
	}

	
	private Boolean LoginStatus;
	
	public Boolean getLoginStatus() {
		return LoginStatus;
	}

	public void setLoginStatus(Boolean loginStatus) {
		LoginStatus = loginStatus;
	}
	
}
