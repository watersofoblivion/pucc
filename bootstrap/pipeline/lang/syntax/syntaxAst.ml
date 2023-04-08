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
  | File of { loc: loc; pkg: pkg_stmt; imports: import list; tops: top list; }

(* Constructors *)

(* Names *)

let name loc lexeme kontinue =
  Name { loc; lexeme; }
    |> kontinue
let dotted loc lhs rhs kontinue =
  Dotted { loc; lhs; rhs; }
    |> kontinue

(* Types *)

let ty_vis_readonly loc kontinue =
  TyVisReadonly { loc; }
    |> kontinue
let ty_vis_abstract loc kontinue =
  TyVisAbstract { loc; }
    |> kontinue

let ty_bool loc kontinue =
  TyBool { loc; }
    |> kontinue
let ty_int loc kontinue =
  TyInt { loc; }
    |> kontinue
let ty_constr loc name kontinue =
  TyConstr { loc; name; }
    |> kontinue
let ty_fun loc param res kontinue =
  TyFun { loc; param; res; }
    |> kontinue
let ty_sig loc elems kontinue =
  TySig { loc; elems; }
    |> kontinue
let ty_with loc name tys kontinue =
  TyWith { loc; name; tys; }
    |> kontinue

let sig_ty loc name params ty kontinue =
  SigTy { loc; name; params; ty; }
    |> kontinue
let sig_val loc name ty kontinue =
  SigVal { loc; name; ty; }
    |> kontinue
let sig_def loc name ty kontinue =
  SigDef { loc; name; ty; }
    |> kontinue
let sig_mod loc name params ty kontinue =
  SigMod { loc; name; params; ty; }
    |> kontinue

let ty_binding loc name params vis ty kontinue =
  TyBinding { loc; name; params; vis; ty; }
    |> kontinue

let mod_param loc name ty kontinue =
  ModParam { loc; name; ty; }
    |> kontinue

(* Primitive Operations *)

let un_neg loc kontinue =
  UnNeg { loc; }
    |> kontinue
let un_lnot loc kontinue =
  UnLNot { loc; }
    |> kontinue
let un_bnot loc kontinue =
  UnBNot { loc; }
    |> kontinue

let bin_add loc kontinue =
  BinAdd { loc; }
    |> kontinue
let bin_sub loc kontinue =
  BinSub { loc; }
    |> kontinue
let bin_mul loc kontinue =
  BinMul { loc; }
    |> kontinue
let bin_div loc kontinue =
  BinDiv { loc; }
    |> kontinue
let bin_mod loc kontinue =
  BinMod { loc; }
    |> kontinue
let bin_land loc kontinue =
  BinLAnd { loc; }
    |> kontinue
let bin_lor loc kontinue =
  BinLOr { loc; }
    |> kontinue
let bin_band loc kontinue =
  BinBAnd { loc; }
    |> kontinue
let bin_bor loc kontinue =
  BinBOr { loc; }
    |> kontinue
let bin_bxor loc kontinue =
  BinBXor { loc; }
    |> kontinue
let bin_ssl loc kontinue =
  BinSsl { loc; }
    |> kontinue
let bin_ssr loc kontinue =
  BinSsr { loc; }
    |> kontinue
let bin_usl loc kontinue =
  BinUsl { loc; }
    |> kontinue
let bin_usr loc kontinue =
  BinUsr { loc; }
    |> kontinue
let bin_seq loc kontinue =
  BinSeq { loc; }
    |> kontinue
let bin_peq loc kontinue =
  BinPeq { loc; }
    |> kontinue
let bin_sneq loc kontinue =
  BinSneq { loc; }
    |> kontinue
let bin_pneq loc kontinue =
  BinPneq { loc; }
    |> kontinue
let bin_lte loc kontinue =
  BinLte { loc; }
    |> kontinue
let bin_lt loc kontinue =
  BinLt { loc; }
    |> kontinue
let bin_gte loc kontinue =
  BinGte { loc; }
    |> kontinue
let bin_gt loc kontinue =
  BinGt { loc; }
    |> kontinue
let bin_rfa loc kontinue =
  BinRfa { loc; }
    |> kontinue

(* Patterns *)

let patt_ground loc kontinue =
  PattGround { loc; }
    |> kontinue
let patt_bool loc value kontinue =
  PattBool { loc; value; }
    |> kontinue
let patt_int loc lexeme kontinue =
  PattInt { loc; lexeme; }
    |> kontinue
let patt_var loc lexeme kontinue =
  PattVar { loc; lexeme; }
    |> kontinue
let patt_fun loc name params kontinue =
  PattFun { loc; name; params; }
    |> kontinue

let param loc patt ty kontinue =
  Param { loc; patt; ty; }
    |> kontinue

(* Expressions *)

let expr_bool loc value kontinue =
  ExprBool { loc; value; }
    |> kontinue
let expr_int loc lexeme kontinue =
  ExprInt { loc; lexeme; }
    |> kontinue
let expr_id loc name kontinue =
  ExprId { loc; name; }
    |> kontinue
let expr_un loc op operand kontinue =
  ExprUn { loc; op; operand; }
    |> kontinue
let expr_bin loc op lhs rhs kontinue =
  ExprBin { loc; op; lhs; rhs; }
    |> kontinue
let expr_cond loc cond tru fls kontinue =
  ExprCond { loc; cond; tru; fls; }
    |> kontinue
let expr_let loc recur bindings scope kontinue =
  ExprLet { loc; recur; bindings; scope; }
    |> kontinue
let expr_abs loc params ret body kontinue =
  ExprAbs { loc; params; ret; body; }
    |> kontinue
let expr_app loc fn args kontinue =
  ExprApp { loc; fn; args; }
    |> kontinue

let binding loc patt ty value kontinue =
  Binding { loc; patt; ty; value; }
    |> kontinue

(* Package Statements *)

let pkg_library loc name kontinue =
  PkgLibrary { loc; name; }
    |> kontinue
let pkg_executable loc name kontinue =
  PkgExecutable { loc; name; }
    |> kontinue

(* Import *)

let path loc path kontinue =
  Path { loc; path; }
    |> kontinue
let alias loc alias path kontinue =
  Alias { loc; alias; path; }
    |> kontinue
let alias_named loc local path kontinue = alias loc (Some local) path kontinue
let alias_unnamed loc path kontinue = alias loc None path kontinue
let pkgs loc aliases kontinue =
  Packages { loc; aliases; }
    |> kontinue
let import loc pkgs kontinue =
  Import { loc; pkgs; }
    |> kontinue

(* Top-Level Bindings *)

let top_ty loc local bindings kontinue =
  TopTy { loc; local; bindings; }
    |> kontinue
let top_val loc binding kontinue =
  TopVal { loc; binding; }
    |> kontinue
let top_def loc binding kontinue =
  TopDef { loc; binding; }
    |> kontinue
let top_let loc recur bindings kontinue =
  TopLet { loc; recur; bindings; }
    |> kontinue
let top_mod loc name params elems kontinue =
  TopMod { loc; name; params; elems; }
    |> kontinue

(* Files *)

let file loc pkg imports tops kontinue =
  File { loc; pkg; imports; tops; }
    |> kontinue
