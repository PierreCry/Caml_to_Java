
/* Couple */
public class Couple<First,Second> {
	
    private First fst;
    private Second snd;
    
    public Couple(First f, Second s){
        this.fst = f;
        this.snd = s;
    }
    
    public First getFst(){
		return this.fst;
	}
    
    public Second getSnd(){
		return this.snd;
	}
    
}