
/* On ajoute une valeur dans la pile */
public class Push extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
		ValueSE x = new ValueSE(cfg.getValue());
		cfg.getStack().addFirst(x);
		
		//On dépile
		cfg.getCode().pop();
		
    }
	
}