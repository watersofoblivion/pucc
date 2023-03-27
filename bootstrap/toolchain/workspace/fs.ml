(* Filesystem *)

 module type Impl = sig
 end
 
 module type Fs = sig
 end
 
 module Make (Fs: Impl) = struct
 end