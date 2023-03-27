(**
 * {1 Abstract Syntax Testing}
 *
 * Functions for testing the abstract syntax.
 *)

open OUnit2

(** {2 Fixtures} *)

(** {3 Names} *)

val fresh_name : ?loc:Core.loc -> ?id:Core.sym -> unit -> Syntax.name

(** {3 Package Statements} *)

val fresh_pkg_library : ?loc:Core.loc -> ?id:Syntax.name -> unit -> Syntax.pkg

val fresh_pkg_executable : ?loc:Core.loc -> ?id:Syntax.name -> unit -> Syntax.pkg

(** {3 Imports} *)

val fresh_path : ?loc:Core.loc -> ?path:string -> unit -> Syntax.path

val fresh_alias : ?loc:Core.loc -> ?local:Syntax.name -> ?path:Syntax.path -> unit -> Syntax.alias

val fresh_pkgs : ?loc:Core.loc -> ?aliases:(Syntax.alias list) -> unit -> Syntax.pkgs

val fresh_import : ?loc:Core.loc -> ?pkgs:Syntax.pkgs -> unit -> Syntax.import

(** {3 Files} *)

val fresh_file : ?pkg:Syntax.pkg -> ?imports:(Syntax.import list) -> unit -> Syntax.file

(** {2 Location Stripping} *)

(** {3 Names} *)

val deloc_name : Syntax.name -> Syntax.name

(** {3 Package Statements} *)

val deloc_pkg : Syntax.pkg -> Syntax.pkg

(** {3 Imports} *)

val deloc_path : Syntax.path -> Syntax.path

val deloc_alias : Syntax.alias -> Syntax.alias

val deloc_pkgs : Syntax.pkgs -> Syntax.pkgs

val deloc_import : Syntax.import -> Syntax.import

(** {3 Files} *)

val deloc_file : Syntax.file -> Syntax.file

(** {2 Assertions} *)

(** {3 Equality} *)

(** {4 Names} *)

val assert_name_equal : ctxt:test_ctxt -> Syntax.name -> Syntax.name -> unit

(** {4 Package Statements }*)
 
val assert_pkg_equal : ctxt:test_ctxt -> Syntax.pkg -> Syntax.pkg -> unit
(**
 * Assert the the two package statements are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected package statement
 * @param actual The actual package statement
 * @throws Failure Throws if the package statements are not equal
 *)
 
(** {4 Imports} *)

val assert_path_equal : ctxt:test_ctxt -> Syntax.path -> Syntax.path -> unit

val assert_alias_equal : ctxt:test_ctxt -> Syntax.alias -> Syntax.alias -> unit

val assert_pkgs_equal : ctxt:test_ctxt -> Syntax.pkgs -> Syntax.pkgs -> unit

val assert_import_equal : ctxt:test_ctxt -> Syntax.import -> Syntax.import -> unit

(** {4 Files} *)

val assert_file_equal : ctxt:test_ctxt -> Syntax.file -> Syntax.file -> unit
(**
 * Assert the the two files are equal.
 *
 * @param ~ctxt The testing context
 * @param expected The expected file
 * @param actual The actual file
 * @throws Failure Throws if the files are not equal
 *)
