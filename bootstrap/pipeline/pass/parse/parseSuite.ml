open OUnit2

(* Suite *)

let suite =
  "Parsing" >::: [
    ParseEnvSuite.suite;
  ]
