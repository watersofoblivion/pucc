(**
 * {1 Workspaces}
 *
 * A workspace is the environment that PU/CC builds in.
 *
 * The root of the workspace is assumed to be the directory the compiler is run
 * in.  Within the workspace, every directory is assumed to be a package, and
 * all of the [.pucc] files within that directory are assumed to be sources for
 * that package.  All [.test.pucc] files within that directory are assumed to
 * be tests for that package.  Packages can import each other via their paths
 * relative to the workspace root.  (Circular imports are disallowed.)
 *
 * In the bootstrap compiler, no attempt is made to cache intermediate
 * compilation results to allow partial builds.  All sources are recompiled
 * from scratch every invocation of the compiler, though each package is only
 * compiled at most once per invocation of the compiler.
 *)

type ws = private {
  root: Fpath.t; (** The root directory *)
}
(** A workspace *)

type pkg = private {
  ws:   ws;      (** The workspace the package is in *)
  path: Fpath.t; (** The path of the package relative to the workspace root *)
}
(** A package within a workspace *)
 
type file = private {
  pkg:      pkg;     (** The package the file is in *)
  filename: Fpath.t; (** The name of the file *)
}
(** A file within a package *)

val ws : Fpath.t -> ws
(**
 * Construct an empty workspace given a root directory.
 *
 * @param root The root of the workspace
 * @return The workspace
 *)

val pkg : ws -> Fpath.t -> pkg
(**
 * Construct a package within a workspace.
 *
 * @param ws The workspace the package is in
 * @param path The path of the package, relative to the workspace root
 * @return The package
 *)

val file : pkg -> Fpath.t -> file
(**
 * Construct a file within a package.
 * 
 * @param pkg The package the file is in
 * @parma filename The name of the file.  Must be a path with no directory
 *   prefix and is assumed to be relative to the package path.
 * @return The file
 *)

val dummy_ws : ws
(**
 * A workspace guaranteed to be different from all valid workspaces.
 *)

val dummy_pkg : pkg
(**
 * A package guaranteed to be different from all valid packages.  Is contained
 * in {!dummy_ws}.
 *)

val dummy_file : file
(**
 * A file guaranteed to be different from all valid files.  Is contained in
 * {!dummy_pkg}.
 *)

exception FileMismatch of {
    expected: file; (** The expected file *)
    actual:   file; (** The actual file *)
    ws:       bool; (** Whether the files agree on workspace *)
    pkg:      bool; (** Whether the files agree on package *)
    filename: bool; (** Whether the files agree on filename *)
}
(** Raised when two files are not equal *)

val file_mismatch : file -> file -> ?ws:bool -> ?pkg:bool -> ?filename:bool -> unit -> exn
(**
 * Construct a FileMismatch exception.
 *
 * @param expected The expected file
 * @param expected The actual file
 * @param ?ws Whether the files agree on workspace.  Defaults to [true].
 * @param ?pkg Whether the files agree on package.  Defaults to [true].
 * @param ?filename Whether the files agree on filename.  Defaults to [true].
 * @return A FileMismatch exception
 *)

val require_file_equal : file -> file -> unit
(**
 * Require that two files are equal.
 *
 * @param expected The expected file
 * @param actual The actual file
 * @raise FileMismatch Raised when the files are not equal
 *)

(**
 * {2 Filesystem}
 *
 * An abstract representation of a filesystem.  Having this abstract is useful
 * for testing where calls to the filesystem need to be mocked.
 *)

module type Impl = sig
end
(** An implementation of a particular filesystem *)

module type Fs = sig
end
(** An abstract filesystem *)

module Make : functor (Fs: Impl) -> Fs
(** Construct a filesystem from an implementation *)