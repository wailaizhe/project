package com.maiseries.core.bank.web.common.kit;

import com.jfinal.kit.StrKit;
import com.maiseries.core.bank.web.common.exception.ValidateException;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by MaiSeries on 2017/2/24.
 */
public class ValidatorKit {
    private ValidatorKit(){}

    public static String notBlank(String str,String key) throws ValidateException {
        if (StrKit.notBlank(str)){
            return str;
        }else {
            throw new ValidateException("字符串:"+key+" 不存在或为空!");
        }
    }
    public static Integer notBlank(Integer i,String key) throws ValidateException {
        if (i != null){
            return i;
        }else {
            throw new ValidateException("Integer:"+key+" 不存在!");
        }
    }
    public static Object notBlank(Object o,String key) throws ValidateException {
        if (o != null){
            return o;
        }else {
            throw new ValidateException("实例:"+key+" 不存在!");
        }
    }
    public static List notBlank(List list,String key) throws ValidateException {
        if (list != null && list.size()>0){
            return list;
        }else {
            throw new ValidateException("List:"+key+" 不存在或为空!");
        }
    }
    public static BigDecimal notBlank(BigDecimal bd,String key) throws ValidateException {
        if (bd != null){
            return bd;
        }else {
            throw new ValidateException("BigDecimal:"+key+" 不存在!");
        }
    }
}
