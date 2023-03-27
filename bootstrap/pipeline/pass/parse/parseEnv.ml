(* Parsing Environment *)

module IdMap = Map.Make (struct
  type t = string
  let compare = compare
end)

type env = {
  seq: int Core.seq;
  ids: Core.sym IdMap.t;
}

let env ?seq:(seq = Core.seq_nat ()) _ =
  let ids = IdMap.empty in
  { seq; ids }

let symbolize env id =
  try
    let sym = IdMap.find id env.ids in
    (env, sym)
  with Not_found ->
    let sym = Core.gensym ~name:id ~seq:(env.seq) () in
    let ids = IdMap.add id sym env.ids in
    let env = { env with ids } in
    (env, sym)
