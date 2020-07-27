package com.spring.service;

import com.spring.dao.UserDao;

public class UserServiceImpl implements UserService {

    private UserDao userDao;

    // 实现控制反转IoC
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public void getUser() {
        userDao.getUser();
    }
}
