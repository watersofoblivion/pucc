open OUnit2

let suite =
  "Compilation Pipeline" >::: [
    LangTest.suite;
    PassTest.suite;
  ]
