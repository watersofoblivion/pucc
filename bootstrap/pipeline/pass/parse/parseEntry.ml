(* Parser Entry Points *)

let parse_file_from_channel ic env =
  let lexbuf = Lexer.lexbuf_from_in_channel ic in
  Parser.file Lexer.token lexbuf env

let parse_file ?env:(ParseEnv.env) src =
  let lexbuf = Lexer.lexbuf_from_string src in
  Parser.file Lexer.token lexbuf env

let parse_pkg ?env:(ParseEnv.env) src =
  let lexbuf = Lexer.lexbuf_from_string src in
  Parser.pkg Lexer.token lexbuf env

let parse_import ?env:(ParseEnv.env) src =
  let lexbuf = Lexer.lexbuf_from_string src in
  Parser.import Lexer.token lexbuf env
