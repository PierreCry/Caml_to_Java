
/* Return de la fonction */
public class Return extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On dépile
		cfg.getCode().pop();
		
		//On met à jour le terme et on l'ajoute
		CodeSE c = ((CodeSE)(cfg.getStack().pop()));
		cfg.setCode(c.getCode());
		
    }
	
}