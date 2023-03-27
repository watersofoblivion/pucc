(* Monomorphic Administrative Normal Form *)

open Format

open OUnit2

(* Fixtures *)

let fresh_file _ =
  Mono.file

(* Assertions *)

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Mono.File, Mono.File -> let _ = ctxt in ()