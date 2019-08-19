import java.util.*;

/* Code */
public class CodeSE extends StackElem {
	
	/* Fields */
    private LinkedList<Instr> cc;
	
	/* Constructors */
    public CodeSE(LinkedList<Instr> c) {
        this.cc = c;
    }

    public LinkedList<Instr> getCode() {
        return this.cc;
    }  
    
}