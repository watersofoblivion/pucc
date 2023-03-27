(* Abstract Syntax *)

open Format

open OUnit2

(* Utilities *)

let assert_optional_equal ~ctxt id assert_equal expected actual = match (expected, actual) with
  | Some expected, Some actual -> assert_equal ~ctxt expected actual
  | None, None -> ()
  | Some _, None ->
    id
      |> sprintf "Expected %s to be present"
      |> assert_failure
  | None, Some _ ->
    id
      |> sprintf "Unexpected %s present"
      |> assert_failure

(* Fixtures *)

(* Names *)

let fresh_name ?loc:(loc = CoreTest.fresh_loc ()) ?id:(id = Core.gensym ()) _ =
  Syntax.name loc id

(* Package Statements *)

let fresh_pkg_library ?loc:(loc = CoreTest.fresh_loc ()) ?id:(id = fresh_name ()) _ =
  Syntax.pkg_library loc id

let fresh_pkg_executable ?loc:(loc = CoreTest.fresh_loc ()) ?id:(id = fresh_name ()) _ =
  Syntax.pkg_executable loc id

(* Imports *)

let path_seq = Core.seq_str ~prefix:"pkg/path-" ()

let fresh_path ?loc:(loc = CoreTest.fresh_loc ()) ?path:(path = Core.gen path_seq) _ =
  Syntax.path loc path

let fresh_alias ?loc:(loc = CoreTest.fresh_loc ()) ?local ?path:(path = fresh_path ()) _ =
  Syntax.alias loc local path

let fresh_pkgs ?loc:(loc = CoreTest.fresh_loc ()) ?aliases:(aliases = []) _ =
  Syntax.pkgs loc aliases

let fresh_import ?loc:(loc = CoreTest.fresh_loc ()) ?pkgs:(pkgs = fresh_pkgs ()) _ =
  Syntax.import loc pkgs

(* Files *)

let fresh_file ?pkg:(pkg = fresh_pkg_library ()) ?imports:(imports = []) _ =
  Syntax.file pkg imports

(* Location Stripping *)

(* Names *)

let deloc_name = function
  | Syntax.Name name -> Syntax.name Core.dummy name.id

(* Package Statements *)

let deloc_pkg = function
  | Syntax.Library pkg ->
      pkg.id
        |> deloc_name
        |> Syntax.pkg_library Core.dummy
  | Syntax.Executable pkg ->
      pkg.id
        |> deloc_name
        |> Syntax.pkg_executable Core.dummy

(* Imports *)

let deloc_path = function
  | Syntax.Path path -> Syntax.path Core.dummy path.path

let deloc_alias = function
  | Syntax.Alias alias ->
      let local = match alias.alias with None -> None | Some alias -> Some (deloc_name alias) in
      alias.path
        |> deloc_path
        |> Syntax.alias Core.dummy local

let deloc_pkgs = function
  | Syntax.Packages pkgs ->
    pkgs.aliases
      |> List.map deloc_alias
      |> Syntax.pkgs Core.dummy

let deloc_import = function
  | Syntax.Import import ->
    import.pkgs
      |> deloc_pkgs
      |> Syntax.import Core.dummy

(* Files *)

let deloc_file = function
  | Syntax.File file ->
    let pkg = deloc_pkg file.pkg in
    file.imports
      |> List.map deloc_import
      |> Syntax.file pkg

(* Assertions *)

(* Names *)

let assert_name_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.Name expected, Syntax.Name actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      CoreTest.assert_sym_equal ~ctxt expected.id actual.id

(* Package Statements *)

let assert_pkg_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.Library expected, Syntax.Library actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt expected.id actual.id
  | Syntax.Executable expected, Syntax.Executable actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt expected.id actual.id
  | _ -> assert_failure "Package statement constructors do not match"

(* Imports *)

let assert_path_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.Path expected, Syntax.Path actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Package paths are not equal" ~printer:Fun.id expected.path actual.path

let assert_alias_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.Alias expected, Syntax.Alias actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_optional_equal ~ctxt "local alias" assert_name_equal expected.alias actual.alias;
      assert_path_equal ~ctxt expected.path actual.path

let assert_pkgs_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.Packages expected, Syntax.Packages actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      List.iter2 (assert_alias_equal ~ctxt) expected.aliases actual.aliases

let assert_import_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.Import expected, Syntax.Import actual ->
      CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_pkgs_equal ~ctxt expected.pkgs actual.pkgs

(* Files *)

let assert_file_equal ~ctxt expected actual = match (expected, actual) with
  | Syntax.File expected, Syntax.File actual ->
      assert_pkg_equal ~ctxt expected.pkg actual.pkg