(* Location Tracking *)

open OUnit2

open Syntax

open CoreTest

(* Fixtures *)

(* Positions *)

let fresh_pos ?pos ?line ?col ?off =
  let fresh_pos seq kontinue =
    fresh_int ?value:line seq (fun seq line ->
      fresh_int ?value:col seq (fun seq col ->
        fresh_int ?value:off seq (fun seq off ->
          Syntax.pos line col off (fun pos ->
            kontinue seq pos))))
  in 
  fresh ?value:pos fresh_pos

(* let pos_or ?line ?col ?off = given_or (fresh_pos ?line ?col ?off) *)

(* Locations *)

let fresh_loc ?loc ?start ?stop =
  let fresh_loc seq kontinue =
    fresh_pos ?pos:start seq (fun seq start ->
      fresh_pos ?pos:stop seq (fun seq stop ->
        Syntax.loc start stop (fun loc ->
          kontinue seq loc)))
  in
  fresh ?value:loc fresh_loc

(* Assertions *)

let assert_pos_equal ~ctxt expected actual =
  assert_int_equal ~ctxt ~msg:"Line numbers are not equal" expected.line actual.line;
  assert_int_equal ~ctxt ~msg:"Column offsets are not equal" expected.col actual.col;
  assert_int_equal ~ctxt ~msg:"Byte offsets are not equal" expected.off actual.off

let assert_loc_equal ~ctxt expected actual =
  assert_pos_equal ~ctxt expected.start actual.start;
  assert_pos_equal ~ctxt expected.stop actual.stop