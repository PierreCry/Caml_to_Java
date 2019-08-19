import java.util.*;

class Config extends Object {
	
    private Value vv;
    private LinkedList<Instr> cc;
    private LinkedList<StackElem> ss;
	private LinkedList<Couple<String,LinkedList<Instr>>> fds;
	
	/* Constructors */
    public Config (Value v, LinkedList<Instr> c, LinkedList<StackElem> s, LinkedList<Couple<String,LinkedList<Instr>>> f) {
        this.vv = v;
        this.cc = c;
        this.ss = s;
		this.fds = f;
    }
	
	/* ********************* */
	/* Set */
	/* ********************* */
	
	void setValue(Value v) {
        this.vv = v;
    }
	
    void setCode(LinkedList<Instr> c) {
        this.cc = c;
    }
	
    void setStack(LinkedList<StackElem> s) {
        this.ss = s;
    }
	
	void setFds(LinkedList<Couple<String,LinkedList<Instr>>> f) {
		this.fds = f;
	}
	
	/* ********************* */
	/* Get */
	/* ********************* */

    Value getValue() {
        return this.vv;
    }
	
    LinkedList<Instr> getCode() {
        return this.cc;
    }
	
    LinkedList<StackElem> getStack() {
        return this.ss;
    }
	
	LinkedList<Couple<String,LinkedList<Instr>>> getFds() {
		return this.fds;
	}
	
	/* ********************* */
	/* exec */
	/* ********************* */

    // one-step execution 
    boolean exec_step() {
        if (this.cc.isEmpty()) {return false;} 
		else {
			this.cc.get(0).exec_instr(this);			
			return true;
		}
    }

    // run to completion
    void exec() {
        while (exec_step()) {}
    }

    // run for n steps
    void step(int n) {
        System.out.print(n);
    }
    
}