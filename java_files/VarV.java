
/* Var */
public class VarV extends Value {

    /* Fields */
    private String vv;

    /* Constructors */
    public VarV (String v) {
		this.vv = v;
    }
	
	void setValue (String v) {
        this.vv = v;
    }

    String getValue () {
        return this.vv;
    }

    void printValue() {
        System.out.print(this.vv);
    }
	
}