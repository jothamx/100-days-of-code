import com.examples.annotation.MovieRecommender;
import com.examples.pojo.Person;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MyTest {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        Person p = context.getBean("person", Person.class);
        System.out.println(p.toString());
        MovieRecommender recommender = context.getBean("recommender", MovieRecommender.class);
        System.out.println(recommender.toString());
    }
}
