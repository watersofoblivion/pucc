(* Encoded Instructions *)

type t =
  | R of { opcode: bytes; funct: bytes; rd: bytes; rs1: bytes; rs2: bytes }
  | I of { opcode: bytes; funct: bytes; rd: bytes; rs1: bytes; imm: bytes }
  | S of { opcode: bytes; funct: bytes; rd: bytes; rs1: bytes; rs2: bytes; imm: bytes }
  | B of { opcode: bytes; funct: bytes; rs1: bytes; rs2: bytes; imm: bytes }
  | U of { opcode: bytes; rd: bytes; imm: bytes }
  | J of { opcode: bytes; rd: bytes; imm: bytes }

(* Constructors *)

let r opcode funct rd rs1 rs2 = R { opcode; funct; rd; rs1; rs2 }
let i opcode funct rd rs1 imm = I { opcode; funct; rd; rs1; imm }
let s opcode funct rd rs1 rs2 imm = S { opcode; funct; rd; rs1; rs2; imm }
let b opcode funct rs1 rs2 imm = B { opcode; funct; rs1; rs2; imm }
let u opcode rd imm = U { opcode; rd; imm }
let j opcode rd imm = J { opcode; rd; imm }
