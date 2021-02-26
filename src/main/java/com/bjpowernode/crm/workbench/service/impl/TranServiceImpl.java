package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.ContactsDao;
import com.bjpowernode.crm.workbench.dao.CustomerDao;
import com.bjpowernode.crm.workbench.dao.TranDao;
import com.bjpowernode.crm.workbench.dao.TranHistoryDao;
import com.bjpowernode.crm.workbench.domain.Contacts;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.service.TranService;
import java.util.List;


/**
 * @author: yulangyu
 * @date: 2021/2/24 19:36
 * @version: 1.0
 */
public class TranServiceImpl implements TranService {
    //交易相关表
    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private TranHistoryDao tranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);
    private CustomerDao customerDao  = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);

    @Override
    public List<TranHistory> getTranHistoryList(String tranId) {
        List<TranHistory> tList = tranHistoryDao.getTranHistoryList(tranId);
        return tList;
    }

    @Override
    public boolean saveTran(Tran t,String customerName) {
        boolean flag = true;
        Customer customer = customerDao.getCustomerByName(customerName);
        if (customer==null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateBy(t.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setContactSummary(t.getContactSummary());
            customer.setNextContactTime(t.getNextContactTime());
            customer.setOwner(t.getOwner());
            int count= customerDao.save(customer);
            if (count!=1){
                flag =false;
                System.out.println("customer添加失败");
            }
        }
        //此时customer已经一定存在
        t.setCustomerId(customer.getId());
        int count = tranDao.saveTran(t);
        if (count !=1){
            flag = false;
        }

        //添加交易历史
        TranHistory th = new TranHistory();
        th.setId(UUIDUtil.getUUID());
        th.setTranId(t.getId());
        th.setStage(t.getStage());
        th.setMoney(t.getMoney());
        th.setExpectedDate(t.getExpectedDate());
        th.setCreateBy(t.getCreateBy());
        th.setCreateTime(DateTimeUtil.getSysTime());
        TranHistoryDao tranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);
        int count1 = tranHistoryDao.save(th);
        if (count1!=1){
            flag = false;
            System.out.println("交易历史添加失败");
        }

        return flag;
    }

    @Override
    public List<User> getUserList() {
        List<User> uList= tranDao.getUserList();
        return uList;
    }

    @Override
    public Tran detail(String id) {
        Tran t = tranDao.detail(id);
        return t;
    }

    @Override
    public List<Tran> showTranList() {
        List<Tran> tList = tranDao.showTranList();
        return tList;
    }
}
