exception UnknownMneumonic of { mneu: string }
exception ExtraSegments of { extra: string list }

let assert_no_segs = function
  | [] -> ()
  | extra ->
    ExtraSegments { extra }
      |> raise

let rec norm_mneu mneu kontinue = match mneu with
  | Syntax.Mneu mneu ->
    match mneu.segs with
      (* Load *)
      | "ld" :: segs  -> norm_mneu_load Asm.DWord true segs kontinue
      | "lw" :: segs  -> norm_mneu_load Asm.Word true segs kontinue
      | "lh" :: segs  -> norm_mneu_load Asm.HWord true segs kontinue
      | "lb" :: segs  -> norm_mneu_load Asm.Byte true segs kontinue
      | "lwu" :: segs -> norm_mneu_load Asm.Word false segs kontinue
      | "lhu" :: segs -> norm_mneu_load Asm.HWord false segs kontinue
      | "lbu" :: segs -> norm_mneu_load Asm.Byte false segs kontinue

      (* Store *)
      | "sd" :: segs -> norm_mneu_store Asm.DWord segs kontinue
      | "sw" :: segs -> norm_mneu_store Asm.Word segs kontinue
      | "sh" :: segs -> norm_mneu_store Asm.HWord segs kontinue
      | "sb" :: segs -> norm_mneu_store Asm.Byte segs kontinue

      (* Arithmetic *)
      | "add" :: segs   -> norm_mneu_arith Asm.mneu_add Asm.DWord false segs kontinue
      | "addi" :: segs  -> norm_mneu_arith Asm.mneu_add Asm.DWord true segs kontinue
      | "addw" :: segs  -> norm_mneu_arith Asm.mneu_add Asm.Word false segs kontinue
      | "addiw" :: segs -> norm_mneu_arith Asm.mneu_add Asm.Word true segs kontinue
      | "sub" :: segs   -> norm_mneu_arith Asm.mneu_sub Asm.DWord false segs kontinue
      | "subi" :: segs  -> norm_mneu_arith Asm.mneu_sub Asm.DWord true segs kontinue
      | "subw" :: segs  -> norm_mneu_arith Asm.mneu_sub Asm.Word false segs kontinue
      | "subiw" :: segs -> norm_mneu_arith Asm.mneu_sub Asm.Word true segs kontinue

      (* Bitwise logic *)
      | "and" :: segs  -> norm_mneu_logic Asm.mneu_and false segs kontinue
      | "andi" :: segs -> norm_mneu_logic Asm.mneu_and true segs kontinue
      | "or" :: segs   -> norm_mneu_logic Asm.mneu_or false segs kontinue
      | "ori" :: segs  -> norm_mneu_logic Asm.mneu_or true segs kontinue
      | "xor" :: segs  -> norm_mneu_logic Asm.mneu_xor false segs kontinue
      | "xori" :: segs -> norm_mneu_logic Asm.mneu_xor true segs kontinue

      (* Shifts *)
      | "sll" :: segs   -> norm_mneu_shift_left Asm.DWord false segs kontinue
      | "slli" :: segs  -> norm_mneu_shift_left Asm.DWord true segs kontinue
      | "sllw" :: segs  -> norm_mneu_shift_left Asm.Word false segs kontinue
      | "sllwi" :: segs -> norm_mneu_shift_left Asm.Word true segs kontinue
      | "srl" :: segs   -> norm_mneu_shift_right Asm.DWord false false segs kontinue
      | "srli" :: segs  -> norm_mneu_shift_right Asm.DWord true false segs kontinue
      | "srlw" :: segs  -> norm_mneu_shift_right Asm.Word false false segs kontinue
      | "srlwi" :: segs -> norm_mneu_shift_right Asm.Word true false segs kontinue
      | "sra" :: segs   -> norm_mneu_shift_right Asm.DWord false true segs kontinue
      | "srai" :: segs  -> norm_mneu_shift_right Asm.DWord true true segs kontinue
      | "sraw" :: segs  -> norm_mneu_shift_right Asm.Word false true segs kontinue
      | "srawi" :: segs -> norm_mneu_shift_right Asm.Word true true segs kontinue

      (* Jump/Branch *)
      | "jal" :: segs  -> norm_mneu_jump false segs kontinue
      | "jalr" :: segs -> norm_mneu_jump true segs kontinue
      | "beq" :: segs  -> norm_mneu_branch Asm.Eq true segs kontinue
      | "bne" :: segs  -> norm_mneu_branch Asm.Ne true segs kontinue
      | "bge" :: segs  -> norm_mneu_branch Asm.Ge true segs kontinue
      | "bgeu" :: segs -> norm_mneu_branch Asm.Ge false segs kontinue
      | "blt" :: segs  -> norm_mneu_branch Asm.Lt true segs kontinue
      | "bltu" :: segs -> norm_mneu_branch Asm.Lt false segs kontinue

      (* System *)
      | "ecall" :: segs -> norm_mneu_ecall segs kontinue
      | "ebreak" :: segs -> norm_mneu_ebreak segs kontinue

      (* Misc *)
      | "slt" :: segs   -> norm_mneu_slt false true segs kontinue
      | "slti" :: segs  -> norm_mneu_slt true true segs kontinue
      | "sltu" :: segs  -> norm_mneu_slt false false segs kontinue
      | "sltiu" :: segs -> norm_mneu_slt true false segs kontinue
      | "auipc" :: segs -> norm_mneu_auipc segs kontinue
      | "lui" :: segs   -> norm_mneu_lui segs kontinue

      (* Unknown *)
      | segs ->
        let mneu = String.concat "." segs in
        UnknownMneumonic { mneu }
          |> raise
and norm_mneu_load width sext segs kontinue =
  let _ = assert_no_segs segs in
  Asm.mneu_load width sext
    |> kontinue
and norm_mneu_store width segs kontinue =
  let _ = assert_no_segs segs in
  width
    |> Asm.mneu_store
    |> kontinue
and norm_mneu_arith constr width imm segs kontinue =
  let _ = assert_no_segs segs in
  imm
    |> constr width
    |> kontinue
and norm_mneu_logic constr imm segs kontinue =
  let _ = assert_no_segs segs in
  imm
    |> constr
    |> kontinue
and norm_mneu_shift_left width imm segs kontinue =
  let _ = assert_no_segs segs in
  imm
    |> Asm.mneu_sl width
    |> kontinue
and norm_mneu_shift_right width imm arith segs kontinue =
  let _ = assert_no_segs segs in
  arith
    |> Asm.mneu_sr width imm
    |> kontinue
and norm_mneu_jump reg segs kontinue =
  let _ = assert_no_segs segs in
  reg
    |> Asm.mneu_jal
    |> kontinue
and norm_mneu_branch cmp signed segs kontinue =
  let _ = assert_no_segs segs in
  Asm.mneu_br cmp signed
    |> kontinue
and norm_mneu_ecall segs kontinue =
  let _ = assert_no_segs segs in
  Asm.mneu_ecall
    |> kontinue
and norm_mneu_ebreak segs kontinue =
  let _ = assert_no_segs segs in
  Asm.mneu_ebreak
    |> kontinue
and norm_mneu_slt imm signed segs kontinue =
  let _ = assert_no_segs segs in
  signed
    |> Asm.mneu_slt imm
    |> kontinue
and norm_mneu_auipc segs kontinue =
  let _ = assert_no_segs segs in
  Asm.mneu_auipc
    |> kontinue
and norm_mneu_lui segs kontinue =
  let _ = assert_no_segs segs in
  Asm.mneu_lui
    |> kontinue

let norm_imm imm kontinue = match imm with
  | Syntax.ImmInt imm ->
    imm.lexeme
      |> int_of_string
      |> Asm.imm_int
      |> kontinue

let norm_reg reg kontinue = match reg with
  | Syntax.RegGeneral reg ->
    let idx = int_of_string reg.idx in
    match reg.ty with
      | Syntax.RegTyInt ->
        idx
          |> Asm.reg_int
          |> kontinue

let norm_op op kontinue = match op with
  | Syntax.OpReg op ->
    norm_reg op.reg (fun reg ->
      reg
        |> Asm.op_reg
        |> kontinue)
  | Syntax.OpImm op ->
    norm_imm op.value (fun imm ->
      imm
        |> Asm.op_imm
        |> kontinue)
  | Syntax.OpMem op ->
    norm_reg op.base (fun base ->
      norm_imm op.off (fun off ->
        match off with
          | Asm.ImmInt off ->
            Asm.op_mem base off.value
              |> kontinue))
  | Syntax.OpLbl op ->
    op.lbl
      |> Asm.op_lbl
      |> kontinue

let norm_optional fn opt kontinue = match opt with
  | Some value ->
    fn value (fun value ->
      kontinue (Some value))
  | None -> kontinue None

let norm_instr instr kontinue = match instr with
  | Syntax.Instr instr ->
    norm_mneu instr.mneu (fun mneu ->
      norm_op instr.rd (fun rd ->
        norm_optional norm_op instr.rs1 (fun rs1 ->
          norm_optional norm_op instr.rs2 (fun rs2 ->
            Asm.instr mneu rd rs1 rs2
              |> kontinue))))

let rec map fn lst kontinue = match lst with
  | hd :: tl ->
    fn hd (fun hd ->
      map fn tl (fun tl ->
        hd :: tl
          |> kontinue))
  | [] -> kontinue []

let norm_top top kontinue = match top with
  | Syntax.TopBlock top ->
    map norm_instr top.instrs (fun instrs ->
      Asm.top_block top.lbl instrs
        |> kontinue)

let norm_file file kontinue = match file with
  | Syntax.File file ->
    map norm_top file.tops (fun tops ->
      tops
        |> Asm.file
        |> kontinue)
