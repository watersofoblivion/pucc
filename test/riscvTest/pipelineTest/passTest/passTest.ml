open OUnit2

let suite =
  "Passes" >::: [
    ParseTest.suite;
    NormTest.suite;
    CheckTest.suite;
    CodegenTest.suite;
  ]
