(* Symbol Tests *)

open Format

open OUnit2

let assert_optional_equal ~ctxt id assert_equal expected actual = match (expected, actual) with
  | Some expected, Some actual -> assert_equal ~ctxt expected actual
  | None, None -> ()
  | Some _, None ->
    id
      |> sprintf "Expected %s to be present"
      |> assert_failure
  | None, Some _ ->
    id
      |> sprintf "Unexpected %s present"
      |> assert_failure

(* Assertions *)

let assert_sym_equal ~ctxt expected actual =
  let assert_name_equal ~ctxt expected actual =
    assert_equal ~ctxt ~msg:"Names are not equal" ~printer:Fun.id expected actual
  in
  assert_optional_equal ~ctxt "name" assert_name_equal expected.Core.name actual.Core.name;
  assert_equal ~ctxt ~msg:"Indexes are not equal" ~printer:string_of_int expected.Core.idx actual.Core.idx