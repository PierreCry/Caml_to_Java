import java.util.*;

// compile with: javac *java
// run with: java Main
public class Main {
    
    public static void main(String[] args) {
        Config cfg;
        cfg = new Config(new NullV(),Gen.code,LLE.empty(),LLE.empty());
        cfg.exec();
        cfg.getValue().printValue();
        System.out.println();
    }

}