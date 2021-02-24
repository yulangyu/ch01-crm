package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.DicType;

import java.util.List;

/**
 * @author: yulangyu
 * @date: 2021/2/20 22:21
 * @version: 1.0
 */
public interface DicTypeDao {
    List<DicType> getTypeList();
}
