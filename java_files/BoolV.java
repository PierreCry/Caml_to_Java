
/* Boolean */
public class BoolV extends Value {
	
    /* Fields */
    private Boolean bv;

    /* Constructors */
    public BoolV (Boolean b) {
		this.bv = b;
    }
	
	void setBoolean (Boolean b) {
        this.bv = b;
    }

    Boolean getBoolean () {
        return this.bv;
    }

    void printValue() {
        System.out.print(this.bv);
    }
	
}