class Employee {

    private String name = "";
    private double salary = 0;

    public Employee(double s) {
        this("Employee", s);
    }

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    @Override
    public String toString(){
        return this.name+": "+this.salary;
    }
}

public class Constructor {
    public static void main(String[] args) {
        Employee e1 = new Employee("name", 10000);
        Employee e2 = new Employee(5000);
        System.out.println(e1);
        System.out.println(e2);
    }
}
