
/* Int */
public class IntV extends Value {
	
    /* Fields */
    private int iv;

    /* Constructors */
    public IntV (int i) {
		this.iv = i;
    }
	
	void setInt (int i) {
        this.iv = i;
    }

    int getInt () {
        return this.iv;
    }

    void printValue() {
        System.out.print(this.iv);
    }
	
}