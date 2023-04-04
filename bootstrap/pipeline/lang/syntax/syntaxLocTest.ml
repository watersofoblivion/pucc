(* Location Tracking *)

open OUnit2

(* Positions *)

(* Fixtures *)

let pos_seq = Core.seq Fun.id

let fresh_pos ?line:(line = Core.gen pos_seq) ?col:(col = Core.gen pos_seq) ?off:(off = Core.gen pos_seq) _ =
  Syntax.pos line col off

(* Assertions *)

let assert_pos_equal ~ctxt expected actual =
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Line numbers are not equal" expected.Syntax.line actual.Syntax.line;
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Column offsets are not equal" expected.Syntax.col actual.Syntax.col;
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Byte offsets are not equal" expected.Syntax.off actual.Syntax.off

(* Locations *)

(* Fixtures *)

let fresh_loc ?start:(start = fresh_pos ()) ?stop:(stop = fresh_pos ()) _ =
  Syntax.loc start stop

(* Assertions *)

let assert_loc_equal ~ctxt expected actual =
  assert_pos_equal ~ctxt expected.Syntax.start actual.Syntax.start;
  assert_pos_equal ~ctxt expected.Syntax.stop actual.Syntax.stop