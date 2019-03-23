package com.ama.common.box;

public class Label extends Element {
	public Label(String text) {
		this.setHtml("<label>" + text + " %s</label>");
	}
}
