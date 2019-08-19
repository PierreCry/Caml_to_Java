

public class Quote extends Instr {
	
	/* Fields */
    private Value vv;
	
	/* Constructors */
    public Quote (Value v) {
        this.vv = v;
    }
	
	void setValue(Value v) {
        this.vv = v;
    }

    Value getValue() {
        return this.vv;
    }

    void exec_instr(Config cfg) {
        cfg.setValue(this.vv);
        cfg.getCode().pop();
    }
	
}