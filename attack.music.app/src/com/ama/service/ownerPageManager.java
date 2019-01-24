package com.ama.service;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.ama.common.Keys;
import com.ama.view.Views;

import ora.json.JSONArray;
import ora.json.JSONObject;
public class ownerPageManager extends com.ama.common.BaseManager{
	public String execute(){
		HttpServletRequest req;
		try {
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE));
			Views ownerInfo = new Views(this.getConn(), Keys.View.OwnerInfo);
			JSONArray oInfo = ownerInfo.getDatalistJSONArray(Boolean.FALSE);
			String sql = "SELECT FORMAT(SUM(GD.PRICE), 0) AS `SUM`, GD.STATUS FROM GOODS_DETAIL GD WHERE GD.STATUS != 'N' GROUP BY GD.STATUS";
			Views Query = new Views(sql, this.getConn());
			JSONArray tempArray = Query.getDatalistJSONArray(Boolean.FALSE);
			Iterator<Object> itrs = tempArray.iterator();
			JSONObject result = new JSONObject();
			while(itrs.hasNext()){
				JSONObject itr = (JSONObject) itrs.next();
				result.put(itr.getString("Status"), itr.getString("Sum"));
			}
			sql = "SELECT A.SUM, A.SELL_DATE FROM ("
					+"SELECT SUM(PRICE) AS SUM, DATE_FORMAT(SELL_DATE, '%m-%d')AS SELL_DATE FROM GOODS_DETAIL GROUP BY SELL_DATE ORDER BY SELL_DATE DESC  LIMIT 0, 15"
					+") A ORDER BY SELL_DATE ASC;";
			Query = new Views(sql, this.getConn());
			tempArray = Query.getDatalistJSONArray(Boolean.FALSE);
			itrs = tempArray.iterator();
			JSONArray title = new JSONArray();
			JSONArray value = new JSONArray();
			int max = 0;
			while(itrs.hasNext()){
				JSONObject itr = (JSONObject) itrs.next();
				title.put(itr.getString("SellDate"));
				value.put(itr.getBigDecimal("Sum").intValue());
				max = itr.getBigDecimal("Sum").intValue() > max ? itr.getBigDecimal("Sum").intValue() : max;
			}
			result.put("chartData", new JSONObject().put("max", max).put("title", title).put("value", value));
			
			req = (HttpServletRequest) ServletActionContext.getRequest();
			req.setAttribute("AmountCost", oInfo.getJSONObject(0).getString("AmountCost"));
			req.setAttribute("DataMap", result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			com.util.DataBaseUtil.closeConnection(this.getConn());
		}
		return Keys.WEB_Successful;
	}
}
