(* Location Tracking Tests *)

open OUnit2

(* Positions *)

(* Fixtures *)

let pos_seq = Core.seq Fun.id

let fresh_pos ?line:(line = Core.gen pos_seq) ?col:(col = Core.gen pos_seq) ?off:(off = Core.gen pos_seq) _ =
  Core.pos line col off

(* Assertions *)

let assert_pos_equal ~ctxt expected actual =
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Line numbers are not equal" expected.Core.line actual.Core.line;
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Column offsets are not equal" expected.Core.col actual.Core.col;
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Byte offsets are not equal" expected.Core.off actual.Core.off

(* Locations *)

(* Fixtures *)

let fresh_loc ?start:(start = fresh_pos ()) ?stop:(stop = fresh_pos ()) _ =
  Core.loc start stop

(* Assertions *)

let assert_loc_equal ~ctxt expected actual =
  assert_pos_equal ~ctxt expected.Core.start actual.Core.start;
  assert_pos_equal ~ctxt expected.Core.stop actual.Core.stop