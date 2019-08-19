
/* Pair */
public class PairV extends Value{
	
	/* Fields */
    private Value fst;
	private Value snd;
    
	/* Constructors */
    public PairV(Value f, Value s) {
        this.fst = f;
        this.snd = s;
    }
	
	public void setValueFst(Value f) {
		this.fst = f;
	}
	
    public void setValueSnd(Value s) {
		this.snd = s;
	}
    
    public Value getValueFst() {
		return this.fst;
	}
	
    public Value getValueSnd() {
		return this.snd;
	}
	
	void printValue() {
        System.out.println(this.fst);
		System.out.println(this.snd);
    }
	
}