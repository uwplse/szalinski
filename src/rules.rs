use std::cmp::max;
use std::{fmt::Debug, str::FromStr};

use crate::au::ArgList;
use crate::permute::{Partitioning, Permutation};
use crate::solve::solve;
use crate::{
    au::{CadCtx, AU},
    cad::{Cad, EGraph, MetaAnalysis, Rewrite},
    num::{num, Num},
};
use egg::{rewrite as rw, *};
use itertools::Itertools;
use rand::prelude::Distribution;
use rand::thread_rng;
use std::collections::{BTreeMap, HashMap, HashSet};

fn is_not_zero(var: &'static str) -> impl Fn(&mut EGraph, Id, &Subst) -> bool {
    let var = var.parse().unwrap();
    let zero = Cad::Num(num(0.0));
    move |egraph, _, subst| !egraph[subst[var]].nodes.contains(&zero)
}

// fn is_eq(v1: &'static str, v2: &'static str) -> ConditionEqual<Cad> {
//     let p1: Pattern<Cad> = v1.parse().unwrap();
//     let p2: Pattern<Cad> = v2.parse().unwrap();
//     ConditionEqual::new(p1, p2)
// }

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
        rw!("inter_consr"; "(Binop Inter (Fold Inter ?list) ?a)" => "(Fold Inter (Cons ?a ?list))"),

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


    sz_param!(CAD_IDENTS: bool = true);

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
        rw!("add_zero_1"; "?a" => "(+ 0 ?a)"),

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

        rw!("union_trans"; "(Binop Union (Affine Trans (Vec3 ?x ?y ?z) ?a) (Affine Trans (Vec3 ?x ?y ?z) ?b))"=> "(Affine Trans (Vec3 ?x ?y ?z) (Binop Union ?a ?b))"),

        rw!("inter_empty"; "(Binop Inter ?a Empty)"=> "Empty"),

        // idempotent
        rw!("union_same"; "(Binop Union ?a ?a)"=> "?a"),
        rw!("inter_same"; "(Binop Inter ?a ?a)"=> "?a"),

        rw!("inter_union"; "(Binop Inter ?a (Binop Union ?a ?b))"=> "?a"),
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
// this partition will partition all at once
fn partition_list<U, F, K>(args: &[U], mut key_fn: F) -> Option<(Partitioning, Permutation)>
where
    F: FnMut(usize, &U) -> K,
    K: Ord + Eq + Debug + Clone,
    U: Ord,
{
    // allow easy disabling
    sz_param!(PARTITIONING: bool = true);
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

    sz_param!(PARTITIONING_MAX: usize = 5);
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

macro_rules! get_meta_list {
    ($egraph:expr, $eclass:expr) => {
        match &$egraph[$eclass].data.list {
            Some(ids) => ids,
            None => return vec![],
        }
    };
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
            let list = match egraph[root_id].data.list.as_ref() {
                Some(list) => list.clone(),
                None => continue,
            };
            let list_len = list.len();

            // Step 3: compute and build rerolled exprs
            let mut part_to_ids = HashMap::<Vec<Id>, Vec<Id>>::new();
            let au_groups: Vec<(CadCtx, Vec<Id>, Vec<Vec<Num>>)> =
                get_au_groups(egraph, &list, &mut au);
            eprintln!("au_groups.len(): {}", au_groups.len());
            for (template, ids, anti_substs) in au_groups {
                // anti_substs[i] denotes potential anti-substitutions for ids[i].
                // in many cases there will be only one, but there may be many as well.
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
                            let solved_ids = solve(egraph, &anti_substs, &template);
                            let vec_of_ids = part_to_ids.entry(ids).or_default();
                            for id in solved_ids.iter() {
                                vec_of_ids.push(*id);
                            }
                        }
                    }
                }
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

            eprintln!(
                "start searching: option_len: {} list_len: {list_len}",
                part_to_ids.len()
            );

            let mut singleton_part_to_ids = HashMap::new();
            for id in list.iter() {
                let list_id = egraph.add(Cad::List(vec![*id]));
                singleton_part_to_ids.insert(*id, list_id);
            }

            search_combinations_and_add(
                part_to_ids,
                &singleton_part_to_ids,
                egraph,
                root_id,
                singleton_part_to_ids.len(),
                // TODO: magic number
                100000,
            );
            eprintln!("search finished");
        }
    }

    egraph.rebuild();
}

fn search_combinations_and_add(
    mut part_to_ids: Vec<(Vec<Id>, Id)>,
    singleton_part_to_ids: &HashMap<Id, Id>,
    egraph: &mut EGraph,
    root_id: Id,
    target_size: usize,
    mut fuel: i64,
) {
    part_to_ids.sort_by(|a, b| a.0.len().cmp(&b.0.len()).reverse());

    let mut covered_by = HashMap::<Id, HashSet<Id>>::new();

    for (part, id) in part_to_ids.iter() {
        for part_id in part {
            covered_by.entry(*part_id).or_default().insert(*id);
        }
    }

    let mut disabled_parts = HashMap::<Id, usize>::default();
    for (_part, id) in part_to_ids.iter() {
        disabled_parts.insert(*id, 0);
    }

    search_combinations_and_add_impl(
        &part_to_ids,
        &singleton_part_to_ids,
        egraph,
        root_id,
        &mut vec![],
        0,
        &covered_by,
        &mut disabled_parts,
        0,
        target_size,
        3,
        &mut fuel,
    );
}

fn search_combinations_and_add_impl(
    part_to_ids: &[(Vec<Id>, Id)],
    singleton_part_to_ids: &HashMap<Id, Id>,
    egraph: &mut EGraph,
    root_id: Id,
    // part ids that are used
    cur_buffer: &mut Vec<Id>,
    // current position
    cur_pos: usize,
    // a reverted index on the mapping from part to id that covers this part
    covered_by: &HashMap<Id, HashSet<Id>>,
    // parts that are disabled by parts in cur_buffer
    disabled_parts: &mut HashMap<Id, usize>,
    // the size of parts covered
    covered_size: usize,
    // the size to target
    target_size: usize,
    limit: usize,
    fuel: &mut i64,
) -> bool {
    *fuel -= 1;
    if *fuel < 0 {
        return false;
    }
    let mut inserted = false;
    if limit != 0 && covered_size != target_size {
        // for i in cur_pos..(part_to_ids.len() - todo_size + 1) {
        for i in cur_pos..part_to_ids.len() {
            let (part, id) = &part_to_ids[i];
            if disabled_parts[id] == 0 {
                cur_buffer.push(*id);
                for part_id in part {
                    for id in covered_by[part_id].iter() {
                        *disabled_parts.get_mut(id).unwrap() += 1;
                    }
                }

                inserted |= search_combinations_and_add_impl(
                    part_to_ids,
                    singleton_part_to_ids,
                    egraph,
                    root_id,
                    cur_buffer,
                    i + 1,
                    covered_by,
                    disabled_parts,
                    covered_size + part.len(),
                    target_size,
                    limit - 1,
                    fuel,
                );
                if *fuel < 0 {
                    return inserted;
                }

                for part_id in part {
                    for id in covered_by[part_id].iter() {
                        *disabled_parts.get_mut(id).unwrap() -= 1;
                    }
                }
                cur_buffer.pop();
            }
        }
    }

    if !inserted {
        // fill the rest of missing pieces with singleton list
        let mut result = cur_buffer.clone();
        for (part_id, id) in singleton_part_to_ids {
            if cur_buffer
                .iter()
                .all(|id| covered_by.contains_key(part_id) && !covered_by[part_id].contains(id))
            {
                result.push(*id);
            }
        }
        // insert into the e-graph
        if result.len() == 1 {
            egraph.union(root_id, result[0]);
        } else {
            let list_id = egraph.add(Cad::List(result));
            let concat_id = egraph.add(Cad::Concat([list_id]));
            egraph.union(root_id, concat_id);
        }
    }
    return true;
}

fn get_all_part_perms(anti_substs: &Vec<ArgList>) -> HashSet<(Partitioning, Permutation)> {
    let m = anti_substs[0].len();
    // build possible partitions of the list
    // We only care about interesting columns, which hopefully aren't that many.
    let cands: Vec<_> = (0..m)
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
        // when i == j, this corresponds to partitioning by one key
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

fn get_au_groups(
    egraph: &EGraph,
    list: &Vec<Id>,
    au: &mut AU,
) -> Vec<(CadCtx, Vec<Id>, Vec<Vec<Num>>)> {
    let mut au_groups = HashMap::<CadCtx, HashMap<Id, Vec<Num>>>::default();

    // TODO: handle repeated substructures (or do we?)
    eprintln!("list length: {}", list.len());
    // TODO: don't hard code constants
    // Step 1: compute anti-unification
    let mut templates = HashSet::<CadCtx>::default();
    if list.len() < 500 {
        for i in 0..list.len() {
            for j in i + 1..list.len() {
                let result = au.anti_unify_class(egraph, &(list[i], list[j]));
                dbg!(result.len());
                for (cad, _, _) in result {
                    templates.insert(cad.clone());
                }
            }
        }
    } else {
        // If # arguments is too big, we sample a small set of pairs
        // to heuristically find possible templates (and a canonical e-class for each template)
        let mut rng = thread_rng();
        let uniform = rand::distributions::Uniform::new(0, list.len());
        let (mut success_times, mut try_times) = (0, 0);
        // we want # templates * # parametrization to be close to 100_000
        let template_limit = max(100_000 / list.len(), 5);
        while success_times < template_limit && try_times < 100_000 {
            let i = uniform.sample(&mut rng);
            let j = uniform.sample(&mut rng);
            let result = au.anti_unify_class(egraph, &(list[i], list[j]));
            for (cad, _, _) in result {
                templates.insert(cad.clone());
                success_times += 1;
            }
            try_times += 1;
        }
    }

    eprintln!(
        "anti_unification done, templates found: {}",
        au_groups.len()
    );

    for cad in templates {
        // dbg!(&cad);
        let mut map = HashMap::<Id, Vec<Num>>::default();
        for i in 0..list.len() {
            // let result = cad.get_params(egraph, list[i]);
            // if let Some(result) = result {
            //     map.entry(list[i]).or_insert(result);
            // }
            let results = cad.get_params(egraph, list[i]);
            // BIG TODO: this will only get you one parameter
            if results.len() > 0 {
                map.entry(list[i]).or_insert(results[0].clone());
            }
            // for result in results {
            //     map.entry(list[i]).or_insert(result);
            // }
        }
        if !map.is_empty() {
            au_groups.insert(cad, map);
        }
    }

    eprintln!("parametrization done");

    if au_groups.len() == 0 {
        return vec![];
    }
    // flat buffer au_groups
    let au_groups: Vec<(CadCtx, Vec<Id>, Vec<Vec<Num>>)> = au_groups
        .into_iter()
        // .filter(|(_x, y)| y.len() > 2)
        .map(|(x, y)| {
            let mut y = y.into_iter().collect::<Vec<_>>();
            y.sort_by_key(|(id, _args)| *id);
            let mut ids = vec![];
            let mut list_of_args = vec![];
            for (id, args) in y {
                ids.push(id);
                list_of_args.push(args);
            }
            (x, ids, list_of_args)
        })
        .collect();

    // Step 2: shrink the AUs
    // we group by the ids they match and only take ones with smallest size
    // UPDATE: We don't do this, since there's no way to figure out which template is just universally "better"
    // than others.
    // sort by signature (ids), then by size of CadCtx
    // au_groups.sort_unstable_by(|a, b| a.1.cmp(&b.1).then_with(|| a.0.size().cmp(&b.0.size())));
    // let au_groups: Vec<(CadCtx, Vec<Id>)> = au_groups.into_iter().fold(vec![], |mut acc, a| {
    //     if acc.last().map_or(true, |b| a.1 != b.1) {
    //         acc.push(a);
    //     }
    //     acc
    // });
    au_groups
}
