(**
 * {1 Abstract Syntax}
 *
 * A partially typed abstract syntax.
 *)

(**
 * {2 Data Types}
 * 
 * The data types to represent the abstract syntax.
 *)

type name = private
  | Name of {
      loc: Core.loc; (** The location of the name *)
      id:  Core.sym; (** The name *)
    } (** A name *)
(** Names *)

(**
 * {3 Package Statements}
 *)

type pkg = private
  | Library of {
      loc: Core.loc; (** The location of the package statement *)
      id:  name;     (** The name of the library *)
    } (** A library *)
  | Executable of {
      loc: Core.loc; (** The location of the package statement *)
      id:  name;     (** The name of the executable *)
    } (** An executable *)
(** Package Statements *)

(**
 * {3 Imports}
 *)

type path = private
  | Path of {
      loc:  Core.loc; (** The location of the package path *)
      path: string;   (** The package path *)
    } (** A package path *)
(** Package Paths *)

type alias = private
  | Alias of {
      loc:   Core.loc;    (** The location of the alias *)
      alias: name option; (** The local alias *)
      path:  path;        (** The package path *)
  }
(** Aliased Imports *)

type pkgs = private
  | Packages of {
      loc:     Core.loc;   (** The location of the package list *)
      aliases: alias list; (** The aliased imports *)
    } (** A package alias list *)
(** Package Alias Lists *)

type import = private
  | Import of {
      loc:  Core.loc; (** The location of the import statement *)
      pkgs: pkgs;     (** The import list *)
    }
(** Import Statements *)

(**
 * {3 Files}
 *)

type file = private
  | File of {
      pkg: pkg;             (** The package statement *)
      imports: import list; (** The import statements *)
    }
(** Source Files *)

(**
 * {2 Constructors}
 *
 * Construct values of the abstract syntax.
 *)

val name : Core.loc -> Core.sym -> name
(**
 * Construct a name.
 *
 * @param loc The location of the name
 * @param id The identifier of the name
 * return A name
 *)

(**
 * {3 Package Statements}
 *)

val pkg_library : Core.loc -> name -> pkg
(**
 * Construct a library package.
 *
 * @param loc The location of the package statement
 * @param id The name of the library
 * @return A library package
 *)

val pkg_executable : Core.loc -> name -> pkg
(**
 * Construct an executable package.
 *
 * @param loc The location of the package statement
 * @param id The name of the library
 * @return An executable package
 *)

(**
 * {3 Imports}
 *)

val path : Core.loc -> string -> path
(**
 * Construct a package path.
 * 
 * @param loc The location of the package path
 * @param path The path of the package
 * @return A package path
 *)

val alias : Core.loc -> name option -> path -> alias
(**
 * Construct a package alias clause with an optional local name.
 *
 * @param loc The location of the alias clause
 * @param name The optional local name of the package
 * @param path The package path
 * @return An alias clause
 *)

val alias_named : Core.loc -> name -> path -> alias
(**
 * Construct a locally named alias clause.  This is an alias for
 * [alias loc (Some name) path].
 * 
 * @param loc The location of the alias clause
 * @param local The local name of the package
 * @param path The package path
 * @return An alias clause
 *)

val alias_unnamed : Core.loc -> path -> alias
(**
 * Construct an alias clause using the default package name.  This is an alias
 * for [alias loc None path].
 * 
 * @param loc The location of the alias clause
 * @param path The package path
 * @return An alias clause
 *)

val pkgs : Core.loc -> alias list -> pkgs
(**
 * Construct a package alias list.
 *
 * @param loc The location of the alias clause
 * @param aliases The package aliases
 * @return A package alias list 
 *)

val import : Core.loc -> pkgs -> import
(**
 * Construct an import statement.
 *
 * @param loc The location of the import statement
 * @param pkgs The package alias list
 * @return An import statement
 *)

(**
 * {3 Files}
 *)

val file : pkg -> import list -> file
(**
 * Constructs a source file.
 * 
 * @param pkg The package statement
 * @param imports The import statements
 * @return A source file
 *)