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
public class transactionGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public transactionGoods() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	// protected void doGet(HttpServletRequest request, HttpServletResponse
	// response) throws ServletException, IOException {
	// // TODO Auto-generated method stub
	// response.getWriter().append("Served at:
	// ").append(request.getContextPath());
	// }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter result = null;
		Connection conn = null;
		try {
			result = response.getWriter();
			conn = DataBaseUtil.getConnection(Keys.COMPANY_JNDI_NAME, Boolean.FALSE);
			ora.json.JSONObject reqJson = com.util.JsonsUtil.getJsonObject(request);
			result.append(execute(request, response, reqJson, conn));
		} catch (Exception e) {
			e.printStackTrace();
			result.append(new JSONObject().put("status", Boolean.FALSE).put("message", "something error").toString());
			DataBaseUtil.RollBack(conn);
		} finally {
			DataBaseUtil.closeConnection(conn);
			result.close();
		}
	}

	private String execute(HttpServletRequest request, HttpServletResponse response, ora.json.JSONObject reqJson, Connection conn) throws SQLException, JSONException, ParseException {
		JSONObject result = new JSONObject().put("status", Boolean.TRUE);
		String sql = null;
		PreparedStatement pstmt = null;
		String userID = (((UserInfo) request.getSession().getAttribute(Keys.Session.LoginAccount)).getId());
		java.sql.Timestamp CreateDate = new java.sql.Timestamp(new Date().getTime());
		if (reqJson.has("NewGoods")) {
			reqJson = reqJson.getJSONObject("NewGoods");
			sql = "INSERT INTO `GOODS` (`ITEM`, `ID`, `NAME`, `STATUS`, `RESERVE`, `PURCHASE`, `SELL`, `COST`, `PRICE`, `FACTORY`, `REMARK`, `CREATE_DATE`, `UPDATE_DATE`, `CREATE_WHO`, `UPDATE_WHO`) "
					+ "VALUES ('0', ?, ?, 'S', ?, '0', '0', ?, ?, ?, ?, ?, ?, ?, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reqJson.getString("GoodsId"));
			pstmt.setString(2, reqJson.getString("GoodsName"));
			pstmt.setString(3, reqJson.getString("GoodsAmount"));
			pstmt.setString(4, reqJson.getString("GoodsCost"));
			pstmt.setString(5, reqJson.getString("GoodsPrice"));
			pstmt.setString(6, reqJson.getString("FactoryId"));
			pstmt.setString(7, reqJson.getString("GoodsRemark"));
			pstmt.setTimestamp(8, CreateDate);
			pstmt.setTimestamp(9, CreateDate);
			pstmt.setString(10, userID);
			pstmt.setString(11, userID);
			pstmt.execute();
			sql = "INSERT INTO `GOODS_DETAIL` (`ITEM`, `GOODS_ID`, `CONSUMER_ID`, `STATUS`, `AMOUNT`, `PRICE`, `SELL_DATE`, `REMARK`" + ", `CREATE_DATE`, `CREATE_WHO`)"
					+ "VALUES ('0', ?, '0', 'I', ?, ?, ?, ?, ?, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reqJson.getString("GoodsId"));
			pstmt.setString(2, reqJson.getString("GoodsAmount"));
			pstmt.setBigDecimal(3, reqJson.getBigDecimal("GoodsCost").multiply(reqJson.getBigDecimal("GoodsAmount")));
			pstmt.setDate(4, new java.sql.Date(com.util.DatesUtil.getValue(reqJson.getString("IDate"), com.util.DatesUtil.DateFormat).getTime()));
			pstmt.setString(5, reqJson.getString("GoodsRemark"));
			pstmt.setTimestamp(6, CreateDate);
			pstmt.setString(7, userID);
			pstmt.execute();
		} else if (reqJson.has("OldGoods")) {
			purchaseGoods(reqJson, conn, pstmt, CreateDate, userID);
		} else if (reqJson.has("SellGoods")) {
			sellGoods(reqJson, conn, pstmt, CreateDate, userID);
		} else if (reqJson.has("DelGoodsDetail")) {
			reqJson = reqJson.getJSONObject("DelGoodsDetail");
			sql = "UPDATE `GOODS_DETAIL` SET `STATUS` = 'N', `CREATE_WHO`=? WHERE `GOODS_DETAIL`.`ITEM` = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, reqJson.getString("GoodsDetailId"));
			pstmt.execute();
		} else if (reqJson.has("DayList")) {
			reqJson = (reqJson.getJSONObject("DayList"));
			Iterator<Object> itrs = reqJson.getJSONArray("DayList").iterator();
			while (itrs.hasNext()) {
				JSONObject goods = (JSONObject) itrs.next();
				if ("x".equals(goods.getString("GoodsRemark"))) {
					continue;
				}
				goods.put("IDate", reqJson.getString("DayIDate"));
				if (reqJson.getString("DayConsumerId").equals("D")) {
					goods.put("ConsumerId", "0");
					goods.put("GoodsCost", goods.getString("GoodsPrice"));
					purchaseGoods(new JSONObject().put("OldGoods", goods), conn, pstmt, CreateDate, userID);
				} else {
					goods.put("ConsumerId", reqJson.getString("DayConsumerId"));
					sellGoods(new JSONObject().put("SellGoods", goods), conn, pstmt, CreateDate, userID);
				}
			}

		}
		return result.toString();
	}

	private void purchaseGoods(JSONObject reqJson, Connection conn, PreparedStatement pstmt, java.sql.Timestamp CreateDate, String userID) throws SQLException, JSONException, ParseException {
		reqJson = reqJson.getJSONObject("OldGoods");
		String sql = "UPDATE `GOODS` SET"
				 + "`COST` = ((`COST` * `RESERVE` ) + ?)/(`RESERVE` + ?),  `RESERVE` = `RESERVE` + ?, "
				// `PRICE` = (`PRICE` * `RESERVE` + ? )/(`RESERVE` + ?), "
				+ "`REMARK` = ?, `UPDATE_DATE` = ?, `UPDATE_WHO` = ?, `PURCHASE` = `PURCHASE` + ?" + "WHERE `GOODS`.`ID` = ?;";
		pstmt = conn.prepareStatement(sql);
		 pstmt.setBigDecimal(1, reqJson.getBigDecimal("GoodsCost").multiply(reqJson.getBigDecimal("GoodsAmount")));
		 pstmt.setString(2, reqJson.getString("GoodsAmount"));
		 pstmt.setString(3, reqJson.getString("GoodsAmount"));
		// pstmt.setBigDecimal(4,
		// reqJson.getBigDecimal("GoodsPrice").multiply(reqJson.getBigDecimal("GoodsAmount")));
		// pstmt.setString(5, reqJson.getString("GoodsAmount"));

		pstmt.setString(4, reqJson.getString("GoodsRemark"));
		pstmt.setTimestamp(5, CreateDate);
		pstmt.setString(6, userID);
		pstmt.setString(7, reqJson.getString("GoodsAmount"));
		pstmt.setString(8, reqJson.getString("GoodsId"));
		pstmt.execute();

		sql = "INSERT INTO `GOODS_DETAIL` (`ITEM`, `GOODS_ID`, `CONSUMER_ID`, `STATUS`, `AMOUNT`, `PRICE`, `SELL_DATE`, `REMARK`" + ", `CREATE_DATE`, `CREATE_WHO`)"
				+ "VALUES ('0', ?, '0', 'I', ?, ?, ?, ?, ?, ?);";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, reqJson.getString("GoodsId"));
		pstmt.setString(2, reqJson.getString("GoodsAmount"));
		pstmt.setBigDecimal(3, reqJson.getBigDecimal("GoodsCost").multiply(reqJson.getBigDecimal("GoodsAmount")));
		pstmt.setDate(4, new java.sql.Date(com.util.DatesUtil.getValue(reqJson.getString("IDate"), com.util.DatesUtil.DateFormat).getTime()));
		pstmt.setString(5, reqJson.getString("GoodsRemark"));
		pstmt.setTimestamp(6, CreateDate);
		pstmt.setString(7, userID);
		pstmt.execute();

	}

	private void sellGoods(JSONObject reqJson, Connection conn, PreparedStatement pstmt, java.sql.Timestamp CreateDate, String userID) throws SQLException, JSONException, ParseException {
		reqJson = reqJson.getJSONObject("SellGoods");
		String sql = "UPDATE `GOODS` SET `RESERVE` = `RESERVE` - ?, "
				// + "`PRICE` = ?, "
				+ "`SELL` = `SELL` + ?, " + "`REMARK` = ?, `UPDATE_DATE` = ?, `UPDATE_WHO` = ? " + "WHERE `GOODS`.`ID` = ?;";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, reqJson.getString("GoodsAmount"));
		// pstmt.setString(2, reqJson.getString("GoodsPrice"));
		pstmt.setString(2, reqJson.getString("GoodsAmount"));
		pstmt.setString(3, reqJson.getString("GoodsRemark"));
		pstmt.setTimestamp(4, CreateDate);
		pstmt.setString(5, userID);
		pstmt.setString(6, reqJson.getString("GoodsId"));
		pstmt.execute();

		sql = "INSERT INTO `GOODS_DETAIL` (`ITEM`, `GOODS_ID`, `CONSUMER_ID`, `STATUS`, `AMOUNT`, `PRICE`, `SELL_DATE`, `REMARK`" + ", `CREATE_DATE`, `CREATE_WHO`)"
				+ "VALUES ('0', ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, reqJson.getString("GoodsId"));
		pstmt.setString(2, reqJson.getString("ConsumerId"));
		pstmt.setString(3, "O");
		pstmt.setString(4, reqJson.getString("GoodsAmount"));
		pstmt.setBigDecimal(5, reqJson.getBigDecimal("GoodsAmount").multiply(reqJson.getBigDecimal("GoodsPrice")));
		pstmt.setDate(6, new java.sql.Date(com.util.DatesUtil.getValue(reqJson.getString("IDate"), com.util.DatesUtil.DateFormat).getTime()));
		pstmt.setString(7, reqJson.getString("GoodsRemark"));
		pstmt.setTimestamp(8, CreateDate);
		pstmt.setString(9, userID);
		pstmt.execute();
	}
}
