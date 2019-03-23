package com.ama.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;

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
@WebServlet("/maintainConsumer")
public class maintainConsumer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public maintainConsumer() {
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
			conn = DataBaseUtil.getConnection(Keys.COMPANY_JNDI_NAME, Boolean.FALSE);
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
		String sql = null;
		PreparedStatement pstmt = null;
		String userID = (((UserInfo)request.getSession().getAttribute(Keys.Session.LoginAccount)).getId());
		java.sql.Timestamp CreateDate = new java.sql.Timestamp(new Date().getTime());
		if(reqJson.has("addConsumer")){
			reqJson = reqJson.getJSONObject("addConsumer");
			sql = "INSERT INTO CONSUMER (`ITEM`, `ID`, `STATUS`, `NAME`, `MOBILE`, `REMARK`, `CREATE_DATE`, `CREATE_WHO`) "
					+ "VALUES ('0', ?, 'S', ?, ?, ?, ?, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, StringsUtil.isNull(reqJson.getString("ConsumerId"))?"0":reqJson.getString("ConsumerId"));
			pstmt.setString(2, reqJson.getString("ConsumerName"));
			pstmt.setString(3, reqJson.getString("ConsumerMobile"));
			pstmt.setString(4, reqJson.getString("ConsumerRemark"));
			pstmt.setTimestamp(5, CreateDate);
			pstmt.setString(6, userID);
			pstmt.execute();
		}else if(reqJson.has("editConsumer")){
			reqJson = reqJson.getJSONObject("editConsumer");
			sql = "UPDATE CONSUMER SET "
					+ "`NAME` = ?, `MOBILE` = ?, `REMARK` = ?, `UPDATE_DATE` = ? , `UPDATE_WHO` = ? "
					+ "WHERE `consumer`.`ID` = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reqJson.getString("ConsumerName"));
			pstmt.setString(2, reqJson.getString("ConsumerMobile"));
			pstmt.setString(3, reqJson.getString("ConsumerRemark"));
			pstmt.setTimestamp(4, CreateDate);
			pstmt.setString(5, userID);
			pstmt.setString(6, reqJson.getString("ConsumerId"));
			pstmt.execute();
			
		}else if(reqJson.has("delConsumer")){
			reqJson = reqJson.getJSONObject("delConsumer");
			sql = "UPDATE CONSUMER SET `STATUS` = 'N' WHERE CONSUMER.ID = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reqJson.getString("ConsumerId"));
			pstmt.execute();
		}
		return result.toString();
	}
}
