(** {1 Validation}
 *
 * This pass validates the semantics of the assembly code.  It checks that all
 * instructions are well formed, all register and label references exist, that
 * all immediates are in-bounds, etc.
 *
 * This pass makes only slight modifications to the code.  Namely, the parser
 * and normalization passes assume 64-bit and encode arithmetic and shift
 * instructions as double-word instructions.  If this pass is for 32-bit
 * assembly, those are rewritten to be 32-bit instructions and any explicitly
 * word-sized instructions cause an error.
 *)

(** {2 Exceptions} *)

exception UnsupportedMneumonic of {
  mneu: Asm.mneu
}
(** Raised when an mneumonic is unsupported on the current architecture. *)

exception InvalidMneumonicWidth of {
  mneu:    Asm.mneu;       (** The mneumonic with the invalid width *)
  allowed: Asm.width list; (** The allowed widths *)
}
(** Raised when an invalid width is used to construct a mneumonic. *)

exception RegisterIndexOutOfBounds of {
  reg:   Asm.reg; (** The register given *)
  limit: int;                 (** The number of registers available *)
}
(** Raised when a register is constructed that is out of bounds. *)

exception IntegerImmediateOutOfBounds of {
  value: int; (** The out of bounds value *)
  min:   int; (** The minimum allowed value *)
  max:   int  (** The maximum allowed value *)
}
(** Raised when an integer immediate is out of bounds *)

exception OffsetOutOfBounds of {
  off: int; (** The out of bounds value *)
  min: int; (** The minimum allowed value *)
  max: int  (** The maximum allowed value *)
}
(** Raised when a memory offset is out of bounds *)

exception MissingOperands of {
  instr: Asm.instr; (** The instruction missing the operand(s). *)
  rd:    bool;                  (** True if destination operand is missing. *)
  rs1:   bool;                  (** True if the first source operand is missing. *)
  rs2:   bool                   (** True if the second source operand is missing. *)
}
(** Raised when an instruction is missing one or more operands. *)

exception ExtraOperands of {
  instr: Asm.instr; (** The instruction with extra the operand(s). *)
  rd:    bool;                  (** True if destination operand is unexpected. *)
  rs1:   bool;                  (** True if the first source operand is unexpected. *)
  rs2:   bool                   (** True if the second source operand is unexpected. *)
}
(** Raised when an instruction has extra operands. *)

exception UnknownLabel of {
  lbl: string; (** The unknown label *)
}
(** Raised when an operand refers to a non-existent label. *)

exception DuplicateLabel of {
  lbl: string; (** The duplicate label *)
}
(** Raised when an label is declared more than once. *)

(** {2 Environment} *)

type arch =
  | Arch32 (** 32-bit architecture *)
  | Arch64 (** 64-bit architecture *)
(** The targeted architecture *)

type ext =
  | M        (** Integer multiplication/division instructions *)
  | A        (** Atomic instructions *)
  | Zicsr    (** Constrol status registers *)
  | Counters (** Hardware counters *)
  | F        (** Single-precision Floating Point instructions *)
  | D        (** Double-precision Floating Point instructions *)
  | Q        (** Quad-precision Floating Point instructions *)
  | L        (** Decimal Floating Point instructions *)
  | B        (** Bit-manipulation instructions *)
  | V        (** Vector instructions *)
(** ISA exensions *)

type env
(** An environment *)

val empty : arch -> bool -> bool -> ext list -> env
(** [empty arch priv emb exts] constructs an empty environment for checking.
    [arch] specifies the target architecture.  [priv] specifies if privileged
    instructions are supported.  [emb] specifies if embedded mode is to be used.
    [exts] provides the list supported of ISA extensions. *)

(** {2 Checkers} *)

val check_mneu : env -> Asm.mneu -> (env -> Asm.mneu -> 'a) -> 'a
(** [check_mneu env mneu kontinue] checks the mneumonic [mnue] in the
    environment [env] and passes an environment and mneumonic to the
    continuation [kontinue].  Raises {!UnsupportedMneumonic} if the target
    architecture is 32-bit and mneumonic is for an explicitly word-sized
    value, or {!InvalidMneumonicWidth} if the mneumonic does not support the
    given width. *)

val check_reg : env -> Asm.reg -> (env -> Asm.reg -> 'a) -> 'a
(** [check_reg env reg kontine] checks the register reference [reg] in the
    environment [env] and passes an environment and register reference to the
    continuation [kontinue].  Raises {!RegisterIndexOutOfBounds} if the register
    index is not supported on the target architecture. *)

val check_imm : env -> Asm.imm -> (env -> Asm.imm -> 'a) -> 'a
(** [check_imm env imm kontinue] checks the immediate value [imm] in the
    environment [env] and passes an environment and immediate value to the
    continuation [kontinue].  Raises {!IntegerImmediateOutOfBounds} if the
    immediate value is outside the bounds of any possible operand. *)

val check_op : env -> Asm.op -> (env -> Asm.op -> 'a) -> 'a
(** [check_op env op kontinue] checks the operand [op] in the environment [env]
    and passes an environment and operand to the continuation [kontinue].  In
    addition to the exceptions that can be thrown from {!check_imm}, raises
    {!UnknownLabel} if a label operand refers to a label not bound in the
    environment. *)

val check_instr : env -> Asm.instr -> (env -> Asm.instr -> 'a) -> 'a
(** [check_instr env instr kontinue] checks the instruction [instr] in the
    environment [env] and passes an environment and instruction to the
    continuation [kontinue].  In addition to the exceptions that can be thrown
    by {!check_mneu}, {!check_reg}, {!check_imm}, and {!check_op}, raises
    {!MissingOperands} if a required operand is not present, or {!ExtraOperands}
    if an unexpected operand is present.  Raises {!IntegerImmediateOutOfBounds}
    if an immediate operand is out of bounds for this particular instruction. *)

val check_top : env -> Asm.top -> (env -> Asm.top -> 'a) -> 'a
(** [check_top env top kontinue] checks the top-level block [top] in the
    environment [env] and passes an environment and top-level block to the
    continuation [kontinue].  In addition to the exceptions raised by
    {!check_instr}, raises {!DuplicateLabel} if a label is redeclared. *)

val check_file : env -> Asm.file -> (env -> Asm.file -> 'a) -> 'a
(** [check_file env file kontinue] checks the file [file] in the environment
    [env] and passes an environment and top-level block to the continuation
    [kontinue].  Raises any exception that can be raised by {!check_top}. *)
