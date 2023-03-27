(**
 * {1 Closure-Passing CPS}
 *
 * A fully typed, closure-passing CPS.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the closure-passing CPS.
 *)

type file = private
  | File (** A file *)
(** Files *)

(**
* {2 Constructors}
*
* Construct values of the closure-passing CPS.
*)

(** {3 Files} *)

val file : file
(**
* Constructs a file.
*
* @return A file
*)
