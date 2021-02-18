package com.bjpowernode.crm.workbench.dao;

public interface ActivityRemarkDao {
    int getCountByIds(String[] ids);

    int deleteByIds(String[] ids);
}
