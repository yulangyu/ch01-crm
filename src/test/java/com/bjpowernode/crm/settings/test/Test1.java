package com.bjpowernode.crm.settings.test;

import com.bjpowernode.crm.utils.MD5Util;
import org.junit.Test;

public class Test1 {
    //@Test
    public void test01(){
        String pwd = "yly123....";
        String str = MD5Util.getMD5(pwd);
        System.out.println(str);
    }

    //@Test
    public void test2(){
        System.out.println("1");
        System.out.println("2");
        System.out.println("3");
        System.out.println("4");
    }
}
