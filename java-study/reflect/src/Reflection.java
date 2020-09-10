import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.time.Month;

public class Reflection {
    public static void main(String[] args) throws IllegalAccessException,
            InstantiationException, NoSuchFieldException, NoSuchMethodException, InvocationTargetException, ClassNotFoundException {
        // print class info
        printClassInfo("".getClass());
        printClassInfo(Runnable.class);
        printClassInfo(Month.class);
        printClassInfo(String[].class);
        printClassInfo(int.class);

        //只能调用public的无参构造器
        Class cls = String.class;
        String s = (String) cls.newInstance();

        //获得类字段
        Class stdClass = Student.class;
        // 获取public字段"score":
        System.out.println(stdClass.getField("score"));
        // 获取private字段"grade":
        System.out.println(stdClass.getDeclaredField("grade"));


        Person p = new Person("Xiao Ming");
        System.out.println(p.getName()); // "Xiao Ming"
        Class c = p.getClass();
        Field f = c.getDeclaredField("name");
        f.setAccessible(true);
        f.set(p, "Xiao Hong");
        System.out.println(p.getName()); // "Xiao Hong"

        //反射调用函数
        String hello = "Hello world";
        // 获取String substring(int)方法，参数为int:
        Method m = String.class.getMethod("substring", int.class);
        // 在s对象上调用该方法并获取结果:
        String r = (String) m.invoke(hello, 6);
        System.out.println(r);

        //反射调用构造函数
        Constructor cons = Integer.class.getConstructor(String.class);
        Integer n = (Integer) cons.newInstance("456");
        System.out.println(n);

        //获得Class的两种方法
        Class cls1 = String.class;
        Class cls2 = Class.forName("java.lang.String");

        //获得父类class
        Class cls3 = String.class.getSuperclass();
        System.out.println(cls3);

        //获得接口列表
        Class[] is = String.class.getInterfaces();
        for (Class i : is) {
            System.out.println(i);
        }



    }

    static void printClassInfo(Class cls) {
        System.out.println("Class name: " + cls.getName());
        System.out.println("Simple name: " + cls.getSimpleName());
        if (cls.getPackage() != null) {
            System.out.println("Package name: " + cls.getPackage().getName());
        }
        System.out.println("is interface: " + cls.isInterface());
        System.out.println("is enum: " + cls.isEnum());
        System.out.println("is array: " + cls.isArray());
        System.out.println("is primitive: " + cls.isPrimitive());
    }
}

class Student extends Person {
    public int score;
    private int grade;

    public Student(String name) {
        super(name);
    }
}

class Person {
    private String name;

    public Person(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }
}