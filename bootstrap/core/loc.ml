(* Location Tracking *)

(* Positions *)

type pos = {
  line: int;
  col:  int;
  off:  int;
}

let pos line col off = { line; col; off }
let lexing_position pos = {
  line = pos.Lexing.pos_lnum;
  col  = pos.pos_cnum - pos.pos_bol;
  off  = pos.pos_cnum
}

exception PositionMismatch of { expected: pos; actual: pos; line: bool; col: bool; off: bool; }

let position_mismatch expected actual ?line:(line = true) ?col:(col = true) ?off:(off = true) _ =
  PositionMismatch { expected; actual; line; col; off; }

let require_pos_equal expected actual =
  let line = expected.line = actual.line in
  let col = expected.col = actual.col in
  let off = expected.off = actual.off in
  if line && col && off
  then ()
  else
    position_mismatch expected actual ~line ~col ~off ()
      |> raise
  

(* Locations *)

type loc = {
  start: pos;
  stop:  pos;
}

let loc start stop = { start; stop; }
let span start stop =
  loc start.start stop.stop

let dummy =
  let start = pos 0 0 0 in
  let stop = pos 0 0 0 in
  loc start stop

exception LocationMismatch of { expected: loc; actual: loc; start: exn option; stop: exn option; }

let location_mismatch expected actual ?start:(start = None) ?stop:(stop = None) _ =
  LocationMismatch { expected; actual; start; stop; }

let require_loc_equal expected actual =
  let try_pos_equal expected actual = 
    try
      require_pos_equal expected actual;
      None
    with exn -> Some exn
  in
  let start = try_pos_equal expected.start actual.start in
  let stop = try_pos_equal expected.stop actual.stop in
  match (start, stop) with
    | None, None -> ()
    | _ ->
      location_mismatch expected actual ~start ~stop ()
        |> raise
