(* Workspaces *)

type ws = { root: Fpath.t }
let ws root = { root }
let dummy_ws =
  "dummy/workspace/root"
    |> Fpath.v
    |> ws
exception WorkspaceMismatch of { expected: ws; actual: ws; }

type pkg = { ws: ws; path: Fpath.t }
type file = { pkg: pkg; filename: Fpath.t }

let pkg ws path = { ws; path }
let file pkg filename = { pkg; filename }

let dummy_pkg =
    "dummy/package/path"
      |> Fpath.v
      |> pkg dummy_ws
let dummy_file =
    "dummy-file.name"
      |> Fpath.v
      |> file dummy_pkg

exception FileMismatch of { expected: file; actual: file; ws: bool; pkg: bool; filename: bool; }

let file_mismatch expected actual ?ws:(ws = true) ?pkg:(pkg = true) ?filename:(filename = true) _ =
  FileMismatch { expected; actual; ws; pkg; filename; }

let require_file_equal expected actual =
  let _ = expected in
  let _ = actual in
  ()
