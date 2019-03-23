package com.ama.service;

import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.ama.common.Keys;
import com.ama.view.Views;
import com.util.SessionUtil;
import com.util.StringsUtil;

import ora.json.JSONArray;
import ora.json.JSONObject;

public class consumerPageManager extends com.ama.common.BaseManager{
	public String execute(){
		HttpServletRequest req;
		try {
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.COMPANY_JNDI_NAME, Boolean.TRUE));
			
			Views consumerInfo = new Views(this.getConn(), Keys.View.ConsumerInfo);
			JSONArray consumers = consumerInfo.getDatalistJSONArray(Boolean.FALSE);
			JSONArray consumerUse = new JSONArray();
			JSONObject accountMap = this.getAccountMap();
			Iterator<Object> itrs = consumers.iterator();
			while(itrs.hasNext()){
				JSONObject itr = (JSONObject)itrs.next();
				if(itr.getString("Status").equals("S")){
					itr.put("CreateWho", accountMap.getString(itr.getString("CreateWho")));
					if(!StringsUtil.isNull(itr.getString("UpdateWho")))
						itr.put("UpdateWho", accountMap.getString(itr.getString("UpdateWho")));
					consumerUse.put(itr);
				}
				
			}
			
			
			Views maxUpdate = new Views(this.getConn(), Keys.View.ConsumerMaxUpdate);
			JSONArray mUpdate = maxUpdate.getDatalistJSONArray(Boolean.FALSE);
			
			req = (HttpServletRequest) ServletActionContext.getRequest();
			req.setAttribute("consumers", consumerUse);
			req.setAttribute("MaxUpdate", mUpdate.getJSONObject(0).getString("MaxUpdate"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			com.util.DataBaseUtil.closeConnection(this.getConn());
			
		}
		return Keys.WEB_SUCCESSFUL;
	}
}
