(* Abstract Syntax *)

open Format

open OUnit2

open CoreTest
open SyntaxLocTest

(* Fixtures *)

let next_int_lexeme seq kontinue =
  let next seq value =
    value
      |> string_of_int
      |> kontinue seq
  in
  Core.gen seq next

let next_gensym seq kontinue =
  let next seq value =
    value
      |> sprintf "gensym%d"
      |> kontinue seq
  in
  Core.gen seq next

(* Names *)

let fresh_name ?name ?loc ?id =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh ?value:id next_gensym seq (fun seq id ->
        seq
          |> kontinue
          |> Syntax.name loc id))
  in
  fresh ?value:name next

let fresh_dotted ?name ?loc ?lhs ?rhs =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name:lhs seq (fun seq lhs ->
        fresh_name ?name:rhs seq (fun seq rhs ->
          seq
            |> kontinue
            |> Syntax.dotted loc lhs rhs)))
  in
  fresh ?value:name next  

(* Types *)

(* Type Visibility *)

let fresh_ty_vis_readonly ?vis ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> Syntax.ty_vis_readonly loc)
  in
  fresh ?value:vis next

let fresh_ty_vis_abstract ?vis ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> Syntax.ty_vis_abstract loc)
  in
  fresh ?value:vis next

(* Types *)

let fresh_ty_bool ?ty ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> Syntax.ty_bool loc)
  in
  fresh ?value:ty next

let fresh_ty_int ?ty ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> Syntax.ty_int loc)
  in
  fresh ?value:ty next

let fresh_ty_constr ?ty ?loc ?name =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        seq
          |> kontinue
          |> Syntax.ty_constr loc name))
  in
  fresh ?value:ty next

let fresh_ty_fun ?ty ?loc ?param ?res =
  let fresh_ty_fun seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_ty_constr ?ty:param seq (fun seq param ->
        fresh_ty_constr ?ty:res seq (fun seq res ->
          seq
            |> kontinue
            |> Syntax.ty_fun loc param res)))
  in
  fresh ?value:ty fresh_ty_fun

let fresh_ty_sig ?ty ?loc ?elems:(elems = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      (* TODO: Fresh Elems List *)
      seq
        |> kontinue
        |> Syntax.ty_sig loc elems)
  in
  fresh ?value:ty next

let fresh_ty_with ?ty ?loc ?name ?bindings:(bindings = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Bindings List *)
        seq
          |> kontinue
          |> Syntax.ty_with loc name bindings))
  in
  fresh ?value:ty next

(* Signature Elements *)

let fresh_sig_ty ?sig_elem ?loc ?name ?params:(params = []) ?ty:(ty = None) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Params List *)
        (* TODO: Fresh Ty Option *)
        seq
          |> kontinue
          |> Syntax.sig_ty loc name params ty))
  in
  fresh ?value:sig_elem next

let fresh_sig_val ?sig_elem ?loc ?name ?ty =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        fresh_ty_constr ?ty seq (fun seq ty ->
          seq
            |> kontinue
            |> Syntax.sig_val loc name ty)))
  in
  fresh ?value:sig_elem next

let fresh_sig_def ?sig_elem ?loc ?name ?ty =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        fresh_ty_constr ?ty seq (fun seq ty ->
          seq
            |> kontinue
            |> Syntax.sig_def loc name ty)))
  in
  fresh ?value:sig_elem next
  
let fresh_sig_mod ?sig_elem ?loc ?name ?params:(params = []) ?ty =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Params List *)
        fresh_ty_constr ?ty seq (fun seq ty ->
          seq
            |> kontinue
            |> Syntax.sig_mod loc name params ty)))
  in
  fresh ?value:sig_elem next

(* Type Bindings *)

let fresh_ty_binding ?ty_binding ?loc ?name ?params:(params = []) ?vis:(vis = None) ?ty =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Params List *)
        (* TODO: Fresh Vis Option *)
        fresh_ty_constr ?ty seq (fun seq ty ->
          seq
            |> kontinue
            |> Syntax.ty_binding loc name params vis ty)))
  in
  fresh ?value:ty_binding next

(* Module Parameters *)

let fresh_mod_param ?mod_param ?loc ?name ?ty:(ty = None) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Ty Option *)
        seq
          |> kontinue
          |> Syntax.mod_param loc name ty))
  in
  fresh ?value:mod_param next

(* Primitive Operations *)

(* Unary Operators *)

let fresh_un constr ?un ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> constr loc)
  in
  fresh ?value:un next

let fresh_un_neg ?un ?loc seq kontinue = fresh_un Syntax.un_neg ?un ?loc seq kontinue
let fresh_un_lnot ?un ?loc seq kontinue = fresh_un Syntax.un_lnot ?un ?loc seq kontinue
let fresh_un_bnot ?un ?loc seq kontinue = fresh_un Syntax.un_bnot ?un ?loc seq kontinue

(* Binary Operators *)

let fresh_bin constr ?bin ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> constr loc)
  in
  fresh ?value:bin next

let fresh_bin_add ?bin ?loc seq kontinue = fresh_bin Syntax.bin_add ?bin ?loc seq kontinue 
let fresh_bin_sub ?bin ?loc seq kontinue = fresh_bin Syntax.bin_sub ?bin ?loc seq kontinue 
let fresh_bin_mul ?bin ?loc seq kontinue = fresh_bin Syntax.bin_mul ?bin ?loc seq kontinue 
let fresh_bin_div ?bin ?loc seq kontinue = fresh_bin Syntax.bin_div ?bin ?loc seq kontinue 
let fresh_bin_mod ?bin ?loc seq kontinue = fresh_bin Syntax.bin_mod ?bin ?loc seq kontinue 
let fresh_bin_land ?bin ?loc seq kontinue = fresh_bin Syntax.bin_land ?bin ?loc seq kontinue 
let fresh_bin_lor ?bin ?loc seq kontinue = fresh_bin Syntax.bin_lor ?bin ?loc seq kontinue 
let fresh_bin_band ?bin ?loc seq kontinue = fresh_bin Syntax.bin_band ?bin ?loc seq kontinue 
let fresh_bin_bor ?bin ?loc seq kontinue = fresh_bin Syntax.bin_bor ?bin ?loc seq kontinue 
let fresh_bin_bxor ?bin ?loc seq kontinue = fresh_bin Syntax.bin_bxor ?bin ?loc seq kontinue 
let fresh_bin_ssl ?bin ?loc seq kontinue = fresh_bin Syntax.bin_ssl ?bin ?loc seq kontinue   
let fresh_bin_ssr ?bin ?loc seq kontinue = fresh_bin Syntax.bin_ssr ?bin ?loc seq kontinue     
let fresh_bin_usl ?bin ?loc seq kontinue = fresh_bin Syntax.bin_usl ?bin ?loc seq kontinue       
let fresh_bin_usr ?bin ?loc seq kontinue = fresh_bin Syntax.bin_usr ?bin ?loc seq kontinue 
let fresh_bin_seq ?bin ?loc seq kontinue = fresh_bin Syntax.bin_seq ?bin ?loc seq kontinue     
let fresh_bin_peq ?bin ?loc seq kontinue = fresh_bin Syntax.bin_peq ?bin ?loc seq kontinue       
let fresh_bin_sneq ?bin ?loc seq kontinue = fresh_bin Syntax.bin_sneq ?bin ?loc seq kontinue         
let fresh_bin_pneq ?bin ?loc seq kontinue = fresh_bin Syntax.bin_pneq ?bin ?loc seq kontinue                       
let fresh_bin_lte ?bin ?loc seq kontinue = fresh_bin Syntax.bin_lte ?bin ?loc seq kontinue         
let fresh_bin_lt ?bin ?loc seq kontinue = fresh_bin Syntax.bin_lt ?bin ?loc seq kontinue         
let fresh_bin_gte ?bin ?loc seq kontinue = fresh_bin Syntax.bin_gte ?bin ?loc seq kontinue         
let fresh_bin_gt ?bin ?loc seq kontinue = fresh_bin Syntax.bin_gt ?bin ?loc seq kontinue                     
let fresh_bin_rfa ?bin ?loc seq kontinue = fresh_bin Syntax.bin_rfa ?bin ?loc seq kontinue 

(* Patterns *)

let fresh_patt_ground ?patt ?loc =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      seq
        |> kontinue
        |> Syntax.patt_ground loc)
  in
  fresh ?value:patt next

let fresh_patt_bool ?patt ?loc ?value =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_bool ?value seq (fun seq value ->
        seq
          |> kontinue
          |> Syntax.patt_bool loc value))
  in
  fresh ?value:patt next

let fresh_patt_int ?patt ?loc ?lexeme =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh ?value:lexeme next_int_lexeme seq (fun seq lexeme ->
        seq
          |> kontinue
          |> Syntax.patt_int loc lexeme))
  in
  fresh ?value:patt next

let fresh_patt_var ?patt ?loc ?lexeme =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh ?value:lexeme next_gensym seq (fun seq lexeme ->
        seq
          |> kontinue
          |> Syntax.patt_var loc lexeme))
  in
  fresh ?value:patt next

let fresh_patt_fun ?patt ?loc ?name ?params:(params = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Params List *)
        seq
          |> kontinue
          |> Syntax.patt_fun loc name params))
  in
  fresh ?value:patt next

(* Parameters *)

let fresh_param ?param ?loc ?patt ?ty:(ty = None) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_patt_ground ?patt seq (fun seq patt ->
        (* TODO: Fresh Ty Option *)
        seq
          |> kontinue
          |> Syntax.param loc patt ty))
  in
  fresh ?value:param next

(* Expressions *)

let fresh_expr_bool ?expr ?loc ?value =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_bool ?value seq (fun seq value ->
        seq
          |> kontinue
          |> Syntax.expr_bool loc value))
  in
  fresh ?value:expr next

let fresh_expr_int ?expr ?loc ?lexeme =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh ?value:lexeme next_int_lexeme seq (fun seq lexeme ->
        seq
          |> kontinue
          |> Syntax.expr_int loc lexeme))
  in
  fresh ?value:expr next

let fresh_expr_id ?expr ?loc ?name =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        seq
          |> kontinue
          |> Syntax.expr_id loc name))
  in
  fresh ?value:expr next

let fresh_expr_un ?expr ?loc ?op ?operand =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_un_lnot ?un:op seq (fun seq op ->
        fresh_expr_bool ?expr:operand seq (fun seq operand ->
          seq
            |> kontinue
            |> Syntax.expr_un loc op operand)))
  in
  fresh ?value:expr next

let fresh_expr_bin ?expr ?loc ?op ?lhs ?rhs =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_bin_band ?bin:op seq (fun seq op ->
        fresh_expr_bool ?expr:lhs seq (fun seq lhs ->
          fresh_expr_bool ?expr:rhs seq (fun seq rhs ->
            seq
              |> kontinue
              |> Syntax.expr_bin loc op lhs rhs))))
  in
  fresh ?value:expr next

let fresh_expr_cond ?expr ?loc ?cond ?tru ?fls =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_expr_bool ?expr:cond seq (fun seq cond ->
        fresh_expr_int ?expr:tru seq (fun seq tru ->
          fresh_expr_int ?expr:fls seq (fun seq fls ->
            seq
              |> kontinue
              |> Syntax.expr_cond loc cond tru fls))))
  in
  fresh ?value:expr next

let fresh_expr_let ?expr ?loc ?recur ?bindings:(bindings = []) ?scope =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_bool ?value:recur seq (fun seq recur ->
        (* TODO: Fresh Binding List *)
        fresh_expr_int ?expr:scope seq (fun seq scope ->
          seq
            |> kontinue
            |> Syntax.expr_let loc recur bindings scope)))
  in
  fresh ?value:expr next

let fresh_expr_abs ?expr ?loc ?params:(params = []) ?ret:(ret = None) ?body =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      (* TODO: Fresh Params List*)
      (* TODO: Fresh Ty Option *)
      fresh_expr_int ?expr:body seq (fun seq body ->
        seq
          |> kontinue
          |> Syntax.expr_abs loc params ret body))
  in
  fresh ?value:expr next

let fresh_expr_app ?expr ?loc ?fn ?args:(args = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_expr_abs ?expr:fn seq (fun seq fn ->
        (* TODO: Fresh Expr List *)
        seq
          |> kontinue
          |> Syntax.expr_app loc fn args))
  in
  fresh ?value:expr next

(* Bindings *)

let fresh_binding ?binding ?loc ?patt ?ty:(ty = None) ?value =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_patt_ground ?patt seq (fun seq patt ->
        (* TODO: Fresh Ty Option *)
        fresh_expr_int ?expr:value seq (fun seq value ->
          seq
            |> kontinue
            |> Syntax.binding loc patt ty value)))
  in
  fresh ?value:binding next

(* Package Statements *)

let fresh_pkg_library ?pkg ?loc ?name =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        seq
          |> kontinue
          |> Syntax.pkg_library loc name))
  in
  fresh ?value:pkg next

let fresh_pkg_executable ?pkg ?loc ?name =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        seq
          |> kontinue
          |> Syntax.pkg_executable loc name))
  in
  fresh ?value:pkg next

(* Imports *)

let fresh_path ?path ?loc ?pkgpath =
  let next_path seq kontinue =
    let next seq value =
      value
        |> sprintf "path/to/pkg/%d"
        |> kontinue seq
    in
    Core.gen seq next
  in
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh ?value:pkgpath next_path seq (fun seq pkgpath ->
        seq
          |> kontinue
          |> Syntax.path loc pkgpath))
  in
  fresh ?value:path next

let fresh_alias ?alias ?loc ?local:(local = None) ?path =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      (* TODO: Fresh Name Option *)
      fresh_path ?path seq (fun seq path ->
        seq
          |> kontinue
          |> Syntax.alias loc local path))
  in
  fresh ?value:alias next

let fresh_pkgs ?pkgs ?loc ?aliases:(aliases = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      (* TODO: Fresh Alias List *)
      seq
        |> kontinue
        |> Syntax.pkgs loc aliases)
  in
  fresh ?value:pkgs next

let fresh_import ?import ?loc ?pkgs =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_pkgs ?pkgs seq (fun seq pkgs ->
        seq
          |> kontinue
          |> Syntax.import loc pkgs))
  in
  fresh ?value:import next

(* Top-Level Bindings *)

let fresh_top_ty ?top ?loc ?local ?bindings:(bindings = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_bool ?value:local seq (fun seq local ->
        (* TODO: Fresh Ty Binding List *)
        seq
          |> kontinue
          |> Syntax.top_ty loc local bindings))
  in
  fresh ?value:top next

let fresh_top_val ?top ?loc ?binding =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_binding ?binding seq (fun seq binding ->
        seq
          |> kontinue
          |> Syntax.top_val loc binding))
  in
  fresh ?value:top next

let fresh_top_def ?top ?loc ?binding =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_binding ?binding seq (fun seq binding ->
        seq
          |> kontinue
          |> Syntax.top_def loc binding))
  in
  fresh ?value:top next

let fresh_top_let ?top ?loc ?recur ?bindings:(bindings = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_bool ?value:recur seq (fun seq recur ->
        (* TODO: Fresh Binding List *)
        seq
          |> kontinue
          |> Syntax.top_let loc recur bindings))
  in
  fresh ?value:top next

let fresh_top_mod ?top ?loc ?name ?params:(params = []) ?elems:(elems = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_name ?name seq (fun seq name ->
        (* TODO: Fresh Param List *)
        (* TODO: Fresh Top List *)
        seq
          |> kontinue
          |> Syntax.top_mod loc name params elems))
  in
  fresh ?value:top next

(* Files *)

let fresh_file ?file ?loc ?pkg ?imports:(imports = []) ?tops:(tops = []) =
  let next seq kontinue =
    fresh_loc ?loc seq (fun seq loc ->
      fresh_pkg_library ?pkg seq (fun seq pkg ->
        (* TODO: Fresh Import List *)
        (* TODO: Fresh Top List *)
        seq
          |> kontinue
          |> Syntax.file loc pkg imports tops))
  in
  fresh ?value:file next

(* Assertions *)

(* Names *)

let fail_name_constr = fail_constr "Name" (function
  | Syntax.Name _ -> "Name"
  | Syntax.Dotted _ -> "Dotted"
) 

let rec assert_name_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Name expected, Syntax.Name actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Names are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.Dotted expected, Syntax.Dotted actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.lhs actual.lhs;
      assert_name_equal ~ctxt ~loc expected.rhs actual.rhs
  | expected, actual -> fail_name_constr ~ctxt expected actual

(* Types *)

let fail_ty_vis_constr = fail_constr "Type visibility" (function
  | Syntax.TyVisReadonly _ -> "TyVisReadonly"
  | Syntax.TyVisAbstract _ -> "TyVisAbstract"
)

let fail_ty_constr = fail_constr "Type" (function
  | Syntax.TyBool _ -> "TyBool"
  | Syntax.TyInt _ -> "TyInt"
  | Syntax.TyConstr _ -> "TyConstr"
  | Syntax.TyFun _ -> "TyFun"
  | Syntax.TySig _ -> "TySig"
  | Syntax.TyWith _ -> "TyWith"
)

let fail_sig_elem_constr = fail_constr "Signature element" (function
  | Syntax.SigTy _ -> "SigTy"
  | Syntax.SigVal _ -> "SigVal"
  | Syntax.SigDef _ -> "SigDef"
  | Syntax.SigMod _ -> "SigMod"
)

let assert_ty_vis_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TyVisReadonly expected, Syntax.TyVisReadonly actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.TyVisAbstract expected, Syntax.TyVisAbstract actual ->
    if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | expected, actual -> fail_ty_vis_constr ~ctxt expected actual

let rec assert_ty_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TyBool expected, Syntax.TyBool actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.TyInt expected, Syntax.TyInt actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.TyConstr expected, Syntax.TyConstr actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | Syntax.TyFun expected, Syntax.TyFun actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_ty_equal ~ctxt ~loc expected.param actual.param;
      assert_ty_equal ~ctxt ~loc expected.res actual.res
  | Syntax.TySig expected, Syntax.TySig actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_list_equal ~ctxt (assert_sig_elem_equal ~loc) expected.elems actual.elems
  | Syntax.TyWith expected, Syntax.TyWith actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_list_equal ~ctxt (assert_ty_binding_equal ~loc) expected.tys actual.tys
  | expected, actual -> fail_ty_constr ~ctxt expected actual

and assert_sig_elem_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.SigTy expected, Syntax.SigTy actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_list_equal ~ctxt (assert_mod_param_equal ~loc) expected.params actual.params;
      assert_optional_equal ~ctxt "Type definitions" (assert_ty_equal ~loc) expected.ty actual.ty
  | Syntax.SigVal expected, Syntax.SigVal actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty
  | Syntax.SigDef expected, Syntax.SigDef actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty
  | Syntax.SigMod expected, Syntax.SigMod actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_list_equal ~ctxt (assert_mod_param_equal ~loc) expected.params actual.params;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty
  | expected, actual -> fail_sig_elem_constr ~ctxt expected actual

and assert_ty_binding_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TyBinding expected, Syntax.TyBinding actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_list_equal ~ctxt (assert_mod_param_equal ~loc) expected.params actual.params;
      assert_optional_equal ~ctxt "Type visibilities" (assert_ty_vis_equal ~loc) expected.vis actual.vis;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty

and assert_mod_param_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.ModParam expected, Syntax.ModParam actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_optional_equal ~ctxt "Module parameter types" (assert_ty_equal ~loc) expected.ty actual.ty

(* Primitive Operations *)

let fail_un_constr = fail_constr "Unary operator" (function
  | Syntax.UnNeg _ -> "UnNeg"
  | Syntax.UnLNot _ -> "UnLNot"
  | Syntax.UnBNot _ -> "UnBNot"
)

let fail_bin_constr = fail_constr "Binary operator" (function
  | Syntax.BinAdd _ -> "BinAdd"
  | Syntax.BinSub _ -> "BinSub"
  | Syntax.BinMul _ -> "BinMul"
  | Syntax.BinDiv _ -> "BinDiv"
  | Syntax.BinMod _ -> "BinMod"
  | Syntax.BinLAnd _ -> "BinLAnd"
  | Syntax.BinLOr _ -> "BinLOr"
  | Syntax.BinBAnd _ -> "BinBAnd"
  | Syntax.BinBOr _ -> "BinBOr"
  | Syntax.BinBXor _ -> "BinBXor"
  | Syntax.BinSsl _ -> "BinSsl"
  | Syntax.BinSsr _ -> "BinSsr"
  | Syntax.BinUsl _ -> "BinUsl"
  | Syntax.BinUsr _ -> "BinUsr"
  | Syntax.BinSeq _ -> "BinSeq"
  | Syntax.BinPeq _ -> "BinPeq"
  | Syntax.BinSneq _ -> "BinSneq"
  | Syntax.BinPneq _ -> "BinPneq"
  | Syntax.BinGte _ -> "BinGte"
  | Syntax.BinGt _ -> "BinGt"
  | Syntax.BinLte _ -> "BinLte"
  | Syntax.BinLt _ -> "BinLt"
  | Syntax.BinRfa _ -> "BinRfa"
)

let assert_un_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.UnNeg expected, Syntax.UnNeg actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.UnLNot expected, Syntax.UnLNot actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.UnBNot expected, Syntax.UnBNot actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | expected, actual -> fail_un_constr ~ctxt expected actual

let assert_bin_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.BinAdd expected, Syntax.BinAdd actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSub expected, Syntax.BinSub actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinMul expected, Syntax.BinMul actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinDiv expected, Syntax.BinDiv actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinMod expected, Syntax.BinMod actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLAnd expected, Syntax.BinLAnd actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLOr expected, Syntax.BinLOr actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinBAnd expected, Syntax.BinBAnd actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinBOr expected, Syntax.BinBOr actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinBXor expected, Syntax.BinBXor actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSsl expected, Syntax.BinSsl actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSsr expected, Syntax.BinSsr actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinUsl expected, Syntax.BinUsl actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinUsr expected, Syntax.BinUsr actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSeq expected, Syntax.BinSeq actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinPeq expected, Syntax.BinPeq actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSneq expected, Syntax.BinSneq actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinPneq expected, Syntax.BinPneq actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinGte expected, Syntax.BinGte actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinGt expected, Syntax.BinGt actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLte expected, Syntax.BinLte actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLt expected, Syntax.BinLt actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinRfa expected, Syntax.BinRfa actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | expected, actual -> fail_bin_constr ~ctxt expected actual
             
(* Patterns *)

let fail_patt_constr = fail_constr "Pattern" (function
  | Syntax.PattGround _ -> "PattGround"
  | Syntax.PattBool _ -> "PattBool"
  | Syntax.PattInt _ -> "PattInt"
  | Syntax.PattVar _ -> "PattVar"
  | Syntax.PattFun _ -> "PattFun"
)

let rec assert_patt_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.PattGround expected, Syntax.PattGround actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.PattBool expected, Syntax.PattBool actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Boolean literals are not equal" ~printer:string_of_bool expected.value actual.value
  | Syntax.PattInt expected, Syntax.PattInt actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Integer literals are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.PattVar expected, Syntax.PattVar actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Variables are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.PattFun expected, Syntax.PattFun actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_list_equal ~ctxt (assert_param_equal ~loc) expected.params actual.params
  | expected, actual -> fail_patt_constr ~ctxt expected actual

and assert_param_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Param expected, Syntax.Param actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_patt_equal ~ctxt ~loc expected.patt actual.patt;
      assert_optional_equal ~ctxt "Parameter types" (assert_ty_equal ~loc) expected.ty actual.ty

(* Expressions *)

let fail_expr_constr = fail_constr "Expression" (function
  | Syntax.ExprBool _ -> "ExprBool"
  | Syntax.ExprInt _ -> "ExprInt"
  | Syntax.ExprId _ -> "ExprId"
  | Syntax.ExprUn _ -> "ExprUn"
  | Syntax.ExprBin _ -> "ExprBin"
  | Syntax.ExprCond _ -> "ExprCond"
  | Syntax.ExprLet _ -> "ExprLet"
  | Syntax.ExprAbs _ -> "ExprAbs"
  | Syntax.ExprApp _ -> "ExprApp"
)

let rec assert_expr_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.ExprBool expected, Syntax.ExprBool actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Values are not equal" ~printer:string_of_bool expected.value actual.value
  | Syntax.ExprInt expected, Syntax.ExprInt actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Integer lexemes are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.ExprId expected, Syntax.ExprId actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | Syntax.ExprUn expected, Syntax.ExprUn actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_un_equal ~ctxt ~loc expected.op actual.op;
      assert_expr_equal ~ctxt ~loc expected.operand actual.operand
  | Syntax.ExprBin expected, Syntax.ExprBin actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_bin_equal ~ctxt ~loc expected.op actual.op;
      assert_expr_equal ~ctxt ~loc expected.lhs actual.lhs;
      assert_expr_equal ~ctxt ~loc expected.rhs actual.rhs
  | Syntax.ExprCond expected, Syntax.ExprCond actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_expr_equal ~ctxt ~loc expected.cond actual.cond;
      assert_expr_equal ~ctxt ~loc expected.tru actual.tru;
      assert_expr_equal ~ctxt ~loc expected.fls actual.fls
  | Syntax.ExprLet expected, Syntax.ExprLet actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Recursion markers are not equal" ~printer:string_of_bool expected.recur actual.recur;
      assert_list_equal ~ctxt (assert_binding_equal ~loc) expected.bindings actual.bindings
  | Syntax.ExprAbs expected, Syntax.ExprAbs actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_list_equal ~ctxt (assert_param_equal ~loc) expected.params actual.params;
      assert_optional_equal ~ctxt "Return types" (assert_ty_equal ~loc) expected.ret actual.ret;
      assert_expr_equal ~ctxt ~loc expected.body actual.body
  | Syntax.ExprApp expected, Syntax.ExprApp actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_expr_equal ~ctxt expected.fn actual.fn;
      assert_list_equal ~ctxt (assert_expr_equal ~loc) expected.args actual.args
  | expected, actual -> fail_expr_constr ~ctxt expected actual

and assert_binding_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Binding expected, Syntax.Binding actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_patt_equal ~ctxt ~loc expected.patt actual.patt;
      assert_optional_equal ~ctxt "Binding types" (assert_ty_equal ~loc) expected.ty actual.ty;
      assert_expr_equal ~ctxt ~loc expected.value actual.value

(* Package Statements *)

let fail_pkg_constr = fail_constr "Package statement" (function
  | Syntax.PkgLibrary _ -> "PkgLibrary"
  | Syntax.PkgExecutable _ -> "PkgExecutable"
)

let assert_pkg_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.PkgLibrary expected, Syntax.PkgLibrary actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | Syntax.PkgExecutable expected, Syntax.PkgExecutable actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | expected, actual -> fail_pkg_constr ~ctxt expected actual

(* Imports *)

let assert_path_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Path expected, Syntax.Path actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Package paths are not equal" ~printer:Fun.id expected.path actual.path

let assert_alias_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Alias expected, Syntax.Alias actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_optional_equal ~ctxt "local alias" (assert_name_equal ~loc) expected.alias actual.alias;
      assert_path_equal ~ctxt ~loc expected.path actual.path

let assert_pkgs_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Packages expected, Syntax.Packages actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_list_equal ~ctxt (assert_alias_equal ~loc) expected.aliases actual.aliases

let assert_import_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Import expected, Syntax.Import actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_pkgs_equal ~ctxt ~loc expected.pkgs actual.pkgs

(* Top-Level Bindings *)

let fail_top_constr = fail_constr "Top-level binding" (function
  | Syntax.TopTy _ -> "TopTy"
  | Syntax.TopVal _ -> "TopVal"
  | Syntax.TopDef _ -> "TopDef"
  | Syntax.TopLet _ -> "TopLet"
  | Syntax.TopMod _ -> "TopMod"
)

let rec assert_top_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TopTy expected, Syntax.TopTy actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Local markings are not equal" ~printer:string_of_bool expected.local actual.local;
      assert_list_equal ~ctxt (assert_ty_binding_equal ~loc) expected.bindings actual.bindings
  | Syntax.TopVal expected, Syntax.TopVal actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_binding_equal ~ctxt ~loc expected.binding actual.binding
  | Syntax.TopDef expected, Syntax.TopDef actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_binding_equal ~ctxt ~loc expected.binding actual.binding
  | Syntax.TopLet expected, Syntax.TopLet actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Recursion markings are not equal" ~printer:string_of_bool expected.recur actual.recur;
      assert_list_equal ~ctxt (assert_binding_equal ~loc) expected.bindings actual.bindings
  | Syntax.TopMod expected, Syntax.TopMod actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_list_equal ~ctxt (assert_mod_param_equal ~loc) expected.params actual.params;
      assert_list_equal ~ctxt (assert_top_equal ~loc) expected.elems actual.elems
  | expected, actual -> fail_top_constr ~ctxt expected actual

(* Files *)

let assert_file_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.File expected, Syntax.File actual ->
      if loc then assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_pkg_equal ~ctxt ~loc expected.pkg actual.pkg;
      assert_list_equal ~ctxt (assert_import_equal ~loc) expected.imports actual.imports;
      assert_list_equal ~ctxt (assert_top_equal ~loc) expected.tops actual.tops