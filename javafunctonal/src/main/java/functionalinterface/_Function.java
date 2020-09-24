package functionalinterface;

import java.util.function.BiFunction;
import java.util.function.Function;

public class _Function {


    static Function<Integer, Integer> incrementByOneFunction = number -> number + 1;

    static Function<Integer, Integer> multiplyByTenFunction = number -> number * 10;

    static BiFunction<Integer, Integer, Integer> incrementByOneAndMultiplyBiFunction =
            (numberToIncrement, numberToMultiply)
                    -> (numberToIncrement + 1) * numberToMultiply;

    public static void main(String[] args) {

        int increment = incrementByOneFunction.apply(1);
        System.out.println(increment);

        int multiply = multiplyByTenFunction.apply(increment);
        System.out.println(multiply);


        Function<Integer, Integer> addByOneAndThenMultiplyByTen =
                incrementByOneFunction
                        .andThen(multiplyByTenFunction);
        System.out.println(addByOneAndThenMultiplyByTen.apply(5));

        System.out.println(incrementByOneAndMultiplyBiFunction.apply(5, 10));
    }
}
