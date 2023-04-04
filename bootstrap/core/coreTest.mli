(**
 * {1 Core Testing}
 *
 * Functions for working with core types in tests.  
 *)

open OUnit2

(**
 * {2 Assertions}
 *)

val assert_optional_equal : ctxt:test_ctxt -> string -> (ctxt:test_ctxt -> 'a -> 'a -> unit) -> 'a option -> 'a option -> unit

val fail_constr : string -> ('a -> string) -> ctxt:test_ctxt -> 'a -> 'a -> unit

(**
 * {2 Sequences}
 *)

(**
 * {3 Fixtures}
 *)

(**
 * {3 Assertions}
 *)

(**
 * {2 Symbols}
 *)

(**
 * {3 Fixtures}
 *)

(**
 * {3 Assertions}
 *)

val assert_sym_equal : ctxt:test_ctxt -> Core.sym -> Core.sym -> unit
(**
 * Assert that two symbols are equal
 *
 * @param ~ctxt The testing context
 * @param expected The expected symbol
 * @param actual The actual symbol
 *)
