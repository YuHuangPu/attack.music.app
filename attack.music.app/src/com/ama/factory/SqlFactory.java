package com.ama.factory;

import com.util.StringsUtil;

public class SqlFactory {
	private static StringBuffer SQL;
	public static String getFactoryInfo() {
		return getFactoryInfo("");
	}
	public static String getFactoryInfo(String whereCondition) {
		SQL = new StringBuffer("SELECT ");
		SQL.append(" f.ID, f.NAME, f.CONTACT, f.ADDRESS, f.MOBILE, f.REMARK");
		SQL.append(" , f.CREATE_WHO, f.UPDATE_WHO, DATE_FORMAT(f.UPDATE_DATE,'%Y-%m-%d %T') as \"Update_DATE\"");
		SQL.append(" FROM FACTORY f");
		SQL.append(" WHERE f.STATUS = 'S' ");
		SQL.append(StringsUtil.eliminateNull(whereCondition));
		SQL.append(" ORDER BY f.ID");
		return SQL.toString();
	}
	public static String getReserveInfo() {
		return getReserveInfo("");
	}
	public static String getReserveInfo(String whereCondition) {
		SQL = new StringBuffer("SELECT * ");
		SQL.append(" FROM GOODS G ");
		SQL.append(" WHERE G.STATUS = 'S' ");
		SQL.append( StringsUtil.eliminateNull(whereCondition));
		SQL.append(" ORDER BY G.ITEM");
		return SQL.toString();
	}
}
