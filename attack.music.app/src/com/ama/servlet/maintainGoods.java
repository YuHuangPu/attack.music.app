package com.ama.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ama.common.Keys;
import com.ama.data.info.UserInfo;
import com.util.DataBaseUtil;
import com.util.StringsUtil;

import ora.json.JSONException;
import ora.json.JSONObject;

/**
 * Servlet implementation class addFactory
 */
@WebServlet("/purchaseGoods")
public class maintainGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public maintainGoods() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter result = null;
		Connection conn = null;
		try {
			result = response.getWriter();
			conn = DataBaseUtil.getConnection(Keys.CompanyJndiName, Boolean.FALSE);
			ora.json.JSONObject reqJson = com.util.JsonsUtil.getJsonObject(request);
			result.append(execute(request, response, reqJson, conn));
		} catch (Exception e) {
			e.printStackTrace();
			result.append(new JSONObject().put("status", Boolean.FALSE).put("message", "something error").toString());
			DataBaseUtil.RollBack(conn);
		} finally{
			DataBaseUtil.closeConnection(conn);
			result.close();
		}
	}
	private String execute(HttpServletRequest request, HttpServletResponse response, ora.json.JSONObject reqJson, Connection conn) throws SQLException, JSONException, ParseException{
		JSONObject result = new JSONObject().put("status", Boolean.TRUE);
		PreparedStatement pstmt = null;
		String userID = (((UserInfo)request.getSession().getAttribute(Keys.Session.LoginAccount)).getId());
		java.sql.Timestamp CreateDate = new java.sql.Timestamp(new Date().getTime());
		if(reqJson.has("addGoods")){
			reqJson = reqJson.getJSONObject("addGoods");
			Iterator<Object> itrs = reqJson.getJSONArray("GoodsList").iterator();
			while(itrs.hasNext()){
				JSONObject goods = (JSONObject)itrs.next();
				goods.put("FactoryId", reqJson.getString("FactoryId"));
				goods.put("GoodsId",StringsUtil.nvlString(goods.getString("GoodsId"), "0") );
				goods.put("GoodsReserve",StringsUtil.nvlString(goods.getString("GoodsReserve"), "0") );
				goods.put("GoodsCost", StringsUtil.nvlString(goods.getString("GoodsCost"), "0") );
				goods.put("GoodsPrice", StringsUtil.nvlString(goods.getString("GoodsPrice"), "0") );
				addGoods(goods, conn, pstmt, CreateDate, userID);
			}
		}else if(reqJson.has("editGoods")){
			reqJson = reqJson.getJSONObject("editGoods");
			
			String sql = "UPDATE `GOODS` SET "
					+ "`NAME` = ?, "
					+ "`RESERVE` = ?, "
					+ "`COST` = ?, "
					+ "`PRICE` = ?, "
					+ "`FACTORY` = ?, "
					+ "`REMARK` = ?, "
					+ "`UPDATE_DATE` = ?, "
					+ "`UPDATE_WHO` = ? "
					+ "WHERE `GOODS`.`ID` = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reqJson.getString("GoodsName"));
			pstmt.setString(2, reqJson.getString("GoodsReserve"));
			pstmt.setString(3, reqJson.getString("GoodsCost"));
			pstmt.setString(4, reqJson.getString("GoodsPrice"));
			pstmt.setString(5, reqJson.getString("FactoryId"));
			pstmt.setString(6, reqJson.getString("GoodsRemark"));
			pstmt.setTimestamp(7, CreateDate);
			pstmt.setString(8, userID);
			pstmt.setString(9, reqJson.getString("GoodsId"));
			pstmt.execute();
			
		}else if(reqJson.has("delGoods")){
			reqJson = reqJson.getJSONObject("delGoods");
			
			String sql = "UPDATE `GOODS` SET "
					+ "`STATUS` = 'N', "
					+ "`UPDATE_DATE` = ?, "
					+ "`UPDATE_WHO` = ? "
					+ "WHERE `GOODS`.`ID` = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, CreateDate);
			pstmt.setString(2, userID);
			pstmt.setString(3, reqJson.getString("GoodsId"));
			pstmt.execute();
			
		}
		return result.toString();
	}
	private void addGoods(JSONObject reqJson, Connection conn, PreparedStatement pstmt, java.sql.Timestamp CreateDate, String userID) throws SQLException, JSONException, ParseException{
		String sql = "INSERT INTO `GOODS` (`ITEM`, `ID`, `NAME`, `STATUS`, `RESERVE`, `PURCHASE`, `SELL`, `COST`, `PRICE`, `FACTORY`, `REMARK`, `CREATE_DATE`, `UPDATE_DATE`, `CREATE_WHO`, `UPDATE_WHO`) "
				+ "VALUES ('0', ?, ?, 'S', ?, '0', '0', ?, ?, ?, ?, ?, ?, ?, ?);";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, reqJson.getString("GoodsId"));
		pstmt.setString(2, reqJson.getString("GoodsName"));
		pstmt.setString(3, reqJson.getString("GoodsReserve"));
		pstmt.setString(4, reqJson.getString("GoodsCost"));
		pstmt.setString(5, reqJson.getString("GoodsPrice"));
		pstmt.setString(6, reqJson.getString("FactoryId"));
		pstmt.setString(7, reqJson.getString("GoodsRemark"));
		pstmt.setTimestamp(8, CreateDate);
		pstmt.setTimestamp(9, CreateDate);
		pstmt.setString(10, userID);
		pstmt.setString(11, userID);
		pstmt.execute();
	}
}
