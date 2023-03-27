(**
 * {1 CPS Conversion}
 *
 * Passes over the monomorphic A-Normal form and converts it into Continuation
 * Passing Style.  Additionally, performs type-checking as a sanity check.
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
 
 val kont_file : env -> Mono.file -> (env * Cps.file)
 (**
  * CPS convert a monomorphic A-Normal form file.
  *
  * @param env The environment to CPS convert in
  * @param fileset The file to CPS convert
  * @return An updated environment and the CPS-converted file
  *)
