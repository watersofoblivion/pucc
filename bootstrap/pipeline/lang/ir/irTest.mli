(**
 * {1 Administrative Normal Form Testing}
 *
 * Functions for testing the annotated syntax.
 *)

open OUnit2

(**
 * {2 Printers}
 *)

val string_of_pkg : Ir.pkg -> string
(**
 * Converts a package constructor into a string
 *
 * @param pkg The package statement
 * @return A human-readable version of the constructor name
 *)

(**
 * {2 Fixtures}
 *)

val fresh_pkg_library : ?id:Core.sym -> unit -> Ir.pkg
(**
 * Generate a fresh library package statement.
 *
 * @param ?id The name of the library.  Defaults to using {!Core.gensym}.
 * @param _ A dummy parameter
 * @return A fresh library package statement
 *)


val fresh_pkg_executable : ?id:Core.sym -> unit -> Ir.pkg
(**
 * Generate a fresh executable package statement.
 *
 * @param ?id The name of the executable.  Defaults to using {!Core.gensym}.
 * @param _ A dummy parameter
 * @return A fresh executable package statement
 *)

val fresh_file : ?pkg:Ir.pkg -> unit -> Ir.file
(**
 * Generate a fresh file.
 *
 * @param ?pkg The package statement.  Defaults to {!fresh_pkg_library}.
 * @param _ A dummy parameter
 * @return A fresh file
 *)

(** {2 Assertions} *)

(**
 * {3 Equality}
 *
 * Assert the equality of two annotated ASTs.
 *)

val assert_pkg_equal : ctxt:test_ctxt -> Ir.pkg -> Ir.pkg -> unit
(**
 * Assert the the two package statements are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected package statement
 * @param actual The actual package statement
 * @raise Failure Throws if the package statements are not equal
 *)

val assert_file_equal : ctxt:test_ctxt -> Ir.file -> Ir.file -> unit
(**
 * Assert the two files are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected file
 * @param actual The actual file
 * @raise Failure Throws if the files are not equal
 *)

(**
 * {3 Failure}
 * 
 * Fail due to the inequality of annotated AST constructors
 *)

val fail_pkg_constr : string -> Ir.pkg -> unit
(**
 * Fail due to the inequality of two package statement constructors
 *
 * @param expected The expected constructor as a string
 * @param actual The actual constructor
 * @raise Failure Always.
 *)