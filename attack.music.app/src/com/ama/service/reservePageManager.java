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

public class reservePageManager extends com.ama.common.BaseManager{
	public String execute(){
		HttpServletRequest req;
		try {
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE));
			
			Views goods = new Views(this.getConn(), Keys.View.GoodsInfo);
			JSONArray gInfo = goods.getDatalistJSONArray(Boolean.FALSE);
			
			JSONObject accountMap = this.getAccountMap();
			JSONObject factoryMap = this.getFactoryMap();
			Iterator<Object> itrs = gInfo.iterator();
			while(itrs.hasNext()){
				JSONObject itr = (JSONObject)itrs.next();
				itr.put("CreateWho", accountMap.getString(itr.getString("CreateWho")));
				if(!StringsUtil.isNull(itr.getString("UpdateWho")))
				itr.put("UpdateWho", accountMap.getString(itr.getString("UpdateWho")));
				itr.put("FactoryName", factoryMap.getString(itr.getString("Factory")));
			}
			
			
			Views maxUpdate = new Views(this.getConn(), Keys.View.GoodsDetailMaxUpdate);
			JSONArray mUpdate = maxUpdate.getDatalistJSONArray(Boolean.FALSE);
			
			Views factoryInfo = new Views(this.getConn(), Keys.View.FactoryInfo);
			JSONArray factory = factoryInfo.getDatalistJSONArray(Boolean.FALSE);
			itrs = factory.iterator();
			while(itrs.hasNext()){
				JSONObject itr = (JSONObject)itrs.next();
				itr.put("Value", itr.getString("Id"));
				itr.put("Text", String.format("%s - %s", itr.getString("Id"), itr.getString("Name")));
			}
			
			
			
			req = (HttpServletRequest) ServletActionContext.getRequest();
			req.setAttribute("gInfo", gInfo);
			req.setAttribute("MaxUpdate", mUpdate.getJSONObject(0).getString("MaxUpdate"));
			req.setAttribute("factorys", factory);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			com.util.DataBaseUtil.closeConnection(this.getConn());
		}
		return Keys.WEB_Successful;
	}
}
