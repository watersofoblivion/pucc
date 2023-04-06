(* Abstract Syntax *)

open SyntaxLoc

(*
 * TODO:
 *
 * - Comments (doc and non-doc)
 * - Integer radix (0x, 0b, 0o, etc.)
 * - Make lists (param lists, etc.) dedicated data types with their own locations
 * - Monad types and do syntax
 * - Pattern matching
 * - Records, Structs, and Variants
 * - Type parameters (polymorphism)
 * - Strings and Blobs
 * - Function overloading
 * - Operator overloading
 * - Local types
 * - Local modules (not first class)
 * - Pretty Print
 *)

(* Data Types *)

(* Names *)

type name =
  | Name   of { loc: loc; lexeme: string; }
  | Dotted of { loc: loc; lhs: name; rhs: name; }

(* Types *)

type ty_vis =
  | TyVisReadonly of { loc: loc }
  | TyVisAbstract of { loc: loc }

type ty =
  | TyBool   of { loc: loc; }
  | TyInt    of { loc: loc; }
  | TyConstr of { loc: loc; name: name; }
  | TyFun    of { loc: loc; param: ty; res: ty; }
  | TySig    of { loc: loc; elems: sig_elem list; }
  | TyWith   of { loc: loc; name: name; tys: ty_binding list; }
and sig_elem =
  | SigTy  of { loc: loc; name: name; params: mod_param list; ty: ty option; }
  | SigVal of { loc: loc; name: name; ty: ty; }
  | SigDef of { loc: loc; name: name; ty: ty; }
  | SigMod of { loc: loc; name: name; params: mod_param list; ty: ty; }
and ty_binding =
  | TyBinding of { loc: loc; name: name; params: mod_param list; vis: ty_vis option; ty: ty; }
and mod_param =
  | ModParam of { loc: loc; name: name; ty: ty option; }

(* Primitive Operations *)

type un =
  | UnNeg  of { loc: loc }
  | UnLNot of { loc: loc }
  | UnBNot of { loc: loc }

type bin =
  | BinAdd  of { loc: loc }
  | BinSub  of { loc: loc }
  | BinMul  of { loc: loc }
  | BinDiv  of { loc: loc }
  | BinMod  of { loc: loc }
  | BinLAnd of { loc: loc }
  | BinLOr  of { loc: loc }
  | BinBAnd of { loc: loc }
  | BinBOr  of { loc: loc }
  | BinBXor of { loc: loc }
  | BinSsl  of { loc: loc }
  | BinSsr  of { loc: loc }
  | BinUsl  of { loc: loc }
  | BinUsr  of { loc: loc }
  | BinSeq  of { loc: loc }
  | BinPeq  of { loc: loc }
  | BinSneq of { loc: loc }
  | BinPneq of { loc: loc }
  | BinLte  of { loc: loc }
  | BinLt   of { loc: loc }
  | BinGte  of { loc: loc }
  | BinGt   of { loc: loc }
  | BinRfa  of { loc: loc }

(* Patterns *)

type patt =
  | PattGround of { loc: loc; }
  | PattBool   of { loc: loc; value: bool; }
  | PattInt    of { loc: loc; lexeme: string; }
  | PattVar    of { loc: loc; lexeme: string; }
  | PattFun    of { loc: loc; name: name; params: param list; }
and param =
  | Param of { loc: loc; patt: patt; ty: ty option; }

(* Expressions *)

type expr =
  | ExprBool of { loc: loc; value: bool; }
  | ExprInt  of { loc: loc; lexeme: string; }
  | ExprId   of { loc: loc; name: name; }
  | ExprUn   of { loc: loc; op: un; operand: expr; }
  | ExprBin  of { loc: loc; op: bin; lhs: expr; rhs: expr; }
  | ExprCond of { loc: loc; cond: expr; tru: expr; fls: expr; }
  | ExprLet  of { loc: loc; recur: bool; bindings: binding list; scope: expr; }
  | ExprAbs  of { loc: loc; params: param list; ret: ty option; body: expr; }
  | ExprApp  of { loc: loc; fn: expr; args: expr list; }
and binding =
  | Binding of { loc: loc; patt: patt; ty: ty option; value: expr; }

(* Package Statement *)

type pkg_stmt = 
  | PkgLibrary    of { loc: loc; name: name; }
  | PkgExecutable of { loc: loc; name: name; }

(* Imports *)

type path =
  | Path of { loc: loc; path: string; }
type alias =
  | Alias of { loc: loc; alias: name option; path: path }
type pkgs =
  | Packages of { loc: loc; aliases: alias list; }
type import =
  | Import of { loc: loc; pkgs: pkgs }

(* Top-Level Bindings *)

type top =
  | TopTy  of { loc: loc; local: bool; bindings: ty_binding list; }
  | TopVal of { loc: loc; binding: binding; }
  | TopDef of { loc: loc; binding: binding; }
  | TopLet of { loc: loc; recur: bool; bindings: binding list; }
  | TopMod of { loc: loc; name: name; params: mod_param list; elems: top list; }

(* Files *)

type file =
  | File of { loc: loc; pkg: pkg; imports: import list; tops: top list; }

(* Constructors *)

(* Names *)

let name loc lexeme kontinue =
  Name { loc; lexeme; }
    |> kontinue
let dotted loc lhs rhs kontinue =
  Dotted { loc; lhs; rhs; }
    |> kontinue

(* Types *)

let ty_vis_readonly loc = TyVisReadonly { loc; }
let ty_vis_abstract loc = TyVisAbstract { loc; }

let ty_bool loc = TyBool { loc; }
let ty_int loc = TyInt { loc; }
let ty_constr loc name = TyConstr { loc; name; }
let ty_fun loc param res = TyFun { loc; param; res; }
let ty_sig loc elems = TySig { loc; elems; }
let ty_with loc name tys = TyWith { loc; name; tys; }

let sig_ty loc name params ty = SigTy { loc; name; params; ty; }
let sig_val loc name ty = SigVal { loc; name; ty; }
let sig_def loc name ty = SigDef { loc; name; ty; }
let sig_mod loc name params ty = SigMod { loc; name; params; ty; }

let ty_binding loc name params vis ty = TyBinding { loc; name; params; vis; ty; }

let mod_param loc name ty = ModParam { loc; name; ty; }

(* Primitive Operations *)

let un_neg loc = UnNeg { loc; }
let un_lnot loc = UnLNot { loc; }
let un_bnot loc = UnBNot { loc; }

let bin_add loc = BinAdd { loc; }
let bin_sub loc = BinSub { loc; }
let bin_mul loc = BinMul { loc; }
let bin_div loc = BinDiv { loc; }
let bin_mod loc = BinMod { loc; }
let bin_land loc = BinLAnd { loc; }
let bin_lor loc = BinLOr { loc; }
let bin_band loc = BinBAnd { loc; }
let bin_bor loc = BinBOr { loc; }
let bin_bxor loc = BinBXor { loc; }
let bin_ssl loc = BinSsl { loc; }
let bin_ssr loc = BinSsr { loc; }
let bin_usl loc = BinUsl { loc; }
let bin_usr loc = BinUsr { loc; }
let bin_seq loc = BinSeq { loc; }
let bin_peq loc = BinPeq { loc; }
let bin_sneq loc = BinSneq { loc; }
let bin_pneq loc = BinPneq { loc; }
let bin_lte loc = BinLte { loc; }
let bin_lt loc = BinLt { loc; }
let bin_gte loc = BinGte { loc; }
let bin_gt loc = BinGt { loc; }
let bin_rfa loc = BinRfa { loc; }

(* Patterns *)

let patt_ground loc = PattGround { loc; }
let patt_bool loc value = PattBool { loc; value; }
let patt_int loc lexeme = PattInt { loc; lexeme; }
let patt_var loc lexeme = PattVar { loc; lexeme; }
let patt_fun loc name params = PattFun { loc; name; params; }

let param loc patt ty = Param { loc; patt; ty; }

(* Expressions *)

let expr_bool loc value = ExprBool { loc; value; }
let expr_int loc lexeme = ExprInt { loc; lexeme; }
let expr_id loc name = ExprId { loc; name; }
let expr_un loc op operand = ExprUn { loc; op; operand; }
let expr_bin loc op lhs rhs = ExprBin { loc; op; lhs; rhs; }
let expr_cond loc cond tru fls = ExprCond { loc; cond; tru; fls; }
let expr_let loc recur bindings scope = ExprLet { loc; recur; bindings; scope; }
let expr_abs loc params ret body = ExprAbs { loc; params; ret; body; }
let expr_app loc fn args = ExprApp { loc; fn; args; }

let binding loc patt ty value = Binding { loc; patt; ty; value; }

(* Package Statements *)

let pkg_library loc name = PkgLibrary { loc; name; }
let pkg_executable loc name = PkgExecutable { loc; name; }

(* Import *)

let path loc path = Path { loc; path; }
let alias loc alias path = Alias { loc; alias; path; }
let alias_named loc local path = alias loc (Some local) path
let alias_unnamed loc path = alias loc None path
let pkgs loc aliases = Packages { loc; aliases; }
let import loc pkgs = Import { loc; pkgs; }

(* Top-Level Bindings *)

let top_ty loc local bindings = TopTy { loc; local; bindings; }
let top_val loc binding = TopVal { loc; binding; }
let top_def loc binding = TopDef { loc; binding; }
let top_let loc recur bindings = TopLet { loc; recur; bindings; }
let top_mod loc name params elems = TopMod { loc; name; params; elems; }

(* Files *)

let file loc pkg imports tops = File { loc; pkg; imports; tops; }
