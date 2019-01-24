package com.ama.common;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.StrutsResultSupport;
import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.TilesContainer;
import org.apache.tiles.access.TilesAccess;

import com.opensymphony.xwork2.ActionInvocation;

public class MyTilesTemplateResult extends StrutsResultSupport {
	private static final long serialVersionUID = 1L;

	public MyTilesTemplateResult() {
		super();
	}

	public MyTilesTemplateResult(String location) {
		super(location);
	}

	@Override
	protected void doExecute(String arg0, ActionInvocation arg1) throws Exception {
		setLocation(arg0);
		String definitionName = getLayout(arg0);
		String attributeName = "body";
		ServletContext servletContext = ServletActionContext.getServletContext();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		TilesContainer container = TilesAccess.getContainer(servletContext);
		Attribute attribute = new Attribute(arg0);
		AttributeContext attributeContext = container.startContext(request, response);
		attributeContext.putAttribute(attributeName, attribute);
		container.render(definitionName, request, response);
		container.endContext(request, response);
	}
	private String getLayout(String l){
		switch(l){
			case "/jsp/body/home.jsp":
				return "baseLayout";
			default: 
				return "LayoutView";
		}
	}
}
