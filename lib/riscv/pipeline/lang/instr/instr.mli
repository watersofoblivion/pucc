(** {1 Encoded Instructions}
 *
 * A representation of the assembly ready to be encoded into binary.
 *)

type t = private
  | R of {
      opcode: bytes; (** Opcode *)
      funct:  bytes; (** Function bits *)
      rd:     bytes; (** Destination register *)
      rs1:    bytes; (** First source operand *)
      rs2:    bytes  (** Second source operand *)
    } (** R-type *)
  | I of {
      opcode: bytes; (** Opcode *)
      funct:  bytes; (** Function *)
      rd:     bytes; (** Destination register *)
      rs1:    bytes; (** First source operand *)
      imm:    bytes  (** Immediate value *)
    } (** I-type *)
  | S of {
      opcode: bytes; (** Opcode *)
      funct:  bytes; (** Function *)
      rd:     bytes; (** Destination register *)
      rs1:    bytes; (** First source operand *)
      rs2:    bytes; (** Second source operand *)
      imm:    bytes; (** Immediate value *)
    } (** S-type *)
  | B of {
      opcode: bytes; (** Opcode *)
      funct:  bytes; (** Function *)
      rs1:    bytes; (** First source operand *)
      rs2:    bytes; (** Second source operand *)
      imm:    bytes; (** Immediate value *)
    } (** B-type *)
  | U of {
      opcode: bytes; (** Opcode *)
      rd:     bytes; (** Destination register *)
      imm:    bytes  (** Immediate value *)
    } (** U-type *)
  | J of {
      opcode: bytes; (** Opcode *)
      rd:     bytes; (** Destination register *)
      imm:    bytes; (** Immediate value *)
    } (** J-type *)
(** Instruction Types *)

(** {2 Constructors} *)

val r : bytes -> bytes -> bytes -> bytes -> bytes -> t
(** [r opcode funct rd rs1 rs2] constructs a R-type instruction. *)

val i : bytes -> bytes -> bytes -> bytes -> bytes -> t
(** [i opcode funct rd rs1 imm] constructs a R-type instruction. *)

val s : bytes -> bytes -> bytes -> bytes -> bytes -> bytes -> t
(** [s opcode funct rd rs1 rs2 imm] constructs a S-type instruction. *)

val b : bytes -> bytes -> bytes -> bytes -> bytes -> t
(** [b opcode funct rs1 rs2 imm] constructs a B-type instruction. *)

val u : bytes -> bytes -> bytes -> t
(** [u opcode rd imm] constructs a U-type instruction. *)

val j : bytes -> bytes -> bytes -> t
(** [j opcode rd imm] constructs a J-type instruction. *)
