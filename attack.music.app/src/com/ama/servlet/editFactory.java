package com.ama.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ama.common.BaseManager;
import com.ama.common.Keys;
import com.ama.data.info.UserInfo;
import com.util.DataBaseUtil;
import com.util.SessionUtil;
import com.util.StringsUtil;

import ora.json.JSONObject;

/**
 * Servlet implementation class addFactory
 */
@WebServlet("/addFactory")
public class editFactory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editFactory() {
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
	private String execute(HttpServletRequest request, HttpServletResponse response, ora.json.JSONObject reqJson, Connection conn) throws SQLException{
		JSONObject result = new JSONObject().put("status", Boolean.TRUE);
		String delSql = "UPDATE `FACTORY` SET STATUS='N' WHERE `FACTORY`.`ID` = ?";
		String updateSql = "UPDATE `FACTORY` SET "
				+ "`NAME` = ?, `CONTACT` = ?, `ADDRESS` = ?, `MOBILE` = ?, `REMARK` = ?"
				+ ", `UPDATE_WHO` = ?, `UPDATE_DATE` = ? WHERE `FACTORY`.`ID` = ?";
		String userID = (((UserInfo)request.getSession().getAttribute(Keys.Session.LoginAccount)).getId());
		java.sql.Timestamp UpdateDate = new java.sql.Timestamp(new Date().getTime());
		if(reqJson.length() != 1){
			PreparedStatement pstmt = conn.prepareStatement(updateSql);
			
			pstmt.setString(1, reqJson.getString("FactoryName"));
			pstmt.setString(2, reqJson.getString("FactoryContact"));
			pstmt.setString(3, reqJson.getString("FactoryAddress"));
			pstmt.setString(4, reqJson.getString("FactoryMobile"));
			pstmt.setString(5, reqJson.getString("FactoryRemark"));
			pstmt.setString(6, userID);
			pstmt.setTimestamp(7, UpdateDate);
			pstmt.setString(8, reqJson.getString("FactoryId"));
			pstmt.execute();
		}else{
			PreparedStatement pstmt = conn.prepareStatement(delSql);
			pstmt.setString(1, reqJson.getString("FactoryID"));
			pstmt.execute();
		}
		return result.toString();
	}
}
