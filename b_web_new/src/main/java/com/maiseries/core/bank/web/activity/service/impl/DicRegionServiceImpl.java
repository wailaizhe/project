package com.maiseries.core.bank.web.activity.service.impl;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import code.main.base.dao.DicRegionDao;
import code.main.base.entity.DicRegion;
import code.main.base.service.DicRegionService;

@Service("dicRegionService")
@Transactional
public class DicRegionServiceImpl implements DicRegionService {
	private Logger log = LoggerFactory.getLogger(DicRegionServiceImpl.class);
	@SuppressWarnings({ "rawtypes" })
	Map m = new HashMap();

	@Resource(name = "dicRegionDao")
	private DicRegionDao dicRegionDao;

	@SuppressWarnings({ "rawtypes" })
	public List findTree(String pcode) {
		String hql = "from DicRegion t where statue=0";
		if (pcode != null && !pcode.isEmpty() && !pcode.equals("root")) {
			hql += " and t.pcode='" + pcode + "'";
		} else {
			hql += " and (t.pcode is null or t.pcode='')";
		}
		hql += " order by t.code asc,t.id desc";
		List list = dicRegionDao.findList(hql);
		return list;
	}


	@SuppressWarnings({ "rawtypes" })
	public DicRegion getLevel(String code) {
		String hql = "from DicRegion t where statue=0 and (t.code is null or t.code='"
				+ code + "')";
		DicRegion dic = dicRegionDao.findObject(hql);
		return dic;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List findCheckboxTree(String pcode) {
		String hql = "from DicRegion t where statue=0";
		if (pcode != null && !pcode.isEmpty() && !pcode.equals("root")) {
			hql += " and t.pcode='" + pcode + "'";
		} else {
			hql += " and t.pcode is null or t.pcode=''";
		}
		hql += " order by t.code asc,t.id desc";
		List<DicRegion> list = dicRegionDao.findList(hql);
		List result = new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			DicRegion tmp = list.get(i);
			Map m = new HashMap();
			m.put("id", tmp.getId());
			m.put("code", tmp.getCode());
			m.put("pcode", tmp.getPcode());
			m.put("text", tmp.getText());
			m.put("level", tmp.getLevel());
			m.put("checked", false);
			result.add(m);
		}
		return result;
	}

	public DicRegion find(Integer id, boolean lazy) {
		if (lazy) {
			return dicRegionDao.load(DicRegion.class, id);
		} else {
			return dicRegionDao.get(DicRegion.class, id);
		}
	}

	public DicRegion findByCode(String code) {
		String hql = "from DicRegion t where t.code=? and statue=0";
		return dicRegionDao.findObject(hql, code);
	}

	/**
	 * 获取省，市，县区，乡镇，街道的对象
	 */
	public DicRegion findRegion(int id1, int id2, int id3, int id4, int id5) {
		DicRegion org = null;
		if (id5 > 0) {
			org = this.find(id5, false);
		} else if (id4 > 0) {
			org = this.find(id4, false);
		} else if (id3 > 0) {
			org = this.find(id3, false);
		} else if (id2 > 0) {
			org = this.find(id2, false);
		} else if (id1 > 0) {
			org = this.find(id1, false);
		}
		return org;
	}

	/**
	 * 查找所选地区的完整地址
	 */
	public String findAddress(String pcode, String result) {
		int len = 0;
		String str = "";
		int subIndex = 0;
		while ((len = pcode.length()) >= 2) {
			str += ",'" + pcode + "'";
			if (pcode.length() % 2 == 0) {
				if (pcode.length() > 8) {
					subIndex = len - 3;
				} else {
					subIndex = len - 2;
				}
			} else {
				subIndex = len - 3;
			}
			pcode = pcode.substring(0, subIndex);
		}
		if(str==null||str.isEmpty()){
			return "";
		}
		String hql = "from DicRegion where code in (" + str.substring(1)
				+ ") and statue=0 order by code";
		List<DicRegion> list = dicRegionDao.findList(hql);
		String tmp = "";
		for (DicRegion rg : list) {
			tmp += rg.getText();
		}
		return tmp + result;
	}

	/**
	 * 根据地区编码获取上级及本级信息
	 */
	@SuppressWarnings("unchecked")
	public List<DicRegion> findRegions(String code) {
		if(code==null||code.isEmpty()){
			return new ArrayList();
		}
		int len = 0;
		String str = "";
		int subIndex = 0;
		while ((len = code.length()) >= 2) {
			str += ",'" + code + "'";
			if (code.length() % 2 == 0) {
				if (code.length() > 8) {
					subIndex = len - 3;
				} else {
					subIndex = len - 2;
				}
			} else {
				subIndex = len - 3;
			}
			code = code.substring(0, subIndex);
		}

		String hql = "from DicRegion where code in (" + str.substring(1)
				+ ") and statue=0 order by code";
		log.info(hql);
		List<DicRegion> list = dicRegionDao.findList(hql);
		return list;
	}

	/**
	 * 查找所选地区的下级id；多个以“,”分隔
	 */
	@SuppressWarnings({ "rawtypes" })
	public String findChildIds(String code, String result) {
		String ret = "";
		if (code != null && !code.isEmpty()) {
			String hql = "from DicRegion where code like '" + code
					+ "%' and statue=0";
			List list = dicRegionDao.findList(hql);
			for (int i = 0; i < list.size(); i++) {
				DicRegion rd = (DicRegion) list.get(i);
				ret += rd.getId() + ",";
			}
		}
		return ret + result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List findArray(String pcode) {
		String hql = "from DicRegion t where statue=0";
		if (pcode != null && !pcode.isEmpty()) {
			hql += " and t.pcode='" + pcode + "'";
		}
		hql += " order by t.code asc,t.id desc";
		List<DicRegion> list = dicRegionDao.findList(hql);
		return list;
	}

	/**
	 * 省，市，县区，乡镇，街道的级联菜单用于查询条件中
	 */
	public List<DicRegion> findDicArray(String cond) {
		StringBuffer hsql = new StringBuffer("from DicRegion dr where statue=0");
		if (cond != null && !cond.isEmpty())
			hsql.append(cond);
		hsql.append(" order by dr.code, dr.id desc");
		//System.out.println("\n\nhql:" + hsql.toString());
		return dicRegionDao.findList(hsql.toString());
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map add(DicRegion org) {
		DicRegion tmp = dicRegionDao.findObject(
				"from DicRegion where code=? and statue=0", org.getCode());
		if (tmp == null) {
			dicRegionDao.add(org);
			m.put("success", true);
			m.put("msg", "TIP011");
		} else {
			m.put("success", false);
			m.put("msg", "TIP027");
		}
		return m;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map update(DicRegion org) {
		DicRegion tmp = dicRegionDao.findObject(
				"from DicRegion where code=? and id <> ? and statue=0",
				org.getCode(), org.getId());
		if (tmp == null) {
			dicRegionDao.update(org);
			m.put("success", true);
			m.put("msg", "TIP013");
		} else {
			m.put("success", false);
			m.put("msg", "TIP028");
		}
		return m;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map delete(String id, String code) {
		try {
			String hql = "update DicRegion set statue=1 where id=" + id;
			dicRegionDao.doHql(hql);
			m.put("success", true);
			m.put("msg", "TIP005");
		} catch (Exception e) {
			m.put("success", false);
			m.put("msg", e.getMessage());
			e.printStackTrace();
		}
		return m;
	}

	/**
	 * 查询省市和直辖市
	 * 
	 * @return
	 */
	public List<DicRegion> getTopLevelRegion() {
		String hql = "from DicRegion t where t.statue= 0 and t.level = 1 order by t.code";
		List<DicRegion> list = dicRegionDao.findList(hql);
		return list;
	}

	/**
	 * 查找所选地区的下级单位 add by Leung
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getSubUnitArray(String code) {
		List al = new ArrayList();
		if (code != null && !code.isEmpty()) {
			String hql = "from DicRegion where code like '" + code
					+ "%' and statue=0";
			List list = dicRegionDao.findList(hql);
			for (int i = 0; i < list.size(); i++) {
				DicRegion rd = (DicRegion) list.get(i);
				List li = new ArrayList(2);
				li.add(String.valueOf(rd.getId()));
				li.add(rd.getText());
				al.add(li);
			}
		}
		return al;
	}

	// 解析给定地区字符串 分割成省市县镇返回
	@Override
	public Map getRegionByCode(HttpServletRequest request) {
		String code = request.getParameter("code");
		String address = request.getParameter("address");
		try {
			address = URLDecoder.decode(address, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		DicRegion region =null;
		if(code.length()>1){
			region = findByCode(code.substring(0, 2));
			m.put("sheng", region);
		}
		if(code.length()>3){
			region = findByCode(code.substring(0, 4));
			m.put("shi", region);
		}
		if(code.length()>5){
			region = findByCode(code.substring(0, 6));
			m.put("xian", region);
		}
		m.put("other", address);
		return m;
	}
	/**
	 * 查询相应级别的地区
	 * 
	 * @param listRgion
	 *            过滤出来所有的地区
	 * @param childRegion
	 *            下属地区
	 * @param level
	 *            级别
	 * @return
	 */
	private DicRegion getRegion(List<DicRegion> listRgion,
			DicRegion childRegion, Integer level) {
		if (listRgion == null || listRgion.size() == 0) {
			return null;
		}
		DicRegion parentRegion = null;
		DicRegion curRegion = null;
		for (int i = 0; i < listRgion.size(); i++) {
			curRegion = listRgion.get(i);
			if (curRegion != null && curRegion.getLevel() == level) {
				parentRegion = curRegion;
				break;
			}
		}
		if (level != 4) { // 级别为4 的为最低级别
			// 如果列表中没有当前级别的，则根据子级别地区查询父级别地区
			if (parentRegion == null && childRegion != null
					&& childRegion.getPcode() != null
					&& !"".equals(childRegion.getPcode())) {
				parentRegion = findByCode(childRegion.getPcode());
			}
		}

		return parentRegion;
	}
	
	public Map<String, Object> uploadData(InputStream inputStream) {
		Map<String, Object> m = new HashMap<String, Object>();
        Workbook wb = null;
        
       
		try {
			wb = WorkbookFactory.create(inputStream);
		} catch (Exception e1) {
			
			m.put("success", false);
			m.put("msg", "invalid excel");
			return m;
		}
		Sheet sheet = wb.getSheetAt(0);
		int i = 1;
		while(true) {
			if (sheet.getRow(i) == null ) {
				
				break;
			}
			
			  DicRegion dicRegion = new DicRegion();
			  for (int j = 1; j <=6; j++) {
				Cell	cell = sheet.getRow(i).getCell(j);
					String value = "";
					if(cell!=null)
					{
					if (Cell.CELL_TYPE_STRING == cell.getCellType()) {
		    			value = cell.getStringCellValue();
		    			if (value != null) {
		    				value = value.trim();
		    			}
		    		} else if (Cell.CELL_TYPE_NUMERIC == cell.getCellType()) {
		    			cell.setCellType(1);
		    			value = cell.getStringCellValue();
		    			if (value != null) {
		    				value = value.trim();
		    			}
		    		}
					if (StringUtils.isBlank(value)) {
						continue;
					}
					}else
						value=null;
			    switch (j){
			    case 1:{dicRegion.setCode(value); break;}
			    case 2:
			    	{dicRegion.setLevel(Integer.parseInt(value));break;}
			    case 3:
			    	{dicRegion.setText(value);break;}
			    case 4:
			    	{dicRegion.setPcode(value);break;}
			    case 5:
			    	{dicRegion.setStatue(Integer.parseInt(value));break;}
			    }
                 
			}
		
			  DicRegion tmp = dicRegionDao.findObject(
						"from DicRegion where code=? ", dicRegion.getCode());
			
				if (tmp == null) {
					if(dicRegion.getCode()!=null && dicRegion.getText()!=null)
					this.add(dicRegion);
				} else {
					tmp.setStatue(dicRegion.getStatue());
					tmp.setCode(dicRegion.getCode());
					tmp.setPcode(dicRegion.getPcode());
					tmp.setLevel(dicRegion.getLevel());
					tmp.setText(dicRegion.getText());
					this.update(tmp);
					
				}
			 i++;
		}
		m.put("success", true);
		m.put("msg", "ok");
		return m;
	}
}
