(** {1 Normalization}
 *
 * This pass translates the parsed AST into the internal representation of the
 * assembly language.  It only performs basic enough semantic analysis to
 * perform the translation, such as validating that the mneumonics are actually
 * valid mneumonics, etc.  The main sematic analysis is done in the
 * {!RiscvAsmPassCheck} pass.
 *)

(** {2 Exceptions} *)

exception UnknownMneumonic of {
  mneu: string (** The invalid mnenumonic *)
}
(** Raised when an unknown mneumonic is encountered. *)

exception ExtraSegments of {
  extra: string list  (** The invalid extra segments. *)
}
(** Raised when a mneumonic has extra segments. *)

(** {2 Normalization} *)

val norm_mneu : Syntax.mneu -> (Asm.mneu -> 'a) -> 'a
(** [norm_mneu mneu kontinue] normalizes the mneumonic [mneu] and passes it to
    the continuation [kontinue].  Raises {!UnknownMneumonic} if the mneumonic is
    not recognized, or {!ExtraSegments} if the mneumonic has extra segments. *)

val norm_imm : Syntax.imm -> (Asm.imm -> 'a) -> 'a
(** [norm_imm imm kontinue] normalizes the immediate value [imm] and passes it
    to the continuation [kontinue]. *)

val norm_reg : Syntax.reg -> (Asm.reg -> 'a) -> 'a
(** [norm_reg reg kontinue] normalizes the register reference [reg] and passes
    it to the continuation [kontinue]. *)

val norm_op : Syntax.op -> (Asm.op -> 'a) -> 'a
(** [norm_op op kontinue] normalizes the operand [op] and passes it to the
    continuation [kontinue]. *)

val norm_instr : Syntax.instr -> (Asm.instr -> 'a) -> 'a
(** [norm_instr instr kontinue] normalizes the instruction [instr] and passes it
    to the continuation [kontinue]. *)

val norm_top : Syntax.top -> (Asm.top -> 'a) -> 'a
(** [norm_top top kontinue] normalizes the top-level block [top] and passes it
    to the continuation [kontinue]. *)

val norm_file : Syntax.file -> (Asm.file -> 'a) -> 'a
(** [norm_file file kontinue] normalizes the file [file] and passes it to the
    continuation [kontinue]. *)
