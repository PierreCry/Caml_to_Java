import java.util.*;

/* Branchement */
public class Branch extends Instr {
	
    private LinkedList<Instr> cc1;
	private LinkedList<Instr> cc2;

    /* Constructors */
    public Branch(LinkedList<Instr> c1, LinkedList<Instr> c2) {
        this.cc1 = c1;
		this.cc2 = c2;
    }
	    
    LinkedList<Instr> getCode1() {
        return this.cc1;
    }

    LinkedList<Instr> getCode2() {
        return this.cc2;
    }
	
    void exec_instr(Config cfg) {
		
		//On dépile
        cfg.getCode().pop();
		
		//On recupère de la config
		BoolV b = (BoolV) cfg.getValue();
		ValueSE x = (ValueSE) cfg.getStack().pop();
		cfg.setValue(x.getValue());
		cfg.getStack().addFirst(new CodeSE(cfg.getCode()));
		
		//On execute le code en fonction du boolean
		if (b.getBoolean()) {
			cfg.setCode(new LinkedList<Instr> (this.cc1));
		} else {
			cfg.setCode(new LinkedList<Instr> (this.cc2));
		}
    
    }
	
}