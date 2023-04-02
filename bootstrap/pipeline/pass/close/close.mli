(**
 * {1 Closure Conversion}
 *
 * Closure converts the CPS into closure-passing style.
 *
 * Several tasks are performed concurrently during this pass:
 *
 * {ul
 *   {li Closure conversion is performed}
 *   {li When targeting PU/CC, functions are decomposed into the "extended basic blocks" expected by the PU/CC ISA}}
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
 
 val close_file : env -> Cps.file -> (env * Clo.file)
 (**
  * CPS convert a monomorphic A-Normal form file.
  *
  * @param env The environment to closure convert in
  * @param fileset The file to closure convert
  * @return An updated environment and the closure-converted file
  *)
