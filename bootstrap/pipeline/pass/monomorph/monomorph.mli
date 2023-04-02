(**
 * {1 Monomorphization}
 *
 * Converts the multi-package polymorphic A-Normal form intermediate
 * representation into a single package of monomorphic A-Normal form
 * intermediate representation.
 *
 * This pass is the first step in the "linking" phase of the compiler.  It is
 * expected that exactly one of the packages being merged is an [executable]
 * package and the rest are [library] packages supporting that executable.
 * This pass merges all of them into a single program suitable for
 * whole-program optimization.
 *
 * The set of packages are concatenated in topological (dependency) order.
 * Since all of the type and value bindings in the packages are already in
 * topological order, their concatenation preserves this order across the whole
 * program, simplifying any further analysis and optimization passes.
 *
 * Several tasks are performed concurrently in this pass:
 *
 * {ul
 *   {li All package are flattened into a single executable package}
 *   {li All imports are fully resolved and eliminated}
 *   {li All user-defined types are in-lined}
 *   {li All functors are applied and all modules are expanded away}
 *   {li All polymorphic types are monomorphized}
 *   {li All non-primitive structural equality checks are replaced with generated functions}
 *   {li The program is type-checked}}
 *)

(**
 * {2 Environment}
 *
 * The environment for the pass.
 *)

 type env
 (** The environment *)
 
 val env : env
 (** An empty environment *)
 
 (**
  * {2 Exceptions}
  *
  * The various exceptions that can be thrown from the pass
  *)
 
 (**
  * {3 Exception Constructors}
  *)
 
 (**
  * {2 Pass}
  *
  * The implementation of the pass
  *)

 val monomorph_fileset : env -> Ir.file list -> (env * Mono.file)
 (**
  * Monomorphize a set of A-Normal form files in dependency order into a single
  * monomorphic A-Normal form file.
  *
  * @param env The environment to monomorphize in
  * @param fileset The files to monomorphize
  * @return An updated environment and the monomorphic A-Normal form file
  *)