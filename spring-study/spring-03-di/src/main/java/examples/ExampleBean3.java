package examples;

public class ExampleBean3 {
    private AnotherBean beanOne;

    private YetAnotherBean beanTwo;

    private int i;

    public ExampleBean3(
            AnotherBean anotherBean, YetAnotherBean yetAnotherBean, int i) {
        this.beanOne = anotherBean;
        this.beanTwo = yetAnotherBean;
        this.i = i;
    }

    public static ExampleBean3 createInstance (
            AnotherBean anotherBean, YetAnotherBean yetAnotherBean, int i) {

        ExampleBean3 eb = new ExampleBean3 (anotherBean,yetAnotherBean,i);
        // some other operations...
        return eb;
    }
}
