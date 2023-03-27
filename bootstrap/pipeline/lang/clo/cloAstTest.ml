(* Closure-Passing Style *)

open Format

open OUnit2

(* Fixtures *)

let fresh_file _ =
  Clo.file

(* Assertions *)

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Clo.File, Clo.File -> let _ = ctxt in ()