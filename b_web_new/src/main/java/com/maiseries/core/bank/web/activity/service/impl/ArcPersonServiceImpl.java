package com.maiseries.core.bank.web.activity.service.impl;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("arcPersonService")
@Transactional
public class ArcPersonServiceImpl implements ArcPersonService {
	Map m = new HashMap();
	
	@Resource(name = "arcPersonDao")
	private ArcPersonDao arcPersonDao;
	private static Logger log = (Logger) LoggerFactory.getLogger(ArcPersonServiceImpl.class);
	
	@SuppressWarnings( { "rawtypes", "unchecked" })
	public Map add(ArcPerson temp) {
		try{
			ArcPerson tm = arcPersonDao.findObject(
					"from ArcPerson where cardId=?", temp.getCardId());
			if (tm == null) {
				String id = (String)arcPersonDao.addReturn(temp);
				m.put("id", id);
				m.put("success", true);
				m.put("msg", "TIP011");
			} else {
				tm.setEmail(temp.getEmail());
				arcPersonDao.update(tm);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			log.error(ArcPersonServiceImpl.class.toString(),ex);
		}
		return m;
	}
	
	
}