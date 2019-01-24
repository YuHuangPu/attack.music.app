package com.ama.common.box;

import java.util.ArrayList;
import java.util.List;

public class SearchMenu {
	private List<Elements> elements= new ArrayList<Elements>();
	public List<Elements> getElements() {
		return elements;
	}

	public void setElements(List<Elements> elements) {
		this.elements = elements;
	}

	public class Elements {
		private List<Element> element = new ArrayList<Element>();

		public List<Element> getElement() {
			return element;
		}

		public void setElement(List<Element> element) {
			this.element = element;
		}
	}

	public static class Element {
		public enum TYPE {
			INPUT, SELECT, TEXT
		}
		private Element.TYPE type ;
		
		public Element.TYPE getType() {
			return type;
		}
		public void setType(Element.TYPE type) {
			this.type = type;
		}
		private String text = "";
		
		public String getText() {
			return text;
		}
		public void setText(String text) {
			this.text = text;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		private String name = "";
		public class option{
			private String text = "";
			private String value = "";
			public String getText() {
				return text;
			}
			public void setText(String text) {
				this.text = text;
			}
			public String getValue() {
				return value;
			}
			public void setValue(String value) {
				this.value = value;
			}
		}
	}
}
