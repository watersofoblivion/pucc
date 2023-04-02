(* Abstract Syntax *)

(*
 * TODO:
 *
 * - Comments (doc and non-doc)
 * - Formatting
 * - Integer radix (0x, 0b, 0o, etc.)
 * - Make lists (param lists, etc.) dedicated data types with their own locations
 * - Support elided types in parameter lists ([x, y: Int] instead of [x: Int, y: Int])
 * - Monad types and do syntax
 * - Pattern matching
 * - Records, Structs, and Variants
 * - Type parameters (polymorphism)
 * - Function overloading
 * - Operator overloading
 *)

(* Data Types *)

(* Names *)

type name =
  | Name   of { loc: Core.loc; lexeme: string; }
  | Dotted of { loc: Core.loc; lhs: name; rhs: name; }

(* Types *)

type ty_vis =
  | TyReadonly of { loc: Core.loc }
  | TyAbstract of { loc: Core.loc }

type ty =
  | TyConstr of { loc: Core.loc; name: name; }
  | TyFun    of { loc: Core.loc; param: ty; res: ty; }
  | TySig    of { loc: Core.loc; elems: sig_elem list; }
  | TyWith   of { loc: Core.loc; name: name; tys: ty_binding list; }
and sig_elem =
  | SigTy  of { loc: Core.loc; name: name; params: mod_param list; ty: ty; }
  | SigVal of { loc: Core.loc; name: name; ty: ty; }
  | SigDef of { loc: Core.loc; name: name; ty: ty; }
  | SigMod of { loc: Core.loc; name: name; params: mod_params list; ty: ty; }
and ty_binding =
  | TyBinding of { loc: Core.loc; name: name; vis: ty_vis option; ty: ty; }
and mod_param =
  | ModParam of { loc: Core.loc; name: name; ty: ty; }

(* Primitive Operations *)

type un =
  | UnNeg  of { loc: Core.loc }
  | UnLNot of { loc: Core.loc }
  | UnBNot of { loc: Core.loc }

type bin =
  | BinAdd  of { loc: Core.loc }
  | BinSub  of { loc: Core.loc }
  | BinMul  of { loc: Core.loc }
  | BinDiv  of { loc: Core.loc }
  | BinMod  of { loc: Core.loc }
  | BinLAnd of { loc: Core.loc }
  | BinLOr  of { loc: Core.loc }
  | BinBAnd of { loc: Core.loc }
  | BinBOr  of { loc: Core.loc }
  | BinBXor of { loc: Core.loc }
  | BinSsl  of { loc: Core.loc }
  | BinSsr  of { loc: Core.loc }
  | BinUsl  of { loc: Core.loc }
  | BinUsr  of { loc: Core.loc }
  | BinSeq  of { loc: Core.loc }
  | BinPeq  of { loc: Core.loc }
  | BinSneq of { loc: Core.loc }
  | BinPneq of { loc: Core.loc }
  | BinLte  of { loc: Core.loc }
  | BinLt   of { loc: Core.loc }
  | BinGte  of { loc: Core.loc }
  | BinGt   of { loc: Core.loc }
  | BinRfa  of { loc: Core.loc }

(* Patterns *)

type patt =
  | PattGround of { loc: Core.loc; }
  | PattBool   of { loc: Core.loc; value: bool; }
  | PattInt    of { loc: Core.loc; lexeme: string; }
  | PattVar    of { loc: Core.loc; lexeme: string; }
  | PattFun    of { loc: Core.loc; id: name; params: param list; }
and param =
  | Param of { loc: Core.loc; patt: patt; ty: ty; }

(* Expressions *)

type expr =
  | ExprBool of { loc: Core.loc; value: bool; }
  | ExprInt  of { loc: Core.loc; lexeme: string; }
  | ExprId   of { loc: Core.loc; name: name; }
  | ExprUn   of { loc: Core.loc; op: un; operand: expr; }
  | ExprBin  of { loc: Core.loc; op: bin; lhs: expr; rhs: expr; }
  | ExprCond of { loc: Core.loc; cond: expr; tru: expr; fls: expr; }
  | ExprLet  of { loc: Core.loc; recur: bool; bindings: binding list; scope: expr; }
  | ExprAbs  of { loc: Core.loc; params: param list; ret: ty option; body: expr; }
  | ExprApp  of { loc: Core.loc; fn: expr; args: expr list; }
  | ExprMod  of { loc: Core.loc; elems: struct_elem list; }

(* Structure Elements *)

and struct_elem =
  | StructTy  of { loc: Core.loc; local: bool; bindings: ty_binding list; }
  | StructVal of { loc: Core.loc; binding: binding; }
  | StructDef of { loc: Core.loc; binding: binding; }
  | StructLet of { loc: Core.loc; bindings: binding list; }
  | StructMod of { loc: Core.loc; name: name; params: mod_param list; elems: struct_elem list; }

(* Bindings *)

and binding =
  | Binding of { loc: Core.loc; patt: patt; ty: ty option; value: expr; }

(* Package Statement *)

type pkg = 
  | Library    of { loc: Core.loc; id: name; }
  | Executable of { loc: Core.loc; id: name; }

(* Imports *)

type path =
  | Path of { loc: Core.loc; path: string; }

type alias =
  | Alias of { loc: Core.loc; alias: name option; path: path }

type pkgs =
  | Packages of { loc: Core.loc; aliases: alias list; }

type import =
  | Import of { loc: Core.loc; pkgs: pkgs }

(* Files *)

type file =
  | File of { pkg: pkg; imports: import list; tops: struct_elem list; }

(* Constructors *)

let name loc id = Name { loc; id }

let pkg_library loc id = Library { loc; id }
let pkg_executable loc id = Executable { loc; id }

let path loc path = Path { loc; path }
let alias loc alias path = Alias { loc; alias; path }
let alias_named loc local path = alias loc (Some local) path
let alias_unnamed loc path = alias loc None path
let pkgs loc aliases = Packages { loc; aliases }
let import loc pkgs = Import { loc; pkgs }

let file pkg imports = File { pkg; imports }
