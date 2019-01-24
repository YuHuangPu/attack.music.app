package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DataBaseUtil {
	public static java.sql.Connection getConnection(String JNDINAME, Boolean AutoCommit){
		java.sql.Connection conn = null;
		try{
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource DS = (javax.sql.DataSource)ctx.lookup(JNDINAME);
			
			conn = DS.getConnection();
			conn.setAutoCommit(AutoCommit);
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	public static void closeConnection(java.sql.Connection conn) {
		try{
			if(conn!= null){
				if(!conn.getAutoCommit()){
					conn.commit();
				}
				conn.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static void closeConnectionAll(java.sql.Connection conn, java.sql.PreparedStatement pstmt, java.sql.ResultSet rs) {
		try{
			closePstmtRs(pstmt, rs);
			if(conn!= null){
				if(!conn.getAutoCommit()){
					conn.commit();
				}
				conn.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static void RollBack(java.sql.Connection conn) {
		try{
			if(conn!= null){
				conn.rollback();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static void RollBack(java.sql.Connection conn,  java.sql.PreparedStatement pstmt, java.sql.ResultSet rs) {
		try{
			if(conn!= null){
				conn.rollback();
			}
			closePstmtRs(pstmt, rs);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static void closePstmtRs(java.sql.PreparedStatement pstmt, java.sql.ResultSet rs) {
		try{
			if(pstmt!=null){
				pstmt.close();
			}
			if(rs!=null){
				rs.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static Connection getConnection(Properties conf, Boolean autoCommit) throws ClassNotFoundException, SQLException{
		Class.forName(conf.getProperty("class"));
		Connection conn = null;
		String datasource = conf.getProperty("datasource");
		conn = DriverManager.getConnection(datasource
				, conf.getProperty("username")
				, conf.getProperty("password"));
		if(conn == null){
			throw new SQLException("Connect fail !!");
		}
		conn.setAutoCommit(autoCommit);
		return conn;
	}
}
