import java.util.Scanner;

public class InputOutput {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        // get first input
        System.out.print("What is your name? ");
        String name = in.nextLine();
        // get second input
        System.out.print("How old are you? ");
        int age = in.nextInt();
        in.close();
        // display output on console
        System.out.println("Hello, " + name + ". Next year, you'll be " + (age + 1));
        // display output on console using formartting output
        System.out.printf("Hello, %s. Next year, you'll be %d\n", name, age);
    }
}