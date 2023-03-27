(** {2 Assembly}
 *
 * Represents syntactically and semantically valid assembly.\
 *)

(** {2 Data Types} *)

type width =
  | DWord (** 64-bit double word *)
  | Word  (** 32-bit word *)
  | HWord (** 16-bit half word *)
  | Byte  (** 8-bit byte *)
(** Operand widths *)

type comparator =
  | Eq (** Equal *)
  | Ne (** Not equal *)
  | Ge (** Greater than or equal *)
  | Lt (** Less than *)
(** Branch comparators *)

type mneu = private
  | Load of {
      width: width; (** Datum width *)
      sext:  bool   (** Sign extended *)
    } (** Load from memory *)
  | Store of {
      width: width; (** Datum width *)
    } (** Store to memory *)
  | Add of {
      width: width; (** Operand width *)
      imm:   bool   (** Immediate *)
    } (** Addition *)
  | Sub of {
      width: width; (** Operand width *)
      imm:   bool   (** Immediate *)
    } (** Subtraction *)
  | And of {
      imm: bool (** Immediate *)
    } (** Bitwise logical AND *)
  | Or of {
      imm: bool (** Immediate *)
    } (** Bitwise logical OR *)
  | Xor of {
      imm: bool (** Immediate *)
    } (** Bitwise logical XOR *)
  | Sl of {
      width: width; (** Operand width *)
      imm:   bool   (** Immediate *)
    } (** Shift left *)
  | Sr of {
      width: width; (** Operand width *)
      imm:   bool;  (** Immediate *)
      arith: bool   (** Arithmetic *)
    } (** Shift right *)
  | Jal of {
      reg: bool; (** Register *)
    } (** Jump and link *)
  | Br of {
      cmp:    comparator; (** Comparator *)
      signed: bool        (** Signedness *)
    } (** Branch *)
  | ECall  (** Call into the execution environment *)
  | EBreak (** Return from the execution environment *)
  | Slt of {
      imm:    bool; (** Immediate *)
      signed: bool  (** Signedness *)
    } (** Set less than *)
  | Auipc  (** Add upper immediate to the PC *)
  | Lui    (** Load upper immediate *)
(** Instruction mneumonics *)

type reg = private
  | RegInt of { idx: int }
(** Integer registers *)

type imm = private
  | ImmInt of {
      value: int (** Value *)
    } (** Integers *)
(** Immediate values *)

type op = private
  | OpReg of {
      reg: reg (** Register *)
    } (** Register operand *)
  | OpImm of {
      imm: imm (** Immediate value *)
    } (** Immediate operand *)
  | OpMem of {
      base: reg; (** Register containing the base address *)
      off:  int  (** Immediate address offset *)
    } (** Memory operand *)
  | OpLbl of {
      lbl: string (** The label *)
    } (** Label operand *)
(** Instruction operands *)

type instr = private
  | Instr of {
      mneu: mneu;      (** Mneumonic *)
      rd:   op;        (** Destination operand *)
      rs1:  op option; (** Optional first source operand *)
      rs2:  op option  (** Optional second source operand *)
    } (** Instruction *)
(** Instructions *)

type top = private
  | TopBlock of {
      lbl:    string;    (** Label *)
      instrs: instr list (** Instructions *)
    } (** Labeled block *)
(** Top-Level Blocks *)

type file = private
  | File of {
      tops: top list (** Top-level blocks *)
    } (** File *)
(** Files *)

(** {2 Constructors} *)

(** {3 Instruction Mneumonics} *)

(** {4 Load/Store} *)

val mneu_load : width -> bool -> mneu
(** [mneu_load width sext] constructs a load of a [width]-sized datum from
    memory. If [sext] is [true], the datum is sign-extended.  If [width] is
    {!DWord}, then [sext] is ignored. *)

val mneu_store : width -> mneu
(** [mneu_store width] constructs a store of a [width]-sized datum to memory. *)

(** {4 Arithmetic} *)

val mneu_add : width -> bool -> mneu
(** [mneu_add width imm] constructs an addition of [width]-sized datums.  If
    [imm] is [true], then the second operand is an immediate.  Raises
    {!InvalidMneumonicWidth} if [width] is not one of {!DWord} or {!Word}. *)

val mneu_sub : width -> bool -> mneu
(** [mneu_sub width imm] constructs a subtraction of [width]-sized datums.  If
    [imm] is [true], then the second operand is an immediate.  Raises
    {!InvalidMneumonicWidth} if [width] is not one of {!DWord} or {!Word}. *)

(** {4 Bitwise Logic} *)

val mneu_and : bool -> mneu
(** [mneu_and imm] constructs a 64-bit bitwise logical AND.  If [imm] is [true],
    then the second operand is an immediate. *)

val mneu_or : bool -> mneu
(** [mneu_or imm] constructs a 64-bit bitwise logical OR.  If [imm] is [true],
    then the second operand is an immediate. *)

val mneu_xor : bool -> mneu
(** [mneu_xor imm] constructs a 64-bit bitwise logical XOR.  If [imm] is [true],
    then the second operand is an immediate. *)

(** {4 Shift} *)

val mneu_sl : width -> bool -> mneu
(** [mneu_sl width imm] constructs a left shift of [width].  If [imm] is [true],
    then the second operand is an immediate. Raises {!InvalidMneumonicWidth} if
    [width] is not one of {!DWord} or {!Word}. *)

val mneu_sr : width -> bool -> bool -> mneu
(** [mneu_sr width imm arith] constructs a right shift of [width].  If [imm] is
    [true], then the second operand is an immediate.  If [arith] is [true], then
    the shift is arithmetic.  Otherwise, it is logical. Raises
    {!InvalidMneumonicWidth} if [width] is not one of {!DWord} or {!Word}. *)

(** {4 Control Flow} *)

val mneu_jal : bool -> mneu
(** [mneu_jal reg] constructs an unconditional jump.  If [reg] is [true], the
    target is comes from a register.  Otherwise, it is a PC-relative address. *)

val mneu_br : comparator -> bool -> mneu
(** [mneu_br cmp signed] constructs a conditional branch.  The comparison used
    is [cmp].  If [signed] is [true], the comparison is signed.  Otherwise it is
    unsigned.  The signedness is ignored if [comp] is one of {!Eq} or {!Neq}. *)

(** {4 System} *)

val mneu_ecall : mneu
(** [mneu_ecall] constructs an system call instruction. *)

val mneu_ebreak : mneu
(** [mneu_ebreak] constructs a system call return instruction. *)

(** {4 Misc} *)

val mneu_slt : bool -> bool -> mneu
(** [mneu_slt imm signed] constructs a set less than.  If [imm] is [true], then
    the second operand is an immediate.  If [signed] is [true], the comparison
    is signed. Otherwise, it is unsigned. *)

val mneu_auipc : mneu
(** [auipc] constructs an add upper immediate to PC. *)

val mneu_lui : mneu
(** [lui] constructs a load upper immediate. *)

(** {3 Registers} *)

val reg_int : int -> reg
(** [reg_int idx] constructs a reference to integer register [idx].  Raises
    {!RegisterIndexOutOfBounds} if [idx] is not between 0 and 31 (inclusive). *)

(** {3 Immediate Values} *)

val imm_int : int -> imm
(** [imm_int value] constructs an integer immediate with value [value]. *)

(** {3 Operands} *)

val op_reg : reg -> op
(** [op_reg reg] constructs a register operand reference to register [reg]. *)

val op_imm : imm -> op
(** [op_imm imm] constructs an immediate operand with value [imm]. *)

val op_mem : reg -> int -> op
(** [op_mem base off] constructs a memory operand that computes the address by
    adding [off] to the value in register [base]. *)

val op_lbl : string -> op
(** [op_lbl lbl] constructs a label operand that references label [lbl]. *)

(** {3 Instructions} *)

val instr : mneu -> op -> op option -> op option -> instr
(** [instr mneu rd rs1 rs2] constructs an instruction with mneumonic [mneu]
    operating on operands [rs1] and [rs2] and writing its result into [rd].
    Raises {!IntegerImmediateOutOfBounds} if the second operand is an integer
    immediate and is not within the allowed range.  Raises {!MissingOperand} if
    the second operand is required but not supplied. *)

(** {3 Top-Level Blocks} *)

val top_block : string -> instr list -> top
(** [top_block lbl instrs] constructs a labeled block of instructions with label
    [lbl] and instructions [instrs]. *)

(** {3 Files} *)

val file : top list -> file
(** [file tops] constructs a file with the top-level blocks [tops]. *)
