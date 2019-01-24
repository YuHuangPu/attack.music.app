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
import javax.servlet.ServletRegistration;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ServletFilter implements Filter{
	public void destroy() {
    }
    
    public void doFilter(ServletRequest req, ServletResponse resp,
            FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String target = request.getRequestURI();
        target = target.lastIndexOf("?") > 0 ? target.substring(target.lastIndexOf("/") + 1,target.lastIndexOf("?") - target.lastIndexOf("/")) 
        		: target.substring(target.lastIndexOf("/") + 1);
        ServletRegistration Servlet = req.getServletContext().getServletRegistration(target);
        if (Servlet != null) {
        	Collection<String> RealPath = Servlet.getMappings();
        	Iterator<String> itr = RealPath.iterator();
        	String realpath = "ErrorMessage";
        	if(itr.hasNext()){
        		realpath = itr.next().substring(1) ; 
        	}else{
        		realpath = "ErrorMessage";
//        		request.getSession().setAttribute(SessionKey.ERRORMESSAGE, request.getRequestURI());
        	}
            RequestDispatcher rdsp = request.getRequestDispatcher(realpath);
            rdsp.forward(req, resp);
        } else {
            chain.doFilter(req, resp);
        }
        
    }

    private ArrayList<String> includes = new ArrayList<String>();

    public void init(FilterConfig config) throws ServletException {
        this.includes.addAll(Arrays.asList(config.getInitParameter(
                "includeServlets").split(",")));
    }
}
