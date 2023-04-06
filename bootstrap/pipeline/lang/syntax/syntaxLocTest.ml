(* Location Tracking *)

open OUnit2

open CoreTest

(* Fixtures *)

(* Positions *)

let fresh_pos ?pos ?line ?col ?off seq kontinue =
  let fresh_pos seq kontinue =
    fresh_int ?value:line seq (fun seq line ->
      fresh_int ?value:col seq (fun seq col ->
        fresh_int ?value:off seq (fun seq off ->
          Syntax.pos line col off (fun pos ->
            kontinue seq pos))))
  in 
  fresh ?pos fresh_pos seq kontinue

(* let pos_or ?line ?col ?off = given_or (fresh_pos ?line ?col ?off) *)

(* Locations *)

let fresh_loc ?loc ?start ?stop seq kontinue =
  let fresh_loc seq kontinue =
    fresh_pos ?pos:start seq (fun seq start ->
      fresh_pos ?pos:stop seq (fun seq stop ->
        Syntax.loc start stop (fun loc ->
          kontinue seq loc)))
  in
  fresh ?loc fresh_loc seq kontinue

(* Assertions *)

let assert_pos_equal ~ctxt expected actual =
  assert_int_equal ~ctxt ~msg:"Line numbers are not equal" expected.Syntax.line actual.Syntax.line;
  assert_int_equal ~ctxt ~msg:"Column offsets are not equal" expected.Syntax.col actual.Syntax.col;
  assert_int_equal ~ctxt ~msg:"Byte offsets are not equal" expected.Syntax.off actual.Syntax.off

let assert_loc_equal ~ctxt expected actual =
  assert_pos_equal ~ctxt expected.Syntax.start actual.Syntax.start;
  assert_pos_equal ~ctxt expected.Syntax.stop actual.Syntax.stop