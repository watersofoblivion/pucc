(**
 * {1 Static Single-Assignment Form Testing}
 *
 * Functions for testing the static single-assignment form.
 *)

open OUnit2

(** {2 Fixtures} *)

val fresh_file : unit -> Ssa.file
(**
 * Construct a fresh file
 *
 * @return A fresh file
 *)

(** {2 Assertions} *)
 
val assert_file_equal : ctxt:test_ctxt -> Ssa.file -> Ssa.file -> unit
(**
 * Assert the the two files are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected file
 * @param actual The actual file
 * @throws Failure Throws is the files are not equal
 *)
 