package com.util;

import org.apache.struts2.ServletActionContext;

public class SessionUtil {
	public static void setSession(String SessionName, Object SessionValue){
		ServletActionContext.getRequest().getSession().setAttribute(SessionName, SessionValue);
	}
	public static Object getSession(String SessionName){
		return ServletActionContext.getRequest().getSession().getAttribute(SessionName);
	}
}
