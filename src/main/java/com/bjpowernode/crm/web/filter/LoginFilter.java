package com.bjpowernode.crm.web.filter;

import com.bjpowernode.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("进入到验证有没有登陆过的过滤器");
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        System.out.println(request.getContextPath());
        String path = request.getServletPath();
        System.out.println("context地址----------->"+request.getContextPath());
        System.out.println("相对地址：------------>"+path);

        if ("/settings/user/login.do".equals(path) || "/login.jsp".equals(path)){
            filterChain.doFilter(servletRequest, servletResponse);
        }else {
            if ( user !=null){
                filterChain.doFilter(servletRequest, servletResponse);
            }else {
                response.sendRedirect(request.getContextPath()+"/login.jsp");
            }
        }

    }
}
