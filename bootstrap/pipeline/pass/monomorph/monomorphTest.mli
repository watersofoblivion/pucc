(**
 * {1 Monomorphization Tests}
 *
 * Functions for testing the monomorphization pass
 *)

(**
 * {2 Environment}
 *)

(**
 * {3 Fixtures}
 *)

val fresh_env : unit -> Monomorph.env
(**
 * Construct a fresh environment.
 *
 * @param _ A dummy parameter
 * @return A fresh environment
 *)