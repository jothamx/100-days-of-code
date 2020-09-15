import com.examples.Bean1;
import com.examples.Bean2;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MyTest {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        Bean1 b1 = (Bean1) context.getBean("singleton1");
        Bean2 b2 = (Bean2) context.getBean("singleton2");
        // 因为是singleton模式，所以b1和b2的accountDao相同
        // 如果accountDao是prototype模式，以下会打印false
        System.out.println(b1.getAccountDao()==b2.getAccountDao());

    }
}
