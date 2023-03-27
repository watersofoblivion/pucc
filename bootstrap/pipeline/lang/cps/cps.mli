(**
 * {1 Continuation-Passing Style}
 *
 * A fully typed, continuation-passing style.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the continuation-passing style.
 *)

type file = private
  | File (** A file *)
(** Files *)

(**
* {2 Constructors}
*
* Construct values of the continuation-passing style.
*)

(** {3 Files} *)

val file : file
(**
* Constructs a file.
*
* @return A file
*)
