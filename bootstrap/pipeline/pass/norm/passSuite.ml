(* Pass *)

open OUnit2

(* Package Statements *)

let test_norm_pkg_library ctxt =
  let env = NormTest.fresh_env () in
  let id = Core.gensym () in
  let expected = IrTest.fresh_pkg_library ~id () in
  ()
    |> AnnotTest.fresh_pkg_library ~id 
    |> Norm.norm_pkg env
    |> IrTest.assert_pkg_equal ~ctxt expected

let test_norm_pkg_executable ctxt =
  let env = NormTest.fresh_env () in
  let id = Core.gensym () in
  let expected = IrTest.fresh_pkg_executable ~id () in
  ()
    |> AnnotTest.fresh_pkg_executable ~id
    |> Norm.norm_pkg env
    |> IrTest.assert_pkg_equal ~ctxt expected

let suite_norm_pkg =
  "Package Statements" >::: [
    "Library"    >:: test_norm_pkg_library;
    "Executable" >:: test_norm_pkg_executable;
  ]

(* Files *)

let test_norm_file ctxt =
  let env = NormTest.fresh_env () in
  let pkg = AnnotTest.fresh_pkg_executable () in
  let expected =
    let pkg = Norm.norm_pkg env pkg in
    IrTest.fresh_file ~pkg ()
  in
  let (_, actual) =
    ()
      |> AnnotTest.fresh_file ~pkg
      |> Norm.norm_file env
  in
  IrTest.assert_file_equal ~ctxt expected actual

let suite_norm_file =
  "Files" >:: test_norm_file

(* Suite *)

let suite =
  "Pass" >::: [
    suite_norm_pkg;
    suite_norm_file;
  ]
