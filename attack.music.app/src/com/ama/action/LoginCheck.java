package com.ama.action;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ama.common.Keys;
import com.ama.language.LanguageView;
import com.ama.view.Views;
import com.util.SessionUtil;

import ora.json.JSONArray;
import ora.json.JSONException;
import ora.json.JSONObject;

public class LoginCheck extends com.ama.data.info.UserInfo {
	private Logger log = LoggerFactory.getLogger(Views.class);
	
	public String execute(){		
		return checkUserInfo();
	}
	
	private String checkUserInfo(){
		Views accountView;
		Connection conn = null ;
		try{
			this.setLoginStatus(Boolean.FALSE);
			conn = com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE);
			accountView = new Views(conn, Keys.View.UserInfo) ;
			String MD5Password = com.util.EncryptUtil.EncryptString(this.getPassword());
			accountView.setPstmt( MD5Password, this.getAccount());
			JSONArray LoginAccount = accountView.getDatalistJSONArray(Boolean.FALSE);
			if(LoginAccount.length() == 0 ){
				return com.ama.common.Keys.WEB_Fail;
			}
			JSONObject Account = LoginAccount.getJSONObject(0);
			if(Account.getBoolean("IsPass")){
				loginDo(Account, conn);
				return com.ama.common.Keys.WEB_Successful;
			}else{
				return com.ama.common.Keys.WEB_Fail;
			}
					
		}catch(SQLException e){
			e.printStackTrace();
			log.error(e.getMessage());
			return com.ama.common.Keys.WEB_Fail;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			log.error(e.getMessage());
			return com.ama.common.Keys.WEB_Fail;
		} finally{
			com.util.DataBaseUtil.closeConnection(conn);
			log.info(String.format("[ %s ] LoginStatus [ %s ]", this.getAccount(), this.getLoginStatus()));
		}
	}
	
	private void loginDo(JSONObject Account, Connection conn ) throws JSONException, SQLException{
		this.setEmail(Account.getString("Email"));
		this.setRemark(Account.getString("Remark"));
		this.setId(Account.getString("Id"));
		this.setLoginStatus(Boolean.TRUE);
		SessionUtil.setSession(Keys.Session.LoginAccount, this);
		Boolean lgTag = SessionUtil.getSession("lgView") == null;
		if(lgTag){
			SessionUtil.setSession("lgView", new LanguageView("tw"));
		}
	}
}
