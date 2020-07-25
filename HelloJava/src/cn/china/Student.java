package cn.china;

public class Student extends Person {

    public Student(String name, int birth, int score) {
        super(name, birth);
        this.score = score;
    }

    @Override
    public void run() {
        System.out.println("Student.run");
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    private int score;


}
