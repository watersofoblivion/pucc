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

let assert_segments_equal ~ctxt segs segs' =
  List.iter2 (assert_equal ~ctxt ~msg:"Segments are not equal") segs segs'

let assert_mneu_equal ~ctxt expected actual = match expected, actual with
  | Syntax.Mneu expected, Syntax.Mneu actual ->
    assert_segments_equal ~ctxt expected.segs actual.segs

let assert_imm_equal ~ctxt expected actual = match expected, actual with
  | Syntax.ImmInt expected, Syntax.ImmInt actual ->
    assert_equal ~ctxt ~msg:"Immediate lexemes are not equal" expected.lexeme actual.lexeme

let assert_reg_ty_equal ~ctxt expected actual = match expected, actual with
  | Syntax.RegTyInt, Syntax.RegTyInt ->
    let _ = ctxt in
    ()

let assert_reg_equal ~ctxt expected actual = match expected, actual with
  | Syntax.RegGeneral expected, Syntax.RegGeneral actual ->
    assert_reg_ty_equal ~ctxt expected.ty actual.ty;
    assert_equal ~ctxt ~msg:"Register indices are not equal" expected.idx actual.idx

let assert_op_equal ~ctxt expected actual = match expected, actual with
  | Syntax.OpReg expected, Syntax.OpReg actual ->
    assert_reg_equal ~ctxt expected.reg actual.reg
  | Syntax.OpImm expected, Syntax.OpImm actual ->
    assert_imm_equal ~ctxt expected.value actual.value
  | Syntax.OpMem expected, Syntax.OpMem actual ->
    assert_reg_equal ~ctxt expected.base actual.base;
    assert_imm_equal ~ctxt expected.off actual.off
  | Syntax.OpLbl expected, Syntax.OpLbl actual ->
    assert_equal ~ctxt ~msg:"Labels are not equal" expected.lbl actual.lbl
  | _ -> assert_failure "Operand types do not match"

let assert_optional_op_equal = assert_optional_equal "rs2" assert_op_equal

let assert_instr_equal ~ctxt expected actual = match expected, actual with
  | Syntax.Instr expected, Syntax.Instr actual ->
    assert_mneu_equal ~ctxt expected.mneu actual.mneu;
    assert_op_equal ~ctxt expected.rd actual.rd;
    assert_optional_equal ~ctxt "rs1" assert_op_equal expected.rs1 actual.rs1;
    assert_optional_equal ~ctxt "rs2" assert_op_equal expected.rs2 actual.rs2

let assert_instrs_equal ~ctxt expected actual =
  List.iter2 (assert_instr_equal ~ctxt) expected actual

let assert_top_equal ~ctxt expected actual = match expected, actual with
  | Syntax.TopBlock expected, Syntax.TopBlock actual ->
    assert_equal ~ctxt ~msg:"Labels are not equal" expected.lbl actual.lbl;
    assert_instrs_equal ~ctxt expected.instrs actual.instrs

let assert_tops_equal ~ctxt expected actual =
  List.iter2 (assert_top_equal ~ctxt) expected actual

let assert_file_equal ~ctxt expected actual = match expected, actual with
  | Syntax.File expected, Syntax.File actual ->
    assert_tops_equal ~ctxt expected.tops actual.tops

(* Tests *)

(* Mneumonics *)

let test_mneu ctxt =
  let segs = ["seg-1"; "seg-2"; "seg-3"] in
  match Syntax.mneu segs with
    | Mneu actual ->
      assert_segments_equal ~ctxt segs actual.segs

(* Immediates *)

let test_imm_int ctxt =
  let lexeme = "42" in
  match Syntax.imm_int lexeme with
    | ImmInt actual ->
      assert_equal ~ctxt ~msg:"Lexemes are not equal" lexeme actual.lexeme

(* Register Types *)

let test_reg_ty_int _ =
  match Syntax.reg_ty_int with
    | RegTyInt -> ()

(* Registers *)

let test_reg_general ctxt =
  let ty = Syntax.reg_ty_int in
  let idx = "42" in
  match Syntax.reg_general ty idx with
    | RegGeneral actual ->
      assert_reg_ty_equal ~ctxt ty actual.ty;
      assert_equal ~ctxt ~msg:"Register indices are not equal" idx actual.idx

(* Operands *)

let test_op_reg ctxt =
  let reg = Syntax.reg_general Syntax.reg_ty_int "42" in
  match Syntax.op_reg reg with
    | OpReg actual -> assert_reg_equal ~ctxt reg actual.reg
    | _ -> assert_failure "Expected register operand"

let test_op_imm ctxt =
  let value = Syntax.imm_int "42" in
  match Syntax.op_imm value with
    | OpImm actual -> assert_imm_equal ~ctxt value actual.value
    | _ -> assert_failure "Expected immediate operand"

let test_op_mem ctxt =
  let base = Syntax.reg_general Syntax.reg_ty_int "42" in
  let off = Syntax.imm_int "24" in
  match Syntax.op_mem base off with
    | OpMem actual ->
      assert_reg_equal ~ctxt base actual.base;
      assert_imm_equal ~ctxt off actual.off
    | _ -> assert_failure "Expected memory operand"

let test_op_lbl ctxt =
  let lbl = "test-lbl" in
  match Syntax.op_lbl lbl with
    | OpLbl actual ->
      assert_equal ~ctxt ~msg:"Labels are not equal" lbl actual.lbl
    | _ -> assert_failure "Expected label operand"

(* Instructions *)

let test_instr ctxt =
  let mneu = Syntax.mneu ["seg-1"; "seg-2"; "seg-3"] in
  let rd =
    Syntax.reg_general Syntax.reg_ty_int "0"
      |> Syntax.op_reg
  in
  let rs1 = None in
  let rs2 = None in
  let _ = match Syntax.instr mneu rd rs1 rs2 with
    | Instr actual ->
      assert_mneu_equal ~ctxt mneu actual.mneu;
      assert_op_equal ~ctxt rd actual.rd;
      assert_optional_equal ~ctxt "rs1" assert_op_equal rs1 actual.rs1;
      assert_optional_equal ~ctxt "rs2" assert_op_equal rs2 actual.rs2
  in

  let rs1 =
    let rs1 =
      Syntax.imm_int "1"
        |> Syntax.op_imm
    in
    Some rs1
  in
  let rs2 =
    let base = Syntax.reg_general Syntax.reg_ty_int "2" in
    let rs2 =
      Syntax.imm_int "2"
        |> Syntax.op_mem base
    in
    Some rs2
  in
  match Syntax.instr mneu rd rs1 rs2 with
    | Instr actual ->
      assert_mneu_equal ~ctxt mneu actual.mneu;
      assert_op_equal ~ctxt rd actual.rd;
      assert_optional_equal ~ctxt "rs1" assert_op_equal rs1 actual.rs1;
      assert_optional_equal ~ctxt "rs2" assert_op_equal rs2 actual.rs2

(* Top-Level Blocks *)

let test_top_block ctxt =
  let lbl = "test-label" in
  let instrs =
    let instr =
      let mneu = Syntax.mneu ["addi"] in
      let rd =
        Syntax.reg_general Syntax.reg_ty_int "1"
          |> Syntax.op_reg
      in
      let rs1 =
        Syntax.reg_general Syntax.reg_ty_int "2"
          |> Syntax.op_reg
      in
      let rs2 =
        Syntax.imm_int "3"
          |> Syntax.op_imm
      in
      Syntax.instr mneu rd (Some rs1) (Some rs2)
    in
    let instr' =
      let mneu = Syntax.mneu ["ld"] in
      let rd =
        Syntax.reg_general Syntax.reg_ty_int "4"
          |> Syntax.op_reg
      in
      let rs1 =
        let base = Syntax.reg_general Syntax.reg_ty_int "5" in
        Syntax.imm_int "6"
          |> Syntax.op_mem base
      in
      Syntax.instr mneu rd (Some rs1) None
    in
    [instr; instr']
  in
  match Syntax.top_block lbl instrs with
    | TopBlock actual ->
      assert_equal ~ctxt ~msg:"Labels are not equal" lbl actual.lbl;
      assert_instrs_equal ~ctxt instrs actual.instrs

(* Files *)

let test_file ctxt =
  let tops =
    let top =
      let lbl = "block-one" in
      let instrs =
        let instr =
          let mneu = Syntax.mneu ["addi"] in
          let rd =
            Syntax.reg_general Syntax.reg_ty_int "1"
              |> Syntax.op_reg
          in
          let rs1 =
            Syntax.reg_general Syntax.reg_ty_int "2"
              |> Syntax.op_reg
          in
          let rs2 =
            Syntax.imm_int "3"
              |> Syntax.op_imm
          in
          Syntax.instr mneu rd (Some rs1) (Some rs2)
        in
        let instr' =
          let mneu = Syntax.mneu ["ld"] in
          let rd =
            Syntax.reg_general Syntax.reg_ty_int "4"
              |> Syntax.op_reg
          in
          let rs1 =
            let base = Syntax.reg_general Syntax.reg_ty_int "5" in
            Syntax.imm_int "6"
              |> Syntax.op_mem base
          in
          Syntax.instr mneu rd (Some rs1) None
        in
        [instr; instr']
      in
      Syntax.top_block lbl instrs
    in
    let top' =
      let lbl = "block-two" in
      let instrs =
        let instr =
          let mneu = Syntax.mneu ["subi"] in
          let rd =
            Syntax.reg_general Syntax.reg_ty_int "7"
              |> Syntax.op_reg
          in
          let rs1 =
            Syntax.reg_general Syntax.reg_ty_int "8"
              |> Syntax.op_reg
          in
          let rs2 =
            Syntax.imm_int "9"
              |> Syntax.op_imm
          in
          Syntax.instr mneu rd (Some rs1) (Some rs2)
        in
        let instr' =
          let mneu = Syntax.mneu ["st"] in
          let rd =
            let base = Syntax.reg_general Syntax.reg_ty_int "10" in
            Syntax.imm_int "11"
              |> Syntax.op_mem base
          in
          let rs1 =
            Syntax.reg_general Syntax.reg_ty_int "12"
              |> Syntax.op_reg
          in
          Syntax.instr mneu rd (Some rs1) None
        in
        [instr; instr']
      in
      Syntax.top_block lbl instrs
    in
    [top; top']
  in
  match Syntax.file tops with
    | File actual -> assert_tops_equal ~ctxt tops actual.tops

(* Test Suite *)

let suite =
  "Abstract Syntax" >::: [
    "Mneumonics" >:: test_mneu;
    "Immediates" >::: [
      "Integers" >:: test_imm_int;
    ];
    "Register Types" >::: [
      "Integer" >:: test_reg_ty_int;
    ];
    "Registers" >::: [
      "General Purpose" >:: test_reg_general;
    ];
    "Operands" >::: [
      "Register"  >:: test_op_reg;
      "Immediate" >:: test_op_imm;
      "Memory"    >:: test_op_mem;
      "Label"     >:: test_op_lbl;
    ];
    "Instructions" >:: test_instr;
    "Top Level" >::: [
      "Block" >:: test_top_block;
    ];
    "Files" >:: test_file;
  ]
