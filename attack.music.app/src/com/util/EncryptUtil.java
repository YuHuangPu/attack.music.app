package com.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptUtil {
	public static void main (String [] arge) throws NoSuchAlgorithmException{
		System.out.println(EncryptUtil.EncryptString("0000"));
	}
	public static String EncryptString(String str) throws NoSuchAlgorithmException{
		String input = str;
		String result = input;
	    if(input != null) {
	        MessageDigest md = MessageDigest.getInstance("MD5"); //or "SHA-1"
	        md.update(input.getBytes());
	        BigInteger hash = new BigInteger(1, md.digest());
	        result = hash.toString(16);
	        while(result.length() < 32) { //40 for SHA-1
	            result = "0" + result;
	        }
	    }
		return result;
	}
}
