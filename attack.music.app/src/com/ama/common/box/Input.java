package com.ama.common.box;

import com.util.StringsUtil;

public class Input extends Element {
	private Element label;
	private String defaultValue;
	private String html = "<input class='%s' type='%s' name='%s' value='%s' />";

	/**
	 * 
	 * */
	public Input(Element label, String styleClass, String type, String name, String value, String defaultValue) {
		this.setStyleClass(styleClass);
		this.setLabel(label);
		this.setType(type);
		this.setName(name);
		this.setValue(value);
		this.setDefaultValue(defaultValue);
		String inputTemp = String.format(html, styleClass, type, name, StringsUtil.eliminateNull(value, defaultValue));
		inputTemp = (StringsUtil.isNull(label) ? inputTemp : (String.format(label.getHtml(), inputTemp)));
		this.setHtml(inputTemp);
	}

	public Element getLabel() {
		return label;
	}

	public void setLabel(Element label) {
		this.label = label;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}
}
