(* Symbols *)

type sym = {
  name: string option;
  idx:  int;
}

let default_seq = Seq.seq_nat ()

let gensym ?name ?seq:(seq = default_seq) _ =
  let idx = Seq.gen seq in
  let sym = { name; idx } in
  sym

exception SymbolMismatch of { expected: sym; actual: sym; name: bool; idx: bool; }

let symbol_mismatch expected actual ?name:(name = true) ?idx:(idx = true) _ =
  SymbolMismatch { expected; actual; name; idx; }

let require_sym_equal expected actual =
  let name = match (expected.name, actual.name) with
    | None, None -> true
    | Some expected, Some actual when expected = actual -> true
    | _ -> false
  in
  let idx = expected.idx = actual.idx in
  if name && idx
  then ()
  else 
    symbol_mismatch expected actual ~name ~idx ()
      |> raise
