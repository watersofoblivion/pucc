(* Pass *)

let norm_pkg env pkg = match pkg with
  | Annot.Library pkg -> Ir.pkg_library pkg.id
  | Annot.Executable pkg -> Ir.pkg_executable pkg.id

let norm_file env file = match file with
  | Annot.File file ->
    let pkg = norm_pkg env file.pkg in
    (env, Ir.file pkg)
