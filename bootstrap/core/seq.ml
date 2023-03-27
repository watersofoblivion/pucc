(* Sequences *)

type 'a seq = {
  state: int ref;
  gen:   int -> 'a
}

let seq gen = { state = ref (-1); gen; }
let map_seq f seq =
  let gen n =
    n
      |> seq.gen
      |> f
  in
  { seq with gen = gen }
let gen seq =
  incr seq.state;
  seq.gen !(seq.state)

let seq_nat ?initial:(initial = 0) ?step:(step = 1) _ =
  let gen n = n * step + initial in
  seq gen
let seq_str ?prefix:(prefix = "") ?suffix:(suffix = "") _ =
  let gen n = Format.sprintf "%s%d%s" prefix n suffix in
  seq gen
