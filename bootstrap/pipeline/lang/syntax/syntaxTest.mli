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

val fresh_pos : ?pos:((pos, 'a) fixture) -> ?line:((int, 'a) fixture) -> ?col:((int, 'a) fixture) -> ?off:((int, 'a) fixture) -> (pos, 'a) fixture
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

val fresh_loc : ?loc:((loc, 'a) fixture) -> ?start:((pos, 'a) fixture) -> ?stop:((pos, 'a) fixture) -> (loc, 'a) fixture
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

val fresh_name : ?name:((name, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> ?id:((string, 'a) fixture) -> (name, 'a) fixture
val fresh_dotted : ?name:((name, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> ?lhs:((name, 'a) fixture) -> ?rhs:((name, 'a) fixture) -> (name, 'a) fixture

(** {3 Types} *)

(** {4 Visibility} *)

val fresh_ty_vis_readonly : ?vis:ty_vis -> ?loc:((loc, 'a) fixture) -> (ty_vis, 'a) fixture
val fresh_ty_vis_abstract : ?vis:ty_vis -> ?loc:((loc, 'a) fixture) ->  -> (ty_vis, 'a) fixture

(** {4 Types} *)

val fresh_ty_int : ?ty:((ty, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> (ty, 'a) fixture
val fresh_ty_bool : ?ty:((ty, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> (ty, 'a) fixture
val fresh_ty_constr : ?ty:((ty, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> (ty, 'a) fixture
val fresh_ty_fun : ?ty:((ty, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> ?param:((ty, 'a) fixture) -> ?res:((ty, 'a) fixture) -> (ty, 'a) fixture
val fresh_ty_sig : ?ty:((ty, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> ?elems:(sig_elem list) -> (ty, 'a) fixture
val fresh_ty_with : ?ty:((ty, 'a) fixture) -> ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?bindings:(ty_binding list) -> (ty, 'a) fixture

(** {4 Module Signature Elements} *)

val fresh_sig_ty : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?params:(mod_param list) -> ?ty:((ty option, 'a) fixture) -> (sig_elem, 'a) fixture
val fresh_sig_val : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?ty:((ty, 'a) fixture) -> (sig_elem, 'a) fixture
val fresh_sig_def : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?ty:((ty, 'a) fixture) -> (sig_elem, 'a) fixture
val fresh_sig_mod : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?params:(mod_param list) -> ?ty:((ty, 'a) fixture) -> (sig_elem, 'a) fixture

(** {4 Type Bindings} *)

val fresh_ty_binding : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?params:((mod_param list, 'a) fixture) -> ?vis:((ty_vis option, 'a) fixture) -> ?ty:((ty, 'a) fixture) -> (ty_binding, 'a) fixture

(** {4 Module Parameters} *)

val fresh_mod_param : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?ty:((ty option, 'a) fixture) -> (mod_param, 'a) fixture

(** {3 Primitive Operations} *)

(** {4 Unary Operators} *)

val fresh_un_neg : ?loc:((loc, 'a) fixture) -> (unit, 'a) fixture
val fresh_un_lnot : ?loc:((loc, 'a) fixture) -> (unit, 'a) fixture
val fresh_un_bnot : ?loc:((loc, 'a) fixture) -> (unit, 'a) fixture

(** {4 Binary Operators} *)

val fresh_bin_add : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_sub : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_mul : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_div : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_mod : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_land : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_lor : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_band : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_bor : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_bxor : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_ssl : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_ssr : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_usl : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_usr : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_seq : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_peq : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_sneq : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_pneq : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_gte : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_gt : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_lte : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_lt : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture
val fresh_bin_rfa : ?loc:((loc, 'a) fixture) -> (bin, 'a) fixture

(** {3 Patterns} *)

val fresh_patt_ground : ?loc:((loc, 'a) fixture) -> (patt, 'a) fixture
val fresh_patt_bool : ?loc:((loc, 'a) fixture) -> ?value:((bool, 'a) fixture) -> (patt, 'a) fixture
val fresh_patt_int : ?loc:((loc, 'a) fixture) -> ?lexeme:((string, 'a) fixture) -> (patt, 'a) fixture
val fresh_patt_var : ?loc:((loc, 'a) fixture) -> ?lexeme:((string, 'a) fixture) -> (patt, 'a) fixture
val fresh_patt_fun : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?params:((param list, 'a) fixture) -> (patt, 'a) fixture

(** {4 Parameters} *)

val fresh_param : ?loc:((loc, 'a) fixture) -> ?patt:((patt, 'a) fixture) -> ?ty:((ty option, 'a) fixture) -> (param, 'a) fixture

(** {3 Expressions} *)

val fresh_expr_bool : ?loc:((loc, 'a) fixture) -> ?value:((bool, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_int : ?loc:((loc, 'a) fixture) -> ?lexeme:((string, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_id : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_un : ?loc:((loc, 'a) fixture) -> ?op:((un, 'a) fixture) -> ?operand:((expr, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_bin : ?loc:((loc, 'a) fixture) -> ?op:((bin, 'a) fixture) -> ?lhs:((expr, 'a) fixture) -> ?rhs:((expr, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_cond : ?loc:((loc, 'a) fixture) -> ?cond:((expr, 'a) fixture) -> ?tru:((expr, 'a) fixture) -> ?fls:((expr, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_let : ?loc:((loc, 'a) fixture) -> ?recur:((bool, 'a) fixture) -> ?bindings:((binding list, 'a) fixture) -> ?scope:((expr, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_abs : ?loc:((loc, 'a) fixture) -> ?params:(param list) -> ?ret:((ty option, 'a) fixture) -> ?body:((expr, 'a) fixture) -> (expr, 'a) fixture
val fresh_expr_app : ?loc:((loc, 'a) fixture) -> ?fn:((expr, 'a) fixture) -> ?args:((expr list, 'a) fixture) -> (expr, 'a) fixture

(** {4 Bindings} *)

val fresh_binding : ?loc:((loc, 'a) fixture) -> ?patt:((patt, 'a) fixture) -> ?ty:((ty option, 'a) fixture) -> ?value:expr -> (binding, 'a) fixture

(** {3 Package Statements} *)

val fresh_pkg_library : ?loc:((loc, 'a) fixture) -> ?id:((name, 'a) fixture) -> (pkg_stmt, 'a) fixture
val fresh_pkg_executable : ?loc:((loc, 'a) fixture) -> ?id:((name, 'a) fixture) -> (pkg_stmt, 'a) fixture

(** {3 Imports} *)

val fresh_path : ?loc:((loc, 'a) fixture) -> ?path:((string, 'a) fixture) -> (path, 'a) fixture
val fresh_alias : ?loc:((loc, 'a) fixture) -> ?local:((name, 'a) fixture) -> ?path:((path, 'a) fixture) -> (alias, 'a) fixture
val fresh_pkgs : ?loc:((loc, 'a) fixture) -> ?aliases:((alias list, 'a) fixture) -> (pkgs, 'a) fixture
val fresh_import : ?loc:((loc, 'a) fixture) -> ?pkgs:((pkgs, 'a) fixture) -> (import, 'a) fixture

(** {3 Top-Level Bindings} *)

val fresh_top_ty : ?loc:((loc, 'a) fixture) -> ?local:((bool, 'a) fixture) -> ?bindings:((ty_binding list, 'a) fixture) -> (top, 'a) fixture
val fresh_top_val : ?loc:((loc, 'a) fixture) -> ?binding:((binding, 'a) fixture) -> (top, 'a) fixture
val fresh_top_def : ?loc:((loc, 'a) fixture) -> ?binding:((binding, 'a) fixture) -> (top, 'a) fixture
val fresh_top_let : ?loc:((loc, 'a) fixture) -> ?recur:((bool, 'a) fixture) -> ?bindings:((binding list, 'a) fixture) -> (top, 'a) fixture
val fresh_top_mod : ?loc:((loc, 'a) fixture) -> ?name:((name, 'a) fixture) -> ?params:((mod_param list, 'a) fixture) -> ?elems:((top list, 'a) fixture) -> (top, 'a) fixture

(** {3 Files} *)

val fresh_file : ?loc:((loc, 'a) fixture) -> ?pkg:((pkg, 'a) fixture) -> ?imports:((import list, 'a) fixture) -> ?tops:((top list, 'a) fixture) -> (file, 'a) fixture

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
