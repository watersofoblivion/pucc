(* Pass *)

let flatten_file env file = match file with
  | Clo.File -> (env, Ssa.file)
