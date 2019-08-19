import java.util.*;

/* Définition de la fonctions locales */
class AddDefs extends Instr {
	
	private LinkedList<Couple<String,LinkedList<Instr>>> defs;
	
	public AddDefs (LinkedList<Couple<String,LinkedList<Instr>>> d) {
		this.defs = d;
	}
	
	void exec_instr(Config cfg) {
		
		//On dépile
		cfg.getCode().pop(); 
		
		//On recupère la pile de la config
		LinkedList<Couple<String,LinkedList<Instr>>> fds = cfg.getFds();
		
		//On met à jour la pile et on l'ajoute
		this.defs.addAll(fds);
		cfg.setFds(this.defs);
		
    }
	
}