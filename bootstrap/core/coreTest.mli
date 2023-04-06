(**
 * {1 Core Testing}
 *
 * Functions for working with core types in tests.  
 *)

open OUnit2

(**
 * {2 Helpers}
 *)

type ('a, 'b) kont = Core.seq -> 'a -> 'b
type ('a, 'b) fixture = Core.seq -> ('a, 'b) kont -> 'b

val fresh : ?value:'a -> ('a, 'b) fixture -> ('a, 'b) fixture
val fresh_int : ?value:int -> (int, 'a) fixture
val fresh_string : ?value:string -> (string, 'a) fixture

(**
 * {2 General-Purpose Assertions}
 *)

val assert_bool_equal : ctxt:test_ctxt -> ?msg:string -> bool -> bool -> unit
val assert_int_equal : ctxt:test_ctxt -> ?msg:string -> int -> int -> unit

val assert_optional_equal : ctxt:test_ctxt -> string -> (ctxt:test_ctxt -> 'a -> 'a -> unit) -> 'a option -> 'a option -> unit

val assert_list_equal : ctxt:test_ctxt -> (ctxt:test_ctxt -> 'a -> 'a -> unit) -> 'a list -> 'a list -> unit

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
