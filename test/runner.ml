open OUnit2

let suite =
  "Hdub" >::: [
    RiscvTest.suite
  ]

let _ =
  run_test_tt_main suite
