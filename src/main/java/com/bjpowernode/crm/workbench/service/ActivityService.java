package com.bjpowernode.crm.workbench.service;


import com.bjpowernode.crm.vo.PagenationVo;
import com.bjpowernode.crm.workbench.domain.Activity;

import java.util.Map;

public interface ActivityService {

    boolean save(Activity activity);

    PagenationVo<Activity> pageList(Map<String, Object> map);

    boolean delete(String[] ids);

    Map<String, Object> getUserListAndActivity(String id);

    boolean update(Activity activity);
}
