(**
 * {1 Flattening}
 *
 * Flattens the closure converted CPS to a first-order Static Single-Assignment
 * form.  Additionally, performs type-checking as a sanity check.
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
 
 val flatten_file : env -> Clo.file -> (env * Ssa.file)
 (**
  * Flatten a CPS file.
  *
  * @param env The environment to flatten in
  * @param fileset The file to flatten
  * @return An updated environment and the flattened SSA form of the file
  *)
