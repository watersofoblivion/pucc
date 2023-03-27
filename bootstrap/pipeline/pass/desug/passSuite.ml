(* Pass *)

open OUnit2

(* Package Statements *)

let test_desug_pkg_library ctxt =
  let env = DesugTest.fresh_env () in
  let id = Core.gensym () in
  let expected = AnnotTest.fresh_pkg_library ~id () in

  let name = SyntaxTest.fresh_name ~id () in
  let (_, actual) =
    ()
      |> SyntaxTest.fresh_pkg_library ~id:name
      |> Desug.desug_pkg env
  in
  AnnotTest.assert_pkg_equal ~ctxt expected actual

let test_desug_pkg_executable ctxt =
  let env = DesugTest.fresh_env () in
  let id = Core.gensym () in
  let expected = AnnotTest.fresh_pkg_executable ~id () in

  let name = SyntaxTest.fresh_name ~id () in
  let (_, actual) =
    ()
      |> SyntaxTest.fresh_pkg_executable ~id:name
      |> Desug.desug_pkg env
  in
  AnnotTest.assert_pkg_equal ~ctxt expected actual

let suite_desug_pkg =
  "Package Statements" >::: [
    "Library"    >:: test_desug_pkg_library;
    "Executable" >:: test_desug_pkg_executable;
  ]

(* Files *)

let test_desug_fileset ctxt =
  let env = DesugTest.fresh_env () in
  let id = Core.gensym () in
  let pkg =
    let name = SyntaxTest.fresh_name ~id () in
    SyntaxTest.fresh_pkg_executable ~id:name ()
  in
  let file = SyntaxTest.fresh_file ~pkg () in
  let file' = SyntaxTest.fresh_file ~pkg () in
  let expected =
    let pkg = AnnotTest.fresh_pkg_executable ~id () in
    AnnotTest.fresh_file ~pkg ()
  in
  let (_, actual) = Desug.desug_fileset env [file; file'] in
  AnnotTest.assert_file_equal ~ctxt expected actual

let assert_desug_fileset_mismatched_packages file file' exn =
  let env = DesugTest.fresh_env () in
  assert_raises exn (fun _ -> Desug.desug_fileset env [file; file'])

let test_desug_fileset_mismatched_package ctxt =
  let id = Core.gensym ~name:"one" () in
  let name = SyntaxTest.fresh_name ~id () in
  let pkg = SyntaxTest.fresh_pkg_library ~id:name () in
  let file = SyntaxTest.fresh_file ~pkg () in

  let id' = Core.gensym ~name:"two" () in
  let name' = SyntaxTest.fresh_name ~id:id' () in
  let pkg' = SyntaxTest.fresh_pkg_executable ~id:name' () in
  let file' = SyntaxTest.fresh_file ~pkg:pkg' () in

  let exn =
    let env = DesugTest.fresh_env () in
    let (_, expected) = Desug.desug_pkg env pkg in
    let (_, actual) = Desug.desug_pkg env pkg' in
    let exn = Core.symbol_mismatch id id' ~name:false ~idx:false () in
    Desug.package_mismatch expected actual false (Some exn)
  in
  assert_desug_fileset_mismatched_packages file file' exn
  
let test_desug_fileset_mismatched_package_name ctxt =
  let id = Core.gensym ~name:"one" () in
  let name = SyntaxTest.fresh_name ~id () in
  let pkg = SyntaxTest.fresh_pkg_library ~id:name () in
  let file = SyntaxTest.fresh_file ~pkg () in

  let id' = Core.gensym ~name:"two" () in
  let name' = SyntaxTest.fresh_name ~id:id' () in
  let pkg' = SyntaxTest.fresh_pkg_library ~id:name' () in
  let file' = SyntaxTest.fresh_file ~pkg:pkg' () in

  let exn =
    let env = DesugTest.fresh_env () in
    let (_, expected) = Desug.desug_pkg env pkg in
    let (_, actual) = Desug.desug_pkg env pkg' in
    let exn = Core.symbol_mismatch id id' ~name:false ~idx:false () in
    Desug.package_mismatch expected actual true (Some exn)
  in
  assert_desug_fileset_mismatched_packages file file' exn

let test_desug_fileset_mismatched_package_type ctxt =
  let id = Core.gensym () in
  let name = SyntaxTest.fresh_name ~id () in

  let pkg = SyntaxTest.fresh_pkg_library ~id:name () in
  let file = SyntaxTest.fresh_file ~pkg () in

  let pkg' = SyntaxTest.fresh_pkg_executable ~id:name () in
  let file' = SyntaxTest.fresh_file ~pkg:pkg' () in

  let exn =
    let env = DesugTest.fresh_env () in
    let (_, expected) = Desug.desug_pkg env pkg in
    let (_, actual) = Desug.desug_pkg env pkg' in
    Desug.package_mismatch expected actual false None
  in
  assert_desug_fileset_mismatched_packages file file' exn

let test_desug_fileset_no_input_files ctxt =
  let env = DesugTest.fresh_env () in
  let exn = Desug.no_input_files in
  assert_raises exn (fun _ -> Desug.desug_fileset env [])

let suite_desug_fileset =
  "Files" >::: [
    "Success" >:: test_desug_fileset;
    "Failure" >::: [
      "Mismatched Packages" >::: [
        "Name" >:: test_desug_fileset_mismatched_package_name;
        "Type" >:: test_desug_fileset_mismatched_package_type;
        "Both" >:: test_desug_fileset_mismatched_package;
      ];
      "No Input Files" >:: test_desug_fileset_no_input_files;
    ];
  ]

(* Suite *)

let suite =
  "Pass" >::: [
    suite_desug_pkg;
    suite_desug_fileset;
  ]
