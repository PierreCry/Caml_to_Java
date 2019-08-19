
(* Instructions of the CAM *)

open Miniml;;

type instr =
	PrimInstr of primop
	| Cons
	| Push
	| Swap
	| Return
	| Quote of value
	| Cur of code
	| App
	| Branch of code * code
	| Call of var
	| AddDefs of (var * code) list
	| RmDefs of int

and value =
	NullV 
	| VarV of Miniml.var
	| IntV of int
	| BoolV of bool
	| PairV of value * value
	| ClosureV of code * value

and code = 
	instr list
  
type stackelem = Val of value | Cod of code

(* ****************************** *)

(* Exercice 1 - Fonction exec *)

let rec chop n fds = match n,fds with
	(1,a::fds) -> fds
	| (n,fds) -> chop (n-1) (fds);;

let rec exec_aux = function
	(* Divers *)
	(PairV(x,y),PrimInstr(UnOp(Fst))::c,st,fds) -> exec_aux(x,c,st,fds) (* Fst *)
	| (PairV(x,y),PrimInstr(UnOp(Snd))::c,st,fds) -> exec_aux(y,c,st,fds) (* Snd *)
	| (x,Cons::c,(Val y)::st,fds) -> exec_aux(PairV(y,x),c,st,fds) (* Cons *)
	| (x,Push::c,st,fds) -> exec_aux(x, c, (Val x)::st,fds) (* Push *)
	| (x,Swap::c,(Val y)::st,fds) -> exec_aux(y,c,(Val x)::st,fds) (* Swap *)
	| (t,(Quote v)::c,st,fds) -> exec_aux(v,c,st,fds) (* Quote *)
	| (x,(Cur c1)::c,st,fds) -> exec_aux(ClosureV(c1,x),c,st,fds) (* Cur *)
	| (x,Return::c,(Cod cc)::st,fds) -> exec_aux(x,cc,st,fds) (* Return *)
	| (PairV(ClosureV(x,y),z),(App::c),st,fds) -> exec_aux(PairV(y,z),x,(Cod c)::st,fds) (* App *)
	| ((BoolV b),Branch(c1,c2)::c,(Val x)::st,fds) -> exec_aux(x,(if b then c1 else c2),(Cod c)::st,fds) (* Branch *)
	(* Opérations *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BArith(BAadd)))::c,st,fds) -> exec_aux(IntV(m + n),c,st,fds) (* + *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BArith(BAsub)))::c,st,fds) -> exec_aux(IntV(m - n),c,st,fds) (* - *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BArith(BAmul)))::c,st,fds) -> exec_aux(IntV(m * n),c,st,fds) (* * *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BArith(BAdiv)))::c,st,fds) -> exec_aux(IntV(m / n),c,st,fds) (* / *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BArith(BAmod)))::c,st,fds) -> exec_aux(IntV(m mod n),c,st,fds) (* mod *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BCompar(BCeq)))::c,st,fds) -> exec_aux(BoolV(m == n),c,st,fds) (* == *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BCompar(BCge)))::c,st,fds) -> exec_aux(BoolV(m >= n),c,st,fds) (* >= *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BCompar(BCgt)))::c,st,fds) -> exec_aux(BoolV(m > n),c,st,fds) (* > *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BCompar(BCle)))::c,st,fds) -> exec_aux(BoolV(m <= n),c,st,fds) (* <= *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BCompar(BClt)))::c,st,fds) -> exec_aux(BoolV(m < n),c,st,fds) (* < *)
	| (PairV((IntV m),(IntV n)),PrimInstr(BinOp(BCompar(BCne)))::c,st,fds) -> exec_aux(BoolV(m <> n),c,st,fds) (* <> *)
	(* Appels récursifs *)
	| (t,Call(f)::c,st,fds) -> (t,(List.assoc f fds)@c,st,fds) (* Call *)
	| (t,AddDefs(defs)::c,st,fds) -> (t,c,st,defs@fds) (* AddDefs *)
	| (t,RmDefs(n)::c,st,fds) -> (t,c,st,chop n fds) (* RmDefs *)
	(* Cas de base *)
	| cfg -> cfg ;;
	
let exec = function
	config -> exec_aux(NullV,config,[],[]) ;;

(* Exercice 2 *)

(*
#trace exec
*)
	
(* ****************************** *)

(* Access *)

(* Ces fonctions permettent la gestion des variables dans l'environnement *)

type envelem = EVar of var | EDef of var list;;

let rec access_aux_def v env = match env with
	[] -> failwith "La définition n'existe pas"
	| (x::env) -> if (v=x)
					then [Call x]
					else (access_aux_def v env);;

let rec access_aux_var v env result = match env with
    [] -> failwith "La variable n'existe pas"
    | EVar(x)::env -> if (x=v)
						then result@[PrimInstr(UnOp(Snd))]
						else (access_aux_var v env ((PrimInstr(UnOp(Fst)))::result))
    | EDef(x)::env -> (access_aux_def v x);;

let access v env = access_aux_var v env [];;

(* ****************************** *)

(* Fix *)

(* Ces fonctions permettent la gestion des fonctions définies dans l'environnement récursif *)

let rec funName defs = match defs with
	|((n,b)::defs) -> n::funName(defs)
	|[] -> [];;

let rec compile_aux defs env f = match defs with
	|((n,b)::defs) -> (n,f(env,b)) :: (compile_aux defs env f)
	|[] -> [];;
	
(* ****************************** *)

(* Compile *)

(* 
	Ces fonctions permettent, à partir d'un environnement et d'un terme, de renvoyer
	l'ensemble des instructions à effectué par les fichiers java.
*)

let rec compile = function
	|(env,Bool(b)) -> [Quote(BoolV(b))] (* Bool *)
	|(env,Int(i)) -> [Quote(IntV(i))] (* Int *)
	|(env,Var(v)) -> access v env (* Var *)
	|(env,Fn(v,e)) -> [Cur((compile(EVar(v)::env,e))@[Return])]
	|(env,App(PrimOp(p),e)) -> compile(env,e)@[PrimInstr(p)]
	|(env,App(f,a)) -> [Push]@(compile(env,f))@[Swap]@(compile(env,a))@[Cons;App]
	|(env,Pair(e1,e2)) -> [Push]@(compile(env,e1))@[Swap]@(compile(env,e2))@[Cons]
	|(env,Cond(i,t,e)) -> [Push]@compile(env,i)@[Branch(compile(env,t)@[Return],compile(env,e)@[Return])]
	(* Appels récursifs *)
	|(env,Fix(defs,e)) -> let dc = (compile_aux defs (EDef(funName defs)::env) compile) in 
								let ec = compile(EDef((funName defs))::env,e) in 
									[AddDefs dc] @ ec @ [RmDefs (List.length dc)];;

let compile_prog = function
	Prog(t,exp) -> compile([],exp);;

(* ****************************** *)

(* Print *)

(* 	
	Ces fonctions ont pour but de créer le fichier Gen.java à partir des informations compilées.
	A chaque instruction ou valeur, on écrit son équivalent en java.
*)

(* Instructions *)
let rec print_instr = function
	(* Divers *)
	(PrimInstr(UnOp(Fst))::config) -> "\nLLE.add_elem(new Fst(),"^print_instr(config)^")" (* Fst *)
	|(PrimInstr(UnOp(Snd))::config) -> "\nLLE.add_elem(new Snd(),"^print_instr(config)^")" (* Snd *)
	|(Cons::config) -> "\nLLE.add_elem(new Cons()," ^ print_instr(config)^")" (* Cons *)
	|(Push::config) -> "\nLLE.add_elem(new Push()," ^ print_instr(config)^")" (* Push *)
	|(Swap::config) -> "\nLLE.add_elem(new Swap()," ^ print_instr(config)^")" (* Swap *)
	|((Quote v)::config) -> "\nLLE.add_elem(new Quote("^ print_value(v) ^"),"^print_instr(config)^")" (* Quote *)
	|((Cur c)::config) ->"\nLLE.add_elem(new Cur("^print_instr(c)^"),"^print_instr(config)^")" (* Cur *)
	|(Return::config) -> "\nLLE.add_elem(new Return(),"^print_instr(config)^")" (* Return *)
	|(App::config) -> "\nLLE.add_elem(new App(),"^print_instr(config)^")" (* App *)
	|(Branch(c1,c2) :: config) -> "\nLLE.add_elem(new Branch("^print_instr(c1)^","^print_instr(c2)^")," ^ print_instr(config)^")" (* Branch *)
	(* Opérations *)
	|(PrimInstr(BinOp(BArith(BAadd)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Add),"^print_instr(config)^")" (* + *)
	|(PrimInstr(BinOp(BArith(BAsub)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Sub),"^print_instr(config)^")" (* - *)
	|(PrimInstr(BinOp(BArith(BAmul)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Mult),"^print_instr(config)^")" (* * *)
	|(PrimInstr(BinOp(BArith(BAdiv)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Div),"^print_instr(config)^")" (* / *)
	|(PrimInstr(BinOp(BArith(BAmod)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Mod),"^print_instr(config)^")" (* mod *)
	|(PrimInstr(BinOp(BCompar(BCeq)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Eq),"^print_instr(config)^")" (* == *)
	|(PrimInstr(BinOp(BCompar(BCge)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Ge),"^print_instr(config)^")" (* >= *)
	|(PrimInstr(BinOp(BCompar(BCgt)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Gt),"^print_instr(config)^")" (* > *)
	|(PrimInstr(BinOp(BCompar(BCle)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Le),"^print_instr(config)^")" (* <= *)
	|(PrimInstr(BinOp(BCompar(BClt)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Lt),"^print_instr(config)^")" (* < *)
	|(PrimInstr(BinOp(BCompar(BCne)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Ne),"^print_instr(config)^")" (* <> *)
	(* Appels récursifs *)
	|((Call f)::config) -> "\nLLE.add_elem(new Call(\""^f^"\")," ^ print_instr(config) ^ ")"
	|((AddDefs defs)::config) -> "\nLLE.add_elem(new AddDefs("^ print_defs defs ^"),"^print_instr(config) ^")"
	|((RmDefs n)::config) -> "\nLLE.add_elem(new RmDefs("^string_of_int(n)^"),"^print_instr(config)^ ")"
	(* Cas de base *)
	|[] -> "LLE.empty()"

(* Valeurs *)
and print_value = function 
	  NullV -> "new NullV()"
	| IntV(v) -> "new IntV("^(string_of_int v)^")"
	| VarV(v) -> "new IntV("^v^")"
	| BoolV(b) -> "new BoolV("^(string_of_bool b)^")"
	| PairV(x,y) -> "new PairV("^print_value(x)^","^print_value(y)^")"
	| ClosureV(c,v) -> "new ClosureV("^print_instr(c)^","^print_value(v)^")"
	
(* Pile *)
and print_defs = function
	((n,b)::defs) -> "LLE.add_elem(new Couple(\""^n^"\","^(print_instr b)^"), "^(print_defs defs)^")"
    | [] -> "LLE.empty()";;

(* Fonction principale *)
let print_gen_class_to_java = function 
	cfg -> "import java.util.*; \n" ^
			"public class Gen { \n" ^
			"public static LinkedList<Instr> code =" ^
				print_instr(cfg) ^"; \n}";;