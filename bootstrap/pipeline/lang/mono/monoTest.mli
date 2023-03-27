(**
 * {1 Monomorphic Administrative Normal Form Testing}
 *
 * Functions for testing the monomorphic administrative normal form.
 *)

open OUnit2

(** {2 Fixtures} *)

val fresh_file : unit -> Mono.file
(**
 * Construct a fresh file
 *
 * @return A fresh file
 *)

(** {2 Assertions} *)
 
val assert_file_equal : ctxt:test_ctxt -> Mono.file -> Mono.file -> unit
(**
 * Assert the the two files are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected file
 * @param actual The actual file
 * @throws Failure Throws is the files are not equal
 *)
 