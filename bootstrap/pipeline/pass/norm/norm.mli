(**
 * {1 A-Normalization}
 *
 * Passes over the desugared syntax and converts it into Administrative Normal
 * Form.  Additionally, performs type-checking as a sanity check.
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
 
 val norm_pkg : env -> Annot.pkg -> Ir.pkg
 (**
  * Normalize a package statement.
  *
  * @param env The environment to normalize in
  * @param fileset The package statement to normalize
  * @return An updated environment and the normalized package statement
  *)
 
 val norm_file : env -> Annot.file -> (env * Ir.file)
 (**
  * Normalize an annotated file.
  *
  * @param env The environment to normalize in
  * @param fileset The file to normalize
  * @return An updated environment and the normalized file
  *)