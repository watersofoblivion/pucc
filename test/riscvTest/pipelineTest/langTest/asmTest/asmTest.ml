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
  | Asm.Eq, Asm.Eq
  | Asm.Ne, Asm.Ne
  | Asm.Ge, Asm.Ge
  | Asm.Lt, Asm.Lt -> ()
  | _ -> assert_failure "Comparison operators are not equal"

let assert_width_equal expected actual = match expected, actual with
  | Asm.DWord, Asm.DWord
  | Asm.Word, Asm.Word
  | Asm.HWord, Asm.HWord
  | Asm.Byte, Asm.Byte -> ()
  | _ -> assert_failure "Widths are not equal"

let assert_mneu_equal ~ctxt expected actual = match expected, actual with
  | Asm.Load expected, Asm.Load actual ->
    assert_width_equal expected.width actual.width;
    assert_sext_flag_equal ~ctxt expected.sext actual.sext
  | Asm.Store expected, Asm.Store actual ->
    assert_width_equal expected.width actual.width
  | Asm.Add expected, Asm.Add actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | Asm.Sub expected, Asm.Sub actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | Asm.And expected, Asm.And actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | Asm.Or expected, Asm.Or actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | Asm.Xor expected, Asm.Xor actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | Asm.Sl expected, Asm.Sl actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm
  | Asm.Sr expected, Asm.Sr actual ->
    assert_width_equal expected.width actual.width;
    assert_imm_flag_equal ~ctxt expected.imm actual.imm;
    assert_arith_flag_equal ~ctxt expected.arith actual.arith
  | Asm.Jal expected, Asm.Jal actual ->
    assert_reg_flag_equal ~ctxt expected.reg actual.reg
  | Asm.Br expected, Asm.Br actual ->
    assert_cmp_equal expected.cmp actual.cmp;
    assert_signed_flag_equal ~ctxt expected.signed actual.signed
  | Asm.ECall, Asm.ECall
  | Asm.EBreak, Asm.EBreak -> ()
  | Asm.Slt expected, Asm.Slt actual ->
    assert_imm_flag_equal ~ctxt expected.imm actual.imm;
    assert_signed_flag_equal ~ctxt expected.signed actual.signed
  | Asm.Auipc, Asm.Auipc -> ()
  | Asm.Lui, Asm.Lui -> ()
  | _ -> assert_failure "Mneumonics are not equal"

let assert_reg_equal ~ctxt expected actual = match expected, actual with
  | Asm.RegInt expected, Asm.RegInt actual ->
    assert_reg_idx_equal ~ctxt expected.idx actual.idx

let assert_imm_equal ~ctxt expected actual = match expected, actual with
  | Asm.ImmInt expected, Asm.ImmInt actual ->
    assert_imm_value_equal ~ctxt expected.value actual.value

let assert_op_equal ~ctxt expected actual = match expected, actual with
  | Asm.OpReg expected, Asm.OpReg actual ->
    assert_reg_equal ~ctxt expected.reg actual.reg
  | Asm.OpImm expected, Asm.OpImm actual ->
    assert_imm_equal ~ctxt expected.imm actual.imm
  | Asm.OpMem expected, Asm.OpMem actual ->
    assert_reg_equal ~ctxt expected.base actual.base;
    assert_off_equal ~ctxt expected.off actual.off
  | Asm.OpLbl expected, Asm.OpLbl actual ->
    assert_lbl_equal ~ctxt expected.lbl actual.lbl
  | _ -> assert_failure "Operands are not equal"

let assert_instr_equal ~ctxt expected actual = match expected, actual with
  | Asm.Instr expected, Asm.Instr actual ->
    assert_mneu_equal ~ctxt expected.mneu actual.mneu;
    assert_op_equal ~ctxt expected.rd actual.rd;
    assert_optional_equal ~ctxt "rs1" assert_op_equal expected.rs1 actual.rs1;
    assert_optional_equal ~ctxt "rs2" assert_op_equal expected.rs2 actual.rs2

let assert_instrs_equal ~ctxt expected actual =
  List.iter2 (assert_instr_equal ~ctxt) expected actual

let assert_top_equal ~ctxt expected actual = match expected, actual with
  | Asm.TopBlock expected, Asm.TopBlock actual ->
    assert_lbl_equal ~ctxt expected.lbl actual.lbl;
    assert_instrs_equal ~ctxt expected.instrs actual.instrs

let assert_tops_equal ~ctxt expected actual =
  List.iter2 (assert_top_equal ~ctxt) expected actual

let assert_file_equal ~ctxt expected actual = match expected, actual with
  | Asm.File expected, Asm.File actual ->
    assert_tops_equal ~ctxt expected.tops actual.tops

(* Constructors *)

(* Mneumonics *)

(* Memory *)

let test_mneu_load ctxt =
  let width = Asm.DWord in
  let sext = true in
  match Asm.mneu_load width sext with
    | Load actual ->
      assert_width_equal width actual.width;
      assert_sext_flag_equal ~ctxt sext actual.sext
    | _ -> assert_failure "Expected load mneumonic"

let test_mneu_store _ =
  let width = Asm.DWord in
  match Asm.mneu_store width with
    | Store actual -> assert_width_equal width actual.width
    | _ -> assert_failure "Expected store mneumonic"

(* Arithmetic *)

let test_mneu_add ctxt =
  let width = Asm.DWord in
  let imm = true in
  match Asm.mneu_add width imm with
    | Add actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected add mneumonic"

let test_mneu_sub ctxt =
  let width = Asm.DWord in
  let imm = true in
  match Asm.mneu_sub width imm with
    | Sub actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected sub mneumonic"

(* Bitwise Logic *)

let test_mneu_and ctxt =
  let imm = true in
  match Asm.mneu_and imm with
    | And actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected and mneumonic"

let test_mneu_or ctxt =
  let imm = true in
  match Asm.mneu_or imm with
    | Or actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected or mneumonic"

let test_mneu_xor ctxt =
  let imm = true in
  match Asm.mneu_xor imm with
    | Xor actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected xor mneumonic"

(* Shifts *)

let test_mneu_sl ctxt =
  let width = Asm.DWord in
  let imm = true in
  match Asm.mneu_sl width imm with
    | Sl actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected shift left mneumonic"

let test_mneu_sr ctxt =
  let width = Asm.DWord in
  let imm = false in
  let arith = true in
  match Asm.mneu_sr width imm arith with
    | Sr actual ->
      assert_width_equal width actual.width;
      assert_imm_flag_equal ~ctxt imm actual.imm;
      assert_arith_flag_equal ~ctxt arith actual.arith
    | _ -> assert_failure "Expected shift right mneumonic"

(* Control Flow *)

let test_mneu_jal ctxt =
  let reg = true in
  match Asm.mneu_jal reg with
    | Jal actual -> assert_reg_flag_equal ~ctxt reg actual.reg
    | _ -> assert_failure "Expected jump and link mneumonic"

let test_mneu_br ctxt =
  let cmp = Asm.Ge in
  let signed = true in
  match Asm.mneu_br cmp signed with
    | Br actual ->
      assert_cmp_equal cmp actual.cmp;
      assert_signed_flag_equal ~ctxt signed actual.signed
    | _ -> assert_failure "Expected branch mneumonic"

(* System *)

let test_mneu_ecall _ =
  match Asm.mneu_ecall with
    | ECall -> ()
    | _ -> assert_failure "Expected ecall mneumonic"

let test_mneu_ebreak _ =
  match Asm.mneu_ebreak with
    | EBreak -> ()
    | _ -> assert_failure "Expected ebreak mneumonic"

(* Misc *)

let test_mneu_slt ctxt =
  let imm = true in
  let signed = false in
  match Asm.mneu_slt imm signed with
    | Slt actual ->
      assert_imm_flag_equal ~ctxt imm actual.imm;
      assert_signed_flag_equal ~ctxt signed actual.signed
    | _ -> assert_failure "Expected set less than mneumonic"

let test_mneu_auipc _ =
  match Asm.mneu_auipc with
    | Auipc -> ()
    | _ -> assert_failure "Expected add upper immediate to PC mneumonic"

let test_mneu_lui _ =
  match Asm.mneu_lui with
    | Lui -> ()
    | _ -> assert_failure "Expected load upper immediate mneumonic"

(* Registers *)

let test_reg_int ctxt =
  let idx = 13 in
  match Asm.reg_int idx with
    | RegInt actual ->
      assert_reg_idx_equal ~ctxt idx actual.idx

(* Immediates *)

let test_imm_int ctxt =
  let value = 42 in
  match Asm.imm_int value with
    | ImmInt actual ->
      assert_imm_value_equal ~ctxt value actual.value

(* Operands *)

let test_op_reg ctxt =
  let reg = Asm.reg_int 1 in
  match Asm.op_reg reg with
    | OpReg actual ->
      assert_reg_equal ~ctxt reg actual.reg
    | _ -> assert_failure "Expected register operand"

let test_op_imm ctxt =
  let imm = Asm.imm_int 42 in
  match Asm.op_imm imm with
    | OpImm actual ->
      assert_imm_equal ~ctxt imm actual.imm
    | _ -> assert_failure "Expected immediate operand"

let test_op_mem ctxt =
  let base = Asm.reg_int 1 in
  let off = 42 in
  match Asm.op_mem base 42 with
    | OpMem actual ->
      assert_reg_equal ~ctxt base actual.base;
      assert_off_equal ~ctxt off actual.off
    | _ -> assert_failure "Expected memory operand"

let test_op_lbl ctxt =
  let lbl = "test-label" in
  match Asm.op_lbl lbl with
    | OpLbl actual ->
      assert_lbl_equal ~ctxt lbl actual.lbl
    | _ -> assert_failure "Expected label operand"

(* Instructions *)

let test_instr ctxt =
  let mneu = Asm.mneu_add Asm.DWord true in
  let rd =
    1
      |> Asm.reg_int
      |> Asm.op_reg
  in
  let rs1 =
    42
      |> Asm.imm_int
      |> Asm.op_imm
  in
  let rs2 =
    let reg = Asm.reg_int 2 in
    Asm.op_mem reg 42
  in
  let rs1 = Some rs1 in
  let rs2 = Some rs2 in
  match Asm.instr mneu rd rs1 rs2 with
    | Instr actual ->
      assert_mneu_equal ~ctxt mneu actual.mneu;
      assert_op_equal ~ctxt rd actual.rd;
      assert_optional_equal ~ctxt "rs1" assert_op_equal rs1 actual.rs1;
      assert_optional_equal ~ctxt "rs2" assert_op_equal rs2 actual.rs2

let test_top_block ctxt =
  let lbl = "test-label" in
  let instrs =
    let instr =
      let mneu = Asm.mneu_add Asm.DWord true in
      let rd =
        1
          |> Asm.reg_int
          |> Asm.op_reg
      in
      let rs1 =
        42
          |> Asm.imm_int
          |> Asm.op_imm
      in
      let rs2 =
        let reg = Asm.reg_int 2 in
        Asm.op_mem reg 42
      in
      Asm.instr mneu rd (Some rs1) (Some rs2)
    in
    let instr' =
      let mneu = Asm.mneu_load Asm.DWord true in
      let rd =
        3
          |> Asm.reg_int
          |> Asm.op_reg
      in
      let rs1 =
        let reg = Asm.reg_int 4 in
        Asm.op_mem reg 42
      in
      Asm.instr mneu rd (Some rs1) None
    in
    [instr; instr']
  in
  match Asm.top_block lbl instrs with
    | TopBlock actual ->
      assert_lbl_equal ~ctxt lbl actual.lbl;
      assert_instrs_equal ~ctxt instrs actual.instrs

let test_file ctxt =
  let tops =
    let top =
      let lbl = "first-label" in
      let instrs =
        let instr =
          let mneu = Asm.mneu_add Asm.DWord true in
          let rd =
            1
              |> Asm.reg_int
              |> Asm.op_reg
          in
          let rs1 =
            42
              |> Asm.imm_int
              |> Asm.op_imm
          in
          let rs2 =
            let reg = Asm.reg_int 2 in
            Asm.op_mem reg 42
          in
          Asm.instr mneu rd (Some rs1) (Some rs2)
        in
        let instr' =
          let mneu = Asm.mneu_load Asm.DWord false in
          let rd =
            3
              |> Asm.reg_int
              |> Asm.op_reg
          in
          let rs1 =
            let reg = Asm.reg_int 4 in
            Asm.op_mem reg 42
          in
          Asm.instr mneu rd (Some rs1) None
        in
        [instr; instr']
      in
      Asm.top_block lbl instrs
    in
    let top' =
      let lbl = "second-label" in
      let instrs =
        let instr =
          let mneu = Asm.mneu_sub Asm.Word true in
          let rd =
            4
              |> Asm.reg_int
              |> Asm.op_reg
          in
          let rs1 =
            24
              |> Asm.imm_int
              |> Asm.op_imm
          in
          let rs2 =
            let reg = Asm.reg_int 5 in
            Asm.op_mem reg 24
          in
          Asm.instr mneu rd (Some rs1) (Some rs2)
        in
        let instr' =
          let mneu = Asm.mneu_store Asm.Word in
          let rd =
            let reg = Asm.reg_int 6 in
            Asm.op_mem reg 42
          in
          let rs1 =
            7
              |> Asm.reg_int
              |> Asm.op_reg
          in
          Asm.instr mneu rd (Some rs1) None
        in
        [instr; instr']
      in
      Asm.top_block lbl instrs
    in
    [top; top']
  in
  match Asm.file tops with
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
