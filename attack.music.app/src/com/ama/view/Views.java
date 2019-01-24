package com.ama.view;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.util.StringsUtil;

import ora.json.JSONException;
import ora.json.JSONObject;

import ora.json.JSONArray;

public class Views {
	private Logger log = LoggerFactory.getLogger(Views.class);
	private final String SQL ;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	public Views(Connection conn, String ViewName) throws SQLException{
		SQL = read(ViewName);
		log.info(String.format("SQL : %s", StringsUtil.regulateSimple(SQL)));
		this.conn = conn;
		pstmt = this.conn.prepareStatement(SQL);
	}
	public Views(String sql, Connection conn) throws SQLException{
		SQL = sql;
		log.info(String.format("SQL : %s", StringsUtil.regulateSimple(SQL)));
		this.conn = conn;
		pstmt = this.conn.prepareStatement(SQL);
	}
	private String read(String Name){
		InputStream in = null;
		BufferedReader br = null;
		try{
			in = this.getClass().getResourceAsStream(Name+".view");
			br = new BufferedReader(new InputStreamReader(in, "BIG5"));
			StringBuffer data = new StringBuffer();
			String s = null;
			while((s = br.readLine()) != null){
				data.append(s).append(" ");
			}
			return new String(data);
		}catch(Exception e){
			return null;
		}finally{
			try{
				if(in!=null){in.close();}
				if(br!=null){br.close();}
			}catch(Exception e){
				
			}
		}
	}
	
	public void setPstmt(Object... objects) throws SQLException{
		for(int i = 1; i<= objects.length ; i ++){
			if(StringsUtil.isNull(objects[i - 1])){
				pstmt.setNull(i, Types.NULL);
			}else{
				if(objects[i - 1] instanceof java.sql.Timestamp){
					pstmt.setTimestamp(i,(java.sql.Timestamp)objects[i - 1]);
				}else if(objects[i - 1] instanceof java.lang.String){
					pstmt.setString(i, (String)objects[i - 1]);
				}else if(objects[i - 1] instanceof java.lang.Integer){
					pstmt.setInt(i, (Integer)objects[i - 1]);
				}else{
					pstmt.setObject(i, objects[i - 1]);
				}
			}
		}
	}
	
	public JSONArray getDatalistJSONArray(Boolean AutoDisconn) throws SQLException, JSONException{
		JSONArray datalist = new JSONArray();
		rs = pstmt.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();
		Boolean RowidFlag = Boolean.TRUE;
		while(rs.next()){
			JSONObject data = new JSONObject(rsmd.getColumnCount());
			for(int i = 1 ; i <= rsmd.getColumnCount() ; i++){
				data.put(StringsUtil.ZivString(rsmd.getColumnName(i)), StringsUtil.getValue((rs.getString(i))).trim());
			}
			if(RowidFlag){
				try{
					data.put("idx", rs.getInt("Rowid"));
				}catch(Exception e){
					RowidFlag = Boolean.FALSE;
				}
			}
			datalist.put(data);
		}
		if(AutoDisconn)
			com.util.DataBaseUtil.closeConnectionAll(conn, pstmt, rs);
		return datalist;
	}
}
