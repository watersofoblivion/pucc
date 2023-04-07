(**
 * {1 Abstract Syntax}
 *
 * A partially typed abstract syntax.  This is the abstract syntax produced by
 * the parser.  It is intentionally very relaxed in what it allows, for a few
 * reasons:  
 *
 * {ul
 *   {li It makes parsing simpler because fewer grammar rules need to be written and the ones that do need to be written can be simpler and more general.}
 *   {li It is simpler to generate high-quality error messages during the desugaring pass than trying to weave error handling through the parser.}
 *   {li We want to be able to format source code without having to resolve names, perform semantic and type checking, etc.}
 *   {li We can still lint semantically invalid programs, so being able to parse them and generate an AST is useful.}}
 *)

(**
 * {2 Location Tracking}
 *
 * Tracks locations within the source tree in terms of workspaces, packages,
 * files, and line, column, and byte offsets.
 *)

(**
 * {3 Workspaces}
 *
 * The workspace the source lives in.
 *)

type ws = private Fpath.t
(** A workspace, represented by the root *)

val ws : Fpath.t -> (ws -> 'a) -> 'a
(**
 * Construct a workspace.
 *
 * @param root The root of the workspace
 * @param kontinue A contination that is passed the created workspace
 * @return The result of the continuation
 *)

(**
 * {3 Packages}
 *)

type pkg = private {
  ws:   ws;      (** The workspace the package is in *)
  path: Fpath.t; (** The package path *)
}
(** A package in a workspace *)

val pkg : ws -> Fpath.t -> (pkg -> 'a) -> 'a
(**
 * Construct a package within a workspace.
 *
 * @param ws The workspace the package is in
 * @param path The package path
 * @param kontinue A continuation that is passed the package
 * @return The result of the continuation
 *)

(**
 * {3 Positions}
 *
 * A position is a particular cursor position within a file, in terms of a
 * line offset into the file (starting at [1],) a column offset within that
 * line (starting at [0],) and a byte offset into the file (starting at [0].)
 *)

type pos = private {
  line: int; (** The line within the file *)
  col:  int; (** The column offset within the line *)
  off:  int; (** The byte offset within the file *)
}
(** A position *)

val pos : int -> int -> int -> (pos -> 'a) -> 'a
(**
 * Construct a position.
 * 
 * @param line The line number within the file.
 * @param col The column offset within the line.
 * @param off The byte offset into the file.
 * @param A contination that is passed the position within a file
 * @return The result of the continuation
 *)

val lexing_position : Lexing.position -> (pos -> 'a) -> 'a
(**
 * Construct a position from a {{!lexing buffer} Lexbuf.position}.
 *
 * @param pos The lexing position
 * @param kontinue A continuation that is passed the position
 * @return The result of the continuation
 *)

exception PositionMismatch of {
  expected: pos;  (** The expected position *)
  actual:   pos;  (** The actual position *)
  line:     bool; (** Whether the positions agree on line number *)
  col:      bool; (** Whether the positions agree on column offset *)
  off:      bool; (** Whether the positions agree on byte offset *)
}
(** Raised when two position are not equal *)

val position_mismatch : pos -> pos -> ?line:bool -> ?col:bool -> ?off:bool -> (exn -> 'a) -> 'a
(**
 * Constructs a PositionMismatch exception.
 *
 * @param expected The expected position
 * @param actual The actual position
 * @param ?line Whether the positions agree on line number.  Defaults to [true].
 * @param ?col Whether the positions agree on column offset.  Defaults to [true].
 * @param ?off Whether the positions agree on byte offset.  Defaults to [true].
 * @param kontinue A contination that is passed the exception
 * @return The result of the continuation
 *)

val require_pos_equal : pos -> pos -> (pos -> 'a) -> 'a
(**
 * Require that two position values are equal.
 *
 * @param expected The expected position
 * @param actual The actual position
 * @param kontinue A continuation that is passed the position.  Specifically,
 *   it is passed the [actual] position.
 * @return The result of the continuation
 * @raise PositionMismatch Raised if the two positions are not equal
 *)

(**
 * {3 Locations}
 *
 * A location is the location of a syntactic element within a source file.  It
 * spans two positions and is always bound to a specific file within a specific
 * package.
 *)

type loc = private {
  start: pos; (** The starting position within the file *)
  stop:  pos; (** The ending position within the file *)
}
(** A location in the source tree *)

val dummy : loc
(** A dummy location guaranteed to be different from all valid locations. *)
 
val loc : pos -> pos -> (loc -> 'a) -> 'a
(**
 * Construct a location.
 *
 * @param start The starting position of the location
 * @param stop The ending position of the location
 * @param kontinue A continuation that is passed the location
 * @return The result of the continuation
 *)

val span : loc -> loc -> (loc -> 'a) -> 'a
(**
 * Constructs a location that spans two locations.  I.e., it starts at the
 * starting position of the first location and stops at the ending position of
 * the second location.
 *
 * @param start The starting location
 * @param stop The ending location
 * @param kontinue A continuation that is passed the location
 * @return The result of the continuation
 *)

exception LocationMismatch of {
  expected: loc;        (** The expected location *)
  actual:   loc;        (** The actual location *)
  start:    exn option; (** Whether the locations differ on start position *)
  stop:     exn option; (** Whether the locations differ on end position *)
}
(** Raised when two locations are not equal *)

val location_mismatch : loc -> loc -> ?start:(exn option) -> ?stop:(exn option) -> (exn -> 'a) -> 'a
(**
 * Construct a LocationMismatch exception.
 *
 * @param expected The expected location
 * @param actual The actual location
 * @param ?start Whether the locations differ on start position.  Defaults to [None].
 * @param ?stop Whether the locations differ on end position.  Defaults to [None].
 * @param kontinue A continuation that is passed the exception
 * @return The result of the continuation
 *)

val require_loc_equal : loc -> loc -> (loc -> 'a) -> 'a
(**
 * Require the two locations are equal.
 *
 * @param expected The expected location
 * @param actual The actual location
 * @param kontinue A continuation that is passed the location.  Specifically,
 *   it is passed the [actual] location.
 * @raise LocationMismatch Raised if the locations are not equal
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the abstract syntax.
 *)

(**
 * {3 Names}
 *)

type name = private
  | Name of {
      loc:    loc;    (** The location of the name *)
      lexeme: string; (** The name *)
    } (** Name *)
  | Dotted of {
      loc: loc;  (** The location of the name *)
      lhs: name; (** The left-hand side *)
      rhs: name; (** The right-hand side *)
    } (** Dotted Name *)
(** Names *)

(**
 * {3 Types}
 *)

type ty_vis = private
  | TyVisReadonly of {
      loc: loc; (** The location of the visibility *)
    } (** Read-Only *)
  | TyVisAbstract of {
      loc: loc; (** The location of the visibility *)
    } (** Abstract *)
(** Type Visibility *)

type ty = private
  | TyBool of {
      loc: loc; (** The location of the constructor *)
    } (** Boolean *)
  | TyInt of {
      loc: loc; (** The location of the constructor *)
    } (** Integer *)
  | TyConstr of {
      loc:  loc;  (** The location of the contructor *)
      name: name; (** The name *)
    } (** Constructor *)
  | TyFun of {
      loc:   loc; (** The location of the function *)
      param: ty;  (** The parameter type *)
      res:   ty;  (** The result type *)
    } (** Function *)
  | TySig of {
      loc:   loc;           (** The location of the signature *)
      elems: sig_elem list; (** The elements *)
    } (** Module Signature *)
  | TyWith of {
      loc:  loc;             (** The location of the with clause *)
      name: name;            (** The module name *)
      tys:  ty_binding list; (** The bound types *)
    } (** Module With *)
(** Types *)

and sig_elem = private
  | SigTy of {
      loc:    loc;            (** The location of the type *)
      name:   name;           (** The type name *)
      params: mod_param list; (** The module parameters *)
      ty:     ty option;      (** the type definition *)
    } (** Type Definition *)
  | SigVal of {
      loc:  loc;  (** The location of the value *)
      name: name; (** The value name *)
      ty:   ty;   (** The value type *)
    } (** Value Binding *)
  | SigDef of {
      loc:  loc;  (** The location of the definition *)
      name: name; (** The function name *)
      ty:   ty;   (** The function type *)
    } (** Function Definitions *)
  | SigMod of {
      loc:    loc;            (** The location of the module *)
      name:   name;           (** The module name *)
      params: mod_param list; (** The module parameters *)
      ty:     ty;             (** The module type *)
    } (** Module *)
(** Signature Elements *)

and ty_binding = private
  | TyBinding of {
      loc:    loc;            (** The location of the type binding *)
      name:   name;           (** The type name *)
      params: mod_param list; (** The module parameters *)
      vis:    ty_vis option;  (** The type visibility *)
      ty:     ty;             (** The type definition *)
    } (** Type Binding *)
(** Type Bindings *)

and mod_param = private
  | ModParam of {
      loc:  loc;       (** The location of the module parameter *)
      name: name;      (** The parameter name *)
      ty:   ty option; (** The parameter type *)
    } (** Module Parameter *)
(** Module Parameters *)

(**
 * {2 Primitive Operations}
 *)

type un =
  | UnNeg of {
      loc: loc; (** The location of the operator *)
    } (** Negation *)
  | UnLNot of {
      loc: loc; (** The location of the operator *)
    } (** Logical NOT *)
  | UnBNot of {
      loc: loc; (** The location of the operator *)
    } (** Bitwise NOT *)
(** Unary Operators *)

type bin =
  | BinAdd of {
      loc: loc; (** The location of the operator *)
    } (** Addition *)
  | BinSub of {
      loc: loc; (** The location of the operator *)
    } (** Subtration *)
  | BinMul of {
      loc: loc; (** The location of the operator *)
    } (** Multiplication *)
  | BinDiv of {
      loc: loc; (** The location of the operator *)
    } (** Division *)
  | BinMod of {
      loc: loc; (** The location of the operator *)
    } (** Modulus *)
  | BinLAnd of {
      loc: loc; (** The location of the operator *)
    } (** Logical AND *)
  | BinLOr of {
      loc: loc; (** The location of the operator *)
    } (** Logical OR *)
  | BinBAnd of {
      loc: loc; (** The location of the operator *)
    } (** Bitwise AND *)
  | BinBOr of {
      loc: loc; (** The location of the operator *)
    } (** Bitwise OR *)
  | BinBXor of {
      loc: loc; (** The location of the operator *)
    } (** Bitwise XOR *)
  | BinSsl of {
      loc: loc; (** The location of the operator *)
    } (** Signed Shift Left *)
  | BinSsr of {
      loc: loc; (** The location of the operator *)
    } (** Signed Shift Right *)
  | BinUsl of {
      loc: loc; (** The location of the operator *)
    } (** Unsigned Shift Left *)
  | BinUsr of {
      loc: loc; (** The location of the operator *)
    } (** Unsigned Shift Right *)
  | BinSeq of {
      loc: loc; (** The location of the operator *)
    } (** Structural Equality *)
  | BinPeq of {
      loc: loc; (** The location of the operator *)
    } (** Physical Equality *)
  | BinSneq of {
      loc: loc; (** The location of the operator *)
    } (** Structural Inequality *)
  | BinPneq of {
      loc: loc; (** The location of the operator *)
    } (** Physical Inequality *)
  | BinLte of {
      loc: loc; (** The location of the operator *)
    } (** Less Then or Equal *)
  | BinLt of {
      loc: loc; (** The location of the operator *)
    } (** Less Then *)
  | BinGte of {
      loc: loc; (** The location of the operator *)
    } (** Greater Then or Equal *)
  | BinGt of {
      loc: loc; (** The location of the operator *)
    } (** Greater Then *)
  | BinRfa of {
      loc: loc; (** The location of the operator *)
    } (** Reverse Function Application *)
(** Binary Operators *)

(**
 * {3 Patterns}
 *)

type patt =
  | PattGround of {
      loc: loc; (** The location of the pattern *)
    } (** Ground *)
  | PattBool of {
      loc:   loc;  (** The location of the pattern *)
      value: bool; (** The boolean value *)
    } (** Boolean Literal *)
  | PattInt of {
      loc:    loc;    (** The location of the pattern *)
      lexeme: string; (** The integer lexeme *)
    } (** Integer Literal *)
  | PattVar of {
      loc:    loc;    (** The location of the pattern *)
      lexeme: string; (** The variable lexeme *)
    } (** Variable *)
  | PattFun of {
      loc:    loc;        (** The location of the pattern *)
      name:   name;       (** The function name *)
      params: param list; (** The function parameters *)
    } (** Function *)
(** Patterns *)

and param =
  | Param of {
      loc:  loc;       (** The location of the parameter *)
      patt: patt;      (** The pattern the parameter matches *)
      ty:   ty option; (** The parameter type *)
    } (** Parameter *)
(** Function Parameters *)

(**
 * {3 Expressions}
 *)

type expr =
  | ExprBool of {
      loc:   loc;  (** The location of the expression *)
      value: bool; (** The boolean value *)
    } (** Boolean Literal *)
  | ExprInt of {
      loc:    loc;    (** The location of the expression *)
      lexeme: string; (** The integer lexeme *)
    } (** Integer Literal *)
  | ExprId of {
      loc:  loc;  (** The location of the expression *)
      name: name; (** The referenced name *)
    } (** Identifier Literal *)
  | ExprUn of {
      loc:     loc;  (** The location of the expression *)
      op:      un;   (** The operator *)
      operand: expr; (** The operand *)
    } (** Unary Operation *)
  | ExprBin of {
      loc: loc;  (** The location of the expression *)
      op:  bin;  (** The operator *)
      lhs: expr; (** The left-hand operand *)
      rhs: expr; (** The right-hand operand *)
    } (** Binary Operation *)
  | ExprCond of {
      loc:  loc;  (** The location of the expression *)
      cond: expr; (** The condition *)
      tru:  expr; (** The true case *)
      fls:  expr; (** The false case *)
    } (** Condition *)
  | ExprLet of {
      loc:      loc;          (** The location of the expression *)
      recur:    bool;         (** Whether the binding is marked recursive *)
      bindings: binding list; (** The bindings *)
      scope:    expr;         (** The scope of the bindings *)
    } (** Value Binding *)
  | ExprAbs of {
      loc:    loc;        (** The location of the expression *)
      params: param list; (** The function parameters *)
      ret:    ty option;  (** The return type *)
      body:   expr;       (** The function body *)
    } (** Function Abstraction *)
  | ExprApp of {
      loc:  loc;       (** The location of the expression *)
      fn:   expr;      (** The function *)
      args: expr list; (** The arguments *)
    } (** Function Application *)
(** Expressions *)

and binding =
  | Binding of {
      loc:   loc;       (** The location of the binding *)
      patt:  patt;      (** The pattern bound *)
      ty:    ty option; (** The tyoe of the bound value *)
      value: expr;      (** The bound value *)
    } (** Value Binding *)
(** Value Bindings *)

(**
 * {3 Package Statements}
 *)

type pkg_stmt = private
  | PkgLibrary of {
      loc:  loc;  (** The location of the package statement *)
      name: name; (** The name of the library *)
    } (** A library *)
  | PkgExecutable of {
      loc:  loc;  (** The location of the package statement *)
      name: name; (** The name of the executable *)
    } (** An executable *)
(** Package Statements *)

(**
 * {3 Imports}
 *)

type path = private
  | Path of {
      loc:  loc;    (** The location of the package path *)
      path: string; (** The package path *)
    } (** A package path *)
(** Package Paths *)

type alias = private
  | Alias of {
      loc:   loc;         (** The location of the alias *)
      alias: name option; (** The local alias *)
      path:  path;        (** The package path *)
  }
(** Aliased Imports *)

type pkgs = private
  | Packages of {
      loc:     loc;        (** The location of the package list *)
      aliases: alias list; (** The aliased imports *)
    } (** A package alias list *)
(** Package Alias Lists *)

type import = private
  | Import of {
      loc:  loc;  (** The location of the import statement *)
      pkgs: pkgs; (** The import list *)
    }
(** Import Statements *)

(**
 * {3 Top-Level Bindings}
 *)

type top =
  | TopTy of {
      loc:      loc;             (** The location of the binding *)
      local:    bool;            (** Whether the binding is local *)
      bindings: ty_binding list; (** The type bindings *)
    } (** Type Binding *)
  | TopVal of {
      loc:     loc;     (** The location of the binding *)
      binding: binding; (** The value binding *)
    } (** Value Binding *)
  | TopDef of {
      loc:     loc;     (** The location of the binding *)
      binding: binding; (** The function definition *)
    } (** Function Definition *)
  | TopLet of {
      loc:      loc;          (** The location of the binding *)
      recur:    bool;         (** Whether the bindings are recursive *)
      bindings: binding list; (** The value bindings *)
    } (** Local Binding *)
  | TopMod of {
      loc:    loc;            (** The location of the module *)
      name:   name;           (** The module name *)
      params: mod_param list; (** The module parameters *)
      elems:  top list;       (** The structure elements *)
    } (** Module Binding *)
(** Top-Level Bindings *)

(**
 * {3 Files}
 *)

type file = private
  | File of {
      loc:     loc;         (** The location of the file *)
      pkg:     pkg;         (** The package statement *)
      imports: import list; (** The import statements *)
      tops:    top list;    (** The top-level bindings *)
    }
(** Source Files *)

(**
 * {2 Constructors}
 *
 * Construct values of the abstract syntax.
 *)

(**
 * {3 Names}
 *)

val name : loc -> string -> (name -> 'a) -> 'a
(**
 * Construct a name.
 *
 * @param loc The location of the name
 * @param name The identifier
 * @return A name
 *)


val dotted : loc -> name -> name -> (name -> 'a) -> 'a
(**
 * Construct a dotted name.
 *
 * @param loc The location of the name
 * @param lhs The left-hand name
 * @param rhs The right-hand name
 * @return A dotted name
 *)

(**
 * {3 Types}
 *)

(**
 * {4 Visibilities}
 *)

val ty_vis_readonly : loc -> (ty_vis -> 'a) -> 'a
(**
 * Construct a read-only visibility.
 *
 * @param loc The location of the visibility
 * @return A type visibility
 *)

val ty_vis_abstract : loc -> (ty_vis -> 'a) -> 'a
(**
 * Construct an abstract visibility
 *
 * @param loc The location of the visibility
 * @return A type visibility
 *)

(**
 * {4 Types}
 *)

val ty_bool : loc -> (ty -> 'a) -> 'a
(**
 * Construct a boolean type constructor
 *
 * @param loc The location of the type
 * @return A boolean constructor
 *)

val ty_int : loc -> (ty -> 'a) -> 'a
(**
 * Construct an integer type constructor
 *
 * @param loc The location of the type
 * @return An integer constructor
 *)

val ty_constr : loc -> name -> (ty -> 'a) -> 'a
(**
 * Construct a type constructor
 * 
 * @param loc The location of the type
 * @param name The constructor name
 * @return A type constructor
 *)

val ty_fun : loc -> ty -> ty -> (ty -> 'a) -> 'a
(**
 * Construct a function type
 * 
 * @param loc The location of the type
 * @param param The parameter type
 * @param ret The return type
 * @return A function type
 *)

val ty_sig : loc -> sig_elem list -> (ty -> 'a) -> 'a
(**
 * Construct a module signature
 *
 * @param loc The location of the signature
 * @param elems The signature elements
 * @return A module signature
 *)

val ty_with : loc -> name -> ty_binding list -> (ty -> 'a) -> 'a
(**
 * Construct a module signature with types bound
 *
 * @param loc The location of the signature
 * @param name The signature name
 * @param tys The bound types
 * @return A module signature with types bound
 *)

(**
 * {4 Signature Elements}
 *)

val sig_ty : loc -> name -> mod_param list -> ty option -> (sig_elem -> 'a) -> 'a
(**
 * Construct a type binding signature element
 *
 * @param loc The location of the element
 * @param name The type name
 * @param params The module parameters
 * @param ty The type definition
 * @return A type binding signature element
 *)

val sig_val : loc -> name -> ty -> (sig_elem -> 'a) -> 'a
(**
 * Construct a value binding signature element
 *
 * @param loc The location of the element
 * @param name The bound name
 * @param ty The bound value type
 * @return A value binding signature element
 *)

val sig_def : loc -> name -> ty -> (sig_elem -> 'a) -> 'a
(**
 * Construct a function definition signature element
 * 
 * @param loc The location of the element
 * @param name The function name
 * @param ty The function type
 * @return A function definition signature element
 *)

val sig_mod : loc -> name -> mod_param list -> ty -> (sig_elem -> 'a) -> 'a
(**
 * Construct a module definition signature element
 * 
 * @param loc The location of the element
 * @param name The module name
 * @param params The module parameters
 * @param ty The module type
 * @return A module definition signature element
 *)
 
(**
 * {4 Type Bindings}
 *)

val ty_binding : loc -> name -> mod_param list -> ty_vis option -> ty -> (ty_binding -> 'a) -> 'a
(**
 * Construct a type binding
 *
 * @param loc The location of the binding
 * @param name The type name
 * @param params The module parameters
 * @param vis The type visibility
 * @param ty The type definition
 * @return A type binding
 *)

(**
 * {4 Module Parameters}
 *)

val mod_param : loc -> name -> ty option -> (mod_param -> 'a) -> 'a
(**
 * Construct a module parameter
 *
 * @param loc The location of the module parameter
 * @param name The parameter name
 * @param ty The parameter type
 * @return A module parameter
 *)

(**
 * {3 Primitive Operations}
 *)

(**
 * {4 Unary Operators}
 *)

val un_neg : loc -> (un -> 'a) -> 'a
(**
 * Construct a negation operator
 * 
 * @param loc The location of the operator
 * @return A negation operator
 *)

val un_lnot : loc -> (un -> 'a) -> 'a
(**
 * Construct a logical NOT operator
 * 
 * @param loc The location of the operator
 * @return A logical NOT operator
 *)

val un_bnot : loc -> (un -> 'a) -> 'a
(**
 * Construct a bitwise NOT operator
 * 
 * @param loc The location of the operator
 * @return A bitwise NOT operator
 *)

(**
 * {4 Binary Operators}
 *)

val bin_add : loc -> (bin -> 'a) -> 'a
(**
 * Construct an addition operator
 *
 * @param loc The location of the operator
 * @return An addition operator
 *)

val bin_sub : loc -> (bin -> 'a) -> 'a
(**
 * Construct a subtration operator
 *
 * @param loc The location of the operator
 * @return A subtration operator
 *)

val bin_mul : loc -> (bin -> 'a) -> 'a
(**
 * Construct a multiplication operator
 *
 * @param loc The location of the operator
 * @return A multiplication operator
 *)

val bin_div : loc -> (bin -> 'a) -> 'a
(**
 * Construct a division operator
 *
 * @param loc The location of the operator
 * @return A division operator
 *)

val bin_mod : loc -> (bin -> 'a) -> 'a
(**
 * Construct a modulus operator
 *
 * @param loc The location of the operator
 * @return A modulus operator
 *)

val bin_land : loc -> (bin -> 'a) -> 'a
(**
 * Construct a logical AND operator
 *
 * @param loc The location of the operator
 * @return A logical AND operator
 *)

val bin_lor : loc -> (bin -> 'a) -> 'a
(**
 * Construct a logical OR operator
 *
 * @param loc The location of the operator
 * @return A logical OR operator
 *)

val bin_band : loc -> (bin -> 'a) -> 'a
(**
 * Construct a bitwise AND operator
 *
 * @param loc The location of the operator
 * @return A bitwise AND operator
 *)

val bin_bor : loc -> (bin -> 'a) -> 'a
(**
 * Construct a bitwise OR operator
 *
 * @param loc The location of the operator
 * @return A bitwise OR operator
 *)

val bin_bxor : loc -> (bin -> 'a) -> 'a
(**
 * Construct a bitwise XOR operator
 *
 * @param loc The location of the operator
 * @return A bitwise XOR operator
 *)

val bin_ssl : loc -> (bin -> 'a) -> 'a
(**
 * Construct a signed shift left operator
 *
 * @param loc The location of the operator
 * @return A signed shift left operator
 *)

val bin_ssr : loc -> (bin -> 'a) -> 'a
(**
 * Construct a signed shift right operator
 *
 * @param loc The location of the operator
 * @return A signed shift right operator
 *)

val bin_usl : loc -> (bin -> 'a) -> 'a
(**
 * Construct an unsigned shift left operator
 *
 * @param loc The location of the operator
 * @return An unsigned shift left operator
 *)

val bin_usr : loc -> (bin -> 'a) -> 'a
(**
 * Construct an unsigned shift right operator
 *
 * @param loc The location of the operator
 * @return An unsigned shift right operator
 *)

val bin_seq : loc -> (bin -> 'a) -> 'a
(**
 * Construct a structural equality operator
 *
 * @param loc The location of the operator
 * @return A structural equality operator
 *)

val bin_peq : loc -> (bin -> 'a) -> 'a
(**
 * Construct a physical equality operator
 *
 * @param loc The location of the operator
 * @return A physical equality operator
 *)

val bin_sneq : loc -> (bin -> 'a) -> 'a
(**
 * Construct a structural inequality operator
 *
 * @param loc The location of the operator
 * @return A structural inequality operator
 *)

val bin_pneq : loc -> (bin -> 'a) -> 'a
(**
 * Construct a physical inequality operator
 *
 * @param loc The location of the operator
 * @return A physical inequality operator
 *)

val bin_lte : loc -> (bin -> 'a) -> 'a
(**
 * Construct a less than or equal operator
 *
 * @param loc The location of the operator
 * @return A less than or equal operator
 *)

val bin_lt : loc -> (bin -> 'a) -> 'a
(**
 * Construct a less than operator
 *
 * @param loc The location of the operator
 * @return A less than operator
 *)

val bin_gte : loc -> (bin -> 'a) -> 'a
(**
 * Construct a greater than or equal operator
 *
 * @param loc The location of the operator
 * @return A greater than or equal operator
 *)

val bin_gt : loc -> (bin -> 'a) -> 'a
(**
 * Construct a greater than operator
 *
 * @param loc The location of the operator
 * @return A greater than operator
 *)

val bin_rfa : loc -> (bin -> 'a) -> 'a
(**
 * Construct a reverse function application operator
 *
 * @param loc The location of the operator
 * @return A reverse function application operator
 *)

(** 
 * {3 Patterns}
 *)

val patt_ground : loc -> (patt -> 'a) -> 'a
(**
 * Construct a ground pattern
 *
 * @param loc The location of the pattern
 * @return A ground pattern
 *)

val patt_bool : loc -> bool -> (patt -> 'a) -> 'a
(**
 * Construct a boolean literal pattern
 *
 * @param loc The location of the pattern
 * @param value The literal value
 * @return A boolean literal pattern
 *)

val patt_int : loc -> string -> (patt -> 'a) -> 'a
(**
 * Construct an integer literal pattern
 *
 * @param loc The location of the pattern
 * @param lexeme The literal lexeme
 * @return An integer literal pattern
 *)

val patt_var : loc -> string -> (patt -> 'a) -> 'a
(**
 * Construct a variable pattern
 *
 * @param loc The location of the pattern
 * @param lexeme The variable lexeme
 * @return A variable pattern
 *)

val patt_fun : loc -> name -> param list -> (patt -> 'a) -> 'a
(**
 * Construct a function pattern
 * 
 * @param loc The location of the pattern
 * @param name The function name
 * @param params The function parameters
 * @return A function pattern
 *)
 
(**
 * {3 Parameters}
 *)

val param : loc -> patt -> ty option -> (param -> 'a) -> 'a
(**
 * Construct a function parameter
 * 
 * @param loc The location of the parameter
 * @param patt The pattern the parameter matches
 * @param ty The type of the pattern
 * @return A function parameter
 *)

(**
 * {3 Expressions}
 *)

val expr_bool : loc -> bool -> (expr -> 'a) -> 'a
(**
 * Construct a boolean literal expression
 *
 * @param loc The location of the expression
 * @param value The literal value
 * @return A boolean literal expression
 *)

val expr_int : loc -> string -> (expr -> 'a) -> 'a
(**
 * Construct an integer literal expression
 *
 * @param loc The location of the expression
 * @param lexeme The integer lexeme
 * @return An integer literal expression
 *)

val expr_id : loc -> name -> (expr -> 'a) -> 'a
(**
 * Construct an identifier literal expression
 *
 * @param loc The location of the expression
 * @param name The identifier
 * @return An identifier literal expression
 *)

val expr_un : loc -> un -> expr -> (expr -> 'a) -> 'a
(**
 * Construct a unary operation expression
 *
 * @param loc The location of the expression
 * @param op The operator
 * @param operand The operand
 * @return The unary operation expression
 *)

val expr_bin : loc -> bin -> expr -> expr -> (expr -> 'a) -> 'a
(**
 * Construct a binary operation expression
 *
 * @param loc The location of the expression
 * @param op The operator
 * @param lhs The left-hand operand
 * @param rhs The right-hand operand
 * @return A binary operation expression
 *)

val expr_cond : loc -> expr -> expr -> expr -> (expr -> 'a) -> 'a
(**
 * Construct a condition expression
 *
 * @param loc The location of the expression
 * @param cond The condition
 * @param tru The true case
 * @param fls The false case
 * @return A condition expression
 *)

val expr_let : loc -> bool -> binding list -> expr -> (expr -> 'a) -> 'a
(**
 * Construct a value binding expression
 *
 * @param loc The location of the expression
 * @param recur Whether the binding is marked recursive
 * @param bindings The value bindings
 * @param scope The scope of the bindings
 * @return A value binding expression
 *)

val expr_abs : loc -> param list -> ty option -> expr -> (expr -> 'a) -> 'a
(**
 * Construct a function abstraction
 *
 * @param loc The location of the expression
 * @param params The function parameters
 * @param ret The return type
 * @param body The function body
 * @return A function abstraction expression
 *)

val expr_app : loc -> expr -> expr list -> (expr -> 'a) -> 'a
(**
 * Construct a function application
 *
 * @param loc The location of the expression
 * @param fn The function applied
 * @param args The function arguments
 * @return A function application expression
 *)

(**
 * {3 Bindings}
 *)

val binding : loc -> patt -> ty option -> expr -> binding
(**
 * Construct a value binding
 *
 * @param loc The location of the binding
 * @param patt The pattern the binding matches
 * @param ty The type of the binding
 * @param value The bound value
 * @return A value binding
 *)

(**
 * {3 Package Statements}
 *)

val pkg_library : loc -> name -> pkg_stmt
(**
 * Construct a library package.
 *
 * @param loc The location of the package statement
 * @param id The name of the library
 * @return A library package
 *)

val pkg_executable : loc -> name -> pkg_stmt
(**
 * Construct an executable package.
 *
 * @param loc The location of the package statement
 * @param id The name of the library
 * @return An executable package
 *)

(**
 * {3 Imports}
 *)

val path : loc -> string -> path
(**
 * Construct a package path.
 * 
 * @param loc The location of the package path
 * @param path The path of the package
 * @return A package path
 *)

val alias : loc -> name option -> path -> alias
(**
 * Construct a package alias clause with an optional local name.
 *
 * @param loc The location of the alias clause
 * @param name The optional local name of the package
 * @param path The package path
 * @return An alias clause
 *)

val alias_named : loc -> name -> path -> alias
(**
 * Construct a locally named alias clause.  This is an alias for
 * [alias loc (Some name) path].
 * 
 * @param loc The location of the alias clause
 * @param local The local name of the package
 * @param path The package path
 * @return An alias clause
 *)

val alias_unnamed : loc -> path -> alias
(**
 * Construct an alias clause using the default package name.  This is an alias
 * for [alias loc None path].
 * 
 * @param loc The location of the alias clause
 * @param path The package path
 * @return An alias clause
 *)

val pkgs : loc -> alias list -> pkgs
(**
 * Construct a package alias list.
 *
 * @param loc The location of the alias clause
 * @param aliases The package aliases
 * @return A package alias list 
 *)

val import : loc -> pkgs -> import
(**
 * Construct an import statement.
 *
 * @param loc The location of the import statement
 * @param pkgs The package alias list
 * @return An import statement
 *)

(**
 * {3 Top-Level Bindings}
 *)

val top_ty : loc -> bool -> ty_binding list -> top
(**
 * Construct a top-level type binding
 *
 * @param loc The location of the binding
 * @param local Whether the bindings are local
 * @param bindings The type bindings
 * @return A top-level type binding
 *)

val top_val : loc -> binding -> top
(**
 * Construct a top-level value binding
 *
 * @param loc The location of the binding
 * @param binding The value binding
 * @return A top-level value binding
 *)

val top_def : loc -> binding -> top
(**
 * Construct a top-level function definition
 *
 * @param loc The location of the definition
 * @param binding The function definition
 * @return A top-level function definition
 *)

val top_let : loc -> bool -> binding list -> top
(**
 * Construct a top-level local binding
 *
 * @param loc The location of the binding
 * @param recur Whether the bindings are marked recursive
 * @param bindings The local bindings
 * @return A top-level local binding
 *)

val top_mod : loc -> name -> mod_param list -> top list -> top
(**
 * Construct a top-level module definition
 *
 * @param loc The location of the definition
 * @param name The module name
 * @param params The module parameters
 * @param elems The structure elements
 * @return A top-level module definition
 *)

(**
 * {3 Files}
 *)

val file : loc -> pkg -> import list -> top list -> file
(**
 * Constructs a source file.
 * 
 * @param loc The location of the file
 * @param pkg The package statement
 * @param imports The import statements
 * @param tops The top-level bindings
 * @return A source file
 *)