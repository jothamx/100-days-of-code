package com.examples;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties
public class SpringBootConfigApplication {
    public static void main(String[] args) {
        SpringApplication.run(SpringBootConfigApplication.class, args);
    }
}
