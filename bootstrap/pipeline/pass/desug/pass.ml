(* Pass *)

(* Exceptions *)

exception PackageMismatch of { expected: Annot.pkg; actual: Annot.pkg; ty: bool; id: exn option }
exception NoInputFiles

let package_mismatch expected actual ty id = PackageMismatch { expected; actual; ty; id; }
let no_input_files = NoInputFiles

(* Names *)

let desug_name env = function
  | Syntax.Name name ->
      (env, name.id)

(* Package Statements *)

let desug_pkg env = function
  | Syntax.Library pkg ->
      let (env, id) = desug_name env pkg.id in
      let pkg = Annot.pkg_library id in
      (env, pkg)
  | Syntax.Executable pkg ->
      let (env, id) = desug_name env pkg.id in
      let pkg = Annot.pkg_executable id in
      (env, pkg)

(* Files and Filesets *)

let annot_pkg_id = function
  | Annot.Library pkg -> pkg.id
  | Annot.Executable pkg -> pkg.id

let require_pkg_equal expected actual = 
  match expected with
    | None -> Some actual
    | (Some expected) as original ->
      let ty = match expected, actual with
        | Annot.Library _, Annot.Library _
        | Annot.Executable _, Annot.Executable _ -> true
        | _ -> false
      in
      let sym =
        let expected = annot_pkg_id expected in
        let actual = annot_pkg_id actual in
        try
          Core.require_sym_equal expected actual;
          None
        with exn -> Some exn
      in
      match (ty, sym) with
        | true, None -> original
        | _ ->
          package_mismatch expected actual ty sym
            |> raise


let desug_file env expected = function
  | Syntax.File file ->
      let (env, pkg) = desug_pkg env file.pkg in
      let expected = require_pkg_equal expected pkg in
      (env, expected, ())

let require_pkg = function
  | Some pkg -> pkg
  | None ->
      no_input_files
        |> raise

let rec desug_files env expected = function
  | [] -> (env, expected)
  | file :: files ->
      let (env, expected, _) = desug_file env expected file in
      desug_files env expected files

let desug_fileset env fileset =
  let (env, pkg) = desug_files env None fileset in
  let pkg = require_pkg pkg in
  let file = Annot.file pkg in
  (env, file)
