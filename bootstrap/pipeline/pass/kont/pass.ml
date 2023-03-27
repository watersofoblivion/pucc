(* Pass *)

let kont_file env file = match file with
  | Mono.File -> (env, Cps.file)
