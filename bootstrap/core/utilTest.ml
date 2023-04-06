(* Utilities *)

open Format

open OUnit2

(* Helpers *)

type ('a, 'b) kont = Core.seq -> 'a -> 'b
type ('a, 'b) fixture = Core.seq -> ('a, 'b) kont -> 'b

let fresh ?value fn seq kontinue = match value with
  | Some value -> kontinue seq value
  | None -> fn seq kontinue

let fresh_int ?value = fresh ?value Core.gen 
let fresh_string ?value =
  let gen seq kontinue =
    Core.gen seq (fun seq n ->
      n
        |> Format.sprintf "gensym%d"
        |> kontinue seq)
  in
  fresh ?value gen

(* Assertions *)

let assert_bool_equal ~ctxt ?msg expected actual =
  assert_equal ~ctxt ?msg ~printer:string_of_bool expected actual

let assert_int_equal ~ctxt ?msg expected actual =
  assert_equal ~ctxt ?msg ~printer:string_of_int expected actual

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

(* Failures *)

let fail_constr msg printer ~ctxt expected actual =
  let msg = sprintf "%s constructors do not match" msg in
  assert_equal ~ctxt ~cmp:(fun _ _ -> false) ~msg ~printer expected actual
      