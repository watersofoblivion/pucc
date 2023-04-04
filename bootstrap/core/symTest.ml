(* Symbol Tests *)

open Format

open OUnit2

(* Assertions *)

let assert_sym_equal ~ctxt expected actual =
  let assert_name_equal ~ctxt expected actual =
    assert_equal ~ctxt ~msg:"Names are not equal" ~printer:Fun.id expected actual
  in
  UtilTest.assert_optional_equal ~ctxt "name" assert_name_equal expected.Core.name actual.Core.name;
  assert_equal ~ctxt ~msg:"Indexes are not equal" ~printer:string_of_int expected.Core.idx actual.Core.idx