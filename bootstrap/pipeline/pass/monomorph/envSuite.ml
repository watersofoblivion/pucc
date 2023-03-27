(* Environment *)

open OUnit2

(* Constructor *)

let test_env _ =
  let env = Monomorph.env in
  ()

let suite_constr =
  "Constructors" >:: test_env

(* Suite *)

let suite =
  "Environment" >::: [
    suite_constr;
  ]
