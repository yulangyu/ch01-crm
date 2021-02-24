package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.dao.DicTypeDao;
import com.bjpowernode.crm.settings.dao.DicValueDao;
import com.bjpowernode.crm.settings.domain.DicType;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author: yulangyu
 * @date: 2021/2/20 22:24
 * @version: 1.0
 */
public class DicServiceImpl implements DicService {
    private DicTypeDao dicTypeDao = SqlSessionUtil.getSqlSession().getMapper(DicTypeDao.class);
    private DicValueDao dicValueDao = SqlSessionUtil.getSqlSession().getMapper(DicValueDao.class);

    @Override
    public Map<String, List<DicValue>> getAll() {
        Map<String,List<DicValue>> map = new HashMap<String,List<DicValue>>();
        //将字典类型列表全部取出，
        List<DicType> dicTypeList = dicTypeDao.getTypeList();
        for (DicType dicType:dicTypeList) {
              String code = dicType.getCode();
            System.out.println(code);
              List<DicValue> dicValueList =  dicValueDao.getValueList(code);
              map.put(code,dicValueList);
        }
        Set<String> set = map.keySet();
        for (String key:set){
            List<DicValue> dicValueList =map.get(key);
            for(DicValue dicValue:dicValueList){
                System.out.println(key+"---->"+dicValue.getText());
            }

        }
        return map;
    }
}
