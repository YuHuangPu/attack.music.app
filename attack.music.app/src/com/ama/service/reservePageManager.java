package com.ama.service;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.ama.common.Keys;
import com.ama.common.box.Element;
import com.ama.common.box.Input;
import com.ama.common.box.Label;
import com.ama.common.box.SearchMenu;
import com.ama.factory.SqlFactory;
import com.ama.language.LanguageView;
import com.ama.view.Views;
import com.opensymphony.xwork2.ActionContext;
import com.util.StringsUtil;

import ora.json.JSONArray;
import ora.json.JSONObject;

public class reservePageManager extends com.ama.common.BaseManager {
	public String execute() {
		HttpServletRequest req;
		try {
			req = (HttpServletRequest) ServletActionContext.getRequest();
			setSearchMenu(req);
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.COMPANY_JNDI_NAME, Boolean.TRUE));

			String goodsId = StringsUtil.eliminateNull(req.getParameter("goodsId"));
			String goodsName = StringsUtil.eliminateNull(req.getParameter("goodsName"));
			String factory = StringsUtil.eliminateNull(req.getParameter("factory"));
			Views goods = new Views(SqlFactory.getReserveInfo("AND ID like ? AND NAME like ? AND factory in (select f.id from factory f where f.name like ?)"), this.getConn());
			goods.setPstmt("%" + goodsId + "%", "%" + goodsName + "%", "%" + factory + "%");
			JSONArray gInfo = goods.getDatalistJSONArray(Boolean.FALSE);
//			goods.getDatalistJSONArray(Boolean.FALSE);

			JSONObject accountMap = this.getAccountMap();
			JSONObject factoryMap = this.getFactoryMap();
			Iterator<Object> itrs = gInfo.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				itr.put("CreateWho", accountMap.getString(itr.getString("CreateWho")));
				if (!StringsUtil.isNull(itr.getString("UpdateWho")))
					itr.put("UpdateWho", accountMap.getString(itr.getString("UpdateWho")));
				itr.put("FactoryName", factoryMap.getString(itr.getString("Factory")));
			}

			Views maxUpdate = new Views(this.getConn(), Keys.View.GoodsDetailMaxUpdate);
			JSONArray mUpdate = maxUpdate.getDatalistJSONArray(Boolean.FALSE);

			Views vw = new Views(SqlFactory.getFactoryInfo(), this.getConn());
			JSONArray factoryData = vw.getDatalistJSONArray(Boolean.FALSE);
			itrs = factoryData.iterator();
			while (itrs.hasNext()) {
				JSONObject itr = (JSONObject) itrs.next();
				itr.put("Value", itr.getString("Id"));
				itr.put("Text", String.format("%s - %s", itr.getString("Id"), itr.getString("Name")));
			}

			req.setAttribute("gInfo", gInfo);
			req.setAttribute("MaxUpdate", mUpdate.getJSONObject(0).getString("MaxUpdate"));
			req.setAttribute("factorys", factoryData);
			req.setAttribute("actionName", ActionContext.getContext().getName());
			req.setAttribute("searchTemp", StringsUtil.eliminateNull(req.getParameter("searchTemp")));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			com.util.DataBaseUtil.closeConnection(this.getConn());
		}
		return Keys.WEB_SUCCESSFUL;
	}

	private void setSearchMenu(HttpServletRequest req) {
		LanguageView lg = (LanguageView) req.getAttribute("lgView");
		SearchMenu sm = new SearchMenu();
		Element id = new Input(new Label(lg.getId("005") + " : "), "form-control form-control-sm", "text", "goodsId",
				StringsUtil.eliminateNull(req.getParameter("goodsId")), null);
		Element name = new Input(new Label(lg.getId("006") + " : "), "form-control form-control-sm", "text",
				"goodsName", StringsUtil.eliminateNull(req.getParameter("goodsName")), null);
		Element factory = new Input(new Label(lg.getId("002") + " : "), "form-control form-control-sm", "text",
				"factory", StringsUtil.eliminateNull(req.getParameter("factory")), null);

		sm.setElements(Arrays.asList(id, name, factory));
		req.setAttribute("searchMenu", sm);
	}
}
