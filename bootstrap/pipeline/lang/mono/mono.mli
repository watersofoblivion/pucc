(**
 * {1 Monomorphic Administrative Normal Form}
 *
 * A fully typed, monomorphic administrative normal form.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the monomorphic administrative normal form.
 *)

type file = private
  | File (** A file *)
(** Files *)

(**
* {2 Constructors}
*
* Construct values of the monomorphic administrative normal form.
*)

(** {3 Files} *)

val file : file
(**
* Constructs a file.
*
* @return A file
*)
