import java.util.*;

/* Appel de la fonction */
public class Call extends Instr {
	
	private String ss;
	
	public Call (String s) {
		this.ss = s;
	}
	
	void exec_instr(Config cfg) {
		
		//On dépile
		cfg.getCode().pop();
		
		//On recupère la pile de la config
		LinkedList<Couple<String,LinkedList<Instr>>> fds = cfg.getFds();
		
		//On met à jour la pile et on l'ajoute
		for (int i=0; i<fds.size(); i++){
			if (fds.get(i).getFst().equals(this.ss)){
				LinkedList<Instr> c = new LinkedList<Instr>(fds.get(i).getSnd());
				c.addAll(cfg.getCode());
				cfg.setCode(c);
				break;
			}
		}
		
	}
    
}