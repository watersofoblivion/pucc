(* Continuation-Passing Style *)

open Format

open OUnit2

(* Fixtures *)

let fresh_file _ =
  Cps.file

(* Assertions *)

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Cps.File, Cps.File -> let _ = ctxt in ()