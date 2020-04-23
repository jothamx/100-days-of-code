
public class Hello {
    public static void main(String[] args) {
        System.out.println("We will not use 'Hello, World!'");
        // String concatenation
        String s = "Hello";
        String sub = s.substring(0, 3);
        System.out.println(sub);
        // Test String for equal using equals() method
        // Do not use the == operator to test whether two strings are equal!
        if ("Hello".equals(s)) {
            System.out.println("s equal to \"Hello\"");
        }
        // Empty and Null Strings
        String emp = "";
        if (emp.length() == 0) {
            System.out.println("emp is empty");
        }
        if (emp.equals("")) {
            System.out.println("emp is empty");
        }
        String nullstr = null;
        if (nullstr == null) {
            System.out.println("nullstr is null");
        }
        // Building Strings
        StringBuilder builder=new StringBuilder();
        builder.append("Hel");
        builder.append("lo!");
        String completedString=builder.toString();
        System.out.println(completedString);
    }
}