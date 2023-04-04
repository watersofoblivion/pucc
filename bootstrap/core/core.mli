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
 *
 * Sequences use mutability because it makes creating test fixtures orders of
 * magnitude simpler.
 *)

type 'a seq
(** A sequence of values *)

val seq : (int -> 'a) -> 'a seq
(**
 * Construct a sequence of values derivable from the natural numbers.
 *
 * @param gen A function to compute a value from a natural number.
 * @return A sequence of values
 *)

val map_seq : ('a -> 'b) -> 'a seq -> 'b seq
(**
 * Transforms the values in a sequence.
 *
 * @param f A function to transform values
 * @param seq A sequence of values
 * @return A sequence of transformed values
 *)

val gen : 'a seq -> 'a
(**
 * Generate the next value in the sequence.
 *
 * @param seq The sequence of values
 * @return The next value in the sequence
 *)

val seq_nat : ?initial:int -> ?step:int -> unit -> int seq
(**
 * A sequence of natural numbers.
 *
 * @param ?initial The initial value.  Defaults to [0].
 * @param ?step The amount to increment each step.  Defaults to [1].
 * @param _ A dummy parameter
 * @return A sequence of natural numbers
 *)

val seq_str : ?prefix:string -> ?suffix:string -> unit -> string seq
(**
 * A sequence of strings.  Defaults to turning the natural numbers into
 * strings, a la {!string_of_int}.
 *
 * @param ?prefix A prefix placed before the number
 * @param ?suffix A suffix placed after the number
 * @param _ A dummy parameter
 * @return A sequence of strings
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
 
val gensym : ?name:string -> ?seq:(int seq) -> unit -> sym
(**
 * Generates a fresh symbol using the given sequence.
 *
 * @param ?name The hunam-readable name of the symbol.  Defaults to the empty
 *   string.
 * @param ?seq The sequence to use when generating the symbol.  Defaults to a
 *   global integer sequence.
 * @param _ A dummy parameter
 * @return The generated symbol
 *)

exception SymbolMismatch of {
  expected: sym;        (** The expected symbol *)
  actual:   sym;        (** The actual symbol *)
  name:     bool;       (** Whether the symbols agree on name *)
  idx:      bool;       (** Whether the symbols agree on index *)
}
(** Raised when two symbols are not equal *)

val symbol_mismatch : sym -> sym -> ?name:bool -> ?idx:bool -> unit -> exn
(**
 * Construct a SymbolMismatch exception
 *
 * @param expected The expected symbol
 * @param actual The actual symbol
 * @param ?name Whether the symbols agree on name.  Defaults to [true].
 * @param ?idx Whether the symbols agree on index.  Defaults to [true].
 * @param _ Dummy parameter
 * @return A SymbolMismatch exception
 *)
 
val require_sym_equal : sym -> sym -> unit
(**
 * Require that two symbols are equal.
 *
 * @param expected The expected symbol
 * @param actual The actual symbol
 * @raise SymbolMismatch Raised if the symbols are not equal
 *)