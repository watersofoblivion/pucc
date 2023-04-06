(* Sequences *)

type seq = int

let seq = 0
let gen seq kontinue = kontinue (seq + 1) seq
