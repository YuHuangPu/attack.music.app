package com.ama.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoLoginFilter implements Filter{
	public void destroy() {
    }
    
    public void doFilter(ServletRequest req, ServletResponse resp,
            FilterChain chain) throws IOException, ServletException {
    	if (!(resp instanceof HttpServletResponse)) {
			chain.doFilter(req, resp);
			return;
		}

		if (req.getAttribute(this.getClass().getName()) != null) {
			chain.doFilter(req, resp);
			return;
		}
		req.setAttribute(this.getClass().getName(), "true");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String target = request.getRequestURI();
        target = target.lastIndexOf("?") > 0 ? target.substring(target.lastIndexOf("/") + 1,target.lastIndexOf("?") - target.lastIndexOf("/")) 
        		: target.substring(target.lastIndexOf("/") + 1);
        RequestDispatcher rdsp = request.getRequestDispatcher("com.tpsd.common.LoginCheck");
        response.sendRedirect("com.tpsd.common.LoginCheck");
//        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
    }
}
