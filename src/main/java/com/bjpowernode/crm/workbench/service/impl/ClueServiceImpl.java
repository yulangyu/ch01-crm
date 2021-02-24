package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.*;
import com.bjpowernode.crm.workbench.domain.*;
import com.bjpowernode.crm.workbench.service.ClueService;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class ClueServiceImpl implements ClueService {
    //线索相关表
    private ClueDao clueDao = SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
    private ClueActivityRelationDao clueActivityRelationDao = SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationDao.class);
    private ClueRemarkDao clueRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ClueRemarkDao.class);

    //客户相关表
    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private CustomerRemarkDao customerRemarkDao = SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkDao.class);

    //联系人相关表
    private ContactsDao contactsDao = SqlSessionUtil.getSqlSession().getMapper(ContactsDao.class);
    private ContactsRemarkDao contactsRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ContactsRemarkDao.class);
    private ContactsActivityRelationDao contactsActivityRelationDao = SqlSessionUtil.getSqlSession().getMapper(ContactsActivityRelationDao.class);

    //交易相关表
    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private TranHistoryDao tranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);


    @Override
    public boolean convert(String clueId, Tran t, String createBy) {
        String createTime = DateTimeUtil.getSysTime();
        boolean flag =true;
        //(1) 获取到线索id，通过线索id获取线索对象（线索对象当中封装了线索的信息）
        Clue clue = clueDao.getById(clueId);
        //(2) 通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精确匹配，判断该客户是否存在！）
        //(3) 通过线索对象提取联系人信息，保存联系人
        //(4) 线索备注转换到客户备注以及联系人备注
        //(5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
        //(6) 如果有创建交易需求，创建一条交易
        //(7) 如果创建了交易，则创建一条该交易下的交易历史
        //(8) 删除线索备注
        //(9) 删除线索和市场活动的关系
        //(10) 删除线索

        return flag;
    }

    @Override
 public boolean bund(String clueId, String[] activityId) {
   boolean flag = true;
   for (String aid:activityId) {
   ClueActivityRelation car = new ClueActivityRelation();
   car.setId(UUIDUtil.getUUID());
   car.setClueId(clueId);
   car.setActivityId(aid);
   int count = clueActivityRelationDao.bund(car);
   if (count != 1){
    flag = false;
   }
  }
  return flag;
 }

 @Override
 public Clue getClueDetail(String id) {
  Clue clue =  clueDao.getClueDetail(id);
  return clue;
 }

 @Override
 public boolean saveClue(Clue clue) {
  boolean flag = true;
  int count = clueDao.saveClue(clue);
  if (count != 1){
   flag = false;
  }
  return flag;
 }

 @Override
 public List<User> getUserList() {
  List<User> uList = clueDao.getUserList();
  return uList;
 }
}
