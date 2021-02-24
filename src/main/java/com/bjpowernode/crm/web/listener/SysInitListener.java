package com.bjpowernode.crm.web.listener;

import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.settings.service.impl.DicServiceImpl;
import com.bjpowernode.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author: yulangyu
 * @date: 2021/2/21 12:10
 * @version: 1.0
 */
public class SysInitListener implements ServletContextListener {
    /*

         该方法是用来监听上下文域对象的方法，当服务器启动，上下文域对象创建
         对象创建完毕后，马上执行该方法

         event：该参数能够取得监听的对象
                 监听的是什么对象，就可以通过该参数能取得什么对象
                 例如我们现在监听的是上下文域对象，通过该参数就可以取得上下文域对象

      */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("上下文域对象创建了");
        ServletContext application = sce.getServletContext();
        DicService ds = (DicService) ServiceFactory.getService(new DicServiceImpl());
        Map<String, List<DicValue>> map = ds.getAll();
        Set<String> set = map.keySet();
        for (String key :set) {
            application.setAttribute(key,map.get(key));
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("服务器已关闭");
    }
}
