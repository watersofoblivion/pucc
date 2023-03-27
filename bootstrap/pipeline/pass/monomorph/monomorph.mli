(**
 * {1 Monomorphization}
 *
 * Passes over the A-Normal form syntax and converts it into Monomorphic
 * Administrative Normal Form.  Additionally, performs type-checking as a
 * sanity check.
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