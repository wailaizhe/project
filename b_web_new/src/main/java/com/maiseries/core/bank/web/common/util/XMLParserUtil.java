/**
 * 
 */
package com.maiseries.core.bank.web.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;



/**
 * @author sumaomao
 * 
 */
public class XMLParserUtil {

	public static Map getMapByXml(String xmlStr) {
		Map map = new HashMap();
//		xmlStr= "<info><option id='u41' value='123'></option><option id='u42' value='123'></option></info>";
		try {
			Document doc = DocumentHelper.parseText(xmlStr);
			Element root = doc.getRootElement();
			List nameList = root.elements();
			for (Iterator nameIter = nameList.iterator(); nameIter.hasNext();) {
				Element eleName = (Element) nameIter.next();
				String id = eleName.attribute("id").getText();
				String value = eleName.attribute("value").getText();
				map.put(id, value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 用于解析从数据库中读出的见证信息xml
	 * @param xmlStr
	 * @return
	 */
	public static Map xml2Map(String xmlStr) {
		Map map = new LinkedHashMap();
		try {
			Document doc = DocumentHelper.parseText(xmlStr);
			Element root = doc.getRootElement();
			List nameList = root.elements();
			for (Iterator nameIter = nameList.iterator(); nameIter.hasNext();) {
				List list = new ArrayList();
				Element eleName = (Element) nameIter.next();
				String approvCheckName = eleName.attribute("id").getText();
				String approveNote = eleName.attribute("name").getText();
				map.put(approvCheckName, approveNote);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
//	public static void main(String[] args) {
//		XMLParserUtil.getMapByXml("");
//	}
}
