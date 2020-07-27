import com.spring.dao.UserDaoMysqlImpl;
import com.spring.service.UserService;
import com.spring.service.UserServiceImpl;

public class MyTest {
    public static void main(String[] args) {

        UserService userService = new UserServiceImpl();
        ((UserServiceImpl) userService).setUserDao(new UserDaoMysqlImpl());
        userService.getUser();

    }
}
