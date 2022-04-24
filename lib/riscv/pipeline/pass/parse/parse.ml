module Menhir = Parser.MenhirInterpreter

include Lexer
include Parser

let file path kontinue =
  let parser = MenhirLib.Convert.Simplified.traditional2revised Parser.file in
  let res = path
    |> Lexer.lexbuf_from_file
    |> Sedlexing.with_tokenizer Lexer.lex
    |> parser
  in
  res kontinue
