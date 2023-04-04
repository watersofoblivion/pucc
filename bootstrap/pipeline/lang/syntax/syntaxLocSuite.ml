open OUnit2

open CoreTest
open SyntaxTest

(* Positions *)

(* Constructors *)

let test_pos ctxt =
  let expected_line = 1 in
  let expected_col = 2 in
  let expected_off = 3 in

  let actual = Syntax.pos expected_line expected_col expected_off in

  assert_equal ~ctxt ~msg:"Line numbers are not equal" ~printer:string_of_int expected_line actual.Syntax.line;
  assert_equal ~ctxt ~msg:"Column offsets are not equal" ~printer:string_of_int expected_col actual.Syntax.col;
  assert_equal ~ctxt ~msg:"Byte offsets are not equal" ~printer:string_of_int expected_off actual.Syntax.off

let test_lexing_position ctxt =
  let expected = Syntax.pos 1 2 4 in
  { Lexing.pos_fname = "filename";
    Lexing.pos_lnum = 1;
    Lexing.pos_bol = 2;
    Lexing.pos_cnum = 4; }
    |> Syntax.lexing_position
    |> assert_pos_equal ~ctxt expected


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

  let expected = fresh_pos ~line ~col ~off () in
  let actual = fresh_pos ~line ~col ~off () in

  try Syntax.require_pos_equal expected actual
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

  let expected = fresh_pos ~line ~col ~off () in
  let actual = fresh_pos ~line:line' ~col ~off () in

  let exn = Syntax.position_mismatch expected actual ~line:false () in
  assert_raises exn (fun _ -> Syntax.require_pos_equal expected actual)

let test_require_pos_equal_mismatch_col ctxt =
  let line = 1 in
  let col = 2 in
  let col' = 3 in
  let off = 4 in

  let expected = fresh_pos ~line ~col ~off () in
  let actual = fresh_pos ~line ~col:col' ~off () in

  let exn = Syntax.position_mismatch expected actual ~col:false () in
  assert_raises exn (fun _ -> Syntax.require_pos_equal expected actual)

let test_require_pos_equal_mismatch_off ctxt =
  let line = 1 in
  let col = 2 in
  let off = 3 in
  let off' = 4 in

  let expected = fresh_pos ~line ~col ~off () in
  let actual = fresh_pos ~line ~col ~off:off' () in

  let exn = Syntax.position_mismatch expected actual ~off:false () in
  assert_raises exn (fun _ -> Syntax.require_pos_equal expected actual)

let test_require_pos_equal_mismatch ctxt =
  let expected = fresh_pos () in
  let actual = fresh_pos () in

  let exn = Syntax.position_mismatch expected actual ~line:false ~col:false ~off:false () in
  assert_raises exn (fun _ -> Syntax.require_pos_equal expected actual)

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
  let expected_start = fresh_pos () in
  let expected_stop = fresh_pos () in

  let actual = Syntax.loc expected_start expected_stop in

  assert_pos_equal ~ctxt expected_start actual.Syntax.start;
  assert_pos_equal ~ctxt expected_stop actual.Syntax.stop

let test_span ctxt =
  let expected_start = fresh_pos () in
  let expected_stop = fresh_pos () in

  let actual =
    let start = fresh_loc ~start:expected_start () in
    let stop = fresh_loc ~stop:expected_stop () in
    Syntax.span start stop
  in

  assert_pos_equal ~ctxt expected_start actual.Syntax.start;
  assert_pos_equal ~ctxt expected_stop actual.Syntax.stop

let suite_loc_constr =
  "Constructors" >::: [
    "Positions" >:: test_loc;
    "Span"      >:: test_span;
  ]

(* Operations *)

(* Equality *)

let test_require_loc_equal ctxt =
  let start = fresh_pos () in
  let stop = fresh_pos () in

  let expected = fresh_loc ~start ~stop () in
  let actual = fresh_loc ~start ~stop () in
  
  try Syntax.require_loc_equal expected actual
  with exn ->
    exn
      |> Printexc.to_string
      |> Format.sprintf "Unexpected exception: %s"
      |> assert_failure

let test_require_loc_equal_pos_mismatch_start ctxt =
  let stop = fresh_pos () in

  let start = fresh_pos () in
  let expected = fresh_loc ~start ~stop () in

  let start' = fresh_pos () in
  let actual = fresh_loc ~start:start' ~stop () in

  let exn =
    let start = Syntax.position_mismatch start start' ~line:false ~col:false ~off:false () in
    Syntax.location_mismatch expected actual ~start:(Some start) ()
  in
  assert_raises exn (fun _ -> Syntax.require_loc_equal expected actual)

let test_require_loc_equal_pos_mismatch_stop ctxt =
  let start = fresh_pos () in

  let stop = fresh_pos () in
  let expected = fresh_loc ~start ~stop () in

  let stop' = fresh_pos () in
  let actual = fresh_loc ~start ~stop:stop' () in

  let exn =
    let stop = Syntax.position_mismatch stop stop' ~line:false ~col:false ~off:false () in
    Syntax.location_mismatch expected actual ~stop:(Some stop) ()
  in
  assert_raises exn (fun _ -> Syntax.require_loc_equal expected actual)

let test_require_loc_equal_mismatch ctxt =
  let start = fresh_pos () in
  let stop = fresh_pos () in
  let expected = fresh_loc ~start ~stop () in

  let start' = fresh_pos () in
  let stop' = fresh_pos () in
  let actual = fresh_loc ~start:start' ~stop:stop' () in

  let exn =
    let start = Syntax.position_mismatch start start' ~line:false ~col:false ~off:false () in
    let stop = Syntax.position_mismatch stop stop' ~line:false ~col:false ~off:false () in
    Syntax.location_mismatch expected actual ~start:(Some start) ~stop:(Some stop) ()
  in
  assert_raises exn (fun _ -> Syntax.require_loc_equal expected actual)
    
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
