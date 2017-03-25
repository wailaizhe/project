package com.maiseries.core.bank.web.activity.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import code.main.base.dao.DicSystemDao;
import code.main.base.domain.Page;
import code.main.base.entity.DicSystem;
import code.main.base.service.DicSystemService;

@Service("dicSystemService")
@Transactional
public class DicSystemServiceImpl implements DicSystemService {
	
	@SuppressWarnings({"rawtypes"})
	Map m = new HashMap();
	
	@Resource(name="dicSystemDao")
	private DicSystemDao dicSystemDao;
	
	@SuppressWarnings({"rawtypes"})
	public List findDic(String type,String bigType) {
		String type2 = type;
		if(type.indexOf(",")==-1 && type.indexOf("'")==-1){
			type2 = "'"+type+"'";
		}
		String hql = "from DicSystem where type in("+type2+") and bigType='"+bigType+"' and statue=0 order by code asc";
		hql += " order by code asc";
		return dicSystemDao.findList(hql);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	public List findAllDic(String type,String bigType) {
		String hql = "select code,text from DicSystem where type='"+type+"' and bigType='"+bigType+"' and statue=0 order by code asc";
		List l = dicSystemDao.findList(hql);
		l.add(0,new String[]{"","全部"});
		return l;
	}
	
	@SuppressWarnings("rawtypes")
	public String findDicText(String type,String bigType,String code) {
		String ret = "";
		if(code!=null && !code.isEmpty()){
			String code2 = "";
			String[] arr = code.split(",");
			for (int i = 0; i < arr.length; i++) {
				code2 += ",'"+arr[i]+"'";
			}
			code2 = code2.substring(1);
			String hql = "select text from DicSystem where code in("+code2+") and bigType='"+bigType+"' and type='"+type+"' and statue=0 order by code asc";
			List l = dicSystemDao.findList(hql);
			for (int i = 0; i < l.size(); i++) {
				ret += "、"+l.get(i);
			}
			if(!ret.equals("")){
				ret = ret.substring(1);
			}
		}
		return ret;
	}
	
	@SuppressWarnings("rawtypes")
	public List findDicList(String type,String bigType,String code){
		if(code!=null && !code.isEmpty()){
			String code2 = "";
			String[] arr = code.split(",");
			for (int i = 0; i < arr.length; i++) {
				code2 += ",'"+arr[i]+"'";
			}
			code2 = code2.substring(1);
			String hql = "from DicSystem where code in("+code2+") and bigType='"+bigType+"' and type='"+type+"' and statue=0 order by code asc";
			return dicSystemDao.findList(hql);
		}
		return new ArrayList();
	}
	
	@SuppressWarnings({"rawtypes"})
	public List findTree(String type) {
		String hql = "from DicSystem where type=? and statue=0 order by code asc";
		List<DicSystem> l = dicSystemDao.findList(hql, type);
		return l;
	}

	public DicSystem find(Integer id, boolean lazy) {
		if(lazy){
			return dicSystemDao.load(DicSystem.class, id);
		}else{
			return dicSystemDao.get(DicSystem.class, id);
		}
	}

	public Page findPage(String bigType,String type, String text,int start,int limit) {
		String where = "where statue=0";
		if(bigType!=null && !bigType.isEmpty()){
			where += " and bigType like '%"+bigType+"%'"; 
		}
		if(type!=null && !type.isEmpty()){
			where += " and type like '%"+type+"%'"; 
		}
		if(text!=null && !text.isEmpty()){
			where += " and (text like '%"+text+"%' or code like '%"+text+"%' or encoding like '%"+text+"%' or scn like '%"+text+"%')"; 
		}
		String hql = "from DicSystem "+where+" order by type asc,code asc";
		Page page=dicSystemDao.findExtPage(hql);
		page.setPageSize(limit);
		page.setPageNumber(start/limit);
		return dicSystemDao.findExtPage(hql);
	}
	
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map add(DicSystem temp) {
		try {
			DicSystem tmp = dicSystemDao.findObject("from DicSystem where statue=0 and bigType=? and type=? and text=?",temp.getBigType(), temp.getType(),temp.getText());
			if(tmp == null){
				DicSystem tmp1 = dicSystemDao.findObject("from DicSystem where statue=0 and bigType=? and type=? and code=?",temp.getBigType(), temp.getType(),temp.getCode());
				if(tmp1==null){
					dicSystemDao.add(temp);
					m.put("success", true);
					m.put("msg", "TIP011");
				}else{
					m.put("success", false);
					m.put("msg", "TIP038");
				}
			}else{
				m.put("success", false);
				m.put("msg", "TIP029");
			}
		} catch (Exception e) {
			m.put("success", false);
			m.put("msg", e.getMessage());
			e.printStackTrace();
		}
		return m;
	}

	@SuppressWarnings({"rawtypes","unchecked"})
	public Map update(DicSystem temp) {
		try{
			DicSystem tmp = dicSystemDao.findObject("from DicSystem where statue=0 and bigType=? and type=? and text=? and id <> ?",temp.getBigType(), temp.getType(),temp.getText(),temp.getId());
			if(tmp == null){
				DicSystem tmp2 = dicSystemDao.findObject("from DicSystem where statue=0 and bigType=? and type=? and code=? and id <> ?",temp.getBigType(), temp.getType(),temp.getCode(),temp.getId());
				if(tmp2==null){
					dicSystemDao.update(temp);
					m.put("success", true);
					m.put("msg", "TIP013");
				}else{
					m.put("success", false);
					m.put("msg", "TIP039");
				}
			}else{
				m.put("success", false);
				m.put("msg", "TIP030");
			}
		} catch (Exception e) {
			m.put("success", false);
			m.put("msg", e.getMessage());
			e.printStackTrace();
		}
		return m;
	}

	@SuppressWarnings({"rawtypes","unchecked"})
	public Map delete(String ids) {
		try {
			String hql = "update DicSystem set statue=1 where id in ("+ids+")";
			dicSystemDao.doHql(hql);
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
	 * 查询 某个类型下面 的字典
	 */
	@Override
	public List findAllDicNew(String type, String bigType) {
		String hql = "select id , text,code from DicSystem where type='"+type+"' and bigType='"+bigType+"' and statue=0 order by code asc";
		List l = dicSystemDao.findList(hql);
		return l;
	}
	//根据编码查询参考编码
	@SuppressWarnings("rawtypes")
	public String findDicEncoding(String type,String bigType,String code) {
		String ret = "";
		if(code!=null && !code.isEmpty()){
			
			String hql = "select encoding from DicSystem where code = '"+code+"' and bigType='"+bigType+"' and type='"+type+"' and statue=0 order by code asc";
			List l = dicSystemDao.findList(hql);
			
			if(l!=null && l.size()!=0) {
				ret =(String)l.get(0);
			}
		}
		return ret;
	}

	@Override
	public List findDicNullAtFirst(String type, String bigType) {
		String type2 = type;
		if(type.indexOf(",")==-1 && type.indexOf("'")==-1){
			type2 = "'"+type+"'";
		}
		String hql = "from DicSystem where type in("+type2+") and bigType='"+bigType+"' and statue=0 order by code asc";
		hql += " order by code asc";
		List<DicSystem> findList = dicSystemDao.findList(hql);
		for(DicSystem temp:findList){
			String text = temp.getText();
			if("无".equals(text)){
				findList.remove(temp);
				findList.add(0,temp);
			}
		}
		return findList;
	}
	
	@Override
	public void saveDicSystem(DicSystem dicSystem) {
		dicSystemDao.add(dicSystem);
	}
	
	
}
