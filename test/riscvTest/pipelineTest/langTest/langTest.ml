open OUnit2

let suite =
  "Languages" >::: [
    SyntaxTest.suite;
    AsmTest.suite;
  ]
