import java.util.*;

/* Retrait des fonctions locales */
public class RmDefs extends Instr {
	
	private int nn;
	
	public RmDefs (int n){
		this.nn = n;
	}
	
	void exec_instr(Config cfg) {
		
		//On dépile
		cfg.getCode().pop();
		
		//On met à jour le terme et on l'ajoute
		LinkedList<Couple<String,LinkedList<Instr>>> fds = cfg.getFds();
		for(int i=0;i<this.nn;i++) {fds.pop();}
		cfg.setFds(new LinkedList<Couple<String,LinkedList<Instr>>> (fds));
    }
	
}