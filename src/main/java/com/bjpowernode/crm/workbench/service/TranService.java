package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.Contacts;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

/**
 * @author: yulangyu
 * @date: 2021/2/24 19:36
 * @version: 1.0
 */
public interface TranService {
    List<Tran> showTranList();


    Tran detail(String id);

    List<User> getUserList();

    boolean saveTran(Tran t,String customerName);

    List<TranHistory> getTranHistoryList(String tranId);
}
