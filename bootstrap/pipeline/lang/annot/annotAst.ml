(* Abstract Syntax *)

(* Data Types *)

(* Types *)

type ty =
  | TyBool
  | TyInt
  | TyFun of { param: ty; res: ty }
  | TyMod of { ty: tymod }
  | TyConstr of { id: Core.sym; }
and tymod =
  | ModSig of { tops: topsig; }
  | ModFunct of { id: Core.sym; param: tymod; res: tymod }
  | ModId of { id: Core.sym; }
and topsig =
  | SigTy of { id: Core.sym; ty: ty option; }
  | SigLet of { ty: ty; }

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
  | PrimSeq
  | PrimPeq
  | PrimSneq
  | PrimPneq
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

type expr =
  | ExprBool of { value: bool; }
  | ExprInt of { value: int; }
  | ExprId of { id: Core.sym; }
  | ExprPrim of { op: prim; ops: expr list; }
  | ExprCond of { cond: expr; tru: expr; fls: expr; }
  | ExprLet of { bindings: binding list; scope: expr; }
  | ExprAbs of { arity: int; params: param list; ret: ty; body: expr; }
  | ExprApp of { fn: expr; args: expr list; }

(* Bindings *)

and binding =
  | Binding of { patt: patt; ty: ty; value: expr; }

(* Package Statements *)

type pkg = 
  | Library of { id: Core.sym; }
  | Executable of { id: Core.sym; }

(* Top-Level Statements *)

type top =
  | TopTy of { id: Core.sym; ty: ty; }
  | TopVal of { bindings: binding list; }
  | TopMod of { topmod: topmod; }
and topmod =
  | TopMod of { tops: top list; }
  | TopFunct of { id: Core.sym; ty: tymod; str: topmod; }
  | TopMApp of { funct: }

(* Files *)

type file =
  | File of { pkg: pkg; tops: top list; }

(* Constructors *)

let ty_bool = TyBool
let ty_int = TyInt
let ty_fun param res = TyFun { param; res; }
let ty_constr id = TyConstr { id; }

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
let prim_seq = PrimSeq
let prim_peq = PrimPeq
let prim_sneq = PrimSneq
let prim_pneq = PrimPneq
let prim_lte = PrimLte
let prim_lt = PrimLt
let prim_gte = PrimGte
let prim_gt = PrimGt

let patt_ground = PattGround
let patt_var id = PattVar { id; }

let param patt ty = Param { patt; ty; }

let expr_bool value = ExprBool { value; }
let expr_int value = ExprInt { value; }
let expr_id id = ExprId { id; }
let expr_prim op ops = ExprPrim { op; ops; }
let expr_cond cond tru fls = ExprCond { cond; tru; fls; }
let expr_let bindings scope = ExprLet { bindings; scope; }
let expr_abs params ret body = ExprAbs { arity = List.length params; params; ret; body; }
let expr_app fn args = ExprApp { fn; args; }

let binding patt ty value = Binding { patt; ty; value; }

let pkg_library id = Library { id; }
let pkg_executable id = Executable { id; }

let top_ty id ty = TopTy { id; ty; }
let top_val bindings = TopVal { bindings; }

let file pkg tops = File { pkg; tops; }