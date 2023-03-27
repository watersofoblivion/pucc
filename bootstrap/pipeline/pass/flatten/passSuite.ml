open OUnit2

(* Pass *)

let test_flatten_file ctxt =
  let env = FlattenTest.fresh_env () in
  let expected = SsaTest.fresh_file () in
  let (_, actual) =
    ()
      |> CloTest.fresh_file
      |> Flatten.flatten_file env
  in
  SsaTest.assert_file_equal ~ctxt expected actual

let suite_flatten_file =
  "Files" >:: test_flatten_file

(* Suite *)

let suite =
  "Pass" >::: [
    suite_flatten_file;
  ]
