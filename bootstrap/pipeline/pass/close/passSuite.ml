open OUnit2

(* Pass *)

let test_close_file ctxt =
  let env = CloseTest.fresh_env () in
  let expected = CloTest.fresh_file () in
  let (_, actual) =
    ()
      |> CpsTest.fresh_file
      |> Close.close_file env
  in
  CloTest.assert_file_equal ~ctxt expected actual

let suite_close_file =
  "Files" >:: test_close_file

(* Suite *)

let suite =
  "Pass" >::: [
    suite_close_file;
  ]
