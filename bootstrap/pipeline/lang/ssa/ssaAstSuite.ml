(* Abstract Syntax *)

open OUnit2

(* Constructors *)

let test_file ctxt =
  match Ssa.file with
    | Ssa.File -> ()

let suite_constr_file =
  "Files" >:: test_file

let suite_constr =
  "Constructors" >::: [
    suite_constr_file;
  ]

(* Suite *)

let suite =
  "Abstract Syntax" >::: [
    suite_constr;
  ]
