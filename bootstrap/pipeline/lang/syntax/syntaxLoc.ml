(* Location Tracking *)

(* Workspaces *)

type ws = Fpath.t

let ws root kontinue =
  kontinue root

(** Packages *)

type pkg = {
  ws: ws;
  path: Fpath.t;
}

let pkg ws path kontinue =
  { ws; path; }
    |> kontinue

(* Positions *)

type pos = {
  line: int;
  col:  int;
  off:  int;
}

let pos line col off kontinue =
  { line; col; off }
    |> kontinue
let lexing_position pos kontinue =
  { line = pos.Lexing.pos_lnum;
    col  = pos.pos_cnum - pos.pos_bol;
    off  = pos.pos_cnum }
    |> kontinue

exception PositionMismatch of { expected: pos; actual: pos; line: bool; col: bool; off: bool; }

let position_mismatch expected actual ?line:(line = true) ?col:(col = true) ?off:(off = true) kontinue =
  PositionMismatch { expected; actual; line; col; off; }
    |> kontinue

let require_pos_equal expected actual kontinue =
  let line = expected.line = actual.line in
  let col = expected.col = actual.col in
  let off = expected.off = actual.off in
  if line && col && off
  then kontinue actual
  else position_mismatch expected actual ~line ~col ~off raise
  
(* Locations *)

type loc = {
  start: pos;
  stop:  pos;
}

let loc start stop kontinue =
  { start; stop; }
    |> kontinue
let span start stop kontinue =
  loc start.start stop.stop kontinue

let dummy =
  pos 0 0 0 (fun start ->
    pos 0 0 0 (fun stop ->
      loc start stop Fun.id))
  

exception LocationMismatch of { expected: loc; actual: loc; start: exn option; stop: exn option; }

let location_mismatch expected actual ?start:(start = None) ?stop:(stop = None) kontinue =
  LocationMismatch { expected; actual; start; stop; }
    |> kontinue

let require_loc_equal expected actual kontinue =
  let try_pos_equal expected actual = 
    try require_pos_equal expected actual (fun _ -> None)
    with exn -> Some exn
  in
  let start = try_pos_equal expected.start actual.start in
  let stop = try_pos_equal expected.stop actual.stop in
  match (start, stop) with
    | None, None -> kontinue actual
    | _ -> location_mismatch expected actual ~start ~stop raise
