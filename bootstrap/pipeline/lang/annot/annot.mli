(** {1 Annotated Syntax}
 *
 * A fully type-annotated, desugared syntax for PU/CC.  This syntax does not
 * include location information.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the annotated syntax.
 *)

type pkg = private
  | Library of {
      id: Core.sym; (** The name of the library *)
    } (** A library *)
  | Executable of {
      id: Core.sym; (** The name of the executable *)
    } (** An executable *)
(** Package Statements *)

type file = private
  | File of {
      pkg: pkg; (** The package statement *)
    } (** A file *)
(** A file of annotated syntax *)

(**
 * {2 Constructors}
 *
 * Construct values of the annotated syntax.
 *)

(** {3 Package Statements} *)

val pkg_library : Core.sym -> pkg
(**
 * Constructs a library package statement.
 *
 * @param id The name of the library
 * @return A library package statement
 *)

val pkg_executable : Core.sym -> pkg
(**
 * Constructs an executable package statement.
 *
 * @param id The name of the library
 * @return An executable package statement
 *)

(** {3 Files} *)

val file : pkg -> file
(**
 * Constructs a file of annotated syntax.
 *
 * @param pkg The package statement
 * @return A file of annotated syntax
 *)
