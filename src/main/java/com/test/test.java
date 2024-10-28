package com.test;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vo.UserVo;
import com.service.UserService;
import com.utils.MD5Util;
import org.junit.Test;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class test {

    /***
     * 测试数据连接
     * @throws Exception
     */
    @Test
    public void closeAll() throws Exception {
        String url = "jdbc:mysql://47.94.229.156:3306/ssm?serverTimezone = GMT";
        String name = "root";
        String pwd = "123456";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, name, pwd);
        System.out.println(conn);
    }

    /**
     * 逆向工程
     * @throws IOException
     * @throws XMLParserException
     * @throws InvalidConfigurationException
     * @throws SQLException
     * @throws InterruptedException
     */
    @Test
    public void gennerator() throws IOException, XMLParserException, InvalidConfigurationException, SQLException, InterruptedException {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        File configFile = new File("src/main/resources/mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }

    @Test
    public void addUser(){
        ApplicationContext ioc  = new ClassPathXmlApplicationContext("classpath:springmvc.xml","classpath:application.xml");
        UserService userService =  ioc.getBean(UserService.class);
        for (int i = 0; i < 100; i++) {
            UserVo user = new UserVo();
            int a= i+2;
            user.setUsername("User"+a);
            user.setPassword(MD5Util.digest("123"));

            user.setBirthday("1997-06-08");
            user.setStatus(0);
            user.setSex(0);
            user.setRole(0);
            user.setAddress("山东 济南 长清区 山东女子学院");
            int b = 170507100+a;
            user.setNumber(b);
            user.setDescription("坤德含弘，至善尚美");
            user.setEmail("User"+a+"@sdwomen.univercity");
            userService.addUser(user);
        }
    }
}
