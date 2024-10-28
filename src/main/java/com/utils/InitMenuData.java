package com.utils;

import com.mapper.MenuMapper;


import com.model.Menu;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 初始化菜单数据
 */
public class InitMenuData {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath:application.xml");
        MenuMapper menuMapper = context.getBean(MenuMapper.class);
        menuMapper.insert(new Menu(1,0,"班级管理系统",null,1,null,"&#xe68e;",1));
        menuMapper.insert(new Menu(2,1,"学生管理",null,1,null,"&#xe621;",1));
        menuMapper.insert(new Menu(3,1,"老师管理",null,0,null,"&#xe663;",1));
        menuMapper.insert(new Menu(4,1,"课程管理",null,0,null,"&#xe716;",1));
        menuMapper.insert(new Menu(5,1,"系统管理",null,0,null,"&#xe629;",1));
        menuMapper.insert(new Menu(6,1,"学生列表",null,0,null,"&#xe770;",1));
        menuMapper.insert(new Menu(7,1,"我的课程",null,0,null,"&#xe657;",1));
        menuMapper.insert(new Menu(8,1,"我的课程",null,0,null,"&#xe65b;",1));
        menuMapper.insert(new Menu(9,1,"我的成绩",null,0,null,"&#xe6b2;",1));
        menuMapper.insert(new Menu(10,1,"汽车入库",null,0,null,"&#xe65a;",1));
        menuMapper.insert(new Menu(11,1,"检查单管理",null,0,null,"&#xe705",1));


        //学生管理子节点
        menuMapper.insert(new Menu(12,2,"学生信息",null,0,null,"&#xe60f",1));
        menuMapper.insert(new Menu(13,2,"学生成绩",null,0,null,"&#xe66f;",1));
        //系统管理
        menuMapper.insert(new Menu(14,5,"用户管理",null,0,null,"&#xe770;",1));
        menuMapper.insert(new Menu(15,5,"菜单管理",null,0,null,"&#xe655;",1));
        menuMapper.insert(new Menu(16,5,"角色管理",null,0,null,"&#xe645;",1));
        menuMapper.insert(new Menu(17,5,"日志管理",null,0,null,"&#xe857;",1));
        menuMapper.insert(new Menu(18,5,"系统公告",null,0,null,"&#xe63c;",1));
        menuMapper.insert(new Menu(19,5,"数据源监控",null,0,null,"&#xe62c;",1));


        System.out.println("初始化完成");

    }

}
