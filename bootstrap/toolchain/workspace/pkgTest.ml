(* Workspace Tests *)

open Format

open OUnit2

(* Fixtures *)

let ws_seq =
  ()
    |> Core.seq_str ~prefix:"test/workspace/root-"
    |> Core.map_seq Fpath.v
let pkg_seq =
  ()
    |> Core.seq_str ~prefix:"test/workspace/path-"
    |> Core.map_seq Fpath.v
let file_seq =
  ()
    |> Core.seq_str ~prefix:"test-file-"
    |> Core.map_seq Fpath.v

let fresh_ws ?root:(root = Core.gen ws_seq) _ =
  Workspace.ws root

let fresh_pkg ?ws:(ws = fresh_ws ()) ?path:(path = Core.gen pkg_seq) _ =
  Workspace.pkg ws path

let fresh_file ?pkg:(pkg = fresh_pkg ()) ?filename:(filename = Core.gen file_seq) _ =
  Workspace.file pkg filename

(* Assertions *)

let assert_fpath_equal ~ctxt ?msg:(msg = "Paths") ?normalize:(normalize = true) expected actual =
  let expected = if normalize then Fpath.normalize expected else expected in
  let actual = if normalize then Fpath.normalize actual else expected in
  let msg = sprintf "%s are not equal" msg in
  assert_equal ~ctxt ~cmp:Fpath.equal ~printer:Fpath.to_string ~msg expected actual

let assert_ws_equal ~ctxt expected actual =
  assert_fpath_equal ~ctxt ~msg:"Workspace roots" expected.Workspace.root actual.Workspace.root

let assert_pkg_equal ~ctxt expected actual =
  assert_ws_equal ~ctxt expected.Workspace.ws actual.Workspace.ws;
  assert_fpath_equal ~ctxt ~msg:"Package paths" expected.Workspace.path actual.Workspace.path

let assert_file_equal ~ctxt expected actual =
  assert_pkg_equal ~ctxt expected.Workspace.pkg actual.Workspace.pkg;
  assert_fpath_equal ~ctxt ~msg:"File names" expected.Workspace.filename actual.Workspace.filename
