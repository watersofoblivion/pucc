(**
 * {1 Desugaring}
 *
 * Passes over the abstract syntax, type-checks it, and desugars it into the
 * annotated syntax.
 *)

(**
 * {2 Environment}
 *
 * The environment for the pass.
 *)

type env
(** The environment *)

val env : env
(** An empty environment *)

(**
 * {2 Exceptions}
 *
 * The various exceptions that can be thrown from the pass
 *)

exception PackageMismatch of {
  expected: Annot.pkg;  (** The expected package statement *)
  actual:   Annot.pkg;  (** The actual package statement *)
  ty:       bool;       (** Whether the package statements agree on type *)
  id:       exn option; (** Whether the package statements disagree on id *)
}
(**
 * Raised when a file has a package statement different from the others in the
 * fileset.
 *)

exception NoInputFiles
(**
 * Raised when there are no files in the fileset.
 *)

(**
 * {3 Exception Constructors}
 *)

val package_mismatch : Annot.pkg -> Annot.pkg -> bool -> exn option -> exn
(**
 * Construct a package mismatch exception
 *
 * @param expected The expected package statement
 * @param actual The actual package statement
 * @param ty Whether the package statements agree on type
 * @param id Whether the package statements disagree on id
 * @return A PackageMismatch exception
 *)

val no_input_files : exn
(**
 * Construct a no input files exception.
 *)

(**
 * {2 Pass}
 *
 * The implementation of the pass
 *)

val desug_pkg : env -> Syntax.pkg -> (env * Annot.pkg)
(**
 * Desugar a package statement.
 *
 * @param env The environment to desugar in
 * @param fileset The package statement to desugar
 * @return An updated environment and the desugared package statement
 *)

val desug_fileset : env -> Syntax.file list -> (env * Annot.file)
(**
 * Desugar a set of files into a package in single annotated syntax file.  All
 * files are expected to have the same package name and type.
 *
 * @param env The environment to desugar in
 * @param fileset The files to desugar
 * @return An updated environment and the desugared file
 * @raise PackageMismatch Raised when if a file is found with a different
 *   package type and/or name as the other files in the set.
 *)