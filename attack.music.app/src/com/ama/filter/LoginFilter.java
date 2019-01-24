package com.ama.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ama.common.Keys;
import com.util.SessionUtil;
public class LoginFilter implements Filter {
	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		String target = request.getRequestURI();
		target = target.lastIndexOf("?") > 0
				? target.substring(target.lastIndexOf("/") + 1, target.lastIndexOf("?") - target.lastIndexOf("/"))
				: target.substring(target.lastIndexOf("/") + 1);
		if (com.util.StringsUtil.isNull(target)) {
			RequestDispatcher rdsp = request.getRequestDispatcher("index.jsp");
			rdsp.forward(req, resp);
			return;
		}
		com.ama.data.info.UserInfo userInfo = (com.ama.data.info.UserInfo)request.getSession().getAttribute(Keys.Session.LoginAccount);
		if(userInfo != null && target.equals("home.action")){
			if(userInfo.getLoginStatus()){
	            response.sendRedirect("ownerPage.action");
	            
	            
	            
//				chain.doFilter(req, resp);
				return;
			}
		}else if(userInfo == null && !target.equals("home.action") && !target.equals("login.action") ){
			RequestDispatcher rdsp = request.getRequestDispatcher("index.jsp");
			rdsp.forward(req, resp);
			return;
		}
		chain.doFilter(req, resp);
		return;
	}

	public void init(FilterConfig config) throws ServletException {

	}
}
