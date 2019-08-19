import java.util.*; 
public class Gen { 
public static LinkedList<Instr> code =
LLE.add_elem(new Push(),
LLE.add_elem(new Cur(
LLE.add_elem(new Push(),
LLE.add_elem(new Snd(),
LLE.add_elem(new Swap(),
LLE.add_elem(new Quote(new IntV(3)),
LLE.add_elem(new Cons(),
LLE.add_elem(new BinOp(BinOp.operateur.Mult),
LLE.add_elem(new Return(),LLE.empty())))))))),
LLE.add_elem(new Swap(),
LLE.add_elem(new Quote(new IntV(2)),
LLE.add_elem(new Cons(),
LLE.add_elem(new App(),LLE.empty())))))); 
}