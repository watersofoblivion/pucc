(* Pass *)

let close_file env file = match file with
  | Cps.File -> (env, Clo.file)
