package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.settings.dao.UserDao;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.vo.PagenationVo;
import com.bjpowernode.crm.workbench.dao.ActivityDao;
import com.bjpowernode.crm.workbench.dao.ActivityRemarkDao;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.service.ActivityService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {

    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    private ActivityRemarkDao activityRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public boolean update(Activity activity) {
        boolean flag = true;
        int count = activityDao.update(activity);
        if (count!=1){
            flag=false;
        }
        return flag;
    }


    @Override
    public Map<String, Object> getUserListAndActivity(String id) {
        //取uList
        List<User> uList = userDao.getUserList();

        //取a
        Activity a =  activityDao.getById(id);
        //将uList和a打包到map当中
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("uList",uList);
        map.put("a",a);
        //返回map
        return map;
    }

    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        //查询出需要删除的备注的数量
        int count1 = activityRemarkDao.getCountByIds(ids);
        //删除备注，返回受到影响的条数
        int count2 = activityRemarkDao.deleteByIds(ids);
        if (count1!=count2){
            flag  = false;
        }
        //删除市场活动
        int count3 = activityDao.delete(ids);
        if (count3!=ids.length){
            flag=false;
        }
        return flag;
    }



    @Override
    public boolean save(Activity activity) {
        boolean flag = true;
        int count = activityDao.save(activity);
        if (count!=1){
            flag=false;
        }
        return flag;
    }

    @Override
    public PagenationVo<Activity> pageList(Map<String, Object> map) {
        //取得total
        int total = activityDao.getTotalByCondition(map);
        System.out.println("查询到的总条数"+total);
        //取得vo
        List<Activity> dataList = activityDao.getActivityListByCondition(map);
        //创建一个vo对象，将total和List封装进vo当中
        PagenationVo<Activity> vo = new PagenationVo<Activity>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }
}
