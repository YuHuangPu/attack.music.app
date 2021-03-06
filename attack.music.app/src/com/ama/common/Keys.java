package com.ama.common;

public class Keys {
	public static final String COMPANY = "AttackMusicDataSource";
	public static final String COMPANY_JNDI_NAME = "java:/AttackMusicDataSource";
	public static final String WEB_SUCCESSFUL = "successful";
	public static final String WEB_FAIL = "fail";
	
	/* DataViewKey*/
	public class View{
		public static final String UserInfo = "UserInfo";
		public static final String GoodsDetailInfo = "GoodsDetailInfo";
		public static final String TransactionInfo = "TransactionInfo";
		public static final String ConsumerInfo = "ConsumerInfo";
		public static final String OwnerInfo = "OwnerInfo";
		
		public static final String FactoryMaxUpdate = "FactoryMaxUpdate";
		public static final String GoodsDetailMaxUpdate = "GoodsDetailMaxUpdate";
		public static final String GoodsMaxUpdate = "GoodsMaxUpdate";
		public static final String ConsumerMaxUpdate = "ConsumerMaxUpdate";
		
		public static final String AccountMap = "AccountMap";
		public static final String GoodsMap = "GoodsMap";
		public static final String FactoryMap = "FactoryMap";
		public static final String ConsumerMap = "ConsumerMap";
	}
	
	/* SessionKey */
	public class Session{
		public static final String LoginAccount = "LoginAccount";
		
	}
}
