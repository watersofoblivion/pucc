open Format

open OUnit2

(* Utilities *)

let assert_optional_equal ~ctxt id assert_equal expected actual = match (expected, actual) with
  | Some expected, Some actual -> assert_equal ~ctxt expected actual
  | None, None -> ()
  | Some _, None ->
    id
      |> sprintf "Expected %s to be present"
      |> assert_failure
  | None, Some _ ->
    id
      |> sprintf "Unexpected %s present"
      |> assert_failure

(* Assertions *)

let assert_flag_equal ~ctxt msg expected actual =
  assert_equal ~ctxt ~printer:string_of_bool ~msg expected actual

let assert_sext_flag_equal = assert_flag_equal "Sign extension flags are not equal"
let assert_imm_flag_equal = assert_flag_equal "Immediate flags are not equal"
let assert_arith_flag_equal = assert_flag_equal "Aritmetic shift flags are not equal"
let assert_reg_flag_equal = assert_flag_equal "Register flags are not equal"
let assert_signed_flag_equal = assert_flag_equal "Signedness flags are not equal"

let assert_reg_idx_equal ~ctxt expected actual =
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Register indices are not equal" expected actual
let assert_off_equal ~ctxt expected actual =
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Offsets are not equal" expected actual
let assert_imm_value_equal ~ctxt expected actual =
  assert_equal ~ctxt ~printer:string_of_int ~msg:"Immediate values are not equal" expected actual

let assert_lbl_equal ~ctxt expected actual =
  assert_equal ~ctxt ~msg:"Labels are not equal" expected actual

let assert_cmp_equal expected actual = match expected, actual with
  | RiscV.Eq, RiscV.Eq
  | RiscV.Ne, RiscV.Ne
  | RiscV.Ge, RiscV.Ge
  | RiscV.Lt, RiscV.Lt -> ()
  | _ -> assert_failure "Comparison operators are not equal"

let assert_width_equal expected actual = match expected, actual with
  | RiscV.DWord, RiscV.DWord
  | RiscV.Word, RiscV.Word
  | RiscV.HWord, RiscV.HWord
  | RiscV.Byte, RiscV.Byte -> ()
  | _ -> assert_failure "Widths are not equal"

let assert_mneu_equal ~ctxt expected actual = match expected, actual with
  | RiscV.Load expected, RiscV.Load actual ->
    assert_width_equal expected.width actual.width;
    assert_sext_flag_equal ~ctxt expected.sext actual.sext
  | RiscV.Store expected, RiscV.Store actual ->
    assert_width_equal expected.width actual.width
  | RiscV.Add expected, RiscV.Add actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | RiscV.Sub expected, RiscV.Sub actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | RiscV.And expected, RiscV.And actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | RiscV.Or expected, RiscV.Or actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | RiscV.Xor expected, RiscV.Xor actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | RiscV.Sl expected, RiscV.Sl actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | RiscV.Sr expected, RiscV.Sr actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm;
    assert_arith_flag_equal ~ctxt expected.arith actual.arith
  | RiscV.Jal expected, RiscV.Jal actual ->
    assert_reg_flag_equal ~ctxt expected.reg actual.reg
  | RiscV.Br expected, RiscV.Br actual ->
    assert_cmp_equal expected.cmp actual.cmp;
    assert_signed_flag_equal ~ctxt expected.signed actual.signed
  | RiscV.ECall, RiscV.ECall
  | RiscV.EBreak, RiscV.EBreak -> ()
  | RiscV.Slt expected, RiscV.Slt actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm;
    assert_signed_flag_equal ~ctxt expected.signed actual.signed
  | RiscV.Auipc, RiscV.Auipc -> ()
  | RiscV.Lui, RiscV.Lui -> ()
  | _ -> assert_failure "Mneumonics are not equal"

let assert_reg_equal ~ctxt expected actual = match expected, actual with
  | RiscV.RegInt expected, RiscV.RegInt actual ->
    assert_reg_idx_equal ~ctxt expected.idx actual.idx

let assert_imm_equal ~ctxt expected actual = match expected, actual with
  | RiscV.ImmInt expected, RiscV.ImmInt actual ->
    assert_imm_value_equal ~ctxt expected.value actual.value

let assert_op_equal ~ctxt expected actual = match expected, actual with
  | RiscV.OpReg expected, RiscV.OpReg actual ->
    assert_reg_equal ~ctxt expected.reg actual.reg
  | RiscV.OpImm expected, RiscV.OpImm actual ->
    assert_imm_equal ~ctxt expected.imm actual.imm
  | RiscV.OpMem expected, RiscV.OpMem actual ->
    assert_reg_equal ~ctxt expected.base actual.base;
    assert_off_equal ~ctxt expected.off actual.off
  | RiscV.OpLbl expected, RiscV.OpLbl actual ->
    assert_lbl_equal ~ctxt expected.lbl actual.lbl
  | _ -> assert_failure "Operands are not equal"

let assert_instr_equal ~ctxt expected actual = match expected, actual with
  | RiscV.Instr expected, RiscV.Instr actual ->
    assert_mneu_equal ~ctxt expected.mneu actual.mneu;
    assert_op_equal ~ctxt expected.rd actual.rd;
    assert_optional_equal ~ctxt "rs1" assert_op_equal expected.rs1 actual.rs1;
    assert_optional_equal ~ctxt "rs2" assert_op_equal expected.rs2 actual.rs2

let assert_instrs_equal ~ctxt expected actual =
  List.iter2 (assert_instr_equal ~ctxt) expected actual

let assert_top_equal ~ctxt expected actual = match expected, actual with
  | RiscV.TopBlock expected, RiscV.TopBlock actual ->
    assert_lbl_equal ~ctxt expected.lbl actual.lbl;
    assert_instrs_equal ~ctxt expected.instrs actual.instrs

let assert_tops_equal ~ctxt expected actual =
  List.iter2 (assert_top_equal ~ctxt) expected actual

let assert_file_equal ~ctxt expected actual = match expected, actual with
  | RiscV.File expected, RiscV.File actual ->
    assert_tops_equal ~ctxt expected.tops actual.tops

(* Constructors *)

(* Mneumonics *)

(* Memory *)

let test_mneu_load ctxt =
  let width = RiscV.DWord in
  let sext = true in
  match RiscV.mneu_load width sext with
    | Load actual ->
      assert_width_equal width actual.width;
      assert_sext_flag_equal ~ctxt sext actual.sext
    | _ -> assert_failure "Expected load mneumonic"

let test_mneu_store _ =
  let width = RiscV.DWord in
  match RiscV.mneu_store width with
    | Store actual -> assert_width_equal width actual.width
    | _ -> assert_failure "Expected store mneumonic"

(* Arithmetic *)

let test_mneu_add ctxt =
  let width = RiscV.DWord in
  let imm = true in
  match RiscV.mneu_add width imm with
    | Add actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected add mneumonic"

let test_mneu_sub ctxt =
  let width = RiscV.DWord in
  let imm = true in
  match RiscV.mneu_sub width imm with
    | Sub actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected sub mneumonic"

(* Bitwise Logic *)

let test_mneu_and ctxt =
  let imm = true in
  match RiscV.mneu_and imm with
    | And actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected and mneumonic"

let test_mneu_or ctxt =
  let imm = true in
  match RiscV.mneu_or imm with
    | Or actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected or mneumonic"

let test_mneu_xor ctxt =
  let imm = true in
  match RiscV.mneu_xor imm with
    | Xor actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected xor mneumonic"

(* Shifts *)

let test_mneu_sl ctxt =
  let width = RiscV.DWord in
  let imm = true in
  match RiscV.mneu_sl width imm with
    | Sl actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected shift left mneumonic"

let test_mneu_sr ctxt =
  let width = RiscV.DWord in
  let imm = false in
  let arith = true in
  match RiscV.mneu_sr width imm arith with
    | Sr actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm;
      assert_arith_flag_equal ~ctxt arith actual.arith
    | _ -> assert_failure "Expected shift right mneumonic"

(* Control Flow *)

let test_mneu_jal ctxt =
  let reg = true in
  match RiscV.mneu_jal reg with
    | Jal actual -> assert_reg_flag_equal ~ctxt reg actual.reg
    | _ -> assert_failure "Expected jump and link mneumonic"

let test_mneu_br ctxt =
  let cmp = RiscV.Ge in
  let signed = true in
  match RiscV.mneu_br cmp signed with
    | Br actual ->
      assert_cmp_equal cmp actual.cmp;
      assert_signed_flag_equal ~ctxt signed actual.signed
    | _ -> assert_failure "Expected branch mneumonic"

(* System *)

let test_mneu_ecall _ =
  match RiscV.mneu_ecall with
    | ECall -> ()
    | _ -> assert_failure "Expected ecall mneumonic"

let test_mneu_ebreak _ =
  match RiscV.mneu_ebreak with
    | EBreak -> ()
    | _ -> assert_failure "Expected ebreak mneumonic"

(* Misc *)

let test_mneu_slt ctxt =
  let imm = true in
  let signed = false in
  match RiscV.mneu_slt imm signed with
    | Slt actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm;
      assert_signed_flag_equal ~ctxt signed actual.signed
    | _ -> assert_failure "Expected set less than mneumonic"

let test_mneu_auipc _ =
  match RiscV.mneu_auipc with
    | Auipc -> ()
    | _ -> assert_failure "Expected add upper immediate to PC mneumonic"

let test_mneu_lui _ =
  match RiscV.mneu_lui with
    | Lui -> ()
    | _ -> assert_failure "Expected load upper immediate mneumonic"

(* Registers *)

let test_reg_int ctxt =
  let idx = 13 in
  match RiscV.reg_int idx with
    | RegInt actual ->
      assert_reg_idx_equal ~ctxt idx actual.idx

(* Immediates *)

let test_imm_int ctxt =
  let value = 42 in
  match RiscV.imm_int value with
    | ImmInt actual ->
      assert_imm_value_equal ~ctxt value actual.value

(* Operands *)

let test_op_reg ctxt =
  let reg = RiscV.reg_int 1 in
  match RiscV.op_reg reg with
    | OpReg actual ->
      assert_reg_equal ~ctxt reg actual.reg
    | _ -> assert_failure "Expected register operand"

let test_op_imm ctxt =
  let imm = RiscV.imm_int 42 in
  match RiscV.op_imm imm with
    | OpImm actual ->
      assert_imm_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected immediate operand"

let test_op_mem ctxt =
  let base = RiscV.reg_int 1 in
  let off = 42 in
  match RiscV.op_mem base 42 with
    | OpMem actual ->
      assert_reg_equal ~ctxt base actual.base;
      assert_off_equal ~ctxt off actual.off
    | _ -> assert_failure "Expected memory operand"

let test_op_lbl ctxt =
  let lbl = "test-label" in
  match RiscV.op_lbl lbl with
    | OpLbl actual ->
      assert_lbl_equal ~ctxt lbl actual.lbl
    | _ -> assert_failure "Expected label operand"

(* Instructions *)

let test_instr ctxt =
  let mneu = RiscV.mneu_add RiscV.DWord true in
  let rd =
    1
      |> RiscV.reg_int
      |> RiscV.op_reg
  in
  let rs1 =
    42
      |> RiscV.imm_int
      |> RiscV.op_imm
  in
  let rs2 =
    let reg = RiscV.reg_int 2 in
    RiscV.op_mem reg 42
  in
  let rs1 = Some rs1 in
  let rs2 = Some rs2 in
  match RiscV.instr mneu rd rs1 rs2 with
    | Instr actual ->
      assert_mneu_equal ~ctxt mneu actual.mneu;
      assert_op_equal ~ctxt rd actual.rd;
      assert_optional_equal ~ctxt "rs1" assert_op_equal rs1 actual.rs1;
      assert_optional_equal ~ctxt "rs2" assert_op_equal rs2 actual.rs2

let test_top_block ctxt =
  let lbl = "test-label" in
  let instrs =
    let instr =
      let mneu = RiscV.mneu_add RiscV.DWord true in
      let rd =
        1
          |> RiscV.reg_int
          |> RiscV.op_reg
      in
      let rs1 =
        42
          |> RiscV.imm_int
          |> RiscV.op_imm
      in
      let rs2 =
        let reg = RiscV.reg_int 2 in
        RiscV.op_mem reg 42
      in
      RiscV.instr mneu rd (Some rs1) (Some rs2)
    in
    let instr' =
      let mneu = RiscV.mneu_load RiscV.DWord true in
      let rd =
        3
          |> RiscV.reg_int
          |> RiscV.op_reg
      in
      let rs1 =
        let reg = RiscV.reg_int 4 in
        RiscV.op_mem reg 42
      in
      RiscV.instr mneu rd (Some rs1) None
    in
    [instr; instr']
  in
  match RiscV.top_block lbl instrs with
    | TopBlock actual ->
      assert_lbl_equal ~ctxt lbl actual.lbl;
      assert_instrs_equal ~ctxt instrs actual.instrs

let test_file ctxt =
  let tops =
    let top =
      let lbl = "first-label" in
      let instrs =
        let instr =
          let mneu = RiscV.mneu_add RiscV.DWord true in
          let rd =
            1
              |> RiscV.reg_int
              |> RiscV.op_reg
          in
          let rs1 =
            42
              |> RiscV.imm_int
              |> RiscV.op_imm
          in
          let rs2 =
            let reg = RiscV.reg_int 2 in
            RiscV.op_mem reg 42
          in
          RiscV.instr mneu rd (Some rs1) (Some rs2)
        in
        let instr' =
          let mneu = RiscV.mneu_load RiscV.DWord false in
          let rd =
            3
              |> RiscV.reg_int
              |> RiscV.op_reg
          in
          let rs1 =
            let reg = RiscV.reg_int 4 in
            RiscV.op_mem reg 42
          in
          RiscV.instr mneu rd (Some rs1) None
        in
        [instr; instr']
      in
      RiscV.top_block lbl instrs
    in
    let top' =
      let lbl = "second-label" in
      let instrs =
        let instr =
          let mneu = RiscV.mneu_sub RiscV.Word true in
          let rd =
            4
              |> RiscV.reg_int
              |> RiscV.op_reg
          in
          let rs1 =
            24
              |> RiscV.imm_int
              |> RiscV.op_imm
          in
          let rs2 =
            let reg = RiscV.reg_int 5 in
            RiscV.op_mem reg 24
          in
          RiscV.instr mneu rd (Some rs1) (Some rs2)
        in
        let instr' =
          let mneu = RiscV.mneu_store RiscV.Word in
          let rd =
            let reg = RiscV.reg_int 6 in
            RiscV.op_mem reg 42
          in
          let rs1 =
            7
              |> RiscV.reg_int
              |> RiscV.op_reg
          in
          RiscV.instr mneu rd (Some rs1) None
        in
        [instr; instr']
      in
      RiscV.top_block lbl instrs
    in
    [top; top']
  in
  match RiscV.file tops with
    | File actual ->
      assert_tops_equal ~ctxt tops actual.tops

(* Test Suite *)

let suite =
  "ASM" >::: [
    "Mneumonics" >::: [
      "Memory" >::: [
        "Load"  >:: test_mneu_load;
        "Store" >:: test_mneu_store;
      ];
      "Arithmetic" >::: [
        "Add" >:: test_mneu_add;
        "Subtract" >:: test_mneu_sub;
      ];
      "Bitwise Logic" >::: [
        "And" >:: test_mneu_and;
        "Or"  >:: test_mneu_or;
        "Xor" >:: test_mneu_xor;
      ];
      "Shifts" >::: [
        "Left" >:: test_mneu_sl;
        "Right" >:: test_mneu_sr;
      ];
      "Control" >::: [
        "Jump and Link" >:: test_mneu_jal;
        "Branch"        >:: test_mneu_br;
      ];
      "System" >::: [
        "Call Execution Environment"        >:: test_mneu_ecall;
        "Return from Execution Environment" >:: test_mneu_ebreak;
      ];
      "Misc" >::: [
        "Set Less Than"             >:: test_mneu_slt;
        "Add Upper Immediate to PC" >:: test_mneu_auipc;
        "Load Upper Immediate"      >:: test_mneu_lui;
      ];
    ];
    "Registers" >::: [
      "Integers" >:: test_reg_int;
    ];
    "Immediates" >::: [
      "Integers" >:: test_imm_int;
    ];
    "Operands" >::: [
      "Register"  >:: test_op_reg;
      "Memory"    >:: test_op_mem;
      "Immediate" >:: test_op_imm;
      "Label"     >:: test_op_lbl;
    ];
    "Instructions" >:: test_instr;
    "Top-Level" >::: [
      "Labeled Block" >:: test_top_block;
    ];
    "Files" >:: test_file;
  ]
