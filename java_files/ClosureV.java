import java.util.*;

/* Closure */
class ClosureV extends Value {
	
    /* Fields */
    private LinkedList<Instr> cc;
	private Value vv;

    /* Constructors */
    public ClosureV (LinkedList<Instr> c, Value v) {
		this.cc = c;
		this.vv = v;
    }

    LinkedList<Instr> getCode () {
        return this.cc;
    }
	
    Value getValue () {
        return this.vv;
    }

    void printValue() {
        System.out.print(this.vv);
    }
	
}