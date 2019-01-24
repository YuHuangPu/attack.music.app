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

public class factoryPageManager extends com.ama.common.BaseManager{
	public String execute(){
		HttpServletRequest req;
		try {
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE));
			
			Views factoryInfo = new Views(this.getConn(), Keys.View.FactoryInfo);
			JSONArray fInfo = factoryInfo.getDatalistJSONArray(Boolean.FALSE);
			JSONObject accountMap = this.getAccountMap();
			Iterator<Object> itrs = fInfo.iterator();
			while(itrs.hasNext()){
				JSONObject itr = (JSONObject)itrs.next();
				itr.put("CreateWho", accountMap.getString(itr.getString("CreateWho")));
				if(!StringsUtil.isNull(itr.getString("UpdateWho")))
				itr.put("UpdateWho", accountMap.getString(itr.getString("UpdateWho")));
			}
			
			
			Views maxUpdate = new Views(this.getConn(), Keys.View.FactoryMaxUpdate);
			JSONArray mUpdate = maxUpdate.getDatalistJSONArray(Boolean.FALSE);
			
			req = (HttpServletRequest) ServletActionContext.getRequest();
			req.setAttribute("fInfo", fInfo);
			req.setAttribute("MaxUpdate", mUpdate.getJSONObject(0).getString("MaxUpdate"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			com.util.DataBaseUtil.closeConnection(this.getConn());
		}
		return Keys.WEB_Successful;
	}
}
