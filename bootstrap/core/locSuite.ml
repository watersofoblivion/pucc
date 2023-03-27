open OUnit2

(* Positions *)

(* Constructors *)

let test_pos ctxt =
  let expected_line = 1 in
  let expected_col = 2 in
  let expected_off = 3 in

  let actual = Core.pos expected_line expected_col expected_off in

  assert_equal ~ctxt ~msg:"Line numbers are not equal" ~printer:string_of_int expected_line actual.Core.line;
  assert_equal ~ctxt ~msg:"Column offsets are not equal" ~printer:string_of_int expected_col actual.Core.col;
  assert_equal ~ctxt ~msg:"Byte offsets are not equal" ~printer:string_of_int expected_off actual.Core.off

let test_lexing_position ctxt =
  let expected = Core.pos 1 2 4 in
  { Lexing.pos_fname = "filename";
    Lexing.pos_lnum = 1;
    Lexing.pos_bol = 2;
    Lexing.pos_cnum = 4; }
    |> Core.lexing_position
    |> CoreTest.assert_pos_equal ~ctxt expected


let suite_pos_constr =
  "Constructors" >::: [
    "Offsets"         >:: test_pos;
    "Lexing Position" >:: test_lexing_position;
  ]

(* Operations *)

let test_require_pos_equal ctxt =
  let line = 1 in
  let col = 2 in
  let off = 3 in

  let expected = CoreTest.fresh_pos ~line ~col ~off () in
  let actual = CoreTest.fresh_pos ~line ~col ~off () in

  try Core.require_pos_equal expected actual
  with exn ->
    exn
      |> Printexc.to_string
      |> Format.sprintf "Unexpected exception: %s"
      |> assert_failure

let test_require_pos_equal_mismatch_line ctxt =
  let line = 1 in
  let line' = 2 in
  let col = 3 in
  let off = 4 in

  let expected = CoreTest.fresh_pos ~line ~col ~off () in
  let actual = CoreTest.fresh_pos ~line:line' ~col ~off () in

  let exn = Core.position_mismatch expected actual ~line:false () in
  assert_raises exn (fun _ -> Core.require_pos_equal expected actual)

let test_require_pos_equal_mismatch_col ctxt =
  let line = 1 in
  let col = 2 in
  let col' = 3 in
  let off = 4 in

  let expected = CoreTest.fresh_pos ~line ~col ~off () in
  let actual = CoreTest.fresh_pos ~line ~col:col' ~off () in

  let exn = Core.position_mismatch expected actual ~col:false () in
  assert_raises exn (fun _ -> Core.require_pos_equal expected actual)

let test_require_pos_equal_mismatch_off ctxt =
  let line = 1 in
  let col = 2 in
  let off = 3 in
  let off' = 4 in

  let expected = CoreTest.fresh_pos ~line ~col ~off () in
  let actual = CoreTest.fresh_pos ~line ~col ~off:off' () in

  let exn = Core.position_mismatch expected actual ~off:false () in
  assert_raises exn (fun _ -> Core.require_pos_equal expected actual)

let test_require_pos_equal_mismatch ctxt =
  let expected = CoreTest.fresh_pos () in
  let actual = CoreTest.fresh_pos () in

  let exn = Core.position_mismatch expected actual ~line:false ~col:false ~off:false () in
  assert_raises exn (fun _ -> Core.require_pos_equal expected actual)

let suite_pos_op_require_pos_equal =
  "Require Equality" >::: [
    "Equal" >:: test_require_pos_equal;
    "Mismatch" >::: [
      "Line Number"   >:: test_require_pos_equal_mismatch_line;
      "Column Offset" >:: test_require_pos_equal_mismatch_col;
      "Byte Offset"   >:: test_require_pos_equal_mismatch_off;
      "Multiple"      >:: test_require_pos_equal_mismatch;
    ];
  ]
  
(* Operations Suite *)

let suite_pos_op =
  "Operations" >::: [
    suite_pos_op_require_pos_equal;
  ]

(* Position Suite *)

let suite_pos =
  "Positions" >::: [
    suite_pos_constr;
    suite_pos_op;
  ]

(* Locations *)

(* Constructors *)

let test_loc ctxt =
  let expected_start = CoreTest.fresh_pos () in
  let expected_stop = CoreTest.fresh_pos () in

  let actual = Core.loc expected_start expected_stop in

  CoreTest.assert_pos_equal ~ctxt expected_start actual.Core.start;
  CoreTest.assert_pos_equal ~ctxt expected_stop actual.Core.stop

let test_span ctxt =
  let expected_start = CoreTest.fresh_pos () in
  let expected_stop = CoreTest.fresh_pos () in

  let actual =
    let start = CoreTest.fresh_loc ~start:expected_start () in
    let stop = CoreTest.fresh_loc ~stop:expected_stop () in
    Core.span start stop
  in

  CoreTest.assert_pos_equal ~ctxt expected_start actual.Core.start;
  CoreTest.assert_pos_equal ~ctxt expected_stop actual.Core.stop

let suite_loc_constr =
  "Constructors" >::: [
    "Positions" >:: test_loc;
    "Span"      >:: test_span;
  ]

(* Operations *)

(* Equality *)

let test_require_loc_equal ctxt =
  let start = CoreTest.fresh_pos () in
  let stop = CoreTest.fresh_pos () in

  let expected = CoreTest.fresh_loc ~start ~stop () in
  let actual = CoreTest.fresh_loc ~start ~stop () in
  
  try Core.require_loc_equal expected actual
  with exn ->
    exn
      |> Printexc.to_string
      |> Format.sprintf "Unexpected exception: %s"
      |> assert_failure

let test_require_loc_equal_pos_mismatch_start ctxt =
  let stop = CoreTest.fresh_pos () in

  let start = CoreTest.fresh_pos () in
  let expected = CoreTest.fresh_loc ~start ~stop () in

  let start' = CoreTest.fresh_pos () in
  let actual = CoreTest.fresh_loc ~start:start' ~stop () in

  let exn =
    let start = Core.position_mismatch start start' ~line:false ~col:false ~off:false () in
    Core.location_mismatch expected actual ~start:(Some start) ()
  in
  assert_raises exn (fun _ -> Core.require_loc_equal expected actual)

let test_require_loc_equal_pos_mismatch_stop ctxt =
  let start = CoreTest.fresh_pos () in

  let stop = CoreTest.fresh_pos () in
  let expected = CoreTest.fresh_loc ~start ~stop () in

  let stop' = CoreTest.fresh_pos () in
  let actual = CoreTest.fresh_loc ~start ~stop:stop' () in

  let exn =
    let stop = Core.position_mismatch stop stop' ~line:false ~col:false ~off:false () in
    Core.location_mismatch expected actual ~stop:(Some stop) ()
  in
  assert_raises exn (fun _ -> Core.require_loc_equal expected actual)

let test_require_loc_equal_mismatch ctxt =
  let start = CoreTest.fresh_pos () in
  let stop = CoreTest.fresh_pos () in
  let expected = CoreTest.fresh_loc ~start ~stop () in

  let start' = CoreTest.fresh_pos () in
  let stop' = CoreTest.fresh_pos () in
  let actual = CoreTest.fresh_loc ~start:start' ~stop:stop' () in

  let exn =
    let start = Core.position_mismatch start start' ~line:false ~col:false ~off:false () in
    let stop = Core.position_mismatch stop stop' ~line:false ~col:false ~off:false () in
    Core.location_mismatch expected actual ~start:(Some start) ~stop:(Some stop) ()
  in
  assert_raises exn (fun _ -> Core.require_loc_equal expected actual)
    
(* Equality Suite *)

let suite_loc_op_require_loc_equal =
  "Require Equality" >::: [
    "Equal"            >:: test_require_loc_equal;
    "Mismatch" >::: [
      "Positions" >::: [
        "Start" >:: test_require_loc_equal_pos_mismatch_start;
        "End"   >:: test_require_loc_equal_pos_mismatch_stop;
        "Both"  >:: test_require_loc_equal_mismatch;
      ];
    ];
  ]

(* Operations Suite *)

let suite_loc_ops =
  "Operations" >::: [
    suite_loc_op_require_loc_equal;
  ]

(* Location Suite *)

let suite_loc =
  "Locations" >::: [
    suite_loc_constr;
    suite_loc_ops;
  ]

(* Test Suite *)

let suite =
  "Location Tracking" >::: [
    suite_pos;
    suite_loc;
  ]
