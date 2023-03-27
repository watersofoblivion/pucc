(* Abstract Syntax *)

open Format

open OUnit2

(* Constructors *)

let test_pkg_library ctxt =
  let id = Core.gensym () in
  match Annot.pkg_library id with
    | Annot.Library pkg -> CoreTest.assert_sym_equal ~ctxt id pkg.id
    | actual -> AnnotTest.fail_pkg_constr "library" actual

let test_pkg_executable ctxt =
  let id = Core.gensym () in
  match Annot.pkg_executable id with
    | Annot.Executable pkg -> CoreTest.assert_sym_equal ~ctxt id pkg.id
    | actual -> AnnotTest.fail_pkg_constr "executable" actual

let suite_constr_pkg = 
  "Packages" >::: [
    "Library"    >:: test_pkg_library;
    "Executable" >:: test_pkg_executable;
  ]

let test_file ctxt =
  let pkg = AnnotTest.fresh_pkg_executable () in
  match Annot.file pkg with
    | Annot.File file -> AnnotTest.assert_pkg_equal ~ctxt pkg file.pkg

let suite_constr_file =
  "Files" >:: test_file

let suite_constr =
  "Constructors" >::: [
    suite_constr_pkg;
    suite_constr_file;
  ]

(* Suite *)

let suite =
  "Abstract Syntax" >::: [
    suite_constr;
  ]
