
/* 1er élément d'une pair */
public class Fst extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
        cfg.setValue(((PairV)(cfg.getValue())).getValueFst());
		
		//On dépile
        cfg.getCode().pop();
    }
	
}