(* Monomorphic Administrative Normal Form *)

(* Data Types *)

(* Types *)

type ty =
  | TyBool
  | TyInt
  | TyFun of { param: ty; res: ty }

(* Primitive Operations *)

type prim =
  | PrimNeg
  | PrimAdd
  | PrimSub
  | PrimMul
  | PrimDiv
  | PrimMod
  | PrimLNot
  | PrimBAnd
  | PrimBOr
  | PrimBXor
  | PrimBNot
  | PrimSsl
  | PrimSsr
  | PrimUsl
  | PrimUsr
  | PrimEq
  | PrimNeq
  | PrimLte
  | PrimLt
  | PrimGte
  | PrimGt

(* Patterns *)

type patt =
  | PattGround
  | PattVar of { id: Core.sym; }

(* Function Parameters *)

type param =
  | Param of { patt: patt; ty: ty; }

(* Expressions *)

type atom =
  | AtomBool of { value: bool; }
  | AtomInt of { value: int; }
  | AtomId of { id: Core.sym; }
  | AtomAbs of { arity: int; params: param list; ret: ty; body: expr; }
and expr =
  | ExprPrim of { op: prim; ops: atom list; }
  | ExprCond of { cond: atom; tru: expr; fls: expr; }
  | ExprLet of { bindings: binding list; scope: expr; }
  | ExprApp of { fn: atom; args: atom list; }
  | ExprAtom of { atom: atom; }

(* Bindings *)

and binding =
  | Binding of { patt: patt; ty: ty; value: expr; }

(* Top-Level Bindings *)

type top =
  | TopVal of { bindings: binding list; }

(* Files *)

type file = 
  | File of { tops: top list; }

(* Constructors *)

let ty_bool = TyBool
let ty_int = TyInt
let ty_fun param res = TyFun { param; res; }

let prim_neg = PrimNeg
let prim_add = PrimAdd
let prim_sub = PrimSub
let prim_mul = PrimMul
let prim_div = PrimDiv
let prim_mod = PrimMod
let prim_lnot = PrimLNot
let prim_band = PrimBAnd
let prim_bor = PrimBOr
let prim_bxor = PrimBXor
let prim_bnot = PrimBNot
let prim_ssl = PrimSsl
let prim_ssr = PrimSsr
let prim_usl = PrimUsl
let prim_usr = PrimUsr
let prim_peq = PrimPeq
let prim_pneq = PrimPneq
let prim_lte = PrimLte
let prim_lt = PrimLt
let prim_gte = PrimGte
let prim_gt = PrimGt

let patt_ground = PattGround
let patt_var id = PattVar { id; }

let param patt ty = Param { patt; ty; }

let atom_bool value = AtomBool { value; }
let atom_int value = AtomInt { value; }
let atom_id id = AtomId { id; }
let atom_abs params ret body = AtomAbs { arity = List.lenth params; params; ret; body; }

let expr_prim op ops = ExprPrim { op; ops; }
let expr_cond cond tru fls = ExprCond { cond; tru; fls; }
let expr_let bindings scope = ExprLet { bindings; scope; }
let expr_app fn args = ExprApp { fn; args; }
let expr_atom atom = ExprAtom { atom; }

let binding patt ty value = Binding { patt; ty; value; }

let top_val bindings = TopVal { bindings; }

let file tops = File { tops }