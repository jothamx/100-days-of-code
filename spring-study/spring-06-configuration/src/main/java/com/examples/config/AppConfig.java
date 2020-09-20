package com.examples.config;

import com.examples.bean.Project;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource(value = {"classpath:team.properties", "classpath:project.properties"})
public class AppConfig {
    /*
    @Bean is a method-level annotation and a direct analog of the XML <bean/> element.
        @Bean
        public TransferService transferService() {
            return new TransferServiceImpl();
        }
    For comparison sake, the configuration above is exactly equivalent to the following Spring XML:
        <beans>
            <bean name="transferService" class="com.acme.TransferServiceImpl"/>
        </beans>
    */
    @Bean
    @ConfigurationProperties(prefix = "project")
    public Project project() {
        return new Project();
    }
}
