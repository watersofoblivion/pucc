(* Static Single-Assignment Form *)

open Format

open OUnit2

(* Fixtures *)

let fresh_file _ =
  Ssa.file

(* Assertions *)

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Ssa.File, Ssa.File -> let _ = ctxt in ()
