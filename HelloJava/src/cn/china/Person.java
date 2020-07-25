package cn.china;

import org.jetbrains.annotations.NotNull;

public class Person implements Comparable<Person> {
    private String name;
    private int birth;

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

    @Override
    public int compareTo(@NotNull Person other) {
        return this.name.compareTo(other.name);
    }

    @Override
    public String toString() {
        return "name='" + name + '\'' + ", birth=" + birth;
    }
}
