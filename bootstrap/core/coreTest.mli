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
 * {2 Location Tracking}
 *)

(**
 * {3 Positions}
 *)

(**
 * {4 Fixtures}
 *)

val fresh_pos : ?line:int -> ?col:int -> ?off:int -> unit -> Core.pos
(**
 * Construct a fresh position.  Any values that are not given will be
 * automatically generated.
 *
 * @param ?line The line number of the position
 * @param ?col The column number of the position
 * @param ?off The byte offset of the position
 * @param _ A dummy parameter if none of the optional values are given
 * @return A fresh position
 *)

(**
 * {4 Assertions}
 *)

val assert_pos_equal : ctxt:test_ctxt -> Core.pos -> Core.pos -> unit
(**
 * Assert that two positions are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected position
 * @param actual The actual position
 *)

(**
 * {3 Locations}
 *)

(**
 * {4 Fixtures}
 *)

val fresh_loc : ?start:Core.pos -> ?stop:Core.pos -> unit -> Core.loc
(**
 * Construct a fresh location.  Any values that are not given will be
 * automatically generated.
 *
 * @param ?start The starting position of the location
 * @param ?stop The ending position of the location
 * @param _ A dummy parameter if none of the optional values are given
 * @return A fresh location
 *)

(**
 * {4 Assertions}
 *)

val assert_loc_equal : ctxt:test_ctxt -> Core.loc -> Core.loc -> unit
(**
 * Assert that two locations are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected location
 * @param actual The actual location
 *)

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
