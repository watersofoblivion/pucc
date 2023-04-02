(**
 * {1 Annotated Syntax}
 *
 * A fully type-annotated, desugared syntax for PU/CC.  This syntax does not
 * include location information.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the annotated syntax.
 *)

(** {3 Types} *)

type ty = private
  | TyBool (** Booleans *)
  | TyInt  (** Integers *)
  | TyFun of {
      param: ty; (** The parameter types *)
      res:   ty; (** The result type *)
    } (** Functions *)
  | TyMod of {
      ty: tymod; (** The module type *)
    } (** Module *)
  | TyConstr of {
      id: Core.sym; (** The name of the constructor *)
    } (** Constructor *)
(** Types *)

and tymod =
  | ModSig of {
      tops: sigelem list; (** Signature elements *)
    } (** Signature *)
  | ModFunct of {
      id:  Core.sym; (** The name of the parameter *)
      ty:  tymod;    (** The type of the parameter *)
      res: tymod;    (** The result of the functor *)
    } (** Functor *)
  | ModId of {
      id: Core.sym; (** Identifier *)
    } (** Identifier *)
(** Module Types *)

and sigelem =
  | SigElemTy of {
      tys: tybind list; (** A list of mutually-recursive type bindings *)
    } (** Type bindings *)
  | SigElemLet of {
      ty: ty; (** The type of the bound value *)
    } (** Value bindng *)
(** Signature Elements *)

and tybind = private
  | TyPublic of {
      id: Core.sym; (** The identifier *)
      ty: ty;       (** The type definition *)
    } (** Public types *)
  | TyPrivate of {
      id: Core.sym; (** The identifier *)
      ty: ty;       (** The type definition *)
    } (** Private types *)
  | TyAbstract of {
      id: Core.sym; (** The identifier *)
      ty: ty;       (** The type definition *)
    } (** Abstract types *)
(** Type Bindings *)

(** {3 Primitive Operations} *)

type prim = private
  | PrimNeg  (** Negation *)
  | PrimAdd  (** Addition *)
  | PrimSub  (** Subtraction *)
  | PrimMul  (** Multiplication *)
  | PrimDiv  (** Division *)
  | PrimMod  (** Modulus *)
  | PrimLNot (** Logical NOT *)
  | PrimBAnd (** Bitwise AND *)
  | PrimBOr  (** Bitwise OR *)
  | PrimBXor (** Bitwise XOR *)
  | PrimBNot (** Bitwise NOT *)
  | PrimSsl  (** Signed Shift Left *)
  | PrimSsr  (** Signed Shift Right *)
  | PrimUsl  (** Unsigned Shift Left *)
  | PrimUsr  (** Unsigned Shift Right *)
  | PrimSeq  (** Structural Equality *)
  | PrimPeq  (** Physical Equality *)
  | PrimSneq (** Structural Inequality *)
  | PrimPneq (** Physical Inequality *)
  | PrimLte  (** Less Than or Equal *)
  | PrimLt   (** Less Than *)
  | PrimGte  (** Greater Than or Equal *)
  | PrimGt   (** Greater Than *)
(** Primitive Operations *)

(** {3 Patterns} *)

type patt = private
  | PattGround (** Ground pattern *)
  | PattVar of {
      id: Core.sym; (** The variable to bind to *)
    } (** Variable pattern *)
(** Patterns *)

(** {3 Function Parameters} *)

type param = private
  | Param of {
      patt: patt; (** The pattern to match the parameter against *)
      ty:   ty;   (** The type of the pattern *)
    } (** Function parameter *)
(** Function parameters *)

(** {3 Expressions} *)

type expr = private
  | ExprBool of {
      value: bool; (** The value *)
    } (** A boolean *)
  | ExprInt of {
      value: int; (** The value *)
    } (** An integer *)
  | ExprId of {
      id: Core.sym; (** The identifier *)
    } (** Identifier *)
  | ExprPrim of {
      op:  prim;      (** The operation *)
      ops: expr list; (** The operands *)
    } (** Primitive Operation *)
  | ExprCond of {
      cond: expr; (** Condition *)
      tru:  expr; (** True branch *)
      fls:  expr; (** False branch *)
    } (** Conditional *)
  | ExprLet of {
      bindings: binding list; (** A set of mutually-recursive value bindings *)
      scope:    expr;         (** The scope of the binding *)
    } (** Local binding *)
  | ExprAbs of {
      arity:  int;        (** The arity of the function *)
      params: param list; (** The parameters *)
      ret:    ty;         (** The return type *)
      body:   expr;       (** The body of the funciton *)
    } (** Function abstraction *)
  | ExprApp of {
      fn:   expr;      (** The function to apply *)
      args: expr list; (** The arguments the function is applied to *)
    } (** Function application *)
(** Expressions *)

and binding = private
 | Binding of {
    patt:  patt; (** The pattern to bind *)
    ty:    ty;   (** The type of the value *)
    value: expr; (** The value to bind to the pattern *)
  }
(** Bindings *)

(** {3 Package Statements} *)

type pkg = private
  | Library of {
      id: Core.sym; (** The name of the library *)
    } (** A library *)
  | Executable of {
      id: Core.sym; (** The name of the executable *)
    } (** An executable *)
(** Package Statements *)

(** {3 Top-Level Bindings} *)

type top = private
  | TopTy of {
      id: Core.sym; (** The type name *)
      ty: ty;       (** The type definition *)
    } (** Type Binding *)
  | TopVal of {
      bindings: binding list; (** A set of mutually-recursive value bindings *)
    } (** Value Binding *)
(** Top-Level Bindings *)

(** {3 Files} *)

type file = private
  | File of {
      pkg:  pkg;      (** The package statement *)
      tops: top list; (** The top-level statements *)
    } (** A file *)
(** A file of annotated syntax *)

(**
 * {2 Constructors}
 *
 * Construct values of the annotated syntax.
 *)

(** {3 Types} *)

val ty_bool : ty
(** Construct a boolean type *)

val ty_int : ty
(** Construct an integer type *)

val ty_fun : ty -> ty -> ty
(**
 * Construct a function type.
 *
 * @param param The parameter type
 * @param res The result type
 * @return A function type
 *)

val ty_constr : Core.sym -> ty
(**
 * Construct a type constructor.
 *
 * @param id The name of the constructor
 * @return A type constructor
 *)

(** {3 Primitive Operations} *)

val prim_neg : prim
(** Construct a primitive negation operation. *)

val prim_add : prim
(** Construct a primitive addition operation. *)

val prim_sub : prim
(** Construct a primitive subtraction operation. *)

val prim_mul : prim
(** Consutrct a primitive multiplication operation. *)

val prim_div : prim
(** Construct a primitive division operation. *)

val prim_mod : prim
(** Construct a primitive modulus operation. *)

val prim_lnot : prim
(** Construct a primitive logical NOT operation. *)

val prim_band : prim
(** Construct a primitive bitwise AND operation. *)

val prim_bor : prim
(** Construct a primitive bitwise OR operation. *)

val prim_bxor : prim
(** Construct a primitive bitwise XOR operation. *)

val prim_bnot : prim
(** Construct a primitive bitwise NOT operation. *)

val prim_ssl : prim
(** Construct a primitive signed shift left operation. *)

val prim_ssr : prim
(** Construct a primitive signed shift right operation. *)

val prim_usl : prim
(** Construct a primitive unsigned shift left operation. *)

val prim_usr : prim
(** Construct a primitive unsigned shift right operation. *)

val prim_seq : prim
(** Construct a primitive structural equality operation. *)

val prim_peq : prim
(** Construct a primitive physical equality operation. *)

val prim_sneq : prim
(** Construct a primitive structural inequality operation. *)

val prim_pneq : prim
(** Construct a primitive physical inequality operation. *)

val prim_lte : prim
(** Construct a primitive less than or equal operation. *)

val prim_lt : prim
(** Construct a primitive less than operation. *)

val prim_gte : prim
(** Construct a primitive greater than or equal operation. *)

val prim_gt : prim
(** Construct a primitive greater than operation. *)

(** {3 Patterns} *)

val patt_ground : patt
(** Construct a ground pattern ([_]) *)

val patt_var : Core.sym -> patt
(** Construct a variable pattern *)

(** {3 Function Parameters} *)

val param : patt -> ty -> param
(**
 * Construct a function parameter.
 *
 * @param patt The pattern the parameter matches
 * @param ty The type of the parameter
 * @return A function parameter
 *)

(** {3 Expressions} *)

val expr_bool : bool -> expr
(**
 * Construct a boolean literal.
 *
 * @param value The value
 * @return A boolean literal
 *)

val expr_int : int -> expr
(**
 * Construct an integer literal.
 *
 * @param value The value
 * @return An integer literal
 *)

val expr_id : Core.sym -> expr
(**
 * Construct an identifier.
 *
 * @param id The identifier
 * @return An identifier
 *)

val expr_prim : prim -> expr list -> expr
(**
 * Construct a primitive operation.
 *
 * @parma op The primitive operation
 * @param ops The operands
 * @return A primitive operation
 *)

val expr_cond : expr -> expr -> expr -> expr
(**
 * Construct a conditional expression.
 *
 * @param cond The condition
 * @param tru The true case
 * @param fls The false case
 * @return A conditional expression
 *)

val expr_let : binding list -> expr -> expr
(**
 * Construct a value binding.
 *
 * @param bindings A set of mutually-recursive value bindings
 * @param scope The scope the value is bound in
 * @return A let binding
 *)

val expr_abs : param list -> ty -> expr -> expr
(**
 * Construct a function abstraction.
 *
 * @param params The parameters to the function
 * @param ret The return type of the function
 * @param body The body of the function
 * @return A function abstraction
 *)

val expr_app : expr -> expr list -> expr
(**
 * Construct a function application.
 *
 * @param fn The function to apply
 * @param args The arguments the function is applied to
 * @return A function application
 *)

(** {3 Bindings} *)

val binding : patt -> ty -> expr -> binding
(**
 * Construct a value binding.
 *
 * @param patt The pattern to bind the value to
 * @param ty The type of the value
 * @param value The value to bind
 * @return A value binding 
 *)

(** {3 Package Statements} *)

val pkg_library : Core.sym -> pkg
(**
 * Construct a library package statement.
 *
 * @param id The name of the library
 * @return A library package statement
 *)

val pkg_executable : Core.sym -> pkg
(**
 * Construct an executable package statement.
 *
 * @param id The name of the library
 * @return An executable package statement
 *)

(** {3 Top-Level Statements} *)

val top_ty : Core.sym -> ty -> top
(**
 * Construct a top-level type binding.
 * 
 * @param id The name of the type
 * @param ty The definition of the type
 * @return A type binding
 *)

val top_val : binding list -> top
(**
 * Construct a top-level value binding.
 *
 * @param bindings A set of mutually-recursive value bindings
 * @return A top-level value binding
 *)

(** {3 Files} *)

val file : pkg -> top list -> file
(**
 * Construct a file of annotated syntax.
 *
 * @param pkg The package statement
 * @param tops The top-level statements
 * @return A file of annotated syntax
 *)
