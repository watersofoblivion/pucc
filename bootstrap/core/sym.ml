(* Symbols *)

type sym = {
  name: string option;
  idx:  int;
}

let gensym seq ?name kontinue =
  Seq.gen seq (fun seq idx ->
    { name; idx }
      |> kontinue seq)

exception SymbolMismatch of { expected: sym; actual: sym; name: bool; idx: bool; }

let symbol_mismatch expected actual ?name:(name = true) ?idx:(idx = true) kontinue =
  SymbolMismatch { expected; actual; name; idx; }
    |> kontinue

let require_sym_equal expected actual kontinue =
  let name = match (expected.name, actual.name) with
    | None, None -> true
    | Some expected, Some actual when expected = actual -> true
    | _ -> false
  in
  let idx = expected.idx = actual.idx in
  if name && idx
  then kontinue actual
  else symbol_mismatch expected actual ~name ~idx raise
