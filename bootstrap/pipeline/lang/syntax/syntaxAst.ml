(* Abstract Syntax *)

(* Data Types *)

type name =
  | Name of { loc: Core.loc; id: Core.sym; }

(* Types *)

type ty =
  | TyConstr of { loc: Core.loc; id: Core.sym; }
  | TyFun of { loc: Core.loc; param: ty; res: ty; }

(* Primitive Operations *)

type un =
  | UnNeg of { loc: Core.loc }
  | UnLNot of { loc: Core.loc }
  | UnBNot of { loc: Core.loc }

type bin =
  | BinAdd of { loc: Core.loc }
  | BinSub of { loc: Core.loc }
  | BinMul of { loc: Core.loc }
  | BinDiv of { loc: Core.loc }
  | BinMod of { loc: Core.loc }
  | BinLAnd of { loc: Core.loc }
  | BinLOr of { loc: Core.loc }
  | BinBAnd of { loc: Core.loc }
  | BinBOr of { loc: Core.loc }
  | BinBXor of { loc: Core.loc }
  | BinSsl of { loc: Core.loc }
  | BinSsr of { loc: Core.loc }
  | BinUsl of { loc: Core.loc }
  | BinUsr of { loc: Core.loc }
  | BinSeq of { loc: Core.loc }
  | BinPeq of { loc: Core.loc }
  | BinSneq of { loc: Core.loc }
  | BinPneq of { loc: Core.loc }
  | BinLte of { loc: Core.loc }
  | BinLt of { loc: Core.loc }
  | BinGte of { loc: Core.loc }
  | BinGt of { loc: Core.loc }
  | BinRfa of { loc: Core.loc }

(* Function Parameters *)

type param =
  | Param of { loc: Core.loc; id: name; ty: ty; }

(* Patterns *)

type patt =
  | PattGround of { loc: Core.loc; }
  | PattVar of { loc: Core.loc; id: Core.sym; }
  | PattFun of { loc: Core.loc; id: name; params: param list; }

(* Expressions *)

type expr =
  | ExprBool of { loc: Core.loc; value: bool; }
  | ExprInt of { loc: Core.loc; lexeme: string; }
  | ExprId of { loc: Core.loc; lexeme: Core.sym; }
  | ExprUn of { loc: Core.loc; op: un; operand: expr; }
  | ExprBin of { loc: Core.loc; op: bin; lhs: expr; rhs: expr; }
  | ExprCond of { loc: Core.loc; cond: expr; tru: expr; fls: expr; }
  | ExprLet of { loc: Core.loc; recur: bool; bindings: binding list; scope: expr; }
  | ExprAbs of { loc: Core.loc; params: param list; ret: ty option; body: expr; }
  | ExprApp of { loc: Core.loc; fn: expr; args: expr list; }

(* Bindings *)

and binding =
  | Binding of { loc: Core.loc; patt: patt; ty: ty option; value: expr; }

(* Package Statement *)

type pkg = 
  | Library of { loc: Core.loc; id: name; }
  | Executable of { loc: Core.loc; id: name; }

(* Top-Level Bindings *)

type topvalty =
  | Val
  | Def
  | Let of { loc: Core.loc; recur: bool; }

type top =
  | TopTy of { loc: Core.loc; local: bool; id: name; ty: ty; }
  | TopVal of { loc: Core.loc; ty: topvalty; bindings: binding list; }

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
  | File of { pkg: pkg; imports: import list; }

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
