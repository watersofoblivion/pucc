(* CPS Conversion *)

open OUnit2

(* Pass *)

let test_kont_file ctxt =
  let env = KontTest.fresh_env () in
  let expected = CpsTest.fresh_file () in
  let (_, actual) =
    ()
      |> MonoTest.fresh_file
      |> Kont.kont_file env
  in
  CpsTest.assert_file_equal ~ctxt expected actual

let suite_kont_file =
  "Files" >:: test_kont_file

(* Suite *)

let suite =
  "Pass" >::: [
    suite_kont_file;
  ]
