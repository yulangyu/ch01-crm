package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.Contacts;
import com.bjpowernode.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int save(Tran t);

    List<Tran> showTranList();

    Tran detail(String id);

    List<User> getUserList();

    int saveTran(Tran t);

    int changeStage(Tran t);

    int getTotal();

    List<Map<String, Object>> getCharts();
}
