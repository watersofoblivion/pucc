(**
 * {1 Abstract Syntax Testing}
 *
 * Functions for testing the abstract syntax.
 *)

open OUnit2

(** {2 Fixtures} *)

(**
 * {3 Location Tracking}
 *)

val fresh_pos : ?pos:(Syntax.pos CoreTest.fixture) -> ?line:(int CoreTest.fixture) -> ?col:(int CoreTest.fixture) -> ?off:(int CoreTest.fixture) -> (int, Syntax.pos, 'a) CoreTest.fixture
(**
 * Construct a fresh position.  Any values that are not given will be
 * automatically generated.
 *
 * 
 * @param ?line The line number of the position
 * @param ?col The column number of the position
 * @param ?off The byte offset of the position
 * @param _ A dummy parameter if none of the optional values are given
 * @return A fresh position
 *)

val fresh_loc : ?loc:Syntax.loc -> ?start:Syntax.pos -> ?stop:Syntax.pos -> int Core.seq -> (int Core.seq -> Syntax.loc -> 'a) -> 'a
(**
 * Construct a fresh location.  Any values that are not given will be
 * automatically generated.
 *
 * @param ?start The starting position of the location
 * @param ?stop The ending position of the location
 * @param _ A dummy parameter if none of the optional values are given
 * @return A fresh location
 *)

(** {3 Names} *)

val fresh_name : ?name:Syntax.name -> ?loc:Syntax.loc -> ?id:string -> int Core.seq -> (int Core.seq -> Syntax.name -> 'a) -> 'a
val fresh_dotted : ?name:Syntax.name -> ?loc:Syntax.loc -> ?lhs:Syntax.name -> ?rhs:Syntax.name -> int Core.seq -> (int Core.seq -> Syntax.name -> 'a) -> 'a

(** {3 Types} *)

(** {4 Visibility} *)

val fresh_ty_vis_readonly : ?vis:Syntax.ty_vis -> ?loc:Syntax.loc -> int Core.seq -> (int Core.seq -> Syntax.ty_vis -> 'a) -> 'a
val fresh_ty_vis_abstract : ?vis:Syntax.ty_vis -> ?loc:Syntax.loc ->  -> int Core.seq -> (int Core.seq -> Syntax.ty_vis -> 'a) -> 'a

(** {4 Types} *)

val fresh_ty_int : ?ty:Syntax.ty -> ?loc:Syntax.loc -> int Core.seq -> (int Core.seq -> Syntax.ty -> 'a) -> 'a
val fresh_ty_bool : ?ty:Syntax.ty -> ?loc:Syntax.loc -> int Core.seq -> (int Core.seq -> Syntax.ty -> 'a) -> 'a
val fresh_ty_constr : ?ty:Syntax.ty -> ?loc:Syntax.loc -> ?name:Syntax.name -> int Core.seq -> (int Core.seq -> Syntax.ty -> 'a) -> 'a
val fresh_ty_fun : ?ty:Syntax.ty -> ?loc:Syntax.loc -> ?param:Syntax.ty -> ?res:Syntax.ty -> int Core.seq -> (int Core.seq -> Syntax.ty -> 'a) -> 'a
val fresh_ty_sig : ?ty:Syntax.ty -> ?loc:Syntax.loc -> ?elems:(Syntax.sig_elem list) -> int Core.seq -> (int Core.seq -> Syntax.ty -> 'a) -> 'a
val fresh_ty_with : ?ty:Syntax.ty -> ?loc:Syntax.loc -> ?name:Syntax.name -> ?bindings:(Syntax.ty_binding list) -> int Core.seq -> (int Core.seq -> Syntax.ty -> 'a) -> 'a

(** {4 Module Signature Elements} *)

val fresh_sig_ty : ?loc:Syntax.loc -> ?name:Syntax.name -> ?params:(Syntax.mod_param list) -> ?ty:(Syntax.ty option) -> unit -> Syntax.sig_elem
val fresh_sig_val : ?loc:Syntax.loc -> ?name:Syntax.name -> ?ty:Syntax.ty -> unit -> Syntax.sig_elem
val fresh_sig_def : ?loc:Syntax.loc -> ?name:Syntax.name -> ?ty:Syntax.ty -> unit -> Syntax.sig_elem
val fresh_sig_mod : ?loc:Syntax.loc -> ?name:Syntax.name -> ?params:(Syntax.mod_param list) -> ?ty:Syntax.ty -> unit -> Syntax.sig_elem

(** {4 Type Bindings} *)

val fresh_ty_binding : ?loc:Syntax.loc -> ?name:Syntax.name -> ?params:(Syntax.mod_param list) -> ?vis:(Syntax.ty_vis option) -> ?ty:Syntax.ty -> unit -> Syntax.ty_binding 

(** {4 Module Parameters} *)

val fresh_mod_param : ?loc:Syntax.loc -> ?name:Syntax.name -> ?ty:(Syntax.ty option) -> unit -> Syntax.mod_param

(** {3 Primitive Operations} *)

(** {4 Unary Operators} *)

val fresh_un_neg : ?loc:Syntax.loc -> unit -> Syntax.un
val fresh_un_lnot : ?loc:Syntax.loc -> unit -> Syntax.un
val fresh_un_bnot : ?loc:Syntax.loc -> unit -> Syntax.un

(** {4 Binary Operators} *)

val fresh_bin_add : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_sub : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_mul : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_div : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_mod : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_land : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_lor : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_band : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_bor : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_bxor : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_ssl : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_ssr : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_usl : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_usr : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_seq : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_peq : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_sneq : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_pneq : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_gte : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_gt : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_lte : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_lt : ?loc:Syntax.loc -> unit -> Syntax.bin
val fresh_bin_rfa : ?loc:Syntax.loc -> unit -> Syntax.bin

(** {3 Patterns} *)

val fresh_patt_ground : ?loc:Syntax.loc -> unit -> Syntax.patt
val fresh_patt_bool : ?loc:Syntax.loc -> ?value:bool -> unit -> Syntax.patt
val fresh_patt_int : ?loc:Syntax.loc -> ?lexeme:string -> unit -> Syntax.patt
val fresh_patt_var : ?loc:Syntax.loc -> ?lexeme:string -> unit -> Syntax.patt
val fresh_patt_fun : ?loc:Syntax.loc -> ?name:Syntax.name -> ?params:(Syntax.param list) -> unit -> Syntax.patt

(** {4 Parameters} *)

val fresh_param : ?loc:Syntax.loc -> ?patt:Syntax.patt -> ?ty:(Syntax.ty option) -> unit -> Syntax.param

(** {3 Expressions} *)

val fresh_expr_bool : ?loc:Syntax.loc -> ?value:bool -> unit -> Syntax.expr
val fresh_expr_int : ?loc:Syntax.loc -> ?lexeme:string -> unit -> Syntax.expr
val fresh_expr_id : ?loc:Syntax.loc -> ?name:Syntax.name -> unit -> Syntax.expr
val fresh_expr_un : ?loc:Syntax.loc -> ?op:Syntax.un -> ?operand:Syntax.expr -> unit -> Syntax.expr
val fresh_expr_bin : ?loc:Syntax.loc -> ?op:Syntax.bin -> ?lhs:Syntax.expr -> ?rhs:Syntax.expr -> unit -> Syntax.expr
val fresh_expr_cond : ?loc:Syntax.loc -> ?cond:Syntax.expr -> ?tru:Syntax.expr -> ?fls:Syntax.expr -> unit -> Syntax.expr
val fresh_expr_let : ?loc:Syntax.loc -> ?recur:bool -> ?bindings:(Syntax.binding list) -> ?scope:Syntax.expr -> unit -> Syntax.expr
val fresh_expr_abs : ?loc:Syntax.loc -> ?params:(Syntax.param list) -> ?ret:(Syntax.ty option) -> ?body:Syntax.expr -> unit -> Syntax.expr
val fresh_expr_app : ?loc:Syntax.loc -> ?fn:Syntax.expr -> ?args:(Syntax.expr list) -> unit -> Syntax.expr

(** {4 Bindings} *)

val fresh_binding : ?loc:Syntax.loc -> ?patt:Syntax.patt -> ?ty:(Syntax.ty option) -> ?value:Syntax.expr -> unit -> Syntax.binding

(** {3 Package Statements} *)

val fresh_pkg_library : ?loc:Syntax.loc -> ?id:Syntax.name -> unit -> Syntax.pkg_stmt
val fresh_pkg_executable : ?loc:Syntax.loc -> ?id:Syntax.name -> unit -> Syntax.pkg_stmt

(** {3 Imports} *)

val fresh_path : ?loc:Syntax.loc -> ?path:string -> unit -> Syntax.path
val fresh_alias : ?loc:Syntax.loc -> ?local:Syntax.name -> ?path:Syntax.path -> unit -> Syntax.alias
val fresh_pkgs : ?loc:Syntax.loc -> ?aliases:(Syntax.alias list) -> unit -> Syntax.pkgs
val fresh_import : ?loc:Syntax.loc -> ?pkgs:Syntax.pkgs -> unit -> Syntax.import

(** {3 Top-Level Bindings} *)

val fresh_top_ty : ?loc:Syntax.loc -> ?local:bool -> ?bindings:(Syntax.ty_binding list) -> unit -> Syntax.top
val fresh_top_val : ?loc:Syntax.loc -> ?binding:Syntax.binding -> unit -> Syntax.top
val fresh_top_def : ?loc:Syntax.loc -> ?binding:Syntax.binding -> unit -> Syntax.top
val fresh_top_let : ?loc:Syntax.loc -> ?recur:bool -> ?bindings:(Syntax.binding list) -> unit -> Syntax.top
val fresh_top_mod : ?loc:Syntax.loc -> ?name:Syntax.name -> ?params:(Syntax.mod_param list) -> ?elems:(Syntax.top list) -> unit -> Syntax.top

(** {3 Files} *)

val fresh_file : ?loc:Syntax.loc -> ?pkg:Syntax.pkg -> ?imports:(Syntax.import list) -> ?tops:(Syntax.top list) -> unit -> Syntax.file

(** {2 Assertions} *)

(** {3 Constructor Mismatch} *)

val fail_name_constr : ctxt:test_ctxt -> Syntax.name -> Syntax.name -> unit

val fail_ty_vis_constr : ctxt:test_ctxt -> Syntax.ty_vis -> Syntax.ty_vis -> unit
val fail_ty_constr : ctxt:test_ctxt -> Syntax.ty -> Syntax.ty -> unit
val fail_sig_elem_constr : ctxt:test_ctxt -> Syntax.sig_elem -> Syntax.sig_elem -> unit

val fail_un_constr : ctxt:test_ctxt -> Syntax.un -> Syntax.un -> unit
val fail_bin_constr : ctxt:test_ctxt -> Syntax.bin -> Syntax.bin -> unit

val fail_patt_constr : ctxt:test_ctxt -> Syntax.patt -> Syntax.patt -> unit

val fail_expr_constr : ctxt:test_ctxt -> Syntax.expr -> Syntax.expr -> unit

val fail_pkg_constr : ctxt:test_ctxt -> Syntax.pkg -> Syntax.pkg -> unit

val fail_top_constr : ctxt:test_ctxt -> Syntax.top -> Syntax.top -> unit

(** {3 Equality} *)

(**
 * {4 Location Tracking}
 *)

 val assert_pos_equal : ctxt:test_ctxt -> Syntax.pos -> Syntax.pos -> unit
 (**
  * Assert that two positions are equal.
  *
  * @param ~ctxt The testing context
  * @param expected The expected position
  * @param actual The actual position
  *)
 
 val assert_loc_equal : ctxt:test_ctxt -> Syntax.loc -> Syntax.loc -> unit
 (**
  * Assert that two locations are equal.
  *
  * @param ~ctxt The testing context
  * @param expected The expected location
  * @param actual The actual location
  *)
 
(** {4 Names} *)

val assert_name_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.name -> Syntax.name -> unit

(** {4 Types} *)

val assert_ty_vis_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.ty_vis -> Syntax.ty_vis -> unit
val assert_ty_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.ty -> Syntax.ty -> unit
val assert_sig_elem_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.sig_elem -> Syntax.sig_elem -> unit
val assert_ty_binding_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.ty_binding -> Syntax.ty_binding -> unit
val assert_mod_param_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.mod_param -> Syntax.mod_param -> unit

(** {4 Primitive Operations} *)

val assert_un_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.un -> Syntax.un -> unit
val assert_bin_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.bin -> Syntax.bin -> unit

(** {4 Patterns} *)

val assert_patt_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.patt -> Syntax.patt -> unit
val assert_param_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.param -> Syntax.param -> unit

(** {4 Expressions} *)

val assert_expr_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.expr -> Syntax.expr -> unit
val assert_binding_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.binding -> Syntax.binding -> unit

(** {4 Package Statements }*)
 
val assert_pkg_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.pkg -> Syntax.pkg -> unit
(**
 * Assert the the two package statements are equal.
 *
 * @param ~ctxt The testing context
 * @param ?loc Whether to test for location equality (defaults to [true])
 * @param expected The expected package statement
 * @param actual The actual package statement
 * @throws Failure Throws if the package statements are not equal
 *)
 
(** {4 Imports} *)

val assert_path_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.path -> Syntax.path -> unit
val assert_alias_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.alias -> Syntax.alias -> unit
val assert_pkgs_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.pkgs -> Syntax.pkgs -> unit
val assert_import_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.import -> Syntax.import -> unit

(** {4 Top-Level Bindings} *)

val assert_top_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.top -> Syntax.top -> unit

(** {4 Files} *)

val assert_file_equal : ctxt:test_ctxt -> ?loc:bool -> Syntax.file -> Syntax.file -> unit
(**
 * Assert the the two files are equal.
 *
 * @param ~ctxt The testing context
 * @param ?loc Whether to test for location equality (defaults to [true])
 * @param expected The expected file
 * @param actual The actual file
 * @throws Failure Throws if the files are not equal
 *)
