(** {1 Workspace Tests} *)

open OUnit2

(**
 * {2 Workspaces}
 *)

(**
 * {3 Fixtures}
 *)

val fresh_ws : ?root:Fpath.t -> unit -> Workspace.ws
(**
 * Construct a fresh workspace.
 *
 * @param ?root The workspace root
 * @param _ A dummy parameter if no values are given
 * @return A fresh workspace
 *)

val fresh_pkg : ?ws:Workspace.ws -> ?path:Fpath.t -> unit -> Workspace.pkg
(**
 * Construct a fresh package.
 *
 * @param ?ws The workspace the package is in
 * @param ?path The path of the package within the workspace
 * @param _ A dummy parameter if no values are given
 * @param A fresh package
 *)

val fresh_file : ?pkg:Workspace.pkg -> ?filename:Fpath.t -> unit -> Workspace.file
(**
 * Construct a fresh file.
 *
 * @param ?pkg The package the file is in
 * @param ?filename The name of the file
 * @param _ A dummy parameter if no values are given
 * @return A fresh file
 *)

(**
 * {3 Assertions}
 *)

val assert_ws_equal : ctxt:test_ctxt -> Workspace.ws -> Workspace.ws -> unit
(**
 * Assert that two workspaces are equal.
 * 
 * @param ~ctxt The test context
 * @param expected The expected workspace
 * @param actual The actual workspace
 *)

val assert_pkg_equal : ctxt:test_ctxt -> Workspace.pkg -> Workspace.pkg -> unit
(**
 * Assert that two packages are equal.
 * 
 * @param ~ctxt The test context
 * @param expected The expected package
 * @param actual The actual package
 *)

val assert_file_equal : ctxt:test_ctxt -> Workspace.file -> Workspace.file -> unit
(**
 * Assert that two files are equal.
 * 
 * @param ~ctxt The test context
 * @param expected The expected file
 * @param actual The actual file
 *)