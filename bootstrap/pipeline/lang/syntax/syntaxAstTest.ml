(* Abstract Syntax *)

open Format

open OUnit2

(* Fixtures *)

(* Names *)

let name_seq = Core.seq_str ~prefix:"gensym" ()
let fresh_name ?loc:(loc = CoreTest.fresh_loc ()) ?id:(id = Core.gen name_seq) _ =
  Syntax.name loc id

let fresh_dotted ?loc:(loc = CoreTest.fresh_loc ()) ?lhs:(lhs = fresh_name ()) ?rhs:(rhs = fresh_name ()) _ =
  Syntax.dotted loc lhs rhs

(* Types *)

(* Type Visibility *)

let fresh_ty_vis_readonly ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.ty_vis_readonly loc

let fresh_ty_vis_abstract ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.ty_vis_abstract loc

(* Types *)

let fresh_ty_constr ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) _ =
  Syntax.ty_constr loc name

let fresh_ty_fun ?loc:(loc = CoreTest.fresh_loc ()) ?param:(param = fresh_ty_constr ()) ?res:(res = fresh_ty_constr ()) _ =
  Syntax.ty_fun loc param res

let fresh_ty_sig ?loc:(loc = CoreTest.fresh_loc ()) ?elems:(elems = []) _ =
  Syntax.ty_sig loc elems

let fresh_ty_with ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?bindings:(bindings = []) _ =
  Syntax.ty_with loc name bindings

(* Signature Elements *)

let fresh_sig_ty ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?params:(params = []) ?ty:(ty = None) _ =
  Syntax.sig_ty loc name params ty

let fresh_sig_val ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?ty:(ty = fresh_ty_constr ()) _ =
  Syntax.sig_val loc name ty

let fresh_sig_def ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?ty:(ty = fresh_ty_constr ()) _ =
  Syntax.sig_def loc name ty
  
let fresh_sig_mod ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?params:(params = []) ?ty:(ty = fresh_ty_sig ()) _ =
  Syntax.sig_mod loc name params ty

(* Type Bindings *)

let fresh_ty_binding ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?params:(params = []) ?vis:(vis = None) ?ty:(ty = fresh_ty_constr ()) _ =
  Syntax.ty_binding loc name params vis ty

(* Module Parameters *)

let fresh_mod_param ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?ty:(ty = None) _ =
  Syntax.mod_param loc name ty

(* Primitive Operations *)

(* Unary Operators *)

let fresh_un_neg ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.un_neg loc

let fresh_un_lnot ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.un_lnot loc

let fresh_un_bnot ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.un_bnot loc
    
(* Binary Operators *)

let fresh_bin_add ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_add loc

let fresh_bin_sub ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_sub loc

let fresh_bin_mul ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_mul loc

let fresh_bin_div ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_div loc

let fresh_bin_mod ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_mod loc        

let fresh_bin_land ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_land loc

let fresh_bin_lor ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_lor loc

let fresh_bin_band ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_band loc

let fresh_bin_bor ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_bor loc

let fresh_bin_bxor ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_bxor loc

let fresh_bin_ssl ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_ssl loc
  
let fresh_bin_ssr ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_ssr loc
    
let fresh_bin_usl ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_usl loc
      
let fresh_bin_usr ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_usr loc

let fresh_bin_seq ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_seq loc
    
let fresh_bin_peq ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_peq loc
      
let fresh_bin_sneq ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_sneq loc
        
let fresh_bin_pneq ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_pneq loc
                      
let fresh_bin_lte ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_lte loc
        
let fresh_bin_lt ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_lt loc
        
let fresh_bin_gte ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_gte loc
        
let fresh_bin_gt ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_gt loc
                    
let fresh_bin_rfa ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.bin_rfa loc

(* Patterns *)

let fresh_patt_ground ?loc:(loc = CoreTest.fresh_loc ()) _ =
  Syntax.patt_ground loc

let fresh_patt_bool ?loc:(loc = CoreTest.fresh_loc ()) ?value:(value = true) _ =
  Syntax.patt_bool loc value

let int_patt_seq = Core.seq_str ()
let fresh_patt_int ?loc:(loc = CoreTest.fresh_loc ()) ?lexeme:(lexeme = Core.gen int_patt_seq) _ =
  Syntax.patt_int loc lexeme

let var_patt_seq = Core.seq_str ~prefix:"x" ()
let fresh_patt_var ?loc:(loc = CoreTest.fresh_loc ()) ?lexeme:(lexeme = Core.gen var_patt_seq) _ =
  Syntax.patt_var loc lexeme

let fresh_patt_fun ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?params:(params = []) _ =
  Syntax.patt_fun loc name params

(* Parameters *)

let fresh_param ?loc:(loc = CoreTest.fresh_loc ()) ?patt:(patt = fresh_patt_ground ()) ?ty:(ty = None) _ =
  Syntax.param loc patt ty

(* Expressions *)

let fresh_expr_bool ?loc:(loc = CoreTest.fresh_loc ()) ?value:(value = true) _ =
  Syntax.expr_bool loc value

let int_expr_seq = Core.seq_str ()
let fresh_expr_int ?loc:(loc = CoreTest.fresh_loc ()) ?lexeme:(lexeme = Core.gen int_expr_seq) _ =
  Syntax.expr_int loc lexeme

let fresh_expr_id ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) _ =
  Syntax.expr_id loc name

let fresh_expr_un ?loc:(loc = CoreTest.fresh_loc ()) ?op:(op = fresh_un_lnot ()) ?operand:(operand = fresh_expr_bool ()) _ =
  Syntax.expr_un loc op operand

let fresh_expr_bin ?loc:(loc = CoreTest.fresh_loc ()) ?op:(op = fresh_bin_band ()) ?lhs:(lhs = fresh_expr_bool ()) ?rhs:(rhs = fresh_expr_bool ()) _ =
  Syntax.expr_bin loc op lhs rhs

let fresh_expr_cond ?loc:(loc = CoreTest.fresh_loc ()) ?cond:(cond = fresh_expr_bool ()) ?tru:(tru = fresh_expr_int ()) ?fls:(fls = fresh_expr_int ()) _ =
  Syntax.expr_cond loc cond tru fls

let fresh_expr_let ?loc:(loc = CoreTest.fresh_loc ()) ?recur:(recur = false) ?bindings:(bindings = []) ?scope:(scope = fresh_expr_int ()) _ =
  Syntax.expr_let loc recur bindings scope

let fresh_expr_abs ?loc:(loc = CoreTest.fresh_loc ()) ?params:(params = []) ?ret:(ret = None) ?body:(body = fresh_expr_int ()) _ =
  Syntax.expr_abs loc params ret body

let fresh_expr_app ?loc:(loc = CoreTest.fresh_loc ()) ?fn:(fn = fresh_expr_abs ()) ?args:(args = []) _ =
  Syntax.expr_app loc fn args

(* Bindings*)

let fresh_binding ?loc:(loc = CoreTest.fresh_loc ()) ?patt:(patt = fresh_patt_ground ()) ?ty:(ty = None) ?value:(value = fresh_expr_int ()) _ =
  Syntax.binding loc patt ty value

(* Package Statements *)

let fresh_pkg_library ?loc:(loc = CoreTest.fresh_loc ()) ?id:(id = fresh_name ()) _ =
  Syntax.pkg_library loc id

let fresh_pkg_executable ?loc:(loc = CoreTest.fresh_loc ()) ?id:(id = fresh_name ()) _ =
  Syntax.pkg_executable loc id

(* Imports *)

let path_seq = Core.seq_str ~prefix:"pkg/path-" ()

let fresh_path ?loc:(loc = CoreTest.fresh_loc ()) ?path:(path = Core.gen path_seq) _ =
  Syntax.path loc path

let fresh_alias ?loc:(loc = CoreTest.fresh_loc ()) ?local ?path:(path = fresh_path ()) _ =
  Syntax.alias loc local path

let fresh_pkgs ?loc:(loc = CoreTest.fresh_loc ()) ?aliases:(aliases = []) _ =
  Syntax.pkgs loc aliases

let fresh_import ?loc:(loc = CoreTest.fresh_loc ()) ?pkgs:(pkgs = fresh_pkgs ()) _ =
  Syntax.import loc pkgs

(* Top-Level Bindings *)

let fresh_top_ty ?loc:(loc = CoreTest.fresh_loc ()) ?local:(local = false) ?bindings:(bindings = []) _ =
  Syntax.top_ty loc local bindings

let fresh_top_val ?loc:(loc = CoreTest.fresh_loc ()) ?binding:(binding = fresh_binding ()) _ =
  Syntax.top_val loc binding

let fresh_top_def ?loc:(loc = CoreTest.fresh_loc ()) ?binding:(binding = fresh_binding ()) _ =
  Syntax.top_def loc binding

let fresh_top_let ?loc:(loc = CoreTest.fresh_loc ()) ?recur:(recur = false) ?bindings:(bindings = []) _ =
  Syntax.top_let loc recur bindings 

let fresh_top_mod ?loc:(loc = CoreTest.fresh_loc ()) ?name:(name = fresh_name ()) ?params:(params = []) ?elems:(elems = []) _ =
  Syntax.top_mod loc name params elems

(* Files *)

let fresh_file ?loc:(loc = CoreTest.fresh_loc ()) ?pkg:(pkg = fresh_pkg_library ()) ?imports:(imports = []) ?tops:(tops = []) _ =
  Syntax.file loc pkg imports tops

(* Assertions *)

(* Names *)

let fail_name_constr = CoreTest.fail_constr "Name" (function
  | Syntax.Name _ -> "Name"
  | Syntax.Dotted _ -> "Dotted"
) 

let rec assert_name_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Name expected, Syntax.Name actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Names are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.Dotted expected, Syntax.Dotted actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.lhs actual.lhs;
      assert_name_equal ~ctxt ~loc expected.rhs actual.rhs
  | expected, actual -> fail_name_constr ~ctxt expected actual

(* Types *)

let fail_ty_vis_constr = CoreTest.fail_constr "Type visibility" (function
  | Syntax.TyVisReadonly _ -> "TyVisReadonly"
  | Syntax.TyVisAbstract _ -> "TyVisAbstract"
)

let fail_ty_constr = CoreTest.fail_constr "Type" (function
  | Syntax.TyConstr _ -> "TyConstr"
  | Syntax.TyFun _ -> "TyFun"
  | Syntax.TySig _ -> "TySig"
  | Syntax.TyWith _ -> "TyWith"
)

let fail_sig_elem_constr = CoreTest.fail_constr "Signature element" (function
  | Syntax.SigTy _ -> "SigTy"
  | Syntax.SigVal _ -> "SigVal"
  | Syntax.SigDef _ -> "SigDef"
  | Syntax.SigMod _ -> "SigMod"
)

let assert_ty_vis_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TyVisReadonly expected, Syntax.TyVisReadonly actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.TyVisAbstract expected, Syntax.TyVisAbstract actual ->
    if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | expected, actual -> fail_ty_vis_constr ~ctxt expected actual

let rec assert_ty_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TyConstr expected, Syntax.TyConstr actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | Syntax.TyFun expected, Syntax.TyFun actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_ty_equal ~ctxt ~loc expected.param actual.param;
      assert_ty_equal ~ctxt ~loc expected.res actual.res
  | Syntax.TySig expected, Syntax.TySig actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      List.iter2 (assert_sig_elem_equal ~ctxt ~loc) expected.elems actual.elems
  | Syntax.TyWith expected, Syntax.TyWith actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      List.iter2 (assert_ty_binding_equal ~ctxt ~loc) expected.tys actual.tys
  | expected, actual -> fail_ty_constr ~ctxt expected actual

and assert_sig_elem_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.SigTy expected, Syntax.SigTy actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      List.iter2 (assert_mod_param_equal ~ctxt ~loc) expected.params actual.params;
      CoreTest.assert_optional_equal ~ctxt "Type definitions" (assert_ty_equal ~loc) expected.ty actual.ty
  | Syntax.SigVal expected, Syntax.SigVal actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty
  | Syntax.SigDef expected, Syntax.SigDef actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty
  | Syntax.SigMod expected, Syntax.SigMod actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      List.iter2 (assert_mod_param_equal ~ctxt ~loc) expected.params actual.params;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty
  | expected, actual -> fail_sig_elem_constr ~ctxt expected actual

and assert_ty_binding_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TyBinding expected, Syntax.TyBinding actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      List.iter2 (assert_mod_param_equal ~ctxt ~loc) expected.params actual.params;
      CoreTest.assert_optional_equal ~ctxt "Type visibilities" (assert_ty_vis_equal ~loc) expected.vis actual.vis;
      assert_ty_equal ~ctxt ~loc expected.ty actual.ty

and assert_mod_param_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.ModParam expected, Syntax.ModParam actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      CoreTest.assert_optional_equal ~ctxt "Module parameter types" (assert_ty_equal ~loc) expected.ty actual.ty

(* Primitive Operations *)

let fail_un_constr = CoreTest.fail_constr "Unary operator" (function
  | Syntax.UnNeg _ -> "UnNeg"
  | Syntax.UnLNot _ -> "UnLNot"
  | Syntax.UnBNot _ -> "UnBNot"
)

let fail_bin_constr = CoreTest.fail_constr "Binary operator" (function
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
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.UnLNot expected, Syntax.UnLNot actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.UnBNot expected, Syntax.UnBNot actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | expected, actual -> fail_un_constr ~ctxt expected actual

let assert_bin_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.BinAdd expected, Syntax.BinAdd actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSub expected, Syntax.BinSub actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinMul expected, Syntax.BinMul actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinDiv expected, Syntax.BinDiv actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinMod expected, Syntax.BinMod actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLAnd expected, Syntax.BinLAnd actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLOr expected, Syntax.BinLOr actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinBAnd expected, Syntax.BinBAnd actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinBOr expected, Syntax.BinBOr actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinBXor expected, Syntax.BinBXor actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSsl expected, Syntax.BinSsl actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSsr expected, Syntax.BinSsr actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinUsl expected, Syntax.BinUsl actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinUsr expected, Syntax.BinUsr actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSeq expected, Syntax.BinSeq actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinPeq expected, Syntax.BinPeq actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinSneq expected, Syntax.BinSneq actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinPneq expected, Syntax.BinPneq actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinGte expected, Syntax.BinGte actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinGt expected, Syntax.BinGt actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLte expected, Syntax.BinLte actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinLt expected, Syntax.BinLt actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.BinRfa expected, Syntax.BinRfa actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | expected, actual -> fail_bin_constr ~ctxt expected actual
             
(* Patterns *)

let fail_patt_constr = CoreTest.fail_constr "Pattern" (function
  | Syntax.PattGround _ -> "PattGround"
  | Syntax.PattBool _ -> "PattBool"
  | Syntax.PattInt _ -> "PattInt"
  | Syntax.PattVar _ -> "PattVar"
  | Syntax.PattFun _ -> "PattFun"
)

let rec assert_patt_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.PattGround expected, Syntax.PattGround actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc
  | Syntax.PattBool expected, Syntax.PattBool actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Boolean literals are not equal" ~printer:string_of_bool expected.value actual.value
  | Syntax.PattInt expected, Syntax.PattInt actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Integer literals are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.PattVar expected, Syntax.PattVar actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Variables are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.PattFun expected, Syntax.PattFun actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      List.iter2 (assert_param_equal ~ctxt ~loc) expected.params actual.params
  | expected, actual -> fail_patt_constr ~ctxt expected actual

and assert_param_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Param expected, Syntax.Param actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_patt_equal ~ctxt ~loc expected.patt actual.patt;
      CoreTest.assert_optional_equal ~ctxt "Parameter types" (assert_ty_equal ~loc) expected.ty actual.ty

(* Expressions *)

let fail_expr_constr = CoreTest.fail_constr "Expression" (function
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
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Values are not equal" ~printer:string_of_bool expected.value actual.value
  | Syntax.ExprInt expected, Syntax.ExprInt actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Integer lexemes are not equal" ~printer:Fun.id expected.lexeme actual.lexeme
  | Syntax.ExprId expected, Syntax.ExprId actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | Syntax.ExprUn expected, Syntax.ExprUn actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_un_equal ~ctxt ~loc expected.op actual.op;
      assert_expr_equal ~ctxt ~loc expected.operand actual.operand
  | Syntax.ExprBin expected, Syntax.ExprBin actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_bin_equal ~ctxt ~loc expected.op actual.op;
      assert_expr_equal ~ctxt ~loc expected.lhs actual.lhs;
      assert_expr_equal ~ctxt ~loc expected.rhs actual.rhs
  | Syntax.ExprCond expected, Syntax.ExprCond actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_expr_equal ~ctxt ~loc expected.cond actual.cond;
      assert_expr_equal ~ctxt ~loc expected.tru actual.tru;
      assert_expr_equal ~ctxt ~loc expected.fls actual.fls
  | Syntax.ExprLet expected, Syntax.ExprLet actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Recursion markers are not equal" ~printer:string_of_bool expected.recur actual.recur;
      List.iter2 (assert_binding_equal ~ctxt ~loc) expected.bindings actual.bindings
  | Syntax.ExprAbs expected, Syntax.ExprAbs actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      List.iter2 (assert_param_equal ~ctxt ~loc) expected.params actual.params;
      CoreTest.assert_optional_equal ~ctxt "Return types" (assert_ty_equal ~loc) expected.ret actual.ret;
      assert_expr_equal ~ctxt ~loc expected.body actual.body
  | Syntax.ExprApp expected, Syntax.ExprApp actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_expr_equal ~ctxt expected.fn actual.fn;
      List.iter2 (assert_expr_equal ~ctxt ~loc) expected.args actual.args
  | expected, actual -> fail_expr_constr ~ctxt expected actual

and assert_binding_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Binding expected, Syntax.Binding actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_patt_equal ~ctxt ~loc expected.patt actual.patt;
      CoreTest.assert_optional_equal ~ctxt "Binding types" (assert_ty_equal ~loc) expected.ty actual.ty;
      assert_expr_equal ~ctxt ~loc expected.value actual.value

(* Package Statements *)

let fail_pkg_constr = CoreTest.fail_constr "Package statement" (function
  | Syntax.Library _ -> "Library"
  | Syntax.Executable _ -> "Executable"
)

let assert_pkg_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Library expected, Syntax.Library actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | Syntax.Executable expected, Syntax.Executable actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name
  | expected, actual -> fail_pkg_constr ~ctxt expected actual

(* Imports *)

let assert_path_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Path expected, Syntax.Path actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Package paths are not equal" ~printer:Fun.id expected.path actual.path

let assert_alias_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Alias expected, Syntax.Alias actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      CoreTest.assert_optional_equal ~ctxt "local alias" (assert_name_equal ~loc) expected.alias actual.alias;
      assert_path_equal ~ctxt ~loc expected.path actual.path

let assert_pkgs_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Packages expected, Syntax.Packages actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      List.iter2 (assert_alias_equal ~ctxt ~loc) expected.aliases actual.aliases

let assert_import_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.Import expected, Syntax.Import actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_pkgs_equal ~ctxt ~loc expected.pkgs actual.pkgs

(* Top-Level Bindings *)

let fail_top_constr = CoreTest.fail_constr "Top-level binding" (function
  | Syntax.TopTy _ -> "TopTy"
  | Syntax.TopVal _ -> "TopVal"
  | Syntax.TopDef _ -> "TopDef"
  | Syntax.TopLet _ -> "TopLet"
  | Syntax.TopMod _ -> "TopMod"
)

let rec assert_top_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.TopTy expected, Syntax.TopTy actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Local markings are not equal" ~printer:string_of_bool expected.local actual.local;
      List.iter2 (assert_ty_binding_equal ~ctxt ~loc) expected.bindings actual.bindings
  | Syntax.TopVal expected, Syntax.TopVal actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_binding_equal ~ctxt ~loc expected.binding actual.binding
  | Syntax.TopDef expected, Syntax.TopDef actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_binding_equal ~ctxt ~loc expected.binding actual.binding
  | Syntax.TopLet expected, Syntax.TopLet actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_equal ~ctxt ~msg:"Recursion markings are not equal" ~printer:string_of_bool expected.recur actual.recur;
      List.iter2 (assert_binding_equal ~ctxt ~loc) expected.bindings actual.bindings
  | Syntax.TopMod expected, Syntax.TopMod actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_name_equal ~ctxt ~loc expected.name actual.name;
      List.iter2 (assert_mod_param_equal ~ctxt ~loc) expected.params actual.params;
      List.iter2 (assert_top_equal ~ctxt ~loc) expected.elems actual.elems
  | expected, actual -> fail_top_constr ~ctxt expected actual

(* Files *)

let assert_file_equal ~ctxt ?loc:(loc = true) expected actual = match (expected, actual) with
  | Syntax.File expected, Syntax.File actual ->
      if loc then CoreTest.assert_loc_equal ~ctxt expected.loc actual.loc;
      assert_pkg_equal ~ctxt ~loc expected.pkg actual.pkg;
      List.iter2 (assert_import_equal ~ctxt ~loc) expected.imports actual.imports;
      List.iter2 (assert_top_equal ~ctxt ~loc) expected.tops actual.tops