(* Abstract Syntax *)

(* Data Types *)

type mneu =
  | Mneu of { segs: string list }

type imm =
  | ImmInt of { lexeme: string }

type reg_ty =
  | RegTyInt

type reg =
  | RegGeneral of { ty: reg_ty; idx: string }

type op =
  | OpReg of { reg: reg }
  | OpImm of { value: imm }
  | OpMem of { base: reg; off: imm }
  | OpLbl of { lbl: string }

type instr =
  | Instr of { mneu: mneu; rd: op; rs1: op option; rs2: op option }

type top =
  | TopBlock of { lbl: string; instrs: instr list }

type file =
  | File of { tops: top list }

(* Constructors *)

let mneu segs = Mneu { segs }

let imm_int lexeme = ImmInt { lexeme }

let reg_ty_int = RegTyInt

let reg_general ty idx = RegGeneral { ty; idx }

let op_reg reg = OpReg { reg }
let op_imm value = OpImm { value }
let op_mem base off = OpMem { base; off }
let op_lbl lbl = OpLbl { lbl }

let instr mneu rd rs1 rs2 = Instr { mneu; rd; rs1; rs2 }

let top_block lbl instrs = TopBlock { lbl; instrs }

let file tops = File { tops }
