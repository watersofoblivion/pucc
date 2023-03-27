(** {1 Assembly Language Tests} *)

open OUnit2

(** {2 Test Suite} *)

val suite : test
(** [suite] is the unit test suite. *)

(** {2 Assertions} *)

val assert_mneu_equal : ctxt:test_ctxt -> RiscV.mneu -> RiscV.mneu -> unit
(** [assert_mneu_equal ~ctxt expected actual] asserts that the mneumonic
    [actual] is equal to the mneumonic [expected]. *)

val assert_reg_equal : ctxt:test_ctxt -> RiscV.reg -> RiscV.reg -> unit
(** [assert_reg_equal ~ctxt expected actual] asserts that the register reference
    [actual] is equal to the register reference [expected]. *)

val assert_imm_equal : ctxt:test_ctxt -> RiscV.imm -> RiscV.imm -> unit
(** [assert_imm_equal ~ctxt expected actual] asserts that the immediate value
    [actual] is equal to the immediate value [expected]. *)

val assert_op_equal : ctxt:test_ctxt -> RiscV.op -> RiscV.op -> unit
(** [assert_op_equal ~ctxt expected actual] asserts that the operand [actual] is
    equal to the operand [expected]. *)

val assert_instr_equal : ctxt:test_ctxt -> RiscV.instr -> RiscV.instr -> unit
(** [assert_instr_equal ~ctxt expected actual] asserts that the instruction
    [actual] is equal to the instruction [expected]. *)

val assert_top_equal : ctxt:test_ctxt -> RiscV.top -> RiscV.top -> unit
(** [assert_top_equal ~ctxt expected actual] asserts that the top-level block
    [actual] is equal to the top-level block [expected]. *)

val assert_file_equal : ctxt:test_ctxt -> RiscV.file -> RiscV.file -> unit
(** [assert_file_equal ~ctxt expected actual] asserts that the file [actual] is
    equal to the file [expected]. *)
