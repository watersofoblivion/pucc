(** {2 Assembly}
 *
 * Represents syntactically and semantically valid assembly.\
 *)

(* Data Types *)

type width =
  | DWord
  | Word
  | HWord
  | Byte

type comparator =
  | Eq
  | Ne
  | Ge
  | Lt

type mneu =
  | Load of { width: width; sext: bool }
  | Store of { width: width }
  | Add of { width: width; imm: bool }
  | Sub of { width: width; imm: bool }
  | And of { imm: bool }
  | Or of { imm: bool }
  | Xor of { imm: bool }
  | Sl of { width: width; imm: bool }
  | Sr of { width: width; imm: bool; arith: bool }
  | Jal of { reg: bool }
  | Br of { cmp: comparator; signed: bool }
  | ECall
  | EBreak
  | Slt of { imm: bool; signed: bool }
  | Auipc
  | Lui

type reg =
  | RegInt of { idx: int }

type imm =
  | ImmInt of { value: int }

type op =
  | OpReg of { reg: reg }
  | OpImm of { imm: imm }
  | OpMem of { base: reg; off: int }
  | OpLbl of { lbl: string }

type instr =
  | Instr of { mneu: mneu; rd: op; rs1: op option; rs2: op option }

type top =
  | TopBlock of { lbl: string; instrs: instr list }

type file =
  | File of { tops: top list }

(* Constructors *)

let mneu_load width sext = Load { width; sext }
let mneu_store width = Store { width }

let mneu_add width imm = Add { width; imm }
let mneu_sub width imm = Sub { width; imm }

let mneu_and imm = And { imm }
let mneu_or imm = Or { imm }
let mneu_xor imm = Xor { imm }

let mneu_sl width imm = Sl { width; imm }
let mneu_sr width imm arith = Sr { width; imm; arith }

let mneu_jal reg = Jal { reg }
let mneu_br cmp signed = Br { cmp; signed }

let mneu_ecall = ECall
let mneu_ebreak = EBreak

let mneu_slt imm signed = Slt { imm; signed }
let mneu_auipc = Auipc
let mneu_lui = Lui

let reg_int idx = RegInt { idx }

let imm_int value = ImmInt { value }

let op_reg reg = OpReg { reg }
let op_imm imm = OpImm { imm }
let op_mem base off = OpMem { base; off }
let op_lbl lbl = OpLbl { lbl }

let instr mneu rd rs1 rs2 = Instr { mneu; rd; rs1; rs2 }

let top_block lbl instrs = TopBlock { lbl; instrs }

let file tops = File { tops }
