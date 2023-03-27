{
  (* Constructors *)
  let lexbuf_from_string str = Lexing.from_string ~with_positions:true str
  let lexbuf_from_in_channel ic = Lexing.from_channel ~with_positions:true ic

  (* Unprintable *)
  let eof = Parser.EOF

  (* Punctuation *)
  let punct_pipe = Parser.PUNCT_PIPE
  let punct_arrow = Parser.PUNCT_ARROW
  (*
  let punct_eq = Parser.PUNCT_EQ
  let punct_dot = Parser.PUNCT_DOT
  let punct_comma = Parser.PUNCT_COMMA
  let punct_colon = Parser.PUNCT_COLON
  let punct_semicolon = Parser.PUNCT_SEMICOLON
  let punct_ground = Parser.PUNCT_GROUND
  let punct_lparen = Parser.PUNCT_LPAREN
  let punct_rparen = Parser.PUNCT_RPAREN
  let punct_lbracket = Parser.PUNCT_LBRACKET
  let punct_rbracket = Parser.PUNCT_RBRACKET
  let punct_lbrace = Parser.PUNCT_LBRACE
  let punct_rbrace = Parser.PUNCT_RBRACE
  *)

  (* Operators *)
  (*
  let op_land = Parser.OP_LAND
  let op_lor = Parser.OP_LOR
  let op_lnot = Parser.OP_LNOT
  let op_add = Parser.OP_ADD
  let op_sub = Parser.OP_SUB
  let op_mul = Parser.OP_MUL
  let op_div = Parser.OP_DIV
  let op_mod = Parser.OP_MOD
  let op_band = Parser.OP_BAND
  let op_bxor = Parser.OP_BXOR
  let op_bnot = Parser.OP_BNOT
  let op_ssl = Parser.OP_SSL
  let op_ssr = Parser.OP_SSR
  let op_usl = Parser.OP_USL
  let op_usr = Parser.OP_USR
  let op_seq = Parser.OP_SEQ
  let op_peq = Parser.OP_PEQ
  let op_sneq = Parser.OP_SNEQ
  let op_pneq = Parser.OP_PNEQ
  let op_lte = Parser.OP_LTE
  let op_lt = Parser.OP_LT
  let op_gte = Parser.OP_GTE
  let op_gt = Parser.OP_GT
  let op_rfa = Parser.OP_RFA
  let op_bind = Parser.OP_BIND
  *)

  (* Keywords *)
  let kwd_library = Parser.KWD_LIBRARY
  let kwd_executable = Parser.KWD_EXECUTABLE
  let kwd_import = Parser.KWD_IMPORT
  (*
  let kwd_type = Parser.KWD_TYPE
  let kwd_val = Parser.KWD_VAL
  let kwd_def = Parser.KWD_DEF
  let kwd_let = Parser.KWD_LET
  let kwd_rec = Parser.KWD_REC
  let kwd_in = Parser.KWD_IN
  let kwd_case = Parser.KWD_CASE
  let kwd_of = Parser.KWD_OF
  let kwd_end = Parser.KWD_END
  let kwd_if = Parser.KWD_IF
  let kwd_then = Parser.KWD_THEN
  let kwd_else = Parser.KWD_ELSE
  let kwd_lambda = Parser.KWD_LAMBDA
  let kwd_do = Parser.KWD_DO
  *)

(*
  let lit_true = Parser.LIT_TRUE
  let lit_false = Parser.LIT_FALSE
  let lit_int lexbuf =
    let lexeme = Lexing.lexeme lexbuf in
    Parser.LIT_INT lexeme
*)
  let lit_string buf = 
    let lexeme = Buffer.contents buf in
    Buffer.clear buf;
    Parser.LIT_STRING lexeme
  let lit_ident lexbuf =
    let lexeme = Lexing.lexeme lexbuf in
    Parser.LIT_IDENT lexeme
}

(*
let sign = ('-'|'+')

let bin_prefix = "0b"
let bin_digit = ['0'-'1']
let bin_lit = bin_prefix bin_digit+

let oct_prefix = "0o"
let oct_digit = ['0'-'7']
let oct_lit = oct_prefix oct_digit+

let dec_prefix = "0d"
let dec_digit = ['0'-'9']
let dec_lit = dec_prefix? dec_digit+

let hex_prefix = "0x"
let hex_digit = ['0'-'9' 'A'-'F' 'a'-'f']
let hex_lit = hex_prefix hex_digit+

let int_lit = sign? (bin_lit | oct_lit | dec_lit | hex_lit)
*)

let ident_leading = ['A'-'Z' 'a'-'z' '_']
let ident = ['A'-'Z' 'a'-'z' '0'-'9' '_']
let pred_suffix = '?'
let prime = '\''
let primes_suffix = prime+
let ident_suffix = (pred_suffix | primes_suffix)
let ident = ident_leading+ ident* ident_suffix?

rule token = parse
  (* Whitespace *)
  | [' ' '\t' '\r']+ { token lexbuf }
  | '\n'             { Lexing.new_line lexbuf; token lexbuf }

  (* Unprintable *)
  | eof { eof }

  (* Punctuation *)
  | "|"  { punct_pipe }
  | "->" { punct_arrow }
  (*
  | "="  { punct_eq }
  | "."  { punct_dot }
  | ","  { punct_comma }
  | ":"  { punct_colon }
  | ";"  { punct_semicolon }
  | "_"  { punct_ground }
  | "("  { punct_lparen }
  | ")"  { punct_rparen }
  | "["  { punct_lbracket }
  | "]"  { punct_rbracket }
  | "{"  { punct_lbrace }
  | "}"  { punct_rbrace }
  *)

  (* Operators *)
  (*
  | "&&"  { op_land }
  | "||"  { op_lor }
  | "!"   { op_lnot }
  | "+"   { op_add }
  | "-"   { op_sub }
  | "*"   { op_mul }
  | "/"   { op_div }
  | "%"   { op_mod }
  | "&"   { op_band }
  | "^"   { op_bxor }
  | "~"   { op_bnot }
  | "<<"  { op_ssl }
  | ">>"  { op_ssr }
  | "<<<" { op_usl }
  | ">>>" { op_usr }
  | "=="  { op_seq }
  | "===" { op_peq }
  | "!="  { op_sneq }
  | "!==" { op_pneq }
  | "<="  { op_lte }
  | "<"   { op_lt }
  | ">="  { op_gte }
  | ">"   { op_gt }
  | "|>"  { op_rfa }
  | ">>=" { op_bind }
  *)

  (* Keywords *)
  | "library"    { kwd_library }
  | "executable" { kwd_executable }
  | "import"     { kwd_import }
  (*
  | "type"       { kwd_type }
  | "val"        { kwd_val }
  | "def"        { kwd_def }
  | "let"        { kwd_let }
  | "rec"        { kwd_rec }
  | "in"         { kwd_in }
  | "case"       { kwd_case }
  | "of"         { kwd_of }
  | "end"        { kwd_end }
  | "if"         { kwd_if }
  | "then"       { kwd_then }
  | "else"       { kwd_else }
  | "lambda"     { kwd_lambda }
  | "do"         { kwd_do }
  *)

  (* Literals *)
  (*
  | "()"    { lit_unit }
  | "true"  { lit_true }
  | "false" { lit_false }
  | int_lit { lit_int lexbuf }
  *)
  | '"'     { str (Buffer.create 27) lexbuf }
  | ident   { lit_ident lexbuf }

and str buf = parse
  | "\\'"   { Buffer.add_char buf '\''; str buf lexbuf }
  | "\\\\"  { Buffer.add_char buf '\\'; str buf lexbuf }
  | '"'     { lit_string buf }
  | _ as ch { Buffer.add_char buf ch; str buf lexbuf }
