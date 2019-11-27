package com.ama.filter;

import java.io.IOException;
import java.util.TimeZone;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodingFilter implements Filter {
	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		TimeZone.setDefault(TimeZone.getTimeZone("GMT+8"));
		chain.doFilter(req, resp);
	}

	public void init(FilterConfig config) throws ServletException {
	}
}
