package com.ama.language;

import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.Properties;

public class LanguageView {
	private final String propertieFileName;
	private Properties prop = new Properties();
	public LanguageView(String lg){
		propertieFileName = "language_"+lg+".properties";
		try {
			prop.load(new InputStreamReader(this.getClass().getResourceAsStream(propertieFileName), Charset.forName("UTF-8")));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String getId(String id){
		String value = prop.getProperty(id);
		return value;
	}
}
