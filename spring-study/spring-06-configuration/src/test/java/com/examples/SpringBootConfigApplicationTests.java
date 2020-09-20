package com.examples;

import com.examples.bean.Person;
import com.examples.bean.Team;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;

@SpringBootTest
public class SpringBootConfigApplicationTests {

    @Autowired
    Person person;

    @Autowired
    Team team;

    @Autowired
    ApplicationContext applicationContext;

    @Test
    void contextLoads() {
        System.out.println(person);
        System.out.println(team);
    }

    @Test
    void testBeans() {
        System.out.println(applicationContext.getBean("project").toString());
    }
}
