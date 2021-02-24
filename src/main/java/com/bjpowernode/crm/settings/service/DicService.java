package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

/**
 * @author: yulangyu
 * @date: 2021/2/20 22:23
 * @version: 1.0
 */
public interface DicService {
    Map<String, List<DicValue>> getAll();
}
