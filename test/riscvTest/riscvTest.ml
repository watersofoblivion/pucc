open OUnit2

let suite =
  "RISC-V" >::: [
    PipelineTest.suite;
  ]
