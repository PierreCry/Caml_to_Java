
/* Construction d'une paire */
public class Cons extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
		ValueSE y = ((ValueSE)(cfg.getStack().pop()));
		Value x = cfg.getValue();
		PairV p = new PairV(y.getValue(),x);
		cfg.setValue(p);
		
		//On dépile
		cfg.getCode().pop();
		
    }
	
}