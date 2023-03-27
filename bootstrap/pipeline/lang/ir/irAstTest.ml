(* Abstract Syntax *)

open Format

open OUnit2

(* Fixtures *)

let fresh_pkg_library ?id:(id = Core.gensym ()) _ =
  Ir.pkg_library id

let fresh_pkg_executable ?id:(id = Core.gensym ()) _ =
  Ir.pkg_executable id

let fresh_file ?pkg:(pkg = fresh_pkg_library ()) _ =
  Ir.file pkg

(* Assertions *)

(* Equality *)

let string_of_pkg = function
  | Ir.Library _ -> "library"
  | Ir.Executable _ -> "executable"

let fail_pkg_constr expected actual =
  actual
    |> string_of_pkg
    |> sprintf "Expected constructor '%s', got '%s'" expected
    |> assert_failure
  
let assert_pkg_equal ~ctxt expected actual = match (expected, actual) with
  | Ir.Library expected, Ir.Library actual -> CoreTest.assert_sym_equal ~ctxt expected.id actual.id
  | Ir.Executable expected, Ir.Executable actual -> CoreTest.assert_sym_equal ~ctxt expected.id actual.id
  | expected, actual -> fail_pkg_constr (string_of_pkg expected) actual

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Ir.File expected, Ir.File actual ->
    assert_pkg_equal ~ctxt expected.pkg actual.pkg