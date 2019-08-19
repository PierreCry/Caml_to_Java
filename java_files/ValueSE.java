
/* Value */
public class ValueSE extends StackElem {
	
	/* Fields */
    private Value vv;
    
	/* Constructors */
    public ValueSE(Value v) {
        this.vv = v;
    }

    public Value getValue() {
        return this.vv;
    }
    
}