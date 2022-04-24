(** {1 Parsing} *)

(**
 * {2 Lexers}
 *)

val lexbuf_from_string : string -> Sedlexing.lexbuf
(** [lexbuf_from_string src] constructs a lexing buffer from the string [src]. *)

val lexbuf_from_file : string -> Sedlexing.lexbuf
(** [lexbuf_from_file path] constructs a lexing buffer reading from the file
    [path]. *)

(** {2 Entry Points} *)

val file : string -> (Syntax.file -> 'a) -> 'a
(** [file path kontinue] parses the file [file] and passes it to the
    continuation [kontinue]. *)
