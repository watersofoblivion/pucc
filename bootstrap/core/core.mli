(**
 * {1 Core}
 * 
 * A core library of shared functionality.
 *)

(**
 * {2 Location Tracking}
 *
 * Tracks locations within the source tree in terms of packages, files, and
 * line, column, and byte offsets.
 *)

 (**
  * {3 Positions}
  *
  * A position is a particular cursor position within a file, in terms of a
  * line offset into the file (starting at [1],) a column offset within that
  * line (starting at [0],) and a byte offset into the file (starting at [0].)
  *)

type pos = private {
  line: int; (** The line within the file *)
  col:  int; (** The column offset within the line *)
  off:  int; (** The byte offset within the file *)
}
(** A position *)

val pos : int -> int -> int -> pos
(**
 * Construct a position.
 * 
 * @param line The line number within the file.
 * @param col The column offset within the line.
 * @param off The byte offset into the file.
 * @return A {{!pos} position} within a file
 *)

val lexing_position : Lexing.position -> pos
(**
 * Construct a position from a {{!lexing buffer} Lexbuf.position}.
 *)

exception PositionMismatch of {
  expected: pos;  (** The expected position *)
  actual:   pos;  (** The actual position *)
  line:     bool; (** Whether the positions agree on line number *)
  col:      bool; (** Whether the positions agree on column offset *)
  off:      bool; (** Whether the positions agree on byte offset *)
}
(** Raised when two position are not equal *)

val position_mismatch : pos -> pos -> ?line:bool -> ?col:bool -> ?off:bool -> unit -> exn
(**
 * Constructs a PositionMismatch exception.
 *
 * @param expected The expected position
 * @param actual The actual position
 * @param ?line Whether the positions agree on line number.  Defaults to [true].
 * @param ?col Whether the positions agree on column offset.  Defaults to [true].
 * @param ?off Whether the positions agree on byte offset.  Defaults to [true].
 * @param _ Dummy parameter
 * @return A PositionMismatch exception
 *)

val require_pos_equal : pos -> pos -> unit
(**
 * Require that two position values are equal.
 *
 * @param expected The expected position
 * @param actual The actual position
 * @raise PositionMismatch Raised if the two positions are not equal
 *)

(**
 * {3 Locations}
 *
 * A location is the location of a syntactic element within a source file.  It
 * spans two positions and is always bound to a specific file within a specific
 * package.
 *)

type loc = private {
  start: pos; (** The starting position within the file *)
  stop:  pos; (** The ending position within the file *)
}
(** A location in the source tree *)

val dummy : loc
(** A dummy location guaranteed to be different from all valid locations. *)
 
val loc : pos -> pos -> loc
(**
 * Construct a location.
 *
 * @param start The starting position of the location
 * @param stop The ending position of the location
 * @return A location
 *)

val span : loc -> loc -> loc
(**
 * Constructs a location that spans two locations.  I.e., it starts at the
 * starting position of the first location and stops at the ending position of
 * the second location.
 *
 * @param start The starting location
 * @param stop The ending location
 * @return A location spanning the input locations
 *)

exception LocationMismatch of {
  expected: loc;        (** The expected location *)
  actual:   loc;        (** The actual location *)
  start:    exn option; (** Whether the locations differ on start position *)
  stop:     exn option; (** Whether the locations differ on end position *)
}
(** Raised when two locations are not equal *)

val location_mismatch : loc -> loc -> ?start:(exn option) -> ?stop:(exn option) -> unit -> exn
(**
 * Construct a LocationMismatch exception.
 *
 * @param expected The expected location
 * @param actual The actual location
 * @param ?start Whether the locations differ on start position.  Defaults to [None].
 * @param ?stop Whether the locations differ on end position.  Defaults to [None].
 * @param _ Dummy parameter
 * @return A LocationMismatch exception
 *)

val require_loc_equal : loc -> loc -> unit
(**
 * Require the two locations are equal.
 *
 * @param expected The expected location
 * @param actual The actual location
 * @raise LocationMismatch Raised if the locations are not equal
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