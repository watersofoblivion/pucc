(* Abstract Syntax *)

open Format

open OUnit2

(* Fixtures *)

let fresh_pkg_library ?id:(id = Core.gensym ()) _ =
  Annot.pkg_library id

let fresh_pkg_executable ?id:(id = Core.gensym ()) _ =
  Annot.pkg_executable id

let fresh_file ?pkg:(pkg = fresh_pkg_library ()) _ =
  Annot.file pkg

(* Assertions *)

(* Equality *)

let string_of_pkg = function
  | Annot.Library _ -> "library"
  | Annot.Executable _ -> "executable"

let fail_pkg_constr expected actual =
  actual
    |> string_of_pkg
    |> sprintf "Expected constructor '%s', got '%s'" expected
    |> assert_failure
  
let assert_pkg_equal ~ctxt expected actual = match (expected, actual) with
  | Annot.Library expected, Annot.Library actual -> CoreTest.assert_sym_equal ~ctxt expected.id actual.id
  | Annot.Executable expected, Annot.Executable actual -> CoreTest.assert_sym_equal ~ctxt expected.id actual.id
  | expected, actual -> fail_pkg_constr (string_of_pkg expected) actual

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Annot.File expected, Annot.File actual ->
    assert_pkg_equal ~ctxt expected.pkg actual.pkg