(* Utilities *)

open Format

open OUnit2

(* Assertions *)

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

let assert_list_equal ~ctxt assert_equal expected actual =
  List.iter2 (assert_equal ~ctxt) expected actual

let fail_constr msg printer ~ctxt expected actual =
  let msg = sprintf "%s constructors do not match" msg in
  assert_equal ~ctxt ~cmp:(fun _ _ -> false) ~msg ~printer expected actual
      