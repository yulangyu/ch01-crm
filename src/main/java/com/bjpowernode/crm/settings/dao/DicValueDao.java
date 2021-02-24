package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.DicValue;

import java.util.List;

/**
 * @author: yulangyu
 * @date: 2021/2/20 22:21
 * @version: 1.0
 */
public interface DicValueDao {
    List<DicValue> getValueList(String code);
}
