package com.ama.common;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;

import org.apache.struts2.ServletActionContext;

import com.ama.data.info.UserInfo;
import com.ama.language.LanguageView;
import com.ama.view.Views;
import com.util.SessionUtil;

import ora.json.JSONArray;
import ora.json.JSONException;
import ora.json.JSONObject;

public class BaseManager {
	public BaseManager(){
		this.setUserInfo(((UserInfo)SessionUtil.getSession(Keys.Session.LoginAccount)));
		this.setLgView((LanguageView)SessionUtil.getSession("lgView"));
		setMap();
	}
	private LanguageView lgView ;
	
	public LanguageView getLgView() {
		return lgView;
	}
	public void setLgView(LanguageView lgView) {
		this.lgView = lgView;
	}
	private JSONObject accountMap, factoryMap, GoodsMap, ConsumerMap;
	public JSONObject getAccountMap() {
		return accountMap;
	}
	public void setAccountMap(JSONObject accountMap) {
		this.accountMap = accountMap;
	}
	public JSONObject getFactoryMap() {
		return factoryMap;
	}
	public void setFactoryMap(JSONObject factoryMap) {
		this.factoryMap = factoryMap;
	}
	public JSONObject getGoodsMap() {
		return GoodsMap;
	}
	public void setGoodsMap(JSONObject goodsMap) {
		GoodsMap = goodsMap;
	}
	public JSONObject getConsumerMap() {
		return ConsumerMap;
	}
	public void setConsumerMap(JSONObject consumerMap) {
		ConsumerMap = consumerMap;
	}
	
	private Connection conn ;
	private com.ama.data.info.UserInfo userInfo ;
	public Connection getConn() {
		return conn;
	}
	public void setConn(Connection conn) {
		this.conn = conn;
	}
	public com.ama.data.info.UserInfo getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(com.ama.data.info.UserInfo login) {
		this.userInfo = login;
	}
	
	private void setMap(){
		Connection conn = null ;
		try{
			conn = com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE);
			Views accountMap = new Views(conn, Keys.View.AccountMap);
			this.setAccountMap(queryMap(accountMap));
			
			Views factoryMap = new Views(conn, Keys.View.FactoryMap);
			this.setFactoryMap(queryMap(factoryMap));
			
			Views GoodsMap = new Views(conn, Keys.View.GoodsMap);
			this.setGoodsMap(queryMap(GoodsMap));
			
			Views ConsumerMap = new Views(conn, Keys.View.ConsumerMap);
			this.setConsumerMap(queryMap(ConsumerMap));
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			com.util.DataBaseUtil.closeConnection(conn);
		}
	}
	private JSONObject queryMap(Views map) throws JSONException, SQLException{
		JSONArray aMap = map.getDatalistJSONArray(Boolean.FALSE);
		JSONObject v = new JSONObject(aMap.length());
		Iterator<Object> itrs = aMap.iterator();
		while(itrs.hasNext()){
			JSONObject itr = (JSONObject)itrs.next();
			v.put(itr.getString("Key"), itr.getString("Value"));
		}
		return v;
	}

}
