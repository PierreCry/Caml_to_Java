
/* Placer l'élément au sommet de la pile */
public class Swap extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On dépile
        cfg.getCode().pop();
		
		//On met à jour le terme et on l'ajoute
		ValueSE y = ((ValueSE)(cfg.getStack().pop()));
		ValueSE x = new ValueSE(cfg.getValue());
		cfg.setValue(y.getValue());
		cfg.getStack().addFirst(x);
		
    }
	
}