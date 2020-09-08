
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

public class Enum {
    public static void main(String[] args) {
    
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
    }
}
