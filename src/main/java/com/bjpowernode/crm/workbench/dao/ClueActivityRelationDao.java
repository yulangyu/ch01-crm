package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;

public interface ClueActivityRelationDao {


    int removeRelation(String id);

    int bund(ClueActivityRelation car);
}
