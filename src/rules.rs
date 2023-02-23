use std::{fmt::Debug, str::FromStr};

use crate::au::{ArgList, SolveResult};
use crate::cad::ListVar;
use crate::permute::{Partitioning, Permutation};
use crate::solve::{self, solve};
use crate::{
    au::{CadCtx, AU},
    cad::{println_cad, Cad, EGraph, MetaAnalysis, Rewrite, Vec3},
    num::{num, Num},
};
use egg::{rewrite as rw, *};
use indexmap::IndexSet;
use itertools::Itertools;
use log::warn;
use std::collections::{BTreeMap, HashMap, HashSet};

fn is_not_zero(var: &'static str) -> impl Fn(&mut EGraph, Id, &Subst) -> bool {
    let var = var.parse().unwrap();
    let zero = Cad::Num(num(0.0));
    move |egraph, _, subst| !egraph[subst[var]].nodes.contains(&zero)
}

fn is_eq(v1: &'static str, v2: &'static str) -> ConditionEqual<Cad> {
    let p1: Pattern<Cad> = v1.parse().unwrap();
    let p2: Pattern<Cad> = v2.parse().unwrap();
    ConditionEqual::new(p1, p2)
}

fn is_pos(vars: &[&'static str]) -> impl Fn(&mut EGraph, Id, &Subst) -> bool {
    let vars: Vec<Var> = vars.iter().map(|v| v.parse().unwrap()).collect();
    move |egraph, _, subst| {
        vars.iter().all(|v| {
            egraph[subst[*v]].nodes.iter().all(|n| {
                if let Cad::Num(num) = n {
                    num.to_f64() > 0.0
                } else {
                    true
                }
            })
        })
    }
}

#[rustfmt::skip]
pub fn pre_rules() -> Vec<Rewrite> {
    vec![
        rw!("union_comm"; "(Binop Union ?a ?b)" => "(Binop Union ?b ?a)"),
        rw!("inter_comm"; "(Binop Inter ?a ?b)" => "(Binop Inter ?b ?a)"),
        rw!("fold_nil"; "(Binop ?bop ?a ?b)" => "(Fold ?bop (List ?a ?b))"),
        rw!("fold_cons"; "(Binop ?bop ?a (Fold ?bop ?list))" => "(Fold ?bop (Cons ?a ?list))"),

        rw!(
            "flatten_union";
            "(Fold Union ?list)" => {
                let list = "?list".parse().unwrap();
                let op = Cad::Union;
                Flatten { list, op }
            }
        ),

        // rw!("union_consr"; "(Binop Union (Fold Union ?list) ?a)" => "(Fold Union (Cons ?a ?list))"),
        rw!("inter_consr"; "(Binop Inter/ (Fold Inter ?list) ?a)" => "(Fold Inter (Cons ?a ?list))"),

        // TODO can't parse this now
        // rw!("consl"; "(Binop ?bop (Fold ?bop (List ?items...)) ?a)" => "(Fold ?bop (List ?items... ?a))"),

        //     "(Fold Union (List (Fold Union (List ?list...)) ?rest...))" =>
        //     "(Fold Union (List ?rest... ?list...))"),
        // rw!("flatten_inter";
        //     "(Fold Inter (List (Fold Inter (List ?list...)) ?rest...))" =>
        //     "(Fold Inter (List ?rest... ?list...))"),

        // rw!("union_consr"; "(Binop Union ?a (Fold Union ?list))" => "(Fold Union (Cons ?a ?list))"),
        // rw!("inter_consr"; "(Binop Inter ?a (Fold Inter ?list))" => "(Fold Inter (Cons ?a ?list))"),
        // rw!("list_nil"; "Nil" => "(List)"),
        // rw!("list_cons"; "(Cons ?a (List ?b...))" => "(List ?a ?b...)"),
        // rw!("nil_list"; "(List)" => "Nil"),
        // rw!("cons_list"; "(List ?a ?b...)" => "(Cons ?a (List ?b...))"),


    ]
}

#[rustfmt::skip]
pub fn rules() -> Vec<Rewrite> {


    sz_param!(CAD_IDENTS: bool);
    sz_param!(INV_TRANS: bool);

    let mut rules = vec![
        // rw!("union_comm"; "(Binop Union ?a ?b)" => "(Binop Union ?b ?a)"),
        // rw!("inter_comm"; "(Binop Inter ?a ?b)" => "(Binop Inter ?b ?a)"),
        // rw!("fold_nil"; "(Binop ?bop ?a ?b)" => "(Fold ?bop (List ?a ?b))"),
        // rw!("fold_cons"; "(Binop ?bop ?a (Fold ?bop ?list))" => "(Fold ?bop (Cons ?a ?list))"),
        // rw!("union_consr"; "(Binop Union (Fold Union ?list) ?a)" => "(Fold Union (Cons ?a ?list))"),
        // rw!("inter_consr"; "(Binop Inter (Fold Inter ?list) ?a)" => "(Fold Inter (Cons ?a ?list))"),

        // rw("flatten_union",
        //    "(Fold Union (List (Fold Union (List ?list...)) ?rest...))",
        //    "(Fold Union (List ?rest... ?list...))"),
        // rw("flatten_inter",
        //    "(Fold Inter (List (Fold Inter (List ?list...)) ?rest...))",
        //    "(Fold Inter (List ?rest... ?list...))"),


        // math rules

        rw!("add_comm"; "(+ ?a ?b)" => "(+ ?b ?a)"),
        rw!("add_zero"; "(+ 0 ?a)" => "?a"),

        rw!("sub_zero"; "(- ?a 0)" => "?a"),

        rw!("mul_zero"; "(* 0 ?a)" => "0"),
        rw!("mul_one"; "(* 1 ?a)" => "?a"),
        rw!("mul_comm"; "(* ?a ?b)" => "(* ?b ?a)"),

        rw!("div_one"; "(/ ?a 1)" => "?a"),
        // rw!("mul_div"; "(* ?a (/ ?b ?a))" => "?b"),
        // rw!("div_mul"; "(/ (* ?a ?b) ?a)" => "?b"),
        rw!("mul_div"; "(* ?a (/ ?b ?a))" => "?b"
            if is_not_zero("?a")),
        rw!("div_mul"; "(/ (* ?a ?b) ?a)" => "?b"
            if is_not_zero("?a")),
        // rw!("mul_div_div"; "(* (/ ?a ?b) (/ ?c ?d))" => "(/ (* ?a ?c) (* ?b ?d))"),
        // rw!("div_div"; "(/ (/ ?a ?b) ?a)" => "(/ 1 ?b)"),

        // list rules

        rw!("fold_nil"; "(Binop ?bop ?a ?b)" => "(Fold ?bop (List ?a ?b))"),

        // cad rules

        // TODO: yz: this is not supported yet. Possibly a pre-rule
        // rw!("diff_to_union";
        //    "(Fold Diff (List ?a ?rest...))" =>
        //    "(Binop Diff ?a (Fold Union (List ?rest...)))"),

        rw!("fold_op"; "(Fold ?bop (Affine ?aff ?param ?cad))"=> "(Affine ?aff ?param (Fold ?bop ?cad))"),

        rw!("union_trans"; "(Union (Trans ?x ?y ?z ?a) (Trans ?x ?y ?z ?b))"=> "(Trans ?x ?y ?z (Union ?a ?b))"),

        rw!("inter_empty"; "(Inter ?a Empty)"=> "Empty"),

        // idempotent
        rw!("union_same"; "(Union ?a ?a)"=> "?a"),
        rw!("inter_same"; "(Inter ?a ?a)"=> "?a"),

        rw!("inter_union"; "(Inter ?a (Union ?a ?b))"=> "?a"),
        rw!("repeat_mapi"; "(Repeat ?n ?x)"=> "(MapI ?n ?x)"),
    ];

    if *CAD_IDENTS {
        rules.extend(vec![
            rw!("scale_flip"; "(Affine Scale (Vec3 -1 -1 1) ?a)"=> "(Affine Rotate (Vec3 0 0 180) ?a)"),

            rw!("scale_trans";
               "(Affine Scale (Vec3 ?a ?b ?c) (Affine Trans (Vec3 ?x ?y ?z) ?m))" =>
               "(Affine Trans (Vec3 (* ?a ?x) (* ?b ?y) (* ?c ?z))
              (Affine Scale (Vec3 ?a ?b ?c) ?m))"),

            rw!("trans_scale"; "(Affine Trans (Vec3 ?x ?y ?z) (Affine Scale (Vec3 ?a ?b ?c) ?m))"=> "(Affine Scale (Vec3 ?a ?b ?c) (Affine Trans (Vec3 (/ ?x ?a) (/ ?y ?b) (/ ?z ?c)) ?m))"),

            // rw("scale_rotate",
            //    "(Scale (Vec3 ?a ?a ?a) (Rotate (Vec3 ?x ?y ?z) ?m))",
            //    "(Rotate (Vec3 ?x ?y ?z) (Scale (Vec3 ?a ?a ?a) ?m))"),

            // rw("rotate_scale",
            //    "(Scale (Vec3 ?a ?a ?a) (Rotate (Vec3 ?x ?y ?z) ?m))",
            //    "(Rotate (Vec3 ?x ?y ?z) (Scale (Vec3 ?a ?a ?a) ?m))"),

            // primitives

            rw!("cone_scale";
               "(Cylinder (Vec3 ?h ?r1 ?r2) ?params ?center)" =>
               "(Affine Scale (Vec3 1 1 ?h)
                (Cylinder (Vec3 1 ?r1 ?r2) ?params ?center))"),

            rw!("scale_cone";
                "(Affine Scale (Vec3 1 1 ?h)
                  (Cylinder (Vec3 1 ?r1 ?r2) ?params ?center))" =>
                "(Cylinder (Vec3 ?h ?r1 ?r2) ?params ?center)"
                if is_pos(&["?h"])
            ),

            rw!("cylinder_scale";
               "(Cylinder (Vec3 ?h ?r ?r) ?params ?center)" =>
               "(Affine Scale (Vec3 ?r ?r ?h)
              (Cylinder (Vec3 1 1 1) ?params ?center))"),
            rw!("scale_cylinder";
                "(Affine Scale (Vec3 ?r ?r ?h)
              (Cylinder (Vec3 1 1 1) ?params ?center))" =>
                "(Cylinder (Vec3 ?h ?r ?r) ?params ?center)"
                if is_pos(&["?r", "?h"])
            ),

            rw!("cube_scale";
               "(Cube (Vec3 ?x ?y ?z) ?center)" =>
               "(Affine Scale (Vec3 ?x ?y ?z)
              (Cube (Vec3 1 1 1) ?center))"),
            rw!(
                "scale_cube";
                "(Affine Scale (Vec3 ?x ?y ?z)
              (Cube (Vec3 1 1 1) ?center))" =>
                "(Cube (Vec3 ?x ?y ?z) ?center)"
                if is_pos(&["?x", "?y", "?z"])
            ),

            rw!("sphere_scale";
               "(Sphere ?r ?params)" =>
               "(Affine Scale (Vec3 ?r ?r ?r)
              (Sphere 1 ?params))"),
            rw!(
                "scale_sphere";
                "(Affine Scale (Vec3 ?r ?r ?r)
              (Sphere 1 ?params))" =>
                "(Sphere ?r ?params)"
                if is_pos(&["?r"])
            ),

            // affine rules

            rw!("id"; "(Affine Trans (Vec3 0 0 0) ?a)"=> "?a"),

            rw!("combine_scale"; "(Affine Scale (Vec3 ?a ?b ?c) (Affine Scale (Vec3 ?d ?e ?f) ?cad))"=> "(Affine Scale (Vec3 (* ?a ?d) (* ?b ?e) (* ?c ?f)) ?cad)"),
            rw!("combine_trans"; "(Affine Trans (Vec3 ?a ?b ?c) (Affine Trans (Vec3 ?d ?e ?f) ?cad))"=> "(Affine Trans (Vec3 (+ ?a ?d) (+ ?b ?e) (+ ?c ?f)) ?cad)"),

        ]);
    }

    // rules.push(rw!(
    //     "listapplier";
    //     "?list" => {
    //         let var = "?list".parse().unwrap();
    //         ListApplier { var }
    //     }
    // ));

    if *CAD_IDENTS {
        // add the intro rules only for cads
        let id_affines = &[
            ("scale", "Affine Scale (Vec3 1 1 1)"),
            ("trans", "Affine Trans (Vec3 0 0 0)"),
            ("rotate", "Affine Rotate (Vec3 0 0 0)"),
        ];
        let possible_cads = &[
            ("affine", "(Affine ?op ?param ?cad)"),
            ("bop", "(Binop ?op ?cad1 ?cad2)"),
            ("fold", "(Fold ?op ?cads)"),
        ];
        for (aff_name, id_aff) in id_affines {
            for (cad_name, cad) in possible_cads {
                let intro = format!("id_{}_{}_intro", aff_name, cad_name);
                let outer: Pattern<_> = format!("({} {})", id_aff, cad).parse().unwrap();
                let cad: Pattern<_> = cad.parse().unwrap();
                rules.push(rw!(intro; cad => outer));
            }

            // elim rules work for everything
            let elim = format!("id_{}_elim", aff_name);
            let outer: Pattern<_> = format!("({} ?a)", id_aff).parse().unwrap();
            rules.push(rw!(elim; outer => "?a"));
        }
    }

    println!("Using {} rules", rules.len());

    rules
}

fn get_float(expr: &Cad) -> Option<Num> {
    match expr {
        Cad::Num(f) => Some(f.clone()),
        _ => None,
    }
}

fn get_vec(egraph: &EGraph, expr: &Cad) -> Option<Vec3> {
    if let Cad::Vec3(args) = expr {
        assert_eq!(args.len(), 3);
        let f0 = get_float(&egraph[args[0]].data.best)?;
        let f1 = get_float(&egraph[args[1]].data.best)?;
        let f2 = get_float(&egraph[args[2]].data.best)?;
        Some((f0, f1, f2))
    } else {
        None
    }
}

#[derive(Debug)]
struct ListApplier {
    var: Var,
}

// this partition will partition all at once
fn partition_list<U, F, K>(args: &[U], mut key_fn: F) -> Option<(Partitioning, Permutation)>
where
    F: FnMut(usize, &U) -> K,
    K: Ord + Eq + Debug + Clone,
    U: Ord,
{
    // allow easy disabling
    sz_param!(PARTITIONING: bool);
    if !*PARTITIONING {
        return None;
    }

    // parts is normalized in that key is enumerated in sorted order,
    // and value (each partition) is also sorted.
    let mut parts: BTreeMap<K, Vec<usize>> = Default::default();
    for (i, arg) in args.iter().enumerate() {
        let key = key_fn(i, arg);
        let part = parts.entry(key).or_default();
        part.push(i);
    }
    // normalize each partition
    for (_, part) in &mut parts {
        part.sort_by_key(|i| &args[*i]);
    }

    sz_param!(PARTITIONING_MAX: usize);
    if parts.len() <= 1 || parts.len() > *PARTITIONING_MAX {
        return None;
    }
    // println!("parts: {:?}", parts);

    let mut order = Vec::new();
    let mut lengths = Vec::new();
    for (_, part) in &parts {
        order.extend(part);
        lengths.push(part.len());
    }
    let part = Partitioning::from_vec(lengths);

    let perm = Permutation::from_vec(order);

    return Some((part, perm));
}

fn get_single_cad(egraph: &EGraph, id: Id) -> Cad {
    // let nodes = &egraph[id].nodes;
    // assert!(nodes.iter().all(|n| n == &nodes[0]));
    // let n = &nodes[0];
    // assert_eq!(n.children.len(), 0);
    // n.op.clone()
    let best = &egraph[id].data.best;
    assert!(best.is_leaf());
    best.clone()
}

fn get_affines(egraph: &EGraph, id: Id, affine_kind: &Cad) -> Vec<(Id, Id)> {
    egraph[id]
        .nodes
        .iter()
        .filter_map(|n| {
            if let Cad::Affine(args) = n {
                let kind = get_single_cad(egraph, args[0]);
                if affine_kind == &kind {
                    Some((args[1], args[2]))
                } else {
                    None
                }
            } else {
                None
            }
        })
        .collect()
}

sz_param!(AFFINE_SIGNATURE_MAX_LEN: usize);
type AffineSig = [usize; 3];
fn affine_signature(egraph: &EGraph, id: Id) -> AffineSig {
    let mut scales = 0;
    let mut rotates = 0;
    let mut translates = 0;
    for n in &egraph[id].nodes {
        if let Cad::Affine(args) = n {
            let kind = get_single_cad(egraph, args[0]);
            #[rustfmt::skip]
            match kind {
                Cad::Trans => {translates += 1;}
                Cad::Scale => {scales += 1;}
                Cad::Rotate => {rotates += 1;}
                _ => (),
            };
        }
    }
    translates = AFFINE_SIGNATURE_MAX_LEN.min(translates);
    scales = AFFINE_SIGNATURE_MAX_LEN.min(scales);
    rotates = AFFINE_SIGNATURE_MAX_LEN.min(rotates);
    [translates, scales, rotates]
}

// HACK just part a hard limit here so it doesn't get out of hand
sz_param!(STRUCTURE_MATCH_LIMIT: usize);

fn insert_map2s(egraph: &mut EGraph, list_ids: &[Id]) -> Vec<Id> {
    let mut results = vec![];

    let sigs: Vec<AffineSig> = list_ids
        .iter()
        .map(|&id| affine_signature(egraph, id))
        .collect();
    let unique_sigs: IndexSet<AffineSig> = sigs.iter().cloned().collect();

    for (cadi, cad) in [Cad::Trans, Cad::Scale, Cad::Rotate].iter().enumerate() {
        let affs_list: Vec<Vec<_>> = list_ids
            .iter()
            .map(|&id| get_affines(egraph, id, cad))
            .collect();

        assert!(affs_list
            .iter()
            .zip(&sigs)
            .all(|(affs, sig)| affs.len() >= sig[cadi]));

        let aff_id = egraph.add(cad.clone());

        let unique_sig_lengths = || unique_sigs.iter().map(|&sig| sig[cadi]);

        let total: usize = unique_sig_lengths().product();
        if total > *STRUCTURE_MATCH_LIMIT {
            warn!(
                "Exceeding structure match limit: {} > {}",
                total, *STRUCTURE_MATCH_LIMIT
            );
        }

        for choices in unique_sig_lengths()
            .map(|len| 0..len)
            .multi_cartesian_product()
            .take(*STRUCTURE_MATCH_LIMIT)
        {
            let (param_ids, cad_ids): (Vec<Id>, Vec<Id>) = affs_list
                .iter()
                .zip(&sigs)
                .map(|(affs, sig)| {
                    let unique_sig_i = unique_sigs.get_full(sig).unwrap().0;
                    affs[choices[unique_sig_i]]
                })
                .unzip();

            assert_eq!(param_ids.len(), cad_ids.len());

            let param_list_id = egraph.add(Cad::List(param_ids));
            let cad_list_id = egraph.add(Cad::List(cad_ids));
            let map2 = Cad::Map2([aff_id, param_list_id, cad_list_id]);
            let id = egraph.add(map2);
            results.push(id)
        }
    }

    results
}

#[allow(dead_code)]
fn num_sign(n: Num) -> i32 {
    let f = n.to_f64();
    if f < 0.0 {
        -1
    } else if f > 0.0 {
        1
    } else {
        0
    }
}

macro_rules! get_meta_list {
    ($egraph:expr, $eclass:expr) => {
        match &$egraph[$eclass].data.list {
            Some(ids) => ids,
            None => return vec![],
        }
    };
}

macro_rules! get_unit {
    ($egraph:expr, $eclass:expr, $cad:path) => {{
        let egraph = &$egraph;
        let eclass = $eclass;
        // let nodes = &egraph[eclass_list[0]].nodes;
        // if nodes.len() > 1 {
        //     assert!(nodes[1..].iter().all(|n| n == &nodes[0]))
        // }
        match &egraph[eclass].data.best {
            $cad(p) => {
                // assert_eq!(nodes[0].children.len(), 0);
                p
            }
            _ => panic!("expected {}", stringify!($cad)),
        }
    }};
}

#[derive(Debug)]
struct Flatten {
    op: Cad,
    list: Var,
}

impl Applier<Cad, MetaAnalysis> for Flatten {
    fn apply_one(
        &self,
        egraph: &mut EGraph,
        eclass: Id,
        map: &Subst,
        _searcher_ast: Option<&PatternAst<Cad>>,
        _rule_name: Symbol,
    ) -> Vec<Id> {
        fn get_nested_fold<'a>(egraph: &'a EGraph, op: &'a Cad, id: Id) -> Option<&'a [Id]> {
            let is_op = |i| egraph[i].nodes.iter().any(|c| c == op);
            let get_list = |i| egraph[i].data.list.as_ref().map(Vec::as_slice);
            egraph[id]
                .nodes
                .iter()
                .find(|n| matches!(n, Cad::Fold(_)) && is_op(n.children()[0]))
                .and_then(|n| get_list(n.children()[1]))
        }

        let ids = get_meta_list!(egraph, map[self.list]);
        let mut new_ids = Vec::new();
        for id in ids {
            match get_nested_fold(egraph, &self.op, *id) {
                Some(ids) => new_ids.extend(ids.iter().copied()),
                None => new_ids.push(*id),
            }
        }

        let new_list = egraph.add(Cad::List(new_ids));
        let op = egraph.add(self.op.clone());
        let new_fold = egraph.add(Cad::Fold([op, new_list]));

        let results = vec![new_fold];
        for result in results.iter() {
            egraph.union(eclass, *result);
        }
        results
    }
}

pub fn reroll(egraph: &mut EGraph) {
    let mut au = AU::default();
    let pattern: Pattern<Cad> = "(Fold Union ?list)".parse().unwrap();
    let list_var = Var::from_str(&"?list").unwrap();
    let matches = pattern.search(egraph);

    for m in matches {
        for subst in &m.substs {
            let root_id = subst[list_var];
            let list = egraph[root_id].data.list.as_ref().unwrap().clone();
            let list_len = list.len();

            // Step 3: compute and build rerolled exprs
            let mut part_to_ids = HashMap::<Vec<Id>, Vec<Id>>::new();
            for id in list.iter() {
                let list_id = egraph.add(Cad::List(vec![*id]));
                part_to_ids.insert(vec![*id], vec![list_id]);
            }
            let au_groups = get_au_groups(egraph, &list, &mut au);
            eprintln!("au_groups.len(): {}", au_groups.len());
            for (template, ids) in au_groups {
                println!("template: {:?}", template);
                println!("ids: {:?}", ids);
                let mut no_solving_exprs = vec![];
                // anti_substs[i] denotes potential anti-substitutions for ids[i].
                // in many cases there will be only one, but there may be many as well.
                let anti_subst_candidates = ids
                    .iter()
                    .map(|id| template.get_params(egraph, *id))
                    .multi_cartesian_product();
                // .collect_vec();
                // println!(
                //     "groups: {:?}",
                //     ids.iter()
                //         .map(|id| template.get_params(egraph, *id))
                //         .collect_vec()
                // );
                // println!(
                //     "anti_subst_candidates.len(): {}",
                //     anti_subst_candidates.len()
                // );
                for anti_substs in anti_subst_candidates.take(1000) {
                    assert!(anti_substs.len() == ids.len());

                    // compute all possible partition of the list
                    let part_perms = get_all_part_perms(&anti_substs);

                    // Solve for each partition
                    for (part, perm) in part_perms {
                        let anti_substs_parts: Vec<Vec<ArgList>> =
                            part.apply(&perm.apply(&anti_substs));
                        let id_parts = part.apply(&perm.apply(&ids));

                        for (anti_substs, mut ids) in
                            anti_substs_parts.into_iter().zip(id_parts.into_iter())
                        {
                            ids.sort();
                            if anti_substs.len() > 1 {
                                // TODO: solve should also do partial solving
                                let solved_ids = solve(egraph, &anti_substs, &template);
                                let vec_of_ids = part_to_ids.entry(ids).or_default();
                                for id in solved_ids.iter() {
                                    vec_of_ids.push(*id);
                                }
                            }
                        }
                    }

                    // also add the dumb list that does no solving
                    let col_len = anti_substs[0].len();
                    let arr_of_cols = (0..col_len)
                        .map(|i| anti_substs.iter().map(|row| row[i]).collect_vec())
                        .collect_vec();
                    let n = egraph.add(Cad::Num(anti_substs.len().into()));
                    let arg_ids = arr_of_cols
                        .iter()
                        .map(|col| {
                            let elems = col.iter().map(|n| egraph.add(Cad::Num(*n))).collect_vec();
                            let list_id = egraph.add(Cad::List(elems));
                            let var_id = egraph.add(Cad::ListVar(ListVar("i0".into())));
                            egraph.add(Cad::GetAt([list_id, var_id]))
                        })
                        .collect_vec();
                    let no_solving =
                        SolveResult::from_loop_params(vec![n], arg_ids).assemble(egraph, &template);
                    no_solving_exprs.push(no_solving);
                }
                part_to_ids.entry(ids).or_default().extend(no_solving_exprs);
            }

            // Step 4: try to combine different parts
            let part_to_ids = part_to_ids
                .into_iter()
                .filter_map(|(part, ids)| {
                    if ids.len() > 0 {
                        for id in ids.iter().skip(1) {
                            egraph.union(ids[0], *id);
                        }

                        Some((part, ids[0]))
                    } else {
                        None
                    }
                })
                .collect_vec();

            search_combinations_and_add(
                &part_to_ids,
                egraph,
                root_id,
                &mut vec![],
                &mut HashSet::default(),
                0,
                list_len,
            );
        }
    }

    egraph.rebuild();
}

fn search_combinations_and_add(
    part_to_ids: &[(Vec<Id>, Id)],
    egraph: &mut EGraph,
    root_id: Id,
    // part ids that are used
    cur_buffer: &mut Vec<Id>,
    ids_covered: &mut HashSet<Id>,
    cur_pos: usize,
    target_size: usize,
) {
    let todo_size = target_size - ids_covered.len();
    if todo_size == 0 {
        println!("found a merge!");
        for id in cur_buffer.iter() {
            println_cad(egraph, *id);
        }
        if cur_buffer.len() == 1 {
            egraph.union(root_id, cur_buffer[0]);
        } else {
            let list_id = egraph.add(Cad::List(cur_buffer.clone()));
            let concat_id = egraph.add(Cad::Concat([list_id]));
            egraph.union(root_id, concat_id);
        }
    } else {
        // for i in cur_pos..(part_to_ids.len() - todo_size + 1) {
        for i in cur_pos..part_to_ids.len() {
            let (part, id) = &part_to_ids[i];
            if part.iter().all(|id| !ids_covered.contains(id)) {
                cur_buffer.push(*id);
                ids_covered.extend(part);
                search_combinations_and_add(
                    part_to_ids,
                    egraph,
                    root_id,
                    cur_buffer,
                    ids_covered,
                    i + 1,
                    target_size,
                );
                part.iter().for_each(|id| assert!(ids_covered.remove(id)));
                cur_buffer.pop();
            }
        }
    }
}

fn get_all_part_perms(anti_substs: &Vec<ArgList>) -> HashSet<(Partitioning, Permutation)> {
    let m = anti_substs[0].len();
    // build possible partitions of the list
    // We only care about interesting columns, which hopefully aren't that many.
    let cands: Vec<_> = (1..m)
        .filter(|i| {
            !anti_substs
                .iter()
                .skip(1)
                .all(|anti_subst| anti_subst[*i] == anti_substs[0][*i])
        })
        .collect();

    // compute all possible partition of the list
    let mut part_perms = cands
        .iter()
        .cartesian_product(cands.iter())
        // when i == j, this corresponds partitioning by one key
        .filter(|(i, j)| i <= j)
        .filter_map(|(i, j)| partition_list(&anti_substs, |_, a_s| (a_s[*i], a_s[*j])))
        .collect::<HashSet<_>>();
    // also add the original list
    part_perms.insert((
        Partitioning::from_vec(vec![anti_substs.len()]),
        Permutation::from_vec((0..anti_substs.len()).collect_vec()),
    ));
    part_perms
}

fn get_au_groups(egraph: &EGraph, list: &Vec<Id>, au: &mut AU) -> Vec<(CadCtx, Vec<Id>)> {
    let mut au_groups = HashMap::<CadCtx, HashSet<Id>>::default();

    // TODO: handle repeated substructures (or do we?)
    // Step 1: compute anti-unification
    for i in 0..list.len() {
        for j in i + 1..list.len() {
            let result: &Vec<CadCtx> = au.anti_unify_class(egraph, &(list[i], list[j]));
            for cad in result {
                if au_groups.contains_key(cad) {
                    au_groups.get_mut(cad).unwrap().extend([list[i], list[j]]);
                } else {
                    au_groups.insert(cad.clone(), HashSet::default());
                }
            }
        }
    }
    if au_groups.len() == 0 {
        return vec![];
    }
    // flat buffer au_groups
    let mut au_groups: Vec<(CadCtx, Vec<Id>)> = au_groups
        .into_iter()
        .map(|(x, y)| {
            let mut y = y.into_iter().collect::<Vec<_>>();
            y.sort();
            (x, y)
        })
        .collect();

    // Step 2: shrink the AUs
    // we group by the ids they match and only take ones with smallest size
    // TODO: push this filtering down to AU
    // sort by signature (ids), then by size of CadCtx
    au_groups.sort_unstable_by(|a, b| a.1.cmp(&b.1).then_with(|| a.0.size().cmp(&b.0.size())));
    let au_groups: Vec<(CadCtx, Vec<Id>)> = au_groups.into_iter().fold(vec![], |mut acc, a| {
        if acc.last().map_or(true, |b| a.1 != b.1) {
            acc.push(a);
        }
        acc
    });
    au_groups
}
