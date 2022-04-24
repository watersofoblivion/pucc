(* Exceptions *)

exception UnsupportedMneumonic of { mneu: Asm.mneu }
exception InvalidMneumonicWidth of { mneu: Asm.mneu; allowed: Asm.width list }
exception RegisterIndexOutOfBounds of { reg: Asm.reg; limit: int }
exception IntegerImmediateOutOfBounds of { value: int; min: int; max: int }
exception OffsetOutOfBounds of { off: int; min: int; max: int }
exception MissingOperands of { instr: Asm.instr; rd: bool; rs1: bool; rs2: bool }
exception ExtraOperands of { instr: Asm.instr; rd: bool; rs1: bool; rs2: bool }
exception UnknownLabel of { lbl: string }
exception DuplicateLabel of { lbl: string }

(* Environment *)

module Labels = Set.Make (struct
  type t = string
  let compare = compare
end)

type arch =
  | Arch32
  | Arch64

type ext =
  | M
  | A
  | Zicsr
  | Counters
  | F
  | D
  | Q
  | L
  | B
  | V

type env = {
  arch: arch;
  priv: bool;
  emb:  bool;
  exts: ext list;
  lbls: Labels.t
}

let empty arch priv emb exts =
  { arch; priv; emb; exts; lbls = Labels.empty }

let is_target_32 env = match env.arch with
  | Arch32 -> true
  | _ -> false

let is_embedded env = env.emb

(* let bind env lbl kontinue =
  { env with lbls = Labels.add lbl env.lbls }
    |> kontinue *)

let lookup env lbl kontinue =
  try
    Labels.find lbl env.lbls
      |> kontinue
  with Not_found ->
    UnknownLabel { lbl }
      |> raise

(* Checkers *)

let load_store_width env mneu width kontinue =
  if is_target_32 env
  then match width with
    | Asm.DWord ->
      InvalidMneumonicWidth { mneu; allowed = [Asm.Word; Asm.HWord; Asm.Byte] }
        |> raise
    | _ -> kontinue env mneu
  else kontinue env mneu

let allowed_arith_widths env =
  if is_target_32 env
  then [Asm.Word]
  else [Asm.DWord; Asm.Word]

let wide_width env mneu width kontinue = match width with
  | Asm.HWord | Asm.Byte ->
    let allowed = allowed_arith_widths env in
    InvalidMneumonicWidth { mneu; allowed }
      |> raise
  | _ -> kontinue env mneu

let arith_width constr env mneu width imm kontinue =
  wide_width env mneu width (fun env mneu ->
    if is_target_32 env
    then match width with
      | Asm.DWord ->
        constr Asm.Word imm
          |> kontinue env
      | Asm.Word ->
        UnsupportedMneumonic { mneu }
          |> raise
      | _ -> failwith "Should have been caught by wide_width"
    else kontinue env mneu)

let check_mneu env mneu kontinue = match mneu with
  | Asm.Load load -> load_store_width env mneu load.width kontinue
  | Asm.Store store -> load_store_width env mneu store.width kontinue
  | Asm.Add add -> arith_width Asm.mneu_add env mneu add.width add.imm kontinue
  | Asm.Sub sub -> arith_width Asm.mneu_sub env mneu sub.width sub.imm kontinue
  | Asm.Sl sl -> arith_width Asm.mneu_sl env mneu sl.width sl.imm kontinue
  | Asm.Sr sr -> arith_width (fun width imm -> Asm.mneu_sr width imm sr.arith) env mneu sr.width sr.imm kontinue
  | _ -> kontinue env mneu

let check_reg env reg kontinue = match reg with
  | Asm.RegInt r ->
    let limit = if is_embedded env then 16 else 32 in
    if is_embedded env && r.idx >= limit
    then
      RegisterIndexOutOfBounds { reg; limit }
        |> raise
    else kontinue env reg

let check_imm env imm kontinue = match imm with
  | Asm.ImmInt i ->
    let limit = 1 lsl 20 in
    if i.value >= limit || i.value < -limit
    then
      IntegerImmediateOutOfBounds { value = i.value; min = -limit; max = limit }
        |> raise
    else kontinue env imm

let rec check_op env op kontinue =
  let kontinue _ _ = kontinue env op in
  match op with
    | Asm.OpReg op -> check_reg env op.reg kontinue
    | Asm.OpImm op -> check_imm env op.imm kontinue
    | Asm.OpMem o -> check_op_mem env op o.base o.off kontinue
    | Asm.OpLbl o -> check_op_lbl env op o.lbl kontinue
and check_op_mem env op base off kontinue =
  check_reg env base (fun _ _ ->
    let limit = 1 lsl 12 in
    if off >= limit || off < -limit
    then
      OffsetOutOfBounds { off; min = -limit; max = limit }
        |> raise
    else kontinue env op)
and check_op_lbl env op lbl kontinue =
  lookup env lbl (fun _ ->
    kontinue env op)

let check_instr env instr kontinue = kontinue env instr

let check_top env top kontinue = kontinue env top
let check_file env file kontinue = kontinue env file

(*

let assert_operand_size width mneu = match width with
  | DWord | Word -> mneu
  | _ ->
    InvalidMneumonicWidth { width; allowed = [DWord; Word] }
      |> raise

let assert_register_bounds reg =
  let (limit, idx) = match reg with
    | RegInt reg -> (32, reg.idx)
  in
  if idx >= 0 && idx < limit
  then reg
  else
    RegisterIndexOutOfBounds { idx; limit }
      |> raise

*)

(*

let assert_reg_op op = match op with
  | OpReg _ -> op
  | _ -> failwith "BOOM"

let assert_imm_op op = match op with
  | OpImm _ -> op
  | _ -> failwith "BOOM"

let assert_reg_imm_op op = match op with
  | OpReg _ | OpImm _ -> op
  | _ -> failwith "BOOM"

let assert_mem_op op = match op with
  | OpMem _ -> op
  | _ -> failwith "BOOM"

let assert_lbl_op op = match op with
  | OpLbl _ -> op
  | _ -> failwith "BOOM"

let assert_lbl_imm_op op = match op with
  | OpLbl _ | OpImm _ -> op
  | _ -> failwith "BOOM"

let assert_no_op = function
  | None -> None
  | Some _ -> failwith "BOOM"
let assert_some_op fn = function
  | Some op -> Some (fn op)
  | None -> failwith "BOOM"
let assert_some_reg_op = assert_some_op assert_reg_op
let assert_some_imm_op = assert_some_op assert_imm_op
let assert_some_reg_imm_op = assert_some_op assert_reg_imm_op
let assert_some_mem_op = assert_some_op assert_mem_op
let assert_some_lbl_imm_op = assert_some_op assert_lbl_imm_op

let rec instr mneu rd rs1 rs2 = match mneu with
  | Load _ -> load_instr mneu rd rs1 rs2
  | Store _ -> store_instr mneu rd rs1 rs2
  | Add _ | Sub _ | And | Or | Xor | Sl _ | Sr _ | Slt _ -> rr_ri_instr mneu rd rs1 rs2
  | Jal jal -> jump_instr jal.reg mneu rd rs1 rs2
  | Br _ -> branch_instr mneu rd rs1 rs2
  | Auipc | Lui -> misc_instr mneu rd rs1 rs2
and load_instr mneu rd rs1 rs2 =
  let rd = assert_reg_op rd in
  let rs1 = assert_some_mem_op rs1 in
  rs2
    |> assert_no_op
    |> instr' mneu rd rs1
and store_instr mneu rd rs1 rs2 =
  let rd = assert_mem_op rd in
  let rs1 = assert_some_reg_op rs1 in
  rs2
    |> assert_no_op
    |> instr' mneu rd rs1
and rr_ri_instr mneu rd rs1 rs2 =
  let rd = assert_reg_op rd in
  let rs1 = assert_some_reg_op rs1 in
  rs2
    |> assert_some_reg_imm_op
    |> instr' mneu rd rs1
and jump_instr reg mneu rd rs1 rs2 =
  if reg
  then
    let rd = assert_reg_op rd in
    let rs1 = assert_some_reg_op rs1 in
    rs2
      |> assert_some_lbl_imm_op
      |> instr' mneu rd rs1
  else
    let rd = assert_lbl_imm_op rd in
    let rs1 = assert_no_op rs1 in
    rs2
      |> assert_no_op
      |> instr' mneu rd rs1
and branch_instr _ _ _ _ = failwith "Boom"

and misc_instr mneu rd rs1 rs2 =
  let rd = assert_reg_op rd in
  let rs1 = assert_some_imm_op rs1 in
  rs2
    |> assert_no_op
    |> instr' mneu rd rs1
and instr' mneu rd rs1 rs2 = Instr { mneu; rd; rs1; rs2 }

*)
