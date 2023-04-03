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
 * {2 Data Types}
 * 
 * The data types to represent the abstract syntax.
 *)

(**
 * {3 Names}
 *)

type name = private
  | Name of {
      loc:    Core.loc; (** The location of the name *)
      lexeme: string;   (** The name *)
    } (** Name *)
  | Dotted of {
      loc: Core.loc; (** The location of the name *)
      lhs: name;     (** The left-hand side *)
      rhs: name;     (** The right-hand side *)
    } (** Dotted Name *)
(** Names *)

(**
 * {3 Types}
 *)

type ty_vis = private
  | TyReadonly of {
      loc: Core.loc; (** The location of the visibility *)
    } (** Read-Only *)
  | TyAbstract of {
      loc: Core.loc; (** The location of the visibility *)
    } (** Abstract *)
(** Type Visibility *)

type ty = private
  | TyConstr of {
      loc:  Core.loc; (** The location of the contructor *)
      name: name;     (** The name *)
    } (** Constructor *)
  | TyFun of {
      loc:   Core.loc; (** The location of the function *)
      param: ty;       (** The parameter type *)
      res:   ty;       (** The result type *)
    } (** Function *)
  | TySig of {
      loc:   Core.loc;      (** The location of the signature *)
      elems: sig_elem list; (** The elements *)
    } (** Module Signature *)
  | TyWith of {
      loc:  Core.loc;        (** The location of the with clause *)
      name: name;            (** The module name *)
      tys:  ty_binding list; (** The bound types *)
    } (** Module With *)
(** Types *)

and sig_elem = private
  | SigTy of {
      loc:    Core.loc;       (** The location of the type *)
      name:   name;           (** The type name *)
      params: mod_param list; (** The module parameters *)
      ty:     ty option;      (** the type definition *)
    } (** Type Definition *)
  | SigVal of {
      loc:  Core.loc; (** The location of the value *)
      name: name;     (** The value name *)
      ty:   ty;       (** The value type *)
    } (** Value Binding *)
  | SigDef of {
      loc:  Core.loc; (** The location of the definition *)
      name: name;     (** The function name *)
      ty:   ty;       (** The function type *)
    } (** Function Definitions *)
  | SigMod of {
      loc:    Core.loc;       (** The location of the module *)
      name:   name;           (** The module name *)
      params: mod_param list; (** The module parameters *)
      ty:     ty;             (** The module type *)
    } (** Module *)
(** Signature Elements *)

and ty_binding = private
  | TyBinding of {
      loc:    Core.loc;       (** The location of the type binding *)
      name:   name;           (** The type name *)
      params: mod_param list; (** The module parameters *)
      vis:    ty_vis option;  (** The type visibility *)
      ty:     ty;             (** The type definition *)
    } (** Type Binding *)
(** Type Bindings *)

and mod_param = private
  | ModParam of {
      loc:  Core.loc;  (** The location of the module parameter *)
      name: name;      (** The parameter name *)
      ty:   ty option; (** The parameter type *)
    } (** Module Parameter *)
(** Module Parameters *)

(**
 * {2 Primitive Operations}
 *)

type un =
  | UnNeg of {
      loc: Core.loc; (** The location of the operator *)
    } (** Negation *)
  | UnLNot of {
      loc: Core.loc; (** The location of the operator *)
    } (** Logical NOT *)
  | UnBNot of {
      loc: Core.loc; (** The location of the operator *)
    } (** Bitwise NOT *)
(** Unary Operators *)

type bin =
  | BinAdd of {
      loc: Core.loc; (** The location of the operator *)
    } (** Addition *)
  | BinSub of {
      loc: Core.loc; (** The location of the operator *)
    } (** Subtration *)
  | BinMul of {
      loc: Core.loc; (** The location of the operator *)
    } (** Multiplication *)
  | BinDiv of {
      loc: Core.loc; (** The location of the operator *)
    } (** Division *)
  | BinMod of {
      loc: Core.loc; (** The location of the operator *)
    } (** Modulus *)
  | BinLAnd of {
      loc: Core.loc; (** The location of the operator *)
    } (** Logical AND *)
  | BinLOr of {
      loc: Core.loc; (** The location of the operator *)
    } (** Logical OR *)
  | BinBAnd of {
      loc: Core.loc; (** The location of the operator *)
    } (** Bitwise AND *)
  | BinBOr of {
      loc: Core.loc; (** The location of the operator *)
    } (** Bitwise OR *)
  | BinBXor of {
      loc: Core.loc; (** The location of the operator *)
    } (** Bitwise XOR *)
  | BinSsl of {
      loc: Core.loc; (** The location of the operator *)
    } (** Signed Shift Left *)
  | BinSsr of {
      loc: Core.loc; (** The location of the operator *)
    } (** Signed Shift Right *)
  | BinUsl of {
      loc: Core.loc; (** The location of the operator *)
    } (** Unsigned Shift Left *)
  | BinUsr of {
      loc: Core.loc; (** The location of the operator *)
    } (** Unsigned Shift Right *)
  | BinSeq of {
      loc: Core.loc; (** The location of the operator *)
    } (** Structural Equality *)
  | BinPeq of {
      loc: Core.loc; (** The location of the operator *)
    } (** Physical Equality *)
  | BinSneq of {
      loc: Core.loc; (** The location of the operator *)
    } (** Structural Inequality *)
  | BinPneq of {
      loc: Core.loc; (** The location of the operator *)
    } (** Physical Inequality *)
  | BinLte of {
      loc: Core.loc; (** The location of the operator *)
    } (** Less Then or Equal *)
  | BinLt of {
      loc: Core.loc; (** The location of the operator *)
    } (** Less Then *)
  | BinGte of {
      loc: Core.loc; (** The location of the operator *)
    } (** Greater Then or Equal *)
  | BinGt of {
      loc: Core.loc; (** The location of the operator *)
    } (** Greater Then *)
  | BinRfa of {
      loc: Core.loc; (** The location of the operator *)
    } (** Reverse Function Application *)
(** Binary Operators *)

(**
 * {3 Patterns}
 *)

type patt =
  | PattGround of {
      loc: Core.loc; (** The location of the pattern *)
    } (** Ground *)
  | PattBool of {
      loc:   Core.loc; (** The location of the pattern *)
      value: bool;     (** The boolean value *)
    } (** Boolean Literal *)
  | PattInt of {
      loc:    Core.loc; (** The location of the pattern *)
      lexeme: string;   (** The integer lexeme *)
    } (** Integer Literal *)
  | PattVar of {
      loc:    Core.loc; (** The location of the pattern *)
      lexeme: string;   (** The variable lexeme *)
    } (** Variable *)
  | PattFun of {
      loc:    Core.loc;   (** The location of the pattern *)
      name:   name;       (** The function name *)
      params: param list; (** The function parameters *)
    } (** Function *)
(** Patterns *)

and param =
  | Param of {
      loc:  Core.loc;  (** The location of the parameter *)
      patt: patt;      (** The pattern the parameter matches *)
      ty:   ty option; (** The parameter type *)
    } (** Parameter *)
(** Function Parameters *)

(**
 * {3 Expressions}
 *)

type expr =
  | ExprBool of {
      loc:   Core.loc; (** The location of the expression *)
      value: bool;     (** The boolean value *)
    } (** Boolean Literal *)
  | ExprInt of {
      loc:    Core.loc; (** The location of the expression *)
      lexeme: string;   (** The integer lexeme *)
    } (** Integer Literal *)
  | ExprId of {
      loc:  Core.loc; (** The location of the expression *)
      name: name;     (** The referenced name *)
    } (** Identifier Literal *)
  | ExprUn of {
      loc:     Core.loc; (** The location of the expression *)
      op:      un;       (** The operator *)
      operand: expr;     (** The operand *)
    } (** Unary Operation *)
  | ExprBin of {
      loc: Core.loc; (** The location of the expression *)
      op:  bin;      (** The operator *)
      lhs: expr;     (** The left-hand operand *)
      rhs: expr;     (** The right-hand operand *)
    } (** Binary Operation *)
  | ExprCond of {
      loc:  Core.loc; (** The location of the expression *)
      cond: expr;     (** The condition *)
      tru:  expr;     (** The true case *)
      fls:  expr;     (** The false case *)
    } (** Condition *)
  | ExprLet of {
      loc:      Core.loc;     (** The location of the expression *)
      recur:    bool;         (** Whether the binding is marked recursive *)
      bindings: binding list; (** The bindings *)
      scope:    expr;         (** The scope of the bindings *)
    } (** Value Binding *)
  | ExprAbs of {
      loc:    Core.loc;   (** The location of the expression *)
      params: param list; (** The function parameters *)
      ret:    ty option;  (** The return type *)
      body:   expr;       (** The function body *)
    } (** Function Abstraction *)
  | ExprApp of {
      loc:  Core.loc;  (** The location of the expression *)
      fn:   expr;      (** The function *)
      args: expr list; (** The arguments *)
    } (** Function Application *)
(** Expressions *)

and binding =
  | Binding of {
      loc:   Core.loc;  (** The location of the binding *)
      patt:  patt;      (** The pattern bound *)
      ty:    ty option; (** The tyoe of the bound value *)
      value: expr;      (** The bound value *)
    } (** Value Binding *)
(** Value Bindings *)

(**
 * {3 Package Statements}
 *)

type pkg = private
  | Library of {
      loc:  Core.loc; (** The location of the package statement *)
      name: name;     (** The name of the library *)
    } (** A library *)
  | Executable of {
      loc:  Core.loc; (** The location of the package statement *)
      name: name;     (** The name of the executable *)
    } (** An executable *)
(** Package Statements *)

(**
 * {3 Imports}
 *)

type path = private
  | Path of {
      loc:  Core.loc; (** The location of the package path *)
      path: string;   (** The package path *)
    } (** A package path *)
(** Package Paths *)

type alias = private
  | Alias of {
      loc:   Core.loc;    (** The location of the alias *)
      alias: name option; (** The local alias *)
      path:  path;        (** The package path *)
  }
(** Aliased Imports *)

type pkgs = private
  | Packages of {
      loc:     Core.loc;   (** The location of the package list *)
      aliases: alias list; (** The aliased imports *)
    } (** A package alias list *)
(** Package Alias Lists *)

type import = private
  | Import of {
      loc:  Core.loc; (** The location of the import statement *)
      pkgs: pkgs;     (** The import list *)
    }
(** Import Statements *)

(**
 * {3 Top-Level Bindings}
 *)

type top =
  | TopTy of {
      loc:      Core.loc;        (** The location of the binding *)
      local:    bool;            (** Whether the binding is local *)
      bindings: ty_binding list; (** The type bindings *)
    } (** Type Binding *)
  | TopVal of {
      loc:     Core.loc; (** The location of the binding *)
      binding: binding;  (** The value binding *)
    } (** Value Binding *)
  | TopDef of {
      loc:     Core.loc; (** The location of the binding *)
      binding: binding;  (** The function definition *)
    } (** Function Definition *)
  | TopLet of {
      loc:      Core.loc;     (** The location of the binding *)
      recur:    bool;         (** Whether the bindings are recursive *)
      bindings: binding list; (** The value bindings *)
    } (** Local Binding *)
  | TopMod of {
      loc:    Core.loc;       (** The location of the module *)
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
      loc:     Core.loc;    (** The location of the file *)
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

val name : Core.loc -> string -> name
(**
 * Construct a name.
 *
 * @param loc The location of the name
 * @param name The identifier
 * @return A name
 *)


val dotted : Core.loc -> name -> name -> name
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

val ty_vis_readonly : Core.loc -> ty_vis
(**
 * Construct a read-only visibility.
 *
 * @param loc The location of the visibility
 * @return A type visibility
 *)

val ty_vis_abstract : Core.loc -> ty_vis
(**
 * Construct an abstract visibility
 *
 * @param loc The location of the visibility
 * @return A type visibility
 *)

(**
 * {4 Types}
 *)

val ty_constr : Core.loc -> name -> ty
(**
 * Construct a type constructor
 * 
 * @param loc The location of the type
 * @param name The constructor name
 * @return A type constructor
 *)

val ty_fun : Core.loc -> ty -> ty -> ty
(**
 * Construct a function type
 * 
 * @param loc The location of the type
 * @param param The parameter type
 * @param ret The return type
 * @return A function type
 *)

val ty_sig : Core.loc -> sig_elem list -> ty
(**
 * Construct a module signature
 *
 * @param loc The location of the signature
 * @param elems The signature elements
 * @return A module signature
 *)

val ty_with : Core.loc -> name -> ty_binding list -> ty
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

val sig_ty : Core.loc -> name -> mod_param list -> ty option -> sig_elem
(**
 * Construct a type binding signature element
 *
 * @param loc The location of the element
 * @param name The type name
 * @param params The module parameters
 * @param ty The type definition
 * @return A type binding signature element
 *)

val sig_val : Core.loc -> name -> ty -> sig_elem
(**
 * Construct a value binding signature element
 *
 * @param loc The location of the element
 * @param name The bound name
 * @param ty The bound value type
 * @return A value binding signature element
 *)

val sig_def : Core.loc -> name -> ty -> sig_elem
(**
 * Construct a function definition signature element
 * 
 * @param loc The location of the element
 * @param name The function name
 * @param ty The function type
 * @return A function definition signature element
 *)

val sig_mod : Core.loc -> name -> mod_param list -> ty -> sig_elem
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

val ty_binding : Core.loc -> name -> mod_param list -> ty_vis option -> ty -> ty_binding
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

val mod_param : Core.loc -> name -> ty option -> mod_param
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

val un_neg : Core.loc -> un
(**
 * Construct a negation operator
 * 
 * @param loc The location of the operator
 * @return A negation operator
 *)

val un_lnot : Core.loc -> un
(**
 * Construct a logical NOT operator
 * 
 * @param loc The location of the operator
 * @return A logical NOT operator
 *)

val un_bnot : Core.loc -> un
(**
 * Construct a bitwise NOT operator
 * 
 * @param loc The location of the operator
 * @return A bitwise NOT operator
 *)

(**
 * {4 Binary Operators}
 *)

val bin_add : Core.loc -> bin
(**
 * Construct an addition operator
 *
 * @param loc The location of the operator
 * @return An addition operator
 *)

val bin_sub : Core.loc -> bin
(**
 * Construct a subtration operator
 *
 * @param loc The location of the operator
 * @return A subtration operator
 *)

val bin_mul : Core.loc -> bin
(**
 * Construct a multiplication operator
 *
 * @param loc The location of the operator
 * @return A multiplication operator
 *)

val bin_div : Core.loc -> bin
(**
 * Construct a division operator
 *
 * @param loc The location of the operator
 * @return A division operator
 *)

val bin_mod : Core.loc -> bin
(**
 * Construct a modulus operator
 *
 * @param loc The location of the operator
 * @return A modulus operator
 *)

val bin_land : Core.loc -> bin
(**
 * Construct a logical AND operator
 *
 * @param loc The location of the operator
 * @return A logical AND operator
 *)

val bin_lor : Core.loc -> bin
(**
 * Construct a logical OR operator
 *
 * @param loc The location of the operator
 * @return A logical OR operator
 *)

val bin_band : Core.loc -> bin
(**
 * Construct a bitwise AND operator
 *
 * @param loc The location of the operator
 * @return A bitwise AND operator
 *)

val bin_bor : Core.loc -> bin
(**
 * Construct a bitwise OR operator
 *
 * @param loc The location of the operator
 * @return A bitwise OR operator
 *)

val bin_bxor : Core.loc -> bin
(**
 * Construct a bitwise XOR operator
 *
 * @param loc The location of the operator
 * @return A bitwise XOR operator
 *)

val bin_ssl : Core.loc -> bin
(**
 * Construct a signed shift left operator
 *
 * @param loc The location of the operator
 * @return A signed shift left operator
 *)

val bin_ssr : Core.loc -> bin
(**
 * Construct a signed shift right operator
 *
 * @param loc The location of the operator
 * @return A signed shift right operator
 *)

val bin_usl : Core.loc -> bin
(**
 * Construct an unsigned shift left operator
 *
 * @param loc The location of the operator
 * @return An unsigned shift left operator
 *)

val bin_usr : Core.loc -> bin
(**
 * Construct an unsigned shift right operator
 *
 * @param loc The location of the operator
 * @return An unsigned shift right operator
 *)

val bin_seq : Core.loc -> bin
(**
 * Construct a structural equality operator
 *
 * @param loc The location of the operator
 * @return A structural equality operator
 *)

val bin_peq : Core.loc -> bin
(**
 * Construct a physical equality operator
 *
 * @param loc The location of the operator
 * @return A physical equality operator
 *)

val bin_sneq : Core.loc -> bin
(**
 * Construct a structural inequality operator
 *
 * @param loc The location of the operator
 * @return A structural inequality operator
 *)

val bin_pneq : Core.loc -> bin
(**
 * Construct a physical inequality operator
 *
 * @param loc The location of the operator
 * @return A physical inequality operator
 *)

val bin_lte : Core.loc -> bin
(**
 * Construct a less than or equal operator
 *
 * @param loc The location of the operator
 * @return A less than or equal operator
 *)

val bin_lt : Core.loc -> bin
(**
 * Construct a less than operator
 *
 * @param loc The location of the operator
 * @return A less than operator
 *)

val bin_gte : Core.loc -> bin
(**
 * Construct a greater than or equal operator
 *
 * @param loc The location of the operator
 * @return A greater than or equal operator
 *)

val bin_gt : Core.loc -> bin
(**
 * Construct a greater than operator
 *
 * @param loc The location of the operator
 * @return A greater than operator
 *)

val bin_rfa : Core.loc -> bin
(**
 * Construct a reverse function application operator
 *
 * @param loc The location of the operator
 * @return A reverse function application operator
 *)

(** 
 * {3 Patterns}
 *)

val patt_ground : Core.loc -> patt
(**
 * Construct a ground pattern
 *
 * @param loc The location of the pattern
 * @return A ground pattern
 *)

val patt_bool : Core.loc -> bool -> patt
(**
 * Construct a boolean literal pattern
 *
 * @param loc The location of the pattern
 * @param value The literal value
 * @return A boolean literal pattern
 *)

val patt_int : Core.loc -> string -> patt
(**
 * Construct an integer literal pattern
 *
 * @param loc The location of the pattern
 * @param lexeme The literal lexeme
 * @return An integer literal pattern
 *)

val patt_var : Core.loc -> string -> patt
(**
 * Construct a variable pattern
 *
 * @param loc The location of the pattern
 * @param lexeme The variable lexeme
 * @return A variable pattern
 *)

val patt_fun : Core.loc -> name -> param list -> patt
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

val param : Core.loc -> patt -> ty option -> param
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

val expr_bool : Core.loc -> bool -> expr
(**
 * Construct a boolean literal expression
 *
 * @param loc The location of the expression
 * @param value The literal value
 * @return A boolean literal expression
 *)

val expr_int : Core.loc -> string -> expr
(**
 * Construct an integer literal expression
 *
 * @param loc The location of the expression
 * @param lexeme The integer lexeme
 * @return An integer literal expression
 *)

val expr_id : Core.loc -> name -> expr
(**
 * Construct an identifier literal expression
 *
 * @param loc The location of the expression
 * @param name The identifier
 * @return An identifier literal expression
 *)

val expr_un : Core.loc -> un -> expr -> expr
(**
 * Construct a unary operation expression
 *
 * @param loc The location of the expression
 * @param op The operator
 * @param operand The operand
 * @return The unary operation expression
 *)

val expr_bin : Core.loc -> bin -> expr -> expr -> expr
(**
 * Construct a binary operation expression
 *
 * @param loc The location of the expression
 * @param op The operator
 * @param lhs The left-hand operand
 * @param rhs The right-hand operand
 * @return A binary operation expression
 *)

val expr_cond : Core.loc -> expr -> expr -> expr -> expr
(**
 * Construct a condition expression
 *
 * @param loc The location of the expression
 * @param cond The condition
 * @param tru The true case
 * @param fls The false case
 * @return A condition expression
 *)

val expr_let : Core.loc -> bool -> binding list -> expr -> expr
(**
 * Construct a value binding expression
 *
 * @param loc The location of the expression
 * @param recur Whether the binding is marked recursive
 * @param bindings The value bindings
 * @param scope The scope of the bindings
 * @return A value binding expression
 *)

val expr_abs : Core.loc -> param list -> ty option -> expr -> expr
(**
 * Construct a function abstraction
 *
 * @param loc The location of the expression
 * @param params The function parameters
 * @param ret The return type
 * @param body The function body
 * @return A function abstraction expression
 *)

val expr_app : Core.loc -> expr -> expr list -> expr
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

val binding : Core.loc -> patt -> ty option -> expr -> binding
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

val pkg_library : Core.loc -> name -> pkg
(**
 * Construct a library package.
 *
 * @param loc The location of the package statement
 * @param id The name of the library
 * @return A library package
 *)

val pkg_executable : Core.loc -> name -> pkg
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

val path : Core.loc -> string -> path
(**
 * Construct a package path.
 * 
 * @param loc The location of the package path
 * @param path The path of the package
 * @return A package path
 *)

val alias : Core.loc -> name option -> path -> alias
(**
 * Construct a package alias clause with an optional local name.
 *
 * @param loc The location of the alias clause
 * @param name The optional local name of the package
 * @param path The package path
 * @return An alias clause
 *)

val alias_named : Core.loc -> name -> path -> alias
(**
 * Construct a locally named alias clause.  This is an alias for
 * [alias loc (Some name) path].
 * 
 * @param loc The location of the alias clause
 * @param local The local name of the package
 * @param path The package path
 * @return An alias clause
 *)

val alias_unnamed : Core.loc -> path -> alias
(**
 * Construct an alias clause using the default package name.  This is an alias
 * for [alias loc None path].
 * 
 * @param loc The location of the alias clause
 * @param path The package path
 * @return An alias clause
 *)

val pkgs : Core.loc -> alias list -> pkgs
(**
 * Construct a package alias list.
 *
 * @param loc The location of the alias clause
 * @param aliases The package aliases
 * @return A package alias list 
 *)

val import : Core.loc -> pkgs -> import
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

val top_ty : Core.loc -> bool -> ty_binding list -> top
(**
 * Construct a top-level type binding
 *
 * @param loc The location of the binding
 * @param local Whether the bindings are local
 * @param bindings The type bindings
 * @return A top-level type binding
 *)

val top_val : Core.loc -> binding -> top
(**
 * Construct a top-level value binding
 *
 * @param loc The location of the binding
 * @param binding The value binding
 * @return A top-level value binding
 *)

val top_def : Core.loc -> binding -> top
(**
 * Construct a top-level function definition
 *
 * @param loc The location of the definition
 * @param binding The function definition
 * @return A top-level function definition
 *)

val top_let : Core.loc -> bool -> binding list -> top
(**
 * Construct a top-level local binding
 *
 * @param loc The location of the binding
 * @param recur Whether the bindings are marked recursive
 * @param bindings The local bindings
 * @return A top-level local binding
 *)

val top_mod : Core.loc -> name -> mod_param list -> top list -> top
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

val file : Core.loc -> pkg -> import list -> top list -> file
(**
 * Constructs a source file.
 * 
 * @param loc The location of the file
 * @param pkg The package statement
 * @param imports The import statements
 * @param tops The top-level bindings
 * @return A source file
 *)