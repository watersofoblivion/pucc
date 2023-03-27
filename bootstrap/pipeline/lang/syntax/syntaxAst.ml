(* Abstract Syntax *)

(* Data Types *)

type name =
  | Name of { loc: Core.loc; id: Core.sym; }

(* Package Statement *)

type pkg = 
  | Library of { loc: Core.loc; id: name; }
  | Executable of { loc: Core.loc; id: name; }

(* Imports *)

type path =
  | Path of { loc: Core.loc; path: string; }

type alias =
  | Alias of { loc: Core.loc; alias: name option; path: path }

type pkgs =
  | Packages of { loc: Core.loc; aliases: alias list; }

type import =
  | Import of { loc: Core.loc; pkgs: pkgs }

(* Files *)

type file =
  | File of { pkg: pkg; imports: import list; }

(* Constructors *)

let name loc id = Name { loc; id }

let pkg_library loc id = Library { loc; id }
let pkg_executable loc id = Executable { loc; id }

let path loc path = Path { loc; path }
let alias loc alias path = Alias { loc; alias; path }
let alias_named loc local path = alias loc (Some local) path
let alias_unnamed loc path = alias loc None path
let pkgs loc aliases = Packages { loc; aliases }
let import loc pkgs = Import { loc; pkgs }

let file pkg imports = File { pkg; imports }
