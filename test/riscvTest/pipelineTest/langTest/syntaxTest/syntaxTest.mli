(** {1 Abstract Syntax Tests} *)

open OUnit2

(** {2 Test Suite} *)

val suite : test
(** [suite] is the unit test suite. *)

(** {2 Assertions} *)

val assert_mneu_equal : ctxt:test_ctxt -> Syntax.mneu -> Syntax.mneu -> unit
(** [assert_mneu_equal ~ctxt expected actual] asserts that the mneumonic
    [actual] is equal to the mneumonic [expected]. *)

val assert_imm_equal : ctxt:test_ctxt -> Syntax.imm -> Syntax.imm -> unit
(** [assert_imm_equal ~ctxt expected actual] asserts that the immediate value
    [actual] is equal to the immediate value [expected]. *)

val assert_reg_ty_equal : ctxt:test_ctxt -> Syntax.reg_ty -> Syntax.reg_ty -> unit
(** [assert_reg_ty_equal ~ctxt expected actual] asserts that the register type
    [actual] is equal to the register type [expected]. *)

val assert_reg_equal : ctxt:test_ctxt -> Syntax.reg -> Syntax.reg -> unit
(** [assert_reg_equal ~ctxt expected actual] asserts that the register reference
    [actual] is equal to the register reference [expected]. *)

val assert_op_equal : ctxt:test_ctxt -> Syntax.op -> Syntax.op -> unit
(** [assert_op_equal ~ctxt expected actual] asserts that the operand
    [actual] is equal to the operand [expected]. *)

val assert_optional_op_equal : ctxt:test_ctxt -> Syntax.op option -> Syntax.op option -> unit
(** [assert_optional_op_equal ~ctxt expected actual] asserts that the
    optional operand [actual] is equal to the optional operand [expected]. *)

val assert_instr_equal : ctxt:test_ctxt -> Syntax.instr -> Syntax.instr -> unit
(** [assert_instr_equal ~ctxt expected actual] asserts that the instruction
    [actual] is equal to the instruction [expected]. *)

val assert_top_equal : ctxt:test_ctxt -> Syntax.top -> Syntax.top -> unit
(** [assert_top_equal ~ctxt expected actual] asserts that the top-level block
    [actual] is equal to the top-level block [expected]. *)

val assert_file_equal : ctxt:test_ctxt -> Syntax.file -> Syntax.file -> unit
(** [assert_file_equal ~ctxt expected actual] asserts that the file [actual] is
    equal to the file [expected]. *)
