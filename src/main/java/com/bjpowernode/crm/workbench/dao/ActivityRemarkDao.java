package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {
    int getCountByIds(String[] ids);

    int deleteByIds(String[] ids);

    List<ActivityRemark> getRemarkListById(String activityId);

    int deleteRemarkById(String id);

    int saveRemark(ActivityRemark ar);

    int editRemark(ActivityRemark ar);
}
