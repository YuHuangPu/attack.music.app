package com.ama.service;

import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.ama.common.Keys;
import com.ama.language.LanguageView;
import com.ama.view.Views;
import com.util.SessionUtil;
import com.util.StringsUtil;

import ora.json.JSONArray;
import ora.json.JSONObject;

public class transactionPageManager extends com.ama.common.BaseManager {
	public String execute() {
		HttpServletRequest req;
		try {
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE));

			JSONObject accountMap = this.getAccountMap();
			JSONObject goodsMap = this.getGoodsMap();
			JSONObject consumerMap = this.getConsumerMap();
			LanguageView lgView = this.getLgView();

			String sql = "SELECT * FROM ("
					+ "SELECT SELL_DATE ,"
					+ "CONSUMER_ID, STATUS,"
					+ "SUM(PRICE) AS PRICE,"
					+ "COUNT(*) AS COUNT,"
					+ "SUM(AMOUNT) AS AMOUNT "
					+ "FROM GOODS_DETAIL WHERE STATUS != 'N' "
					+ "GROUP BY STATUS, CONSUMER_ID, SELL_DATE ORDER BY SELL_DATE DESC"
					+ ") A";
			Views Query = new Views(sql, this.getConn());
			JSONArray dgInfoSplitByDayList = Query.getDatalistJSONArray(Boolean.FALSE);
			JSONArray dayKey = new JSONArray();
			JSONObject dayMap = new JSONObject();
			Iterator<Object> itrs = dgInfoSplitByDayList.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				String status = itr.getString("Status").equals("I")
						? (lgView.getId("020") + "/" + consumerMap.getString(itr.getString("ConsumerId")))
						: (lgView.getId("014") + "/" + consumerMap.getString(itr.getString("ConsumerId")));
				String text = String.format(lgView.getId("051"), itr.getInt("Count"), itr.getInt("Amount"), itr.getBigDecimal("Price").intValue());
				dayMap.put(itr.getString("SellDate") + " - " + itr.getString("ConsumerId"), new JSONObject().put("description", itr.put("Status", status).put("text", text)).put("detail", new JSONArray()));
				dayKey.put(itr.getString("SellDate") + " - " + itr.getString("ConsumerId"));
			}

			Views goodsDetail = new Views(this.getConn(), Keys.View.GoodsDetailInfo);
			JSONArray dgInfo = goodsDetail.getDatalistJSONArray(Boolean.FALSE);
			itrs = dgInfo.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				itr.put("CreateWho", accountMap.getString(itr.getString("CreateWho")));
				if (itr.getString("Status").equals("I")) {
					itr.put("StatusText", lgView.getId("020") + " / " + consumerMap.getString(itr.getString("ConsumerId")));
				} else {
					itr.put("StatusText", lgView.getId("014") + " / " + consumerMap.getString(itr.getString("ConsumerId")));
				}
				itr.put("GoodsName", goodsMap.getString(itr.getString("GoodsId")));
				itr.put("Status", itr.getString("Status").equals("I")
						? "Purchase"
						: "Sell");
				dayMap.getJSONObject(itr.getString("SellDate") + " - " + itr.getString("ConsumerId")).getJSONArray("detail").put(itr);
			}

			Views maxUpdate = new Views(this.getConn(), Keys.View.GoodsDetailMaxUpdate);
			JSONArray mUpdate = maxUpdate.getDatalistJSONArray(Boolean.FALSE);

			Views factoryInfo = new Views(this.getConn(), Keys.View.FactoryInfo);
			JSONArray factory = factoryInfo.getDatalistJSONArray(Boolean.FALSE);
			itrs = factory.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				itr.put("Value", itr.getString("Id"));
				itr.put("Text", String.format("%s - %s", itr.getString("Id"), itr.getString("Name")));
			}

			JSONArray hasReserveGoods = new JSONArray();
			JSONArray RGs = new JSONArray();
			Views TransactionInfo = new Views(this.getConn(), Keys.View.TransactionInfo);
			RGs = TransactionInfo.getDatalistJSONArray(Boolean.FALSE);
			itrs = RGs.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				itr.put("Value", itr.getString("Id"));
				itr.put("Text", String.format("%s - %s - " + lgView.getId("013") + ":%s", itr.getString("Id"), itr.getString("Name"), itr.getString("Reserve")));
				if (itr.getInt("Reserve") != 0) {
					hasReserveGoods.put(itr);
				}
			}
			// RGs = new
			// JSONArray().put(RGs.getJSONObject(0)).put(RGs.getJSONObject(0)).put(RGs.getJSONObject(0)).put(RGs.getJSONObject(0));
			Views ConsumerInfo = new Views(this.getConn(), Keys.View.ConsumerInfo);
			JSONArray consumerByDayList = ConsumerInfo.getDatalistJSONArray(Boolean.FALSE);
			JSONArray consumer = new JSONArray();
			itrs = consumerByDayList.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				if (!itr.getString("Status").equals("D")) {
					itr.put("Value", itr.getString("Id"));
					itr.put("Text", String.format("%s - %s", itr.getString("Id"), itr.getString("Name")));
					consumer.put(itr);
				} else {
					itr.put("Value", itr.getString("Status"));
					itr.put("Text", String.format("%s - %s", lgView.getId("020"), itr.getString("Name")));
				}
			}

			req = (HttpServletRequest) ServletActionContext.getRequest();
			req.setAttribute("gdInfoKey", dayKey);
			req.setAttribute("gdInfoMap", dayMap);
			req.setAttribute("MaxUpdate", mUpdate.getJSONObject(0).getString("MaxUpdate"));

			req.setAttribute("factorys", factory);
			req.setAttribute("RGs", RGs);
			req.setAttribute("RGsStr", RGs.toString().replace("\"", "\\\"").replace("'", "\\'"));
			req.setAttribute("hasReserveGoods", hasReserveGoods);
			req.setAttribute("DayListConsumers", consumerByDayList);
			req.setAttribute("consumers", consumer);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			com.util.DataBaseUtil.closeConnection(this.getConn());
		}
		return Keys.WEB_Successful;
	}

}
