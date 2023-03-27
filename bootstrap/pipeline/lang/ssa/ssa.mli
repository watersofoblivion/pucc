(**
 * {1 Static Single-Assignment Form}
 *
 * A fully typed, static single-assignment form.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the static single-assignment form.
 *)

type file = private
  | File (** A file *)
(** Package Statements *)

(**
* {2 Constructors}
*
* Construct values of the static single-assignment form.
*)

(** {3 Files} *)

val file : file
(**
* Constructs a file.
*
* @return A file
*)
