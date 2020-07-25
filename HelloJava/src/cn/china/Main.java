package cn.china;

import org.jetbrains.annotations.NotNull;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.*;
import java.util.ArrayList;
import java.util.Arrays;

enum Weekday {
    //SUN, MON, TUE, WED, THU, FRI, SAT;
    MON(1, "星期一"), TUE(2, "星期二"), WED(3, "星期三"),
    THU(4, "星期四"), FRI(5, "星期五"), SAT(6, "星期六"),
    SUN(0, "星期日");
    public final int dayValue;
    private final String chinese;

    Weekday(int dayValue, String chinese) {
        this.dayValue = dayValue;
        this.chinese = chinese;
    }

    @Override
    public String toString() {
        return this.chinese;
    }
}

class Pair<T> {
    private final T first;
    private final T last;

    public Pair(T first, T last) {
        this.first = first;
        this.last = last;
    }

    public T getFirst() {
        return this.first;
    }

    public T getLast() {
        return this.last;
    }
}

public class Main {

    static void arrayLoop1() {
        int[] ns = new int[]{1, 4, 9, 16, 25};
        for (int n : ns) {
            System.out.print(n + ", ");
        }
    }

    static void arrayLoop2() {
        int[] ns = new int[]{1, 4, 9, 16, 25};
        for (int i : ns) {
            System.out.print(i + ", ");
        }
    }

    static void sortArray() {
        int[] ns = {28, 12, 89, 73, 65, 18, 96, 50, 8, 36};
        Arrays.sort(ns);
        System.out.println(Arrays.toString(ns));
    }

    static void printClassInfo(@NotNull Class cls) {
        System.out.println("Class name:" + cls.getName());
        System.out.println("Simple name:" + cls.getSimpleName());
        if (cls.getPackage() != null) {
            System.out.println("Package name:" + cls.getPackage().getName());
        }
        System.out.println();
    }

    // <? extends Number> => Upper Bounds Wildcards
    static int add(@NotNull Pair<? extends Number> p) {
        Number first = p.getFirst();
        Number last = p.getLast();
        return first.intValue() + last.intValue();
    }

    public static void main(String[] args) throws IntrospectionException, NoSuchFieldException,
            NoSuchMethodException, InvocationTargetException, IllegalAccessException, InstantiationException {
        arrayLoop1();
        System.out.println();
        arrayLoop2();
        System.out.println();
        sortArray();

        Person p = new Person("Jack", 2011);
        System.out.printf("%s was born in %d\n", p.getName(), p.getBirth());

        Group g = new Group();
        g.setNames("Xiao Ming", "Xiao Hong", "Xiao Jun"); // 传入3个String;
        System.out.println(Arrays.toString(g.getNames()));

        Student s = new Student("Xiao Hua", 2001, 98);
        System.out.printf("%s : %d\n", s.getName(), s.getScore());

        // test override
        ArrayList<Person> ps = new ArrayList<>();
        ps.add(new Student("Xiao Ming", 1989, 79));
        ps.add(new Person("Li Lei", 1968));
        for (Person pp : ps) {
            pp.run();
        }

        // Java Bean
        BeanInfo info = Introspector.getBeanInfo(PersonBean.class);
        for (PropertyDescriptor pd : info.getPropertyDescriptors()) {
            System.out.println(pd.getName());
            System.out.println("  " + pd.getReadMethod());
            System.out.println("  " + pd.getWriteMethod());
        }

        // Enum
        Weekday day = Weekday.SUN;
        if (day == Weekday.SAT || day == Weekday.SUN) {
            System.out.println("work at home!");
        } else {
            System.out.println("work at office!");
        }
        System.out.println("FRI ordinal: " + Weekday.FRI.ordinal());
        System.out.println("FRI name: " + Weekday.FRI.name());
        System.out.println("FRI chinese: " + Weekday.FRI.toString());

        printClassInfo("".getClass());
        printClassInfo(Weekday.class);
        printClassInfo(ps.getClass());
        printClassInfo(String[].class);
        printClassInfo(int.class);

        // Reflection Fields
        Field f = String.class.getDeclaredField("value");
        System.out.printf("Field name: %s\n", f.getName());
        System.out.printf("Field type: %s\n", f.getType());
        int m = f.getModifiers();
        System.out.println("String Field 'value':");
        System.out.printf("  final %s\n", Modifier.isFinal(m));
        System.out.printf("  private %s\n", Modifier.isPrivate(m));

        // Reflection Methods
        String sr = "Hello World";
        Method mt = String.class.getMethod("substring", int.class);
        String r = (String) mt.invoke(sr, 6);
        System.out.println(r);

        Method m1 = Integer.class.getMethod("parseInt", String.class);
        Integer n = (Integer) m1.invoke(null, "12345");
        System.out.printf("parseInt: %d\n", n);

        Constructor cons1 = Integer.class.getConstructor(int.class);
        Integer n1 = (Integer) cons1.newInstance(123);
        System.out.printf("getConstructor: %d\n", n1);

        // Generic
        Person[] persons = new Person[]{
                new Person("Bob", 61),
                new Person("Alice", 88),
                new Person("Lily", 75),
        };
        Arrays.sort(persons);
        System.out.println(Arrays.toString(persons));

        Pair<String> pair = new Pair<String>("test", "123");
        System.out.printf("First: %s - Last: %s\n", pair.getFirst(), pair.getLast());

        Pair<Number> pn = new Pair<>(123, 456);
        int nn = add(pn);
        System.out.printf("Pair<Number> add: %d\n", nn);

        Pair<Integer> pi = new Pair<>(123, 456);
        int ii = add(pi);
        System.out.printf("Pair<Integer> add: %d\n", ii);


    }
}
