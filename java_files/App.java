import java.util.LinkedList;

/* Application de la cloture */
public class App extends Instr{

	void exec_instr(Config cfg){
	
		//On dépile
		cfg.getCode().pop();
		
		//On récupère le terme de la config
		PairV p = ((PairV)(cfg.getValue()));
		ClosureV c1 = ((ClosureV)(p.getValueFst()));
		ValueSE y = new ValueSE (c1.getValue());
		ValueSE z = new ValueSE (p.getValueSnd());
		
		//On met à jour le terme et on l'ajoute
		PairV new_p = new PairV(y.getValue(),z.getValue());
		cfg.setValue(new_p);
		cfg.getStack().addFirst(new CodeSE(cfg.getCode()));
		cfg.setCode(new LinkedList<Instr> (c1.getCode()));
	
	}
}