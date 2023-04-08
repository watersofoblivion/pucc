(**
 * {1 Abstract Syntax Testing}
 *
 * Functions for testing the abstract syntax.
 *)

open OUnit2

open Core
open Syntax

open CoreTest

(** {2 Fixtures} *)

(**
 * {3 Location Tracking}
 *)

val fresh_pos : ?pos:pos -> ?line:int -> ?col:int -> ?off:int -> (pos, 'a) fixture
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

val fresh_loc : ?loc:loc -> ?start:pos -> ?stop:pos -> (loc, 'a) fixture
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

val fresh_name : ?name:name -> ?loc:loc -> ?id:string -> (name, 'a) fixture
val fresh_dotted : ?name:name -> ?loc:loc -> ?lhs:name -> ?rhs:name -> (name, 'a) fixture

(** {3 Types} *)

(** {4 Visibility} *)

val fresh_ty_vis_readonly : ?vis:ty_vis -> ?loc:loc -> (ty_vis, 'a) fixture
val fresh_ty_vis_abstract : ?vis:ty_vis -> ?loc:loc -> (ty_vis, 'a) fixture

(** {4 Types} *)

val fresh_ty_int : ?ty:ty -> ?loc:loc -> (ty, 'a) fixture
val fresh_ty_bool : ?ty:ty -> ?loc:loc -> (ty, 'a) fixture
val fresh_ty_constr : ?ty:ty -> ?loc:loc -> ?name:name -> (ty, 'a) fixture
val fresh_ty_fun : ?ty:ty -> ?loc:loc -> ?param:ty -> ?res:ty -> (ty, 'a) fixture
val fresh_ty_sig : ?ty:ty -> ?loc:loc -> ?elems:(sig_elem list) -> (ty, 'a) fixture
val fresh_ty_with : ?ty:ty -> ?loc:loc -> ?name:name -> ?bindings:(ty_binding list) -> (ty, 'a) fixture

(** {4 Module Signature Elements} *)

val fresh_sig_ty : ?sig_elem:sig_elem -> ?loc:loc -> ?name:name -> ?params:(mod_param list) -> ?ty:(ty option) -> (sig_elem, 'a) fixture
val fresh_sig_val : ?sig_elem:sig_elem -> ?loc:loc -> ?name:name -> ?ty:ty -> (sig_elem, 'a) fixture
val fresh_sig_def : ?sig_elem:sig_elem -> ?loc:loc -> ?name:name -> ?ty:ty -> (sig_elem, 'a) fixture
val fresh_sig_mod : ?sig_elem:sig_elem -> ?loc:loc -> ?name:name -> ?params:(mod_param list) -> ?ty:ty -> (sig_elem, 'a) fixture

(** {4 Type Bindings} *)

val fresh_ty_binding : ?ty_binding:ty_binding -> ?loc:loc -> ?name:name -> ?params:(mod_param list) -> ?vis:(ty_vis option) -> ?ty:ty -> (ty_binding, 'a) fixture

(** {4 Module Parameters} *)

val fresh_mod_param : ?mod_param:mod_param -> ?loc:loc -> ?name:name -> ?ty:(ty option) -> (mod_param, 'a) fixture

(** {3 Primitive Operations} *)

(** {4 Unary Operators} *)

val fresh_un_neg : ?un:un -> ?loc:loc -> (unit, 'a) fixture
val fresh_un_lnot : ?un:un -> ?loc:loc -> (unit, 'a) fixture
val fresh_un_bnot : ?un:un -> ?loc:loc -> (unit, 'a) fixture

(** {4 Binary Operators} *)

val fresh_bin_add : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_sub : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_mul : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_div : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_mod : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_land : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_lor : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_band : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_bor : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_bxor : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_ssl : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_ssr : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_usl : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_usr : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_seq : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_peq : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_sneq : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_pneq : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_gte : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_gt : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_lte : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_lt : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture
val fresh_bin_rfa : ?bin:bin -> ?loc:loc -> (bin, 'a) fixture

(** {3 Patterns} *)

val fresh_patt_ground : ?patt:patt -> ?loc:loc -> (patt, 'a) fixture
val fresh_patt_bool : ?patt:patt -> ?loc:loc -> ?value:bool -> (patt, 'a) fixture
val fresh_patt_int : ?patt:patt -> ?loc:loc -> ?lexeme:string -> (patt, 'a) fixture
val fresh_patt_var : ?patt:patt -> ?loc:loc -> ?lexeme:string -> (patt, 'a) fixture
val fresh_patt_fun : ?patt:patt -> ?loc:loc -> ?name:name -> ?params:(param list) -> (patt, 'a) fixture

(** {4 Parameters} *)

val fresh_param : ?param:param -> ?loc:loc -> ?patt:patt -> ?ty:(ty option) -> (param, 'a) fixture

(** {3 Expressions} *)

val fresh_expr_bool : ?expr:expr -> ?loc:loc -> ?value:bool -> (expr, 'a) fixture
val fresh_expr_int : ?expr:expr -> ?loc:loc -> ?lexeme:string -> (expr, 'a) fixture
val fresh_expr_id : ?expr:expr -> ?loc:loc -> ?name:name -> (expr, 'a) fixture
val fresh_expr_un : ?expr:expr -> ?loc:loc -> ?op:un -> ?operand:expr -> (expr, 'a) fixture
val fresh_expr_bin : ?expr:expr -> ?loc:loc -> ?op:bin -> ?lhs:expr -> ?rhs:expr -> (expr, 'a) fixture
val fresh_expr_cond : ?expr:expr -> ?loc:loc -> ?cond:expr -> ?tru:expr -> ?fls:expr -> (expr, 'a) fixture
val fresh_expr_let : ?expr:expr -> ?loc:loc -> ?recur:bool -> ?bindings:(binding list) -> ?scope:expr -> (expr, 'a) fixture
val fresh_expr_abs : ?expr:expr -> ?loc:loc -> ?params:(param list) -> ?ret:(ty option) -> ?body:expr -> (expr, 'a) fixture
val fresh_expr_app : ?expr:expr -> ?loc:loc -> ?fn:expr -> ?args:(expr list) -> (expr, 'a) fixture

(** {4 Bindings} *)

val fresh_binding : ?binding:binding -> ?loc:loc -> ?patt:patt -> ?ty:(ty option) -> ?value:expr -> (binding, 'a) fixture

(** {3 Package Statements} *)

val fresh_pkg_library : ?pkg_stmt:pkg_stmt -> ?loc:loc -> ?name:name -> (pkg_stmt, 'a) fixture
val fresh_pkg_executable : ?pkg_stmt:pkg_stmt -> ?loc:loc -> ?name:name -> (pkg_stmt, 'a) fixture

(** {3 Imports} *)

val fresh_path : ?path:path -> ?loc:loc -> ?pkgpath:string -> (path, 'a) fixture
val fresh_alias : ?alias:alias -> ?loc:loc -> ?local:name -> ?path:path -> (alias, 'a) fixture
val fresh_pkgs : ?pkgs:pkgs -> ?loc:loc -> ?aliases:alias -> (pkgs, 'a) fixture
val fresh_import : ?import:import -> ?loc:loc -> ?pkgs:pkgs -> (import, 'a) fixture

(** {3 Top-Level Bindings} *)

val fresh_top_ty : ?top:top -> ?loc:loc -> ?local:bool -> ?bindings:(ty_binding list) -> (top, 'a) fixture
val fresh_top_val : ?top:top -> ?loc:loc -> ?binding:binding -> (top, 'a) fixture
val fresh_top_def : ?top:top -> ?loc:loc -> ?binding:binding -> (top, 'a) fixture
val fresh_top_let : ?top:top -> ?loc:loc -> ?recur:bool -> ?bindings:(binding list) -> (top, 'a) fixture
val fresh_top_mod : ?top:top -> ?loc:loc -> ?name:name -> ?params:(mod_param list) -> ?elems:(top list) -> (top, 'a) fixture

(** {3 Files} *)

val fresh_file : ?file:file -> ?loc:loc -> ?pkg:pkg_stmt -> ?imports:(import list) -> ?tops:(top list) -> (file, 'a) fixture

(** {2 Assertions} *)

(** {3 Constructor Mismatch} *)

val fail_name_constr : ctxt:test_ctxt -> name -> name -> unit

val fail_ty_vis_constr : ctxt:test_ctxt -> ty_vis -> ty_vis -> unit
val fail_ty_constr : ctxt:test_ctxt -> ty -> ty -> unit
val fail_sig_elem_constr : ctxt:test_ctxt -> sig_elem -> sig_elem -> unit

val fail_un_constr : ctxt:test_ctxt -> un -> un -> unit
val fail_bin_constr : ctxt:test_ctxt -> bin -> bin -> unit

val fail_patt_constr : ctxt:test_ctxt -> patt -> patt -> unit

val fail_expr_constr : ctxt:test_ctxt -> expr -> expr -> unit

val fail_pkg_constr : ctxt:test_ctxt -> pkg -> pkg -> unit

val fail_top_constr : ctxt:test_ctxt -> top -> top -> unit

(** {3 Equality} *)

(**
 * {4 Location Tracking}
 *)

 val assert_pos_equal : ctxt:test_ctxt -> pos -> pos -> unit
 (**
  * Assert that two positions are equal.
  *
  * @param ~ctxt The testing context
  * @param expected The expected position
  * @param actual The actual position
  *)
 
 val assert_loc_equal : ctxt:test_ctxt -> loc -> loc -> unit
 (**
  * Assert that two locations are equal.
  *
  * @param ~ctxt The testing context
  * @param expected The expected location
  * @param actual The actual location
  *)
 
(** {4 Names} *)

val assert_name_equal : ctxt:test_ctxt -> ?loc:bool -> name -> name -> unit

(** {4 Types} *)

val assert_ty_vis_equal : ctxt:test_ctxt -> ?loc:bool -> ty_vis -> ty_vis -> unit
val assert_ty_equal : ctxt:test_ctxt -> ?loc:bool -> ty -> ty -> unit
val assert_sig_elem_equal : ctxt:test_ctxt -> ?loc:bool -> sig_elem -> sig_elem -> unit
val assert_ty_binding_equal : ctxt:test_ctxt -> ?loc:bool -> ty_binding -> ty_binding -> unit
val assert_mod_param_equal : ctxt:test_ctxt -> ?loc:bool -> mod_param -> mod_param -> unit

(** {4 Primitive Operations} *)

val assert_un_equal : ctxt:test_ctxt -> ?loc:bool -> un -> un -> unit
val assert_bin_equal : ctxt:test_ctxt -> ?loc:bool -> bin -> bin -> unit

(** {4 Patterns} *)

val assert_patt_equal : ctxt:test_ctxt -> ?loc:bool -> patt -> patt -> unit
val assert_param_equal : ctxt:test_ctxt -> ?loc:bool -> param -> param -> unit

(** {4 Expressions} *)

val assert_expr_equal : ctxt:test_ctxt -> ?loc:bool -> expr -> expr -> unit
val assert_binding_equal : ctxt:test_ctxt -> ?loc:bool -> binding -> binding -> unit

(** {4 Package Statements }*)
 
val assert_pkg_equal : ctxt:test_ctxt -> ?loc:bool -> pkg -> pkg -> unit
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

val assert_path_equal : ctxt:test_ctxt -> ?loc:bool -> path -> path -> unit
val assert_alias_equal : ctxt:test_ctxt -> ?loc:bool -> alias -> alias -> unit
val assert_pkgs_equal : ctxt:test_ctxt -> ?loc:bool -> pkgs -> pkgs -> unit
val assert_import_equal : ctxt:test_ctxt -> ?loc:bool -> import -> import -> unit

(** {4 Top-Level Bindings} *)

val assert_top_equal : ctxt:test_ctxt -> ?loc:bool -> top -> top -> unit

(** {4 Files} *)

val assert_file_equal : ctxt:test_ctxt -> ?loc:bool -> file -> file -> unit
(**
 * Assert the the two files are equal.
 *
 * @param ~ctxt The testing context
 * @param ?loc Whether to test for location equality (defaults to [true])
 * @param expected The expected file
 * @param actual The actual file
 * @throws Failure Throws if the files are not equal
 *)
