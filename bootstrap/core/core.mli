(**
 * {1 Core}
 * 
 * A core library of shared functionality.
 *)

(**
 * {2 Sequences}
 * 
 * A sequence is a generator of unique values, used to generate unique indexes
 * for symbols or distinct values for test fixtures.
 *
 * A sequence takes an initial value and a function that can take a value and
 * generate the "next" value in the sequence.
 *)

type seq
(** A sequence of values *)

val seq : seq
(**
 * Construct a sequence of values derivable from the natural numbers.
 *
 * @param gen A function to compute a value from a natural number.
 * @return A sequence of values
 *)

val gen : seq -> (seq -> int -> 'a) -> 'a
(**
 * Generate the next value in the sequence.
 *
 * @param seq The sequence of values
 * @param kontinue A continuation that is passed the updated sequence and the
 *   next value
 * @return The result of the continuation
 *)
 
(**
 * {2 Symbols}
 *
 * Symbols are user-supplied or internally-generated identifiers.  Each symbol
 * has a unique index, an optional string name, and a location.  Symbols
 * with equal indexes are equal.  Symbols can be "anonymous" (i.e., have no
 * name) so that the compiler can generate fresh symbols freely.
 *)

type sym = private {
  name: string option; (** The name of the symbol *)
  idx:  int;           (** The unique index of the symbol *)
}
(** A symbolized name *)
 
val gensym : seq -> ?name:string -> (seq -> sym -> 'a) -> 'a
(**
 * Generates a fresh symbol using the given sequence.
 *
 * @param seq The sequence to use when generating the symbol.
 * @param ?name The hunam-readable name of the symbol.  Defaults to the empty
 *   string.
 * @param kontinue A contination that is passed the updated sequence and the symbol
 * @return The result of the continuation
 *)

exception SymbolMismatch of {
  expected: sym;        (** The expected symbol *)
  actual:   sym;        (** The actual symbol *)
  name:     bool;       (** Whether the symbols agree on name *)
  idx:      bool;       (** Whether the symbols agree on index *)
}
(** Raised when two symbols are not equal *)

val symbol_mismatch : sym -> sym -> ?name:bool -> ?idx:bool -> (exn -> 'a) -> 'a
(**
 * Construct a SymbolMismatch exception
 *
 * @param expected The expected symbol
 * @param actual The actual symbol
 * @param ?name Whether the symbols agree on name.  Defaults to [true].
 * @param ?idx Whether the symbols agree on index.  Defaults to [true].
 * @param kontinue A continuation that is passed the exception
 * @return The result of the continuation
 *)
 
val require_sym_equal : sym -> sym -> (sym -> 'a) -> 'a
(**
 * Require that two symbols are equal.
 *
 * @param expected The expected symbol
 * @param actual The actual symbol
 * @param kontinue A continuation that is passed the symbol (specifically, the
 *   [actual] symbol.)
 * @return The result of the continuation
 * @raise SymbolMismatch Raised if the symbols are not equal
 *)