(** {1 Abstract Syntax}
 *
 * Represents the parsed assembly syntax.  This is designed to hold any
 * syntactically valid assembly, even if it is semantically invalid.
 *)

(** {2 Data Types} *)

type mneu = private
  | Mneu of {
      segs: string list (** The segments *)
    } (** A mneumonic *)
(** An assembly mneumonic *)

type imm = private
  | ImmInt of {
      lexeme: string (** Parsed value *)
    } (** Integer Immediate *)
(** Immediate Values *)

type reg_ty = private
  | RegTyInt (** Integer register *)
(** Register Types *)

type reg = private
  | RegGeneral of {
      ty:  reg_ty; (** Type *)
      idx: string  (** Index *)
    } (** General Purpose Register *)
(** Register Identifiers *)

type op = private
  | OpReg of {
      reg: reg (** Register *)
    } (** Register Operand *)
  | OpImm of {
      value: imm (** Value *)
    } (** Immediate Operand *)
  | OpMem of {
      base: reg; (** Base address *)
      off:  imm  (** Offset *)
    } (** Memory Operand *)
  | OpLbl of {
      lbl: string (** Label *)
    } (** Label Operand *)
(** Instruction Operands *)

type instr = private
  | Instr of {
      mneu: mneu;      (** Instruction mneumonic *)
      rd:   op;        (** Destination operand *)
      rs1:  op option; (** Optional first source operand *)
      rs2:  op option  (** Optional second source operand *)
    } (** Instruction *)
(** Instructions *)

type top = private
  | TopBlock of {
      lbl:    string;     (** Label *)
      instrs: instr list; (** Instructions *)
    } (** Labeled instruction block *)
(** Top-level Constructs *)

type file = private
  | File of {
      tops: top list (** Top-Level constructs *)
    } (** File *)
(** Files *)

(** {2 Constructors} *)

(** {3 Instruction Mneumonics} *)

val mneu : string list -> mneu
(** [mneu segs] constructs a mneumonic that is the concatenation of [segs]. *)

(** {3 Immediate Values} *)

val imm_int : string -> imm
(** [imm_int lexeme] constructs an integer immediate with the value [lexeme]. *)

(** {3 Register Types} *)

val reg_ty_int : reg_ty
(** [reg_ty_int] is the integer register type.  (I.e., an [x] register) *)

(** {3 Registers} *)

val reg_general : reg_ty -> string -> reg
(** [reg_general ty idx] constructs a reference to the [idx] register of type
    [ty]. *)

(** {3 Operands} *)

val op_reg : reg -> op
(** [op_reg reg] constructs a register operand referencing [reg]. *)

val op_imm : imm -> op
(** [op_imm imm] constructs an immediate operand referencing [imm]. *)

val op_mem : reg -> imm -> op
(** [op_mem base off] constructs a memory operand that computes the address by
    adding [off] to the value in the [base] register. *)

val op_lbl : string -> op
(** [op_lbl lbl] constructs a label operand that references the label [lbl]. *)

(** {3 Instructions} *)

val instr : mneu -> op -> op option -> op option -> instr
(** [instr mneu rd rs1 rs2] constructs an instruction with the mneumonic
    [mneu], the destination [rd], and source operands [rs1] and [rs2]. *)

(** {3 Top-Level Constructs} *)

val top_block : string -> instr list -> top
(** [top_block lbl instrs] constructs a top-level labeled block of instructions
    [instrs] labeled [lbl]. *)

(** {3 Files} *)

val file : top list -> file
(** [file tops] constructs a file from the top-level constructs [tops]. *)
