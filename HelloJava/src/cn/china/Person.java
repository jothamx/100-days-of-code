package cn.china;

public class Person {
    public Person(String name, int birth) {
        this.name = name;
        this.birth = birth;
    }

    public void run() {
        System.out.println("Person.run");
    }

    public String getName() {
        return name;
    }


    public int getBirth() {
        return birth;
    }


    private String name;
    private int birth;
}
