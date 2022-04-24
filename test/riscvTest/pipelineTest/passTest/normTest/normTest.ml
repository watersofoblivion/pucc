open OUnit2

(* Helpers *)

let syntax_imm_int imm =
  imm
    |> string_of_int
    |> Syntax.imm_int
let syntax_reg_int idx =
  idx
    |> string_of_int
    |> Syntax.reg_general Syntax.reg_ty_int
let syntax_op_reg idx =
  idx
    |> syntax_reg_int
    |> Syntax.op_reg
let syntax_op_imm imm =
  imm
    |> syntax_imm_int
    |> Syntax.op_imm
let syntax_op_mem base off =
  let base = syntax_reg_int base in
  off
    |> syntax_imm_int
    |> Syntax.op_mem base
let syntax_op_lbl = Syntax.op_lbl
let syntax_instr ?rs1:(rs1 = None) ?rs2:(rs2 = None) mneu rd =
  let mneu = Syntax.mneu mneu in
  Syntax.instr mneu rd rs1 rs2

let asm_imm_int = Asm.imm_int
let asm_reg_int = Asm.reg_int
let asm_op_reg idx =
  idx
    |> asm_reg_int
    |> Asm.op_reg
let asm_op_imm imm =
  imm
    |> asm_imm_int
    |> Asm.op_imm
let asm_op_mem base off =
  let base = asm_reg_int base in
  Asm.op_mem base off
let asm_op_lbl = Asm.op_lbl
let asm_instr ?rs1:(rs1 = None) ?rs2:(rs2 = None) mneu rd =
  Asm.instr mneu rd rs1 rs2

(* Mneumonics *)

let test_mneu_load_dword ctxt =
  let syntax = Syntax.mneu ["ld"] in
  true
    |> Asm.mneu_load Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_load_word_sext ctxt =
  let syntax = Syntax.mneu ["lw"] in
  true
    |> Asm.mneu_load Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_load_word_no_sext ctxt =
  let syntax = Syntax.mneu ["lwu"] in
  false
    |> Asm.mneu_load Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_load_hword_sext ctxt =
  let syntax = Syntax.mneu ["lh"] in
  true
    |> Asm.mneu_load Asm.HWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_load_hword_no_sext ctxt =
  let syntax = Syntax.mneu ["lhu"] in
  false
    |> Asm.mneu_load Asm.HWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_load_byte_sext ctxt =
  let syntax = Syntax.mneu ["lb"] in
  true
    |> Asm.mneu_load Asm.Byte
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_load_byte_no_sext ctxt =
  let syntax = Syntax.mneu ["lbu"] in
  false
    |> Asm.mneu_load Asm.Byte
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_store_dword ctxt =
  let syntax = Syntax.mneu ["sd"] in
  Asm.DWord
    |> Asm.mneu_store
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_store_word ctxt =
  let syntax = Syntax.mneu ["sw"] in
  Asm.Word
    |> Asm.mneu_store
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_store_hword ctxt =
  let syntax = Syntax.mneu ["sh"] in
  Asm.HWord
    |> Asm.mneu_store
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_store_byte ctxt =
  let syntax = Syntax.mneu ["sb"] in
  Asm.Byte
    |> Asm.mneu_store
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_add ctxt =
  let syntax = Syntax.mneu ["add"] in
  false
    |> Asm.mneu_add Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_addi ctxt =
  let syntax = Syntax.mneu ["addi"] in
  true
    |> Asm.mneu_add Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_addw ctxt =
  let syntax = Syntax.mneu ["addw"] in
  false
    |> Asm.mneu_add Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_addiw ctxt =
  let syntax = Syntax.mneu ["addiw"] in
  true
    |> Asm.mneu_add Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sub ctxt =
  let syntax = Syntax.mneu ["sub"] in
  false
    |> Asm.mneu_sub Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_subi ctxt =
  let syntax = Syntax.mneu ["subi"] in
  true
    |> Asm.mneu_sub Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_subw ctxt =
  let syntax = Syntax.mneu ["subw"] in
  false
    |> Asm.mneu_sub Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_subiw ctxt =
  let syntax = Syntax.mneu ["subiw"] in
  true
    |> Asm.mneu_sub Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_and ctxt =
  let syntax = Syntax.mneu ["and"] in
  false
    |> Asm.mneu_and
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_andi ctxt =
  let syntax = Syntax.mneu ["andi"] in
  true
    |> Asm.mneu_and
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_or ctxt =
  let syntax = Syntax.mneu ["or"] in
  false
    |> Asm.mneu_or
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_ori ctxt =
  let syntax = Syntax.mneu ["ori"] in
  true
    |> Asm.mneu_or
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_xor ctxt =
  let syntax = Syntax.mneu ["xor"] in
  false
    |> Asm.mneu_xor
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_xori ctxt =
  let syntax = Syntax.mneu ["xori"] in
  true
    |> Asm.mneu_xor
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sll ctxt =
  let syntax = Syntax.mneu ["sll"] in
  false
    |> Asm.mneu_sl Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_slli ctxt =
  let syntax = Syntax.mneu ["slli"] in
  true
    |> Asm.mneu_sl Asm.DWord
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sllw ctxt =
  let syntax = Syntax.mneu ["sllw"] in
  false
    |> Asm.mneu_sl Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sllwi ctxt =
  let syntax = Syntax.mneu ["sllwi"] in
  true
    |> Asm.mneu_sl Asm.Word
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_srl ctxt =
  let syntax = Syntax.mneu ["srl"] in
  false
    |> Asm.mneu_sr Asm.DWord false
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_srli ctxt =
  let syntax = Syntax.mneu ["srli"] in
  false
    |> Asm.mneu_sr Asm.DWord true
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_srlw ctxt =
  let syntax = Syntax.mneu ["srlw"] in
  false
    |> Asm.mneu_sr Asm.Word false
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_srlwi ctxt =
  let syntax = Syntax.mneu ["srlwi"] in
  false
    |> Asm.mneu_sr Asm.Word true
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sra ctxt =
  let syntax = Syntax.mneu ["sra"] in
  true
    |> Asm.mneu_sr Asm.DWord false
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_srai ctxt =
  let syntax = Syntax.mneu ["srai"] in
  true
    |> Asm.mneu_sr Asm.DWord true
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sraw ctxt =
  let syntax = Syntax.mneu ["sraw"] in
  true
    |> Asm.mneu_sr Asm.Word false
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_srawi ctxt =
  let syntax = Syntax.mneu ["srawi"] in
  true
    |> Asm.mneu_sr Asm.Word true
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_jal ctxt =
  let syntax = Syntax.mneu ["jal"] in
  false
    |> Asm.mneu_jal
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_jalr ctxt =
  let syntax = Syntax.mneu ["jalr"] in
  true
    |> Asm.mneu_jal
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_beq ctxt =
  let syntax = Syntax.mneu ["beq"] in
  true
    |> Asm.mneu_br Asm.Eq
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_bne ctxt =
  let syntax = Syntax.mneu ["bne"] in
  true
    |> Asm.mneu_br Asm.Ne
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_bge ctxt =
  let syntax = Syntax.mneu ["bge"] in
  true
    |> Asm.mneu_br Asm.Ge
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_bgeu ctxt =
  let syntax = Syntax.mneu ["bgeu"] in
  false
    |> Asm.mneu_br Asm.Ge
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_blt ctxt =
  let syntax = Syntax.mneu ["blt"] in
  true
    |> Asm.mneu_br Asm.Lt
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_bltu ctxt =
  let syntax = Syntax.mneu ["bltu"] in
  false
    |> Asm.mneu_br Asm.Lt
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_ecall ctxt =
  let syntax = Syntax.mneu ["ecall"] in
  Asm.mneu_ecall
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_ebreak ctxt =
  let syntax = Syntax.mneu ["ebreak"] in
  Asm.mneu_ebreak
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_slt ctxt =
  let syntax = Syntax.mneu ["slt"] in
  true
    |> Asm.mneu_slt false
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_slti ctxt =
  let syntax = Syntax.mneu ["slti"] in
  true
    |> Asm.mneu_slt true
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sltu ctxt =
  let syntax = Syntax.mneu ["sltu"] in
  false
    |> Asm.mneu_slt false
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_sltiu ctxt =
  let syntax = Syntax.mneu ["sltiu"] in
  false
    |> Asm.mneu_slt true
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_auipc ctxt =
  let syntax = Syntax.mneu ["auipc"] in
  Asm.mneu_auipc
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_lui ctxt =
  let syntax = Syntax.mneu ["lui"] in
  Asm.mneu_lui
    |> AsmTest.assert_mneu_equal ~ctxt
    |> Norm.norm_mneu syntax

let test_mneu_unknown _ =
  let syntax = Syntax.mneu ["unknown"; "mneumonic"] in
  let exn = Norm.UnknownMneumonic { mneu = "unknown.mneumonic" } in
  assert_raises exn (fun _ ->
    Norm.norm_mneu syntax (fun _ ->
      assert_failure "Expected exception"))

let test_mneu_extra_segs _ =
  let assert_no_allowed_segments mneu =
    let extra = ["extra"; "segments"] in
    let syntax = Syntax.mneu (mneu :: extra) in
    let exn = Norm.ExtraSegments { extra } in
    assert_raises exn (fun _ ->
      Norm.norm_mneu syntax (fun _ ->
        assert_failure "Expected exception"))
  in
  List.iter assert_no_allowed_segments [
    "ld"; "lw"; "lwu"; "lh"; "lhu"; "lb"; "lbu";
    "sd"; "sw"; "sh"; "sb";
    "add"; "addi"; "addw"; "addiw";
    "sub"; "subi"; "subw"; "subiw";
    "and"; "andi";
    "or"; "ori";
    "xor"; "xori";
    "sll"; "slli"; "sllw"; "sllwi";
    "srl"; "srli"; "srlw"; "srlwi";
    "sra"; "srai"; "sraw"; "srawi";
    "jal"; "jalr";
    "beq"; "bne"; "bge"; "bgeu"; "blt"; "bltu";
    "ecall"; "ebreak";
    "slt"; "slti"; "sltu"; "sltiu";
    "auipc";
    "lui";
  ]

(* Immediates *)

let test_norm_imm_int ctxt =
  let imm = 42 in
  let syntax = syntax_imm_int imm in
  42
    |> asm_imm_int
    |> AsmTest.assert_imm_equal ~ctxt
    |> Norm.norm_imm syntax

(* Registers *)

let test_norm_reg_int ctxt =
  let idx = 10 in
  let syntax = syntax_reg_int idx in
  idx
    |> asm_reg_int
    |> AsmTest.assert_reg_equal ~ctxt
    |> Norm.norm_reg syntax

(* Operands *)

let test_norm_op_reg ctxt =
  let idx = 10 in
  let syntax = syntax_op_reg idx in
  asm_op_reg idx
    |> AsmTest.assert_op_equal ~ctxt
    |> Norm.norm_op syntax

let test_norm_op_imm ctxt =
  let imm = 42 in
  let syntax = syntax_op_imm imm in
  imm
    |> asm_op_imm
    |> AsmTest.assert_op_equal ~ctxt
    |> Norm.norm_op syntax

let test_norm_op_mem ctxt =
  let base = 10 in
  let off = 42 in
  let syntax = syntax_op_mem base off in
  off
    |> asm_op_mem base
    |> AsmTest.assert_op_equal ~ctxt
    |> Norm.norm_op syntax

let test_norm_op_lbl ctxt =
  let lbl = "test-lbl" in
  let syntax = syntax_op_lbl lbl in
  lbl
    |> asm_op_lbl
    |> AsmTest.assert_op_equal ~ctxt
    |> Norm.norm_op syntax

let test_norm_instr ctxt =
  let syntax =
    let rd = syntax_op_reg 1 in
    let rs1 = Some (syntax_op_reg 2) in
    let rs2 = Some (syntax_op_reg 3) in
    syntax_instr ["add"] rd ~rs1 ~rs2
  in
  let mneu = Asm.mneu_add Asm.DWord false in
  let rd = asm_op_reg 1 in
  let rs1 = Some (asm_op_reg 2) in
  let rs2 = Some (asm_op_reg 3) in
  asm_instr mneu rd ~rs1 ~rs2
    |> AsmTest.assert_instr_equal ~ctxt
    |> Norm.norm_instr syntax

let test_norm_top_block ctxt =
  let lbl = "test-lbl" in
  let syntax =
    let instr =
      let rd = syntax_op_reg 1 in
      let rs1 = Some (syntax_op_reg 2) in
      let rs2 = Some (syntax_op_reg 3) in
      syntax_instr ["add"] rd ~rs1 ~rs2
    in
    let instr' =
      let rd = syntax_op_reg 4 in
      let rs1 = Some (syntax_op_mem 5 42) in
      syntax_instr ["ld"] rd ~rs1
    in
    Syntax.top_block lbl [instr; instr']
  in
  let instr =
    let mneu = Asm.mneu_add Asm.DWord false in
    let rd = asm_op_reg 1 in
    let rs1 = Some (asm_op_reg 2) in
    let rs2 = Some (asm_op_reg 3) in
    asm_instr mneu rd ~rs1 ~rs2
  in
  let instr' =
    let mneu = Asm.mneu_load Asm.DWord true in
    let rd = asm_op_reg 4 in
    let rs1 = Some (asm_op_mem 5 42) in
    asm_instr mneu rd ~rs1
  in
  [instr; instr']
    |> Asm.top_block lbl
    |> AsmTest.assert_top_equal ~ctxt
    |> Norm.norm_top syntax

let test_norm_file ctxt =
  let lbl = "test-lbl-one" in
  let lbl' = "test-lbl-two" in
  let syntax =
    let top =
      let instr =
        let rd = syntax_op_reg 1 in
        let rs1 = Some (syntax_op_reg 2) in
        let rs2 = Some (syntax_op_reg 3) in
        syntax_instr ["add"] rd ~rs1 ~rs2
      in
      let instr' =
        let rd = syntax_op_reg 4 in
        let rs1 = Some (syntax_op_mem 5 42) in
        syntax_instr ["ld"] rd ~rs1
      in
      Syntax.top_block lbl [instr; instr']
    in
    let top' =
      let instr =
        let rd = syntax_op_mem 6 24 in
        let rs1 = Some (syntax_op_reg 7) in
        syntax_instr ["sd"] rd ~rs1
      in
      let instr' =
        let rd = syntax_op_reg 8 in
        let rs1 = Some (syntax_op_reg 9) in
        let rs2 = Some (syntax_op_imm 10) in
        syntax_instr ["subi"] rd ~rs1 ~rs2
      in
      Syntax.top_block lbl' [instr; instr']
    in
    Syntax.file [top; top']
  in
  let top =
    let instr =
      let mneu = Asm.mneu_add Asm.DWord false in
      let rd = asm_op_reg 1 in
      let rs1 = Some (asm_op_reg 2) in
      let rs2 = Some (asm_op_reg 3) in
      asm_instr mneu rd ~rs1 ~rs2
    in
    let instr' =
      let mneu = Asm.mneu_load Asm.DWord true in
      let rd = asm_op_reg 4 in
      let rs1 = Some (asm_op_mem 5 42) in
      asm_instr mneu rd ~rs1
    in
    Asm.top_block lbl [instr; instr']
  in
  let top' =
    let instr =
      let mneu = Asm.mneu_store Asm.DWord in
      let rd = asm_op_mem 6 24 in
      let rs1 = Some (asm_op_reg 7) in
      asm_instr mneu rd ~rs1
    in
    let instr' =
      let mneu = Asm.mneu_sub Asm.DWord true in
      let rd = asm_op_reg 8 in
      let rs1 = Some (asm_op_reg 9) in
      let rs2 = Some (asm_op_imm 10) in
      asm_instr mneu rd ~rs1 ~rs2
    in
    Asm.top_block lbl' [instr; instr']
  in
  [top; top']
    |> Asm.file
    |> AsmTest.assert_file_equal ~ctxt
    |> Norm.norm_file syntax

(* Test Suite *)

let suite =
  "Normalization" >::: [
    "Mneumonics" >::: [
      "Load/Store" >::: [
        "Load" >::: [
          "Double Word" >:: test_mneu_load_dword;
          "Word" >::: [
            "Signed"   >:: test_mneu_load_word_sext;
            "Unsigned" >:: test_mneu_load_word_no_sext;
          ];
          "Half Word" >::: [
            "Signed"   >:: test_mneu_load_hword_sext;
            "Unsigned" >:: test_mneu_load_hword_no_sext;
          ];
          "Byte" >::: [
            "Signed"   >:: test_mneu_load_byte_sext;
            "Unsigned" >:: test_mneu_load_byte_no_sext;
          ];
        ];
        "Store" >::: [
          "Double Word" >:: test_mneu_store_dword;
          "Word"        >:: test_mneu_store_word;
          "Half Word"   >:: test_mneu_store_hword;
          "Byte"        >:: test_mneu_store_byte;
        ];
      ];
      "Arithmetic" >::: [
        "Addition" >::: [
          "Double Word" >::: [
            "Register-Register"  >:: test_mneu_add;
            "Register-Immediate" >:: test_mneu_addi;
          ];
          "Word" >::: [
            "Register-Register"  >:: test_mneu_addw;
            "Register-Immediate" >:: test_mneu_addiw;
          ];
        ];
        "Subtraction" >::: [
          "Double Word" >::: [
            "Register-Register"  >:: test_mneu_sub;
            "Register-Immediate" >:: test_mneu_subi;
          ];
          "Word" >::: [
            "Register-Register"  >:: test_mneu_subw;
            "Register-Immediate" >:: test_mneu_subiw;
          ];
        ];
      ];
      "Bitwise Logic" >::: [
        "And" >::: [
          "Register-Register"  >:: test_mneu_and;
          "Register-Immediate" >:: test_mneu_andi;
        ];
        "Or" >::: [
          "Register-Register"  >:: test_mneu_or;
          "Register-Immediate" >:: test_mneu_ori;
        ];
        "Xor" >::: [
          "Register-Register"  >:: test_mneu_xor;
          "Register-Immediate" >:: test_mneu_xori;
        ];
      ];
      "Shift" >::: [
        "Left" >::: [
          "Double Word" >::: [
            "Register-Register"  >:: test_mneu_sll;
            "Register-Immediate" >:: test_mneu_slli;
          ];
          "Word" >::: [
            "Register-Register"  >:: test_mneu_sllw;
            "Register-Immediate" >:: test_mneu_sllwi;
          ];
        ];
        "Right" >::: [
          "Logical" >::: [
            "Double Word" >::: [
              "Register-Register"  >:: test_mneu_srl;
              "Register-Immediate" >:: test_mneu_srli;
            ];
            "Word" >::: [
              "Register-Register"  >:: test_mneu_srlw;
              "Register-Immediate" >:: test_mneu_srlwi;
            ];
          ];
          "Arithmetic" >::: [
            "Double Word" >::: [
              "Register-Register"  >:: test_mneu_sra;
              "Register-Immediate" >:: test_mneu_srai;
            ];
            "Word" >::: [
              "Register-Register"  >:: test_mneu_sraw;
              "Register-Immediate" >:: test_mneu_srawi;
            ];
          ];
        ];
      ];
      "Branch/Jump" >::: [
        "Jump" >::: [
          "Link"          >:: test_mneu_jal;
          "Link Register" >:: test_mneu_jalr;
        ];
        "Branch" >::: [
          "Equality" >::: [
            "Equal"     >:: test_mneu_beq;
            "Not Equal" >:: test_mneu_bne;
          ];
          "Greater Than or Equal" >::: [
            "Signed"   >:: test_mneu_bge;
            "Unsigned" >:: test_mneu_bgeu;
          ];
          "Less Than" >::: [
            "Signed"   >:: test_mneu_blt;
            "Unsigned" >:: test_mneu_bltu;
          ];
        ];
      ];
      "System" >::: [
        "Call Execution Environment"        >:: test_mneu_ecall;
        "Return from Execution Environment" >:: test_mneu_ebreak;
      ];
      "Misc" >::: [
        "Set Less Than" >::: [
          "Signed" >::: [
            "Register-Register"  >:: test_mneu_slt;
            "Register-Immediate" >:: test_mneu_slti;
          ];
          "Unsigned" >::: [
            "Register-Register"  >:: test_mneu_sltu;
            "Register-Immediate" >:: test_mneu_sltiu;
          ];
        ];
        "Add Upper Immediate to PC" >:: test_mneu_auipc;
        "Load Upper Immediate"      >:: test_mneu_lui;
      ];
      "Invalid" >::: [
        "Unknown"        >:: test_mneu_unknown;
        "Extra Segments" >:: test_mneu_extra_segs;
      ];
    ];
    "Immediates" >::: [
      "Integers" >:: test_norm_imm_int;
    ];
    "Registers" >::: [
      "General Purpose" >::: [
        "Integer" >:: test_norm_reg_int;
      ];
    ];
    "Operands" >::: [
      "Register"  >:: test_norm_op_reg;
      "Immediate" >:: test_norm_op_imm;
      "Memory"    >:: test_norm_op_mem;
      "Label"     >:: test_norm_op_lbl;
    ];
    "Instructions" >:: test_norm_instr;
    "Top-Level Blocks" >::: [
      "Labled Block" >:: test_norm_top_block;
    ];
    "Files" >:: test_norm_file;
  ]
