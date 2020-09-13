import java.util.Arrays;

public class Generic {
    public static void main(String[] args) {
        Person[] ps = new Person[]{
                new Person("Bob", 61),
                new Person("Alice", 88),
                new Person("Lily", 75),
        };
        Arrays.sort(ps);
        System.out.println(Arrays.toString(ps));

        Pair<String,String> pair1 = new Pair<>(new String("str 1"),new String("str 2"));
        System.out.println(pair1.getFirst());
        System.out.println(pair1.getLast());

        Pair<String,Integer> pair2 = Pair.create(new String("str"),4);
        System.out.println(pair2.getFirst());
        System.out.println(pair2.getLast());

    }
}

class Person implements Comparable<Person> {
    String name;
    int score;

    Person(String name, int score) {
        this.name = name;
        this.score = score;
    }

    public int compareTo(Person other) {
        return this.name.compareTo(other.name);
    }

    public String toString() {
        return this.name + "," + this.score;
    }
}

