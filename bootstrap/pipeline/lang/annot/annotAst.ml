(* Annotated Syntax *)

(* Data Types *)

type pkg = 
  | Library of { id: Core.sym; }
  | Executable of { id: Core.sym; }

type file =
  | File of { pkg: pkg; }

(* Constructors *)

let pkg_library id = Library { id }
let pkg_executable id = Executable { id }

let file pkg = File { pkg }