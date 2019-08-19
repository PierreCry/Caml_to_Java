
/* 2nd élément d'une paire */
public class Snd extends Instr {
	
	void exec_instr(Config cfg){
		
		//On met à jour le terme et on l'ajoute
		cfg.setValue(((PairV)(cfg.getValue())).getValueSnd());
		
		//On dépile
		cfg.getCode().pop();
		
	}
	
}