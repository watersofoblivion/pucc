type sloc = Lexing.position * Lexing.position
(** A source location *)

module type ParseActions = sig
  (** {1 Location Tracking} *)

  val loc : sloc -> Core.loc
  (**
   * Convert a source location to a location
   *
   * @param sloc The source location
   * @return The location
   *)
  
  (** {1 Names} *)

  val name : sloc -> string -> Syntax.name
  (**
   * Construct a simple name, such as [foo].
   *
   * @param sloc The source location of the name
   * @param lexeme The name
   * @param env The environment to symbolize the name in
   * @return An updated environment and the name
   *)
  
  val dotted : sloc -> Syntax.name -> Syntax.name -> Syntax.name
  (**
   * Construct a dotted name, such [foo.Bar].
   *
   * @param sloc The source location of the name
   * @param lhs The left-hand side of the name
   * @param rhs The right-hand-side of the name
   * @return An updated environment and the name
   *)
  
  (** {1 Types} *)

  (** {2 Visibility} *)

  val ty_vis_readonly : sloc -> Syntax.ty_vis
  (**
   * Construct a readonly type visibility
   * 
   * @param sloc The source location of the visibility
   * @return A readonly type visibility
   *)
  
  val ty_vis_abstract : sloc -> Syntax.ty_vis
  (**
   * Construct an abstract type visibility
   *
   * @param sloc The source location of the visibility
   * @return An abstract type visibility
   *)

  (** {2 Types} *)

  val ty_constr : sloc -> Syntax.name -> Syntax.ty_binding list option -> Syntax.ty
  (**
   * Construct a type constructor, such as [Int].
   *
   * @param sloc The source location of the type
   * @param constr The constructor
   * @param tys The type bindings for "with"
   * @return A type constructor
   *)

  val ty_fun : sloc -> Syntax.ty -> Syntax.ty -> Syntax.ty
  (**
   * Construct a function type, such as [Int -> Bool].
   *
   * @param sloc The source location of the type
   * @param param The parameter type
   * @param res The result type
   * @return A function type
   *)

  val ty_sig : sloc -> Syntax.sig_elem list -> Syntax.ty
  (**
   * Construct a module signature, such as:
   *
   * {|
   * mod
   *   type Foo = Int
   *   val Bar : Bool
   *   def Baz : Int -> Bool
   * end
   * |}
   *
   * @param sloc The source location of the signature
   * @param elems The signature elements
   * @return A module signature
   *)
  
  val ty_with : sloc -> Syntax.name -> Syntax.ty_binding list -> Syntax.ty
  (**
   * Construct a "module with" signature, such as:
   *
   * {|
   * pkg.Mod with type T = Int and type U = Bool
   * |}
   *
   * @param sloc The source location of the signature
   * @param name The signature name
   * @param tys The type bindings
   * @return A "module with" signature
   *)

  (** {2 Signature Elements} *)

  val sig_ty : sloc -> Syntax.name -> Syntax.mod_param list -> Syntax.ty -> Syntax.sig_elem
  (**
   * Construct a type definition signature element, such as [type Foo = Int].
   *
   * @param sloc The source location of the type
   * @param id The type identifier
   * @param params Optional module parameters
   * @param ty The type definition
   * @return A type definition signature element
   *)
  
  val sig_val : sloc -> Syntax.name -> Syntax.ty -> Syntax.sig_elem
  (**
   * Construct a value binding signature element, such as [val Foo: Int].
   *
   * @param sloc The source location of the type
   * @param id The value identifier
   * @param ty The value type
   * @return A value binding signature element
   *)
  
  val sig_def : sloc -> Syntax.name -> Syntax.ty -> Syntax.sig_elem 
  (**
   * Construct a function definition signature element, such as
   * [def Foo: Int -> Bool].
   *
   * @param sloc The source location of the type
   * @param id The function name
   * @param ty The function type
   * @param A function definition signature element
   *)

  val sig_mod : sloc -> Syntax.name -> Syntax.mod_param list -> Syntax.ty -> Syntax.sig_elem
  (**
   * Construct a module definition signature element, such as [type Foo = Int].
   *
   * @param sloc The source location of the module
   * @param id The module identifier
   * @param params Optional module parameters
   * @param ty The module signature
   * @return A module definition signature element
   *)

  (** {2 Type Bindings} *)

  val ty_binding : sloc -> Syntax.name -> Syntax.ty_vis option -> Syntax.ty -> Syntax.ty_binding
  (**
   * Construct a type binding, such as [T = Int].
   * 
   * @param sloc The source location of the binding
   * @param id The type identifier
   * @param vis The type visibility
   * @param ty The type definition
   * @return A type binding
   *)
  
  (** {2 Module Parameters} *)

  val mod_param : sloc -> Syntax.name -> Syntax.ty -> Syntax.mod_param
  (**
   * Construct a module parameter, such as [foo: bar.Baz].
   *
   * @param sloc The source location of the parameter
   * @param id The parameter name
   * @param ty The parameter type
   * @return A module parameter
   *)
  
  (** {1 Operators} *)

  (** {2 Unary} *)

  val un_neg : sloc -> Syntax.un
  (**
   * Construct a negation operator.
   *
   * @param sloc The source location of the operator
   * @return A negation operator
   *)
  
  val un_lnot : sloc -> Syntax.un
  (**
   * Construct a logical NOT operator
   *
   * @param sloc The source location of the operator
   * @return A logical NOT operator
   *)
  
   val un_bnot : sloc -> Syntax.un
   (**
    * Construct a bitwise NOT operator
    *
    * @param sloc The source location of the operator
    * @return A bitwise NOT operator
    *)
 
  (** {2 Binary} *)
  
  val bin_add : sloc -> Syntax.bin
  (**
   * Construct an addition operator
   *
   * @param sloc The source location of the operator
   * @return An addition operator
   *)
  
  val bin_sub : sloc -> Syntax.bin
  (**
   * Construct a subtraction operator
   *
   * @param sloc The source location of the operator
   * @return A subtraction operator
   *)
  
  val bin_mul : sloc -> Syntax.bin
  (**
   * Construct a multiplication operator
   *
   * @param sloc The source location of the operator
   * @return A multiplication operator
   *)
  
  val bin_div : sloc -> Syntax.bin
  (**
   * Construct a division operator
   *
   * @param sloc The source location of the operator
   * @return A division operator
   *)
  
  val bin_mod : sloc -> Syntax.bin
  (**
   * Construct a modulus operator
   *
   * @param sloc The source location of the operator
   * @return A modulus operator
   *)
  
  val bin_land : sloc -> Syntax.bin
  (**
   * Construct a logical AND operator
   *
   * @param sloc The source location of the operator
   * @return A logical AND operator
   *)

  val bin_lor : sloc -> Syntax.bin
  (**
   * Construct a logical OR operator
   *
   * @param sloc The source location of the operator
   * @return A logical OR operator
  *)
  
  val bin_band : sloc -> Syntax.bin
  (**
   * Construct a bitwise AND operator
   *
   * @param sloc The source location of the operator
   * @return A bitwise AND operator
   *)

  val bin_bor : sloc -> Syntax.bin
  (**
   * Construct a bitwise OR operator
   *
   * @param sloc The source location of the operator
   * @return A bitwise OR operator
   *)

  val bin_bxor : sloc -> Syntax.bin
  (**
   * Construct a bitwise XOR operator
   *
   * @param sloc The source location of the operator
   * @return A bitwise XOR operator
   *)

  val bin_ssl : sloc -> Syntax.bin
  (**
   * Construct a signed shift left operator
   *
   * @param sloc The source location of the operator
   * @return A signed shift left operator
   *)

  val bin_ssr : sloc -> Syntax.bin
  (**
   * Construct a signed shift right operator
   *
   * @param sloc The source location of the operator
   * @return A signed shift right operator
   *)

  val bin_usl : sloc -> Syntax.bin
  (**
   * Construct a unsigned shift left operator
   *
   * @param sloc The source location of the operator
   * @return A unsigned shift left operator
   *)
 
  val bin_usr : sloc -> Syntax.bin
  (**
   * Construct a unsigned shift right operator
   *
   * @param sloc The source location of the operator
   * @return A unsigned shift right operator
   *)
 
  val bin_seq : sloc -> Syntax.bin
  (**
   * Construct a structural equality operator
   *
   * @param sloc The source location of the operator
   * @return A structural equality operator
   *)
 
  val bin_peq : sloc -> Syntax.bin
  (**
   * Construct a physical equality operator
   *
   * @param sloc The source location of the operator
   * @return A physical equality operator
   *)

  val bin_sneq : sloc -> Syntax.bin
  (**
   * Construct a structural inequality operator
   *
   * @param sloc The source location of the operator
   * @return A structural inequality operator
   *)
  
  val bin_pneq : sloc -> Syntax.bin
  (**
   * Construct a physical inequality operator
   *
   * @param sloc The source location of the operator
   * @return A physical inequality operator
   *)
 
  val bin_lte : sloc -> Syntax.bin
  (**
   * Construct a less than or equal operator
   *
   * @param sloc The source location of the operator
   * @return A less than or equal operator
   *)
 
  val bin_lt : sloc -> Syntax.bin
  (**
   * Construct a less than operator
   *
   * @param sloc The source location of the operator
   * @return A less than operator
   *)
 
  val bin_gte : sloc -> Syntax.bin
  (**
   * Construct a greater than or equal operator
   *
   * @param sloc The source location of the operator
   * @return A greater than or equal operator
   *)
  
  val bin_gt : sloc -> Syntax.bin
  (**
   * Construct a greater than operator
   *
   * @param sloc The source location of the operator
   * @return A greater than operator
   *)

  (** {1 Patterns} *)

  val patt_ground : sloc -> Syntax.patt
  (**
   * Construct a ground pattern ([_])
   *
   * @param sloc The source location of the pattern
   * @return A ground pattern
   *)
  
  val patt_bool : sloc -> bool -> Syntax.patt
  (**
   * Construct a boolean literal pattern ([true] or [false])
   *
   * @param sloc The source location of the pattern
   * @param value The pattern value
   * @return A boolean literal pattern
   *)
  
  val patt_int : sloc -> string -> Syntax.patt
  (**
   * Construct an integer literal pattern ([1], [42], [-13], etc.)
   *
   * @param sloc The source location of the pattern
   * @param lexeme The pattern value
   * @return An integer literal pattern
   *)
  
  val patt_var : sloc -> string -> Syntax.patt
  (**
   * Construct a variable pattern ([x], [y], etc.)
   *
   * @param sloc The source location of the pattern
   * @param lexeme The variable name
   * @return A variable pattern
   *)
  
  val patt_fun : sloc -> Syntax.name -> Syntax.param list -> Syntax.patt
  (**
   * Construct a function pattern, such as [equal(x: Int, y: Int)]
   *
   * @param sloc The source location of the pattern
   * @param name The function name
   * @param params The function parameters
   * @return A function pattern
   *)

  (** {1 Parameters} *)

  val param : sloc -> Syntax.patt -> Syntax.ty -> Syntax.param
  (**
   * Construct a function parameter, such as [x: Int]
   *
   * @param sloc The source location of the parameter
   * @param patt The pattern the parameter matches
   * @param ty The parameter type
   * @return A function parameter
   *)
  
  (** {1 Expressions} *)

  val expr_bool : sloc -> bool -> Syntax.expr
  (**
   * Construct a boolean literal expression, such as [true]
   *
   * @param sloc The source location of the expression
   * @param value The literal value
   * @return A boolean literal expression
   *)
  
  val expr_int : sloc -> string -> Syntax.expr
  (**
   * Construct an integer literal expression, such as [1], [42], or [-3]
   *
   * @param sloc The source location of the expression
   * @param lexeme The integer lexeme
   * @return An integer literal expression
   *)

  val expr_id : sloc -> Syntax.name -> Syntax.expr
  (**
   * Construct an identifier literal expression, such as [foo] or [bar.Baz]
   *
   * @param sloc The source location of the expression
   * @param name The name referenced
   * @return An identifier literal expression
   *)

  val expr_un : sloc -> Syntax.un -> Syntax.expr -> Syntax.expr
  (**
   * Construct a unary operator expression, such as [!foo]
   * 
   * @param sloc The source location of the expression
   * @param op The unary operator
   * @param operand The operand
   * @return A unary operator expression
   *)

  val expr_bin : sloc -> Syntax.bin -> Syntax.expr -> Syntax.expr -> Syntax.expr
  (**
   * Construct a binary operator expression, such as [1 + 2]
   *
   * @param sloc The source location of the expression
   * @param op The binary operator
   * @param lhs The left-hand side operand
   * @param rhs The right-hand side operand
   * @return A binary operator expression
   *)

  val expr_cond : sloc -> Syntax.expr -> Syntax.expr -> Syntax.expr -> Syntax.expr
  (**
   * Construct a conditional expression, such as [if x == 3 then foo else bar]
   *
   * @param sloc The source location of the expression
   * @param cond The condition expression
   * @param tru The true case
   * @param fls The false case
   * @return A conditional expression
   *)

  val expr_let : sloc -> bool -> Syntax.binding list -> Syntax.expr -> Syntax.expr
  (**
   * Construct a let binding, such as [let rec x = 3 and foo(x: Int): Bool = x > 42 in foo(x)]
   *
   * @param sloc The source location of the expression
   * @param recur Whether the [rec] flag is present
   * @param bindings The value bindings
   * @param scope The scope of the bindings
   * @return A let binding
   *)
  
  val expr_abs : sloc -> Syntax.param list -> Syntax.ty option -> Syntax.expr -> Syntax.expr
  (**
   * Construct a function abstraction expression, such as [fun(x: Int, y: Int) = x >= y]
   *
   * @param sloc The source location of the expression
   * @param params The function parameters
   * @param ret The function return type
   * @param body The function body
   * @return A function abstraction expression
   *)

  val expr_app : sloc -> Syntax.expr -> Syntax.expr list -> Syntax.expr
  (**
   * Construct a function application expression, such as [foo(42, true)]
   *
   * @param sloc The source location of the expression
   * @param fn The function applied
   * @param args The arguments the function is applied to
   * @return A function application expression
   *)

  (** {1 Bindings} *)

  val binding : sloc -> Syntax.patt -> Syntax.ty option -> Syntax.expr -> Syntax.binding
  (**
   * Construct a value binding, such as [x = 3]
   * 
   * @param sloc The source location of the binding
   * @param patt The pattern bound
   * @param ty The type of the bound value
   * @param value The bound value
   * @return A value binding
   *)
  
  (** {1 Package Statements} *)

  val pkg_library : sloc -> Syntax.name -> Syntax.pkg
  (**
   * Construct a library package statement, such as [library foo]
   *
   * @param sloc The source location of the package statement
   * @param name The package name
   * @return A library package statement
   *)

  val pkg_executable : sloc -> Syntax.name -> Syntax.pkg
  (**
   * Construct an executable package statement, such as [executable foo]
   *
   * @param sloc The source location of the package statement
   * @param name The package name
   * @return An executable package statement
   *)

  (** {1 Imports} *)

  val path : sloc -> string -> Syntax.path
  (**
   * Construct a package path, such as ["path/to/package"]
   *
   * @param sloc The source location of the path
   * @param path The package path
   * @return A package path
   *)

  val alias : sloc -> Syntax.name option -> Syntax.path -> Syntax.alias
  (**
   * Construct a package alias clause, such as [localnane -> "path/to/package"]
   *
   * @param sloc The source location of the alias clause
   * @param name The optional local name of the package
   * @param path The package path
   * @return An alias clause
   *)

  val pkgs : sloc -> Syntax.alias list -> Syntax.pkgs
  (**
   * Construct a package alias list, such as:
   *
   * {|
   * | "path/to/package"
   * | localname -> "path/to/another/package"
   * |}
   *
   * @param sloc The source location of the package alias list
   * @param aliaes The list of package aliases
   * @return A package alias list
   *)

  val import : sloc -> Syntax.pkgs -> Syntax.import
  (**
   * Construct an import statement, such as [import "path/to/package"] or:
   *
   * {|
   * import
   *   | "path/to/package"
   *   | localname -> "path/to/another/package"
   * |}
   *
   * @param sloc The source location of the import statement
   * @param pkgs The package alias list
   * @return An import statement
   *)

  (** {1 Files} *)

  val file : sloc -> Syntax.pkg -> Syntax.import list -> Syntax.struct_elem list -> Syntax.file
  (**
   * Construct a source file
   *
   * @param sloc The source location of the file
   * @param pkg The package statement
   * @param imports The import statements
   * @param tops The top-level bindings
   * @return A source file
   *)
end
(** Parsing actions *)

module Actions : ParseActions = struct
  (* Location Tracking *)

  type sloc = Lexing.position * Lexing.position
  let loc (start_pos, end_pos) =
    let start = Core.lexing_position start_pos in
    let stop = Core.lexing_position end_pos in
    Core.loc start stop    

  (* Names *)

  let name sloc lexeme =
    let loc = loc sloc in
    Syntax.name loc lexeme

  let dotted sloc lhs rhs =
    let loc = loc sloc in
    Syntax.dotted loc lhs rhs

  (* Type Visibility *)

  let ty_vis_readonly sloc =
    let loc = loc sloc in
    Syntax.ty_vis_readonly loc
  
  let ty_vis_abstract sloc =
    let loc = loc sloc in
    Syntax.ty_vis_abstract loc

  (* Types *)

  let ty_constr sloc constr tys =
    let loc = loc sloc in
    Syntax.ty_constr loc name
  
  let ty_fun sloc param res =
    let loc = loc sloc in
    Syntax.ty_fun loc param res
  
  let ty_sig sloc elems =
    let loc = loc sloc in
    Syntax.ty_sig loc elems
  
  let ty_with sloc name tys =
    let loc = loc sloc in
    Syntax.ty_with loc name tys

  (* Signature Elements *)

  let sig_ty sloc name params ty =
    let loc = loc sloc in
    let params = match params with
      | Some params -> params
      | None -> []
    in
    Syntax.sig_ty loc name params ty

  let sig_val sloc name ty =
    let loc = loc sloc in
    Syntax.sig_val loc name ty

  let sig_def sloc name ty =
    let loc = loc sloc in
    Syntax.sig_def loc name ty

  let sig_mod sloc name params ty =
    let loc = loc sloc in
    Syntax.sig_mod loc name params ty
  
  (* Type Bindings *)

  let ty_binding sloc name vis ty =
    let loc = loc sloc in
    Syntax.ty_binding loc name vis ty
  
  (* Module Parameters *)
  
  let mod_param sloc name ty =
    let loc = loc sloc in
    Syntax.mod_param loc name ty

  (* Operators *)

  (* Unary *)

  let un_neg sloc =
    let loc = loc sloc in
    Syntax.un_neg loc
  
  let un_lnot sloc =
    let loc = loc sloc in
    Syntax.un_lnot loc
  
  let un_bnot sloc =
    let loc = loc sloc in
    Syntax.un_bnot loc
  
  (* Binary *)

  let bin_add sloc =
    let loc = loc sloc in
    Syntax.bin_add loc

  let bin_sub sloc =
    let loc = loc sloc in
    Syntax.bin_sub loc

  let bin_mul sloc =
    let loc = loc sloc in
    Syntax.bin_mul loc
  
  let bin_div sloc =
    let loc = loc sloc in
    Syntax.bin_div loc

  let bin_mod sloc =
    let loc = loc sloc in
    Syntax.bin_mod loc

  let binbland sloc =
    let loc = loc sloc in
    Syntax.bin_land loc

  let bin_lor sloc =
    let loc = loc sloc in
    Syntax.bin_lor loc

  let bin_band sloc =
    let loc = loc sloc in
    Syntax.bin_band loc

  let bin_bor sloc =
    let loc = loc sloc in
    Syntax.bin_bor loc

  let bin_bxor sloc =
    let loc = loc sloc in
    Syntax.bin_bxor loc

  let bin_ssl sloc =
    let loc = loc sloc in
    Syntax.bin_ssl loc

  let bin_ssr sloc =
    let loc = loc sloc in
    Syntax.bin_ssr loc

  let bin_usl sloc =
    let loc = loc sloc in
    Syntax.bin_usl loc
  
  let bin_usr sloc =
    let loc = loc sloc in
    Syntax.bin_usr loc

  let bin_seq sloc =
    let loc = loc sloc in
    Syntax.bin_seq loc

  let bin_peq sloc =
    let loc = loc sloc in
    Syntax.bin_peq loc
    
  let bin_sneq sloc =
    let loc = loc sloc in
    Syntax.bin_sneq loc

  let bin_pneq sloc =
    let loc = loc sloc in
    Syntax.bin_pneq loc

  let bin_lte sloc =
    let loc = loc sloc in
    Syntax.bin_lte loc

  let bin_lt sloc =
    let loc = loc sloc in
    Syntax.bin_lt loc

  let bin_gte sloc =
    let loc = loc sloc in
    Syntax.bin_gte loc

  let bin_gt sloc =
    let loc = loc sloc in
    Syntax.bin_gt loc

  let bin_rfa sloc =
    let loc = loc sloc in
    Syntax.bin_rfa loc

  (* Patterns *)

  let patt_ground sloc =
    let loc = loc sloc in
    Syntax.patt_ground loc

  let patt_bool sloc value =
    let loc = loc sloc in
    Syntax.patt_bool loc value

  let patt_int sloc lexeme =
    let loc = loc sloc in
    Syntax.patt_int loc lexeme
  
  let patt_var sloc lexeme =
    let loc = loc sloc in
    Syntax.patt_var loc lexeme
  
  let patt_fun sloc name params =
    let loc = loc sloc in
    Syntax.patt_fun loc name params

  (* Parameters *)

  let param sloc patt ty =
    let loc = loc sloc in
    Syntax.param loc patt ty

  (* Expressions *)

  let expr_bool sloc value =
    let loc = loc sloc in
    Syntax.expr_bool loc value
  
  let expr_int sloc lexeme =
    let loc = loc sloc in
    Syntax.expr_int loc lexeme
  
  let expr_id sloc name =
    let loc = loc sloc in
    Syntax.expr_id loc name
  
  let expr_un sloc op operand =
    let loc = loc sloc in
    Syntax.expr_un loc op operand
  
  let expr_bin sloc op lhs rhs =
    let loc = loc sloc in
    Syntax.expr_bin loc op lhs rhs

  let expr_cond sloc cond tru fls =
    let loc = loc sloc in
    Syntax.cond loc cond tru fls

  let expr_let sloc recur bindings scope =
    let loc = loc sloc in
    Syntax.expr_let loc recur bindings scope
  
  let expr_abs sloc params ret body =
    let loc = loc sloc in
    Syntax.expr_abs loc params ret body
  
  let expr_app sloc fn args =
    let loc = loc sloc in
    Syntax.expr_app loc fn args

  (* Bindings *)

  let binding sloc patt ty value =
    let loc = loc sloc in
    Syntax.binding loc patt ty value
  
  (* Package Statements *)

  let pkg_library sloc name =
    let loc = loc sloc in
    Syntax.pkg_library loc name
  
  let pkg_executable sloc name =
    let loc = loc sloc in
    Syntax.pkg_executable loc name
  
  (* Imports *)

  let path sloc path =
    let loc = loc sloc in
    Syntax.path loc path
  
  let alias sloc alias path =
    let loc = loc sloc in
    Syntax.alias loc alias path
  
  let pkgs sloc aliases =
    let loc = loc sloc in
    Syntax.pkgs loc aliases
  
  let import sloc pkgs =
    let loc = loc sloc in
    Syntax.import loc pkgs

  (* Top-Level Bindings *)



  (* Files *)

  let file sloc pkg imports tops =
    let loc = loc sloc in
    Syntax.file loc pkg imports tops
end