(**
 * {1 Administrative Normal Form}
 *
 * A fully typed, administrative normal form.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the administrative normal form.
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
(** Files *)

(**
* {2 Constructors}
*
* Construct values of the administrative normal form.
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
 * Construct a file.
 *
 * @param pkg The package statement of the file
 * @return A file
 *)
