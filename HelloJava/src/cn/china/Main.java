package cn.china;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
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

public class Main {

    static void arrayLoop1() {
        int[] ns = new int[]{1, 4, 9, 16, 25};
        for (int i = 0; i < ns.length; ++i) {
            System.out.print(ns[i] + ", ");
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

    public static void main(String[] args) throws IntrospectionException {
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

        Weekday day = Weekday.SUN;
        if (day == Weekday.SAT || day == Weekday.SUN) {
            System.out.println("work at home!");
        } else {
            System.out.println("work at office!");
        }
        System.out.println("FRI ordinal: " + Weekday.FRI.ordinal());
        System.out.println("FRI name: " + Weekday.FRI.name());
        System.out.println("FRI chinese: " + Weekday.FRI.toString());

    }
}
