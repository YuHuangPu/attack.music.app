package com.ama.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.ama.common.Keys;
import com.ama.common.box.SearchMenu;
import com.ama.common.box.SearchMenu.Element;
import com.ama.common.box.SearchMenu.Elements;
import com.ama.view.Views;
import com.util.SessionUtil;
import com.util.StringsUtil;

import ora.json.JSONArray;
import ora.json.JSONObject;

public class trashPageManager extends com.ama.common.BaseManager{
	public String execute(){
		HttpServletRequest req;
		try {
			this.setConn(com.util.DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.TRUE));
			SearchMenu searchMenu = new SearchMenu();
			
			Elements testGroup = searchMenu.new Elements();
			Element test1Title = new Element();
			Element test1Value = new Element();
			test1Title.setType(SearchMenu.Element.TYPE.TEXT);
			test1Title.setText("textText");
			
			test1Value.setType(SearchMenu.Element.TYPE.INPUT);
			test1Value.setName("testTextName");

			testGroup.getElement().add(test1Title);
			testGroup.getElement().add(test1Value);
			searchMenu.getElements().add(testGroup);
			
			
			req = (HttpServletRequest) ServletActionContext.getRequest();
			req.setAttribute("searchMenu", searchMenu);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			com.util.DataBaseUtil.closeConnection(this.getConn());
		}
		return Keys.WEB_Successful;
	}
}
