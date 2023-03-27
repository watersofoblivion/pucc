(* Pass *)

let monomorph_file env file = match file with
  | Ir.File _ -> (env, ())

let rec monomorph_fileset env files = match files with
  | [] -> (env, Mono.file)
  | file :: files ->
    let (env, _) = monomorph_file env file in
    monomorph_fileset env files
