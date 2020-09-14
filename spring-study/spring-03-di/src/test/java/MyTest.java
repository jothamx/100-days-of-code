import examples.ExampleBean1;
import examples.ExampleBean2;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MyTest {
    public static void main(String[] args) {
        ApplicationContext context =new ClassPathXmlApplicationContext("beans.xml");
        ExampleBean1 exampleBean1 = (ExampleBean1)context.getBean("exampleBean1");
        System.out.println(exampleBean1.toString());
        ExampleBean2 exampleBean2 = (ExampleBean2)context.getBean("exampleBean2");
        System.out.println(exampleBean2.toString());
    }
}
