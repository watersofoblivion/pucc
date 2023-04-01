{
  (* Constructors *)
  let lexbuf_from_string str = Lexing.from_string ~with_positions:true str
  let lexbuf_from_in_channel ic = Lexing.from_channel ~with_positions:true ic
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
  | eof { ParseToken.eof }

  (* Punctuation *)
  | "|"  { ParseToken.punct_pipe }
  | "->" { ParseToken.punct_arrow }
  (*
  | "="  { ParseToken.punct_eq }
  | "."  { ParseToken.punct_dot }
  | ","  { ParseToken.punct_comma }
  | ":"  { ParseToken.punct_colon }
  | ";"  { ParseToken.punct_semicolon }
  | "_"  { ParseToken.punct_ground }
  | "("  { ParseToken.punct_lparen }
  | ")"  { ParseToken.punct_rparen }
  | "["  { ParseToken.punct_lbracket }
  | "]"  { ParseToken.punct_rbracket }
  | "{"  { ParseToken.punct_lbrace }
  | "}"  { ParseToken.punct_rbrace }
  *)

  (* Operators *)
  (*
  | "&&"  { ParseToken.op_land }
  | "||"  { ParseToken.op_lor }
  | "!"   { ParseToken.op_lnot }
  | "+"   { ParseToken.op_add }
  | "-"   { ParseToken.op_sub }
  | "*"   { ParseToken.op_mul }
  | "/"   { ParseToken.op_div }
  | "%"   { ParseToken.op_mod }
  | "&"   { ParseToken.op_band }
  | "^"   { ParseToken.op_bxor }
  | "~"   { ParseToken.op_bnot }
  | "<<"  { ParseToken.op_ssl }
  | ">>"  { ParseToken.op_ssr }
  | "<<<" { ParseToken.op_usl }
  | ">>>" { ParseToken.op_usr }
  | "=="  { ParseToken.op_seq }
  | "===" { ParseToken.op_peq }
  | "!="  { ParseToken.op_sneq }
  | "!==" { ParseToken.op_pneq }
  | "<="  { ParseToken.op_lte }
  | "<"   { ParseToken.op_lt }
  | ">="  { ParseToken.op_gte }
  | ">"   { ParseToken.op_gt }
  | "|>"  { ParseToken.op_rfa }
  | ">>=" { ParseToken.op_bind }
  *)

  (* Keywords *)
  | "library"    { ParseToken.kwd_library }
  | "executable" { ParseToken.kwd_executable }
  | "import"     { ParseToken.kwd_import }
  (*
  | "type"       { ParseToken.kwd_type }
  | "val"        { ParseToken.kwd_val }
  | "def"        { ParseToken.kwd_def }
  | "let"        { ParseToken.kwd_let }
  | "rec"        { ParseToken.kwd_rec }
  | "in"         { ParseToken.kwd_in }
  | "case"       { ParseToken.kwd_case }
  | "of"         { ParseToken.kwd_of }
  | "end"        { ParseToken.kwd_end }
  | "if"         { ParseToken.kwd_if }
  | "then"       { ParseToken.kwd_then }
  | "else"       { ParseToken.kwd_else }
  | "lambda"     { ParseToken.kwd_lambda }
  | "do"         { ParseToken.kwd_do }
  *)

  (* Literals *)
  (*
  | "()"    { ParseToken.lit_unit }
  | "true"  { ParseToken.lit_true }
  | "false" { ParseToken.lit_false }
  | int_lit { ParseToken.lit_int lexbuf }
  *)
  | '"'     { str (Buffer.create 27) lexbuf }
  | ident   { ParseToken.lit_ident lexbuf }

and str buf = parse
  | "\\'"   { Buffer.add_char buf '\''; str buf lexbuf }
  | "\\\\"  { Buffer.add_char buf '\\'; str buf lexbuf }
  | '"'     { ParseToken.lit_string buf }
  | _ as ch { Buffer.add_char buf ch; str buf lexbuf }
