(* Pass *)

open OUnit2

(* Filesets *)

let test_monomorph_fileset ctxt =
  let env = MonomorphTest.fresh_env () in
  let file = IrTest.fresh_file () in
  let file' = IrTest.fresh_file () in
  let expected = MonoTest.fresh_file () in
  let (_, actual) = Monomorph.monomorph_fileset env [file; file'] in
  MonoTest.assert_file_equal ~ctxt expected actual

let suite_monomorph_fileset =
  "Filesets" >:: test_monomorph_fileset

(* Suite *)

let suite =
  "Pass" >::: [
    suite_monomorph_fileset;
  ]
