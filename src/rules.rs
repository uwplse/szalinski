use std::{fmt::Debug, hash::Hash};

use egg::{
    egraph::{AddResult, Metadata},
    expr::{Expr, Id, QuestionMarkName, RecExpr},
    parse::ParsableLanguage,
    pattern::{Applier, Rewrite, WildMap},
};

use indexmap::IndexMap;
use log::*;
use smallvec::{smallvec, SmallVec};

use crate::{
    cad::{Cad, EGraph, Meta, Vec3},
    num::Num,
    permute::{Partitioning, Permutation},
};

fn rw<M: Metadata<Cad>>(name: &str, lhs: &str, rhs: &str) -> Rewrite<Cad, M> {
    Cad::parse_rewrite(name, lhs, rhs).unwrap()
}

#[rustfmt::skip]
pub fn pre_rules() -> Vec<Rewrite<Cad, Meta>> {
    vec![
        rw("fold_nil", "(Binop ?bop ?a ?b)", "(Fold ?bop (List ?a ?b))"),
        rw("union_consl", "(Binop Union (Fold Union ?list) ?a)", "(Fold Union (Cons ?a ?list))"),
        rw("inter_consl", "(Binop Inter (Fold Inter ?list) ?a)", "(Fold Inter (Cons ?a ?list))"),
        // rw("union_consr", "(Binop Union ?a (Fold Union ?list))", "(Fold Union (Cons ?a ?list))"),
        // rw("inter_consr", "(Binop Inter ?a (Fold Inter ?list))", "(Fold Inter (Cons ?a ?list))"),
    ]
}

#[rustfmt::skip]
pub fn rules() -> Vec<Rewrite<Cad, Meta>> {
    let mut rules = vec![
        // math rules

        rw("add_comm", "(+ ?a ?b)", "(+ ?b ?a)"),
        rw("add_zero", "(+ 0 ?a)", "?a"),

        rw("sub_zero", "(- ?a 0)", "?a"),

        rw("mul_zero", "(* 0 ?a)", "0"),
        rw("mul_one", "(* 1 ?a)", "?a"),
        rw("mul_comm", "(* ?a ?b)", "(* ?b ?a)"),

        // list rules

        rw("list_nil", "Nil", "(List)"),
        rw("list_cons", "(Cons ?a (List ?b...))", "(List ?a ?b...)"),
        rw("nil_list", "(List)", "Nil"),
        rw("cons_list", "(List ?a ?b...)", "(Cons ?a (List ?b...))"),

        // cad rules

        rw("fold_nil", "(Binop ?bop ?a ?b)", "(Fold ?bop (List ?a ?b))"),

        // rw("diff_to_union",
        //    "(Fold Diff (List ?a ?rest...))",
        //    "(Binop Diff ?a (Fold Union (List ?rest...)))"),

        rw("fold_repeat",
           "(Fold ?bop (Map2 ?aff (Repeat ?n ?param) ?cads))",
           "(Affine ?aff ?param (Fold ?bop ?cads))"),

        rw("fold_op",
           "(Fold ?bop (Affine ?aff ?param ?cad))",
           "(Affine ?aff ?param (Fold ?bop ?cad))"),

        rw("map_nil",
           "(Cons (Affine ?aff ?param ?cad) Nil)",
           "(Map2 ?aff (Cons ?param Nil) (Cons ?cad Nil))"),
        rw("map_cons",
           "(Cons (Affine ?aff ?param ?cad) (Map2 ?aff ?params ?cads))",
           "(Map2 ?aff (Cons ?param ?params) (Cons ?cad ?cads))"),

        rw("union_trans",
           "(Union (Trans ?x ?y ?z ?a) (Trans ?x ?y ?z ?b))",
           "(Trans ?x ?y ?z (Union ?a ?b))"),

        rw("inter_empty", "(Inter ?a Empty)", "Empty"),

        // idempotent
        rw("union_same", "(Union ?a ?a)", "?a"),
        rw("inter_same", "(Inter ?a ?a)", "?a"),

        rw("inter_union", "(Inter ?a (Union ?a ?b))", "?a"),

        // partitioning
        rw("concat", "(Unpart ?part ?lists)", "(Concat ?lists)"),

        rw("map_unpart_r",
           "(Map2 ?op
              (List ?params...)
              (Unpart ?part ?cads))",
           "(Map2 ?op
              (Unpart ?part (Part ?part (List ?params...)))
              (Unpart ?part ?cads))"),

        // NOTE do we need part/unpart id?
        rw("part_unpart", "(Part ?part (Unpart ?part ?list))", "?list"),
        rw("unpart_part", "(Unpart ?part (Part ?part ?list))", "?list"),

        // unsort propagation
        rw("sort_unsort", "(Sort ?perm (Unsort ?perm ?list))", "?list"),
        rw("unsort_sort", "(Unsort ?perm (Sort ?perm ?list))", "?list"),

        rw("map_unsort_l",
           "(Map2 ?op
              (Unsort ?perm ?params)
              ?cads)",
           "(Unsort ?perm
              (Map2 ?op
                ?params
                (Sort ?perm ?cads)))"),

        rw("map_unsort_r",
           "(Map2 ?op
              ?params
              (Unsort ?perm ?cads))",
           "(Unsort ?perm
              (Map2 ?op
                (Sort ?perm ?params)
                ?cads))"),

        rw("unsort_repeat", "(Unsort ?perm (Repeat ?n ?elem))", "(Repeat ?n ?elem)"),

        rw("fold_union_unsort", "(Fold Union (Unsort ?perm ?x))", "(Fold Union ?x)"),
        rw("fold_inter_unsort", "(Fold Inter (Unsort ?perm ?x))", "(Fold Inter ?x)"),

        // unpolar
        rw("unpolar_trans",
           "(Map2 Trans (Unpolar ?n ?center ?params) ?cads)",
           "(Map2 Trans (Repeat ?n ?center) (Map2 TransPolar ?params ?cads))"),
        // rw("unpolar_trans0",
        //    "(Map2 Trans (Unpolar ?n (Vec3 0 0 0) ?params) ?cads)",
        //    "(Map2 TransPolar ?params ?cads)"),


        // NOTE these explode graph on cads/pldi2020-eval/input/cnc_endmills_holder_nohull.csexp
        // rw("combine_trans",
        //    "(Trans ?a ?b ?c (Trans ?d ?e ?f ?cad))",
        //    "(Trans (+ ?a ?d) (+ ?b ?e) (+ ?c ?f) ?cad)"),
        // rw("combine_rotate",
        //    "(Rotate ?a ?b ?c (Rotate ?d ?e ?f ?cad))",
        //    "(Rotate (+ ?a ?d) (+ ?b ?e) (+ ?c ?f) ?cad)"),

        rw("lift_op",
           "(Union (Affine ?op ?params ?a) (Affine ?op ?params ?b))",
           "(Affine ?op ?params (Union ?a ?b))"),

        rw("rotate_zero", "(Affine Rotate (Vec3 0 0 0) ?a)", "(Affine Trans (Vec3 0 0 0) ?a)"),
        rw("scale_zero",  "(Affine Scale  (Vec3 1 1 1) ?a)", "(Affine Trans (Vec3 0 0 0) ?a)"),
        rw("zero_rotate", "(Affine Trans (Vec3 0 0 0) ?a)", "(Affine Rotate (Vec3 0 0 0) ?a)"),

        rw("scale_flip", "(Affine Scale (Vec3 -1 -1 1) ?a)", "(Affine Rotate (Vec3 0 0 180) ?a)"),

        // rw("scale_trans",
        //    "(Scale (Vec3 ?a ?b ?c) (Trans (Vec3 ?x ?y ?z) ?m))",
        //    "(Trans (Vec3 (* ?a ?x) (* ?b ?y) (* ?c ?z)) (Scale (Vec3 ?a ?b ?c) ?m))"),

        // rw("trans_scale",
        //    "(Trans (Vec3 ?x ?y ?z) (Scale (Vec3 ?a ?b ?c) ?m))",
        //    "(Scale (Vec3 ?a ?b ?c) (Trans (Vec3 (/ ?x ?a) (/ ?y ?b) (/ ?z ?c)) ?m))"),

        // rw("scale_rotate",
        //    "(Scale (Vec3 ?a ?a ?a) (Rotate (Vec3 ?x ?y ?z) ?m))",
        //    "(Rotate (Vec3 ?x ?y ?z) (Scale (Vec3 ?a ?a ?a) ?m))"),

        // rw("rotate_scale",
        //    "(Scale (Vec3 ?a ?a ?a) (Rotate (Vec3 ?x ?y ?z) ?m))",
        //    "(Rotate (Vec3 ?x ?y ?z) (Scale (Vec3 ?a ?a ?a) ?m))"),

        // primitives
        rw("cone_scale",
           "(Cylinder (Vec3 ?h ?r1 ?r2) ?params ?center)",
           "(Affine Scale (Vec3 1 1 ?h)
              (Cylinder (Vec3 1 ?r1 ?r2) ?params ?center))"),
        rw("scale_cone",
           "(Affine Scale (Vec3 1 1 ?h)
              (Cylinder (Vec3 1 ?r1 ?r2) ?params ?center))",
           "(Cylinder (Vec3 ?h ?r1 ?r2) ?params ?center)"),

        rw("cylinder_scale",
           "(Cylinder (Vec3 ?h ?r ?r) ?params ?center)",
           "(Affine Scale (Vec3 ?r ?r ?h)
              (Cylinder (Vec3 1 1 1) ?params ?center))"),
        rw("scale_cylinder",
           "(Affine Scale (Vec3 ?r ?r ?h)
              (Cylinder (Vec3 1 1 1) ?params ?center))",
           "(Cylinder (Vec3 ?h ?r ?r) ?params ?center)"),

        rw("cube_scale",
           "(Cube (Vec3 ?x ?y ?z) ?center)",
           "(Affine Scale (Vec3 ?x ?y ?z)
              (Cube (Vec3 1 1 1) ?center))"),
        rw("scale_cube",
           "(Affine Scale (Vec3 ?x ?y ?z)
              (Cube (Vec3 1 1 1) ?center))",
           "(Cube (Vec3 ?x ?y ?z) ?center)"),

        rw("sphere_scale",
           "(Sphere ?r ?params)",
           "(Affine Scale (Vec3 ?r ?r ?r)
              (Sphere 1 ?params))"),
        rw("scale_sphere",
           "(Affine Scale (Vec3 ?r ?r ?r)
              (Sphere 1 ?params))",
           "(Sphere ?r ?params)"),

        rw("repeat_mapi", "(Repeat ?n ?x)", "(MapI ?n ?x)"),

        // mapi
        rw("map_repeat",
           "(Map2 ?op (MapI ?n ?formula) (MapI ?n ?cad))",
           "(MapI ?n (Affine ?op ?formula ?cad))"),

        Rewrite::new (
            "listapplier",
            Cad::parse_pattern("(List ?items...)").unwrap(),
            ListApplier {
                var: "?items...".parse().unwrap(),
            },
        ),

        Rewrite::new (
            "sortapplier",
            Cad::parse_pattern("(Sort ?perm (List ?items...))").unwrap(),
            SortApplier {
                perm: "?perm".parse().unwrap(),
                items: "?items...".parse().unwrap(),
            },
        ),

        Rewrite::new (
            "partapplier",
            Cad::parse_pattern("(Part ?part (List ?items...))").unwrap(),
            PartApplier {
                part: "?part".parse().unwrap(),
                items: "?items...".parse().unwrap(),
            },
        ),

        // TODO should this perform concat when possible?
        Rewrite::new (
            "unpart-unsort",
            Cad::parse_pattern("(Unpart ?part (List ?items...))").unwrap(),
            UnpartApplier {
                part: "?part".parse().unwrap(),
                items: "?items...".parse().unwrap(),
            },
        ),

        Rewrite::new (
            "sort-unpart",
            Cad::parse_pattern("(Sort ?sort (Unpart ?part (List ?items...)))").unwrap(),
            SortUnpartApplier {
                sort: "?sort".parse().unwrap(),
                part: "?part".parse().unwrap(),
                items: "?items...".parse().unwrap(),
            },
        ),
    ];

    if std::env::var("SUSPECT_RULES") == Ok("1".into()) {
        // NOTE
        // These will break other things
        info!("Using suspect rules");
        println!("Using suspect rules");
        rules.extend(vec![
            rw("union_comm", "(Union ?a ?b)", "(Union ?b ?a)"),
            rw("id", "(Affine Trans (Vec3 0 0 0) ?a)", "?a"),
            rw("combine_scale",
               "(Affine Scale (Vec3 ?a ?b ?c) (Affine Scale (Vec3 ?d ?e ?f) ?cad))",
               "(Affine Scale (Vec3 (* ?a ?d) (* ?b ?e) (* ?c ?f)) ?cad)"),
        ]);
    } else {
        info!("Not using suspect rules");
        println!("Not using suspect rules");
    }

    rules
}

fn get_float(expr: &RecExpr<Cad>) -> Num {
    match expr.as_ref().op {
        Cad::Num(f) => f.clone(),
        _ => panic!("Expected float, got {}", expr.to_sexp()),
    }
}

fn get_vec(expr: &RecExpr<Cad>) -> Option<Vec3> {
    if Cad::Vec3 == expr.as_ref().op {
        let args = &expr.as_ref().children;
        assert_eq!(args.len(), 3);
        let f0 = get_float(&args[0]);
        let f1 = get_float(&args[1]);
        let f2 = get_float(&args[2]);
        Some((f0, f1, f2))
    } else {
        None
    }
}

#[derive(Debug)]
struct ListApplier {
    var: QuestionMarkName,
}

// this partition will partition all at once
fn partition_list<F, K>(egraph: &mut EGraph, ids: &[Id], mut key_fn: F) -> Option<AddResult>
where
    F: FnMut(usize, Id) -> K,
    K: Hash + Eq + Debug + Clone,
{
    // allow easy disabling
    sz_param!(PARTITIONING: bool);
    if !*PARTITIONING {
        return None;
    }

    // actually do the partitioning, keeping track of where we put things
    type Pair<T> = (Vec<usize>, SmallVec<T>);
    let mut parts: IndexMap<K, Pair<_>> = Default::default();
    for (i, &id) in ids.iter().enumerate() {
        let key = key_fn(i, id);
        let (is, ids) = parts.entry(key).or_default();
        is.push(i);
        ids.push(id);
    }

    if parts.len() <= 1 {
        return None;
    }

    let mut order = Vec::new();
    let mut list_ids = smallvec![];
    let mut lengths = Vec::new();
    for (_, (is, ids)) in &parts {
        order.extend(is);
        lengths.push(ids.len());
        list_ids.push(egraph.add(Expr::new(Cad::List, ids.clone())).id);
    }
    let part = Partitioning::from_vec(lengths);
    let part_id = egraph.add(Expr::unit(Cad::Partitioning(part))).id;
    let list_of_lists = egraph.add(Expr::new(Cad::List, list_ids)).id;
    let concat = egraph.add(Expr::new(Cad::Unpart, smallvec![part_id, list_of_lists]));

    let perm = Permutation::from_vec(order);
    let res = if perm.is_ordered() {
        concat
    } else {
        let p = Cad::Permutation(perm);
        let e = Expr::new(
            Cad::Unsort,
            smallvec![egraph.add(Expr::unit(p)).id, concat.id],
        );
        egraph.add(e)
    };

    if !res.was_there {
        debug!("Partition: {:?}", parts);
    }
    return Some(res);
}

fn get_single_cad(egraph: &EGraph, id: Id) -> Cad {
    let nodes = &egraph[id].nodes;
    assert!(nodes.iter().all(|n| n == &nodes[0]));
    let n = &nodes[0];
    assert_eq!(n.children.len(), 0);
    n.op.clone()
}

impl Applier<Cad, Meta> for ListApplier {
    fn apply(&self, egraph: &mut EGraph, map: &WildMap) -> Vec<AddResult> {
        let ids = &map[&self.var];
        let bests: Vec<_> = ids
            .iter()
            .map(|&id| egraph[id].metadata.best.clone())
            .collect();
        let ops: Option<Vec<_>> = ids
            .iter()
            .map(|&id| {
                egraph[id].nodes.iter().find_map(|n| match n.op {
                    Cad::Affine => Some(get_single_cad(egraph, n.children[0])),
                    _ => None,
                })
            })
            .collect();
        let mut results = vec![];

        // don't partition a list of lists
        if ids
            .iter()
            .any(|&id| egraph[id].nodes.iter().any(|n| n.op == Cad::List))
        {
            return results;
        }

        // try to solve a list
        if let Some(vec_list) = bests.iter().map(get_vec).collect::<Option<Vec<Vec3>>>() {
            let len = vec_list.len();
            if len > 2 {
                results.extend(crate::solve::solve(egraph, &vec_list));
            }
            // try to partition things by coordinate
            results.extend(partition_list(egraph, ids, |i, _| vec_list[i].0));
            results.extend(partition_list(egraph, ids, |i, _| vec_list[i].1));
            results.extend(partition_list(egraph, ids, |i, _| vec_list[i].2));
            results.extend(partition_list(egraph, ids, |i, _| {
                (vec_list[i].0, vec_list[i].1)
            }));
            results.extend(partition_list(egraph, ids, |i, _| {
                (vec_list[i].0, vec_list[i].2)
            }));
            results.extend(partition_list(egraph, ids, |i, _| {
                (vec_list[i].1, vec_list[i].2)
            }));
        }

        // try to partition things by eclass
        results.extend(partition_list(egraph, ids, |i, _| ids[i]));

        // try to partition things by operator
        if let Some(ops) = ops {
            results.extend(partition_list(egraph, ids, |i, _| ops[i].clone()));
        }

        // insert repeats
        if ids.len() > 1 {
            let i0 = egraph.find(ids[0]);
            if ids.iter().all(|id| i0 == egraph.find(*id)) {
                let len = Expr::unit(Cad::Num(ids.len().into()));
                let e = Expr::new(Cad::Repeat, smallvec![egraph.add(len).id, i0]);
                results.push(egraph.add(e))
            }
        }

        results
    }
}

macro_rules! get_unit {
    ($egraph:expr, $eclass_list:expr, $cad:path) => {{
        let egraph = &$egraph;
        let eclass_list = &$eclass_list;
        assert_eq!(eclass_list.len(), 1, "more than one eclass");
        let nodes = &egraph[eclass_list[0]].nodes;
        if nodes.len() > 1 {
            assert!(nodes[1..].iter().all(|n| n == &nodes[0]))
        }
        match &nodes[0].op {
            $cad(p) => {
                assert_eq!(nodes[0].children.len(), 0);
                p
            }
            _ => panic!("expected {}", stringify!($cad)),
        }
    }};
}

#[derive(Debug)]
struct SortApplier {
    perm: QuestionMarkName,
    items: QuestionMarkName,
}

impl Applier<Cad, Meta> for SortApplier {
    fn apply(&self, egraph: &mut EGraph, map: &WildMap) -> Vec<AddResult> {
        let items = &map[&self.items];
        let perm: &Permutation = get_unit!(egraph, map[&self.perm], Cad::Permutation);
        let sorted = perm.apply(items);
        let e = Expr::new(Cad::List, sorted.into());
        vec![egraph.add(e)]
    }
}

#[derive(Debug)]
struct PartApplier {
    part: QuestionMarkName,
    items: QuestionMarkName,
}

impl Applier<Cad, Meta> for PartApplier {
    fn apply(&self, egraph: &mut EGraph, map: &WildMap) -> Vec<AddResult> {
        let items = &map[&self.items];
        let part: &Partitioning = get_unit!(egraph, map[&self.part], Cad::Partitioning);
        let list_of_lists = part
            .apply(items)
            .into_iter()
            .map(|sublist| egraph.add(Expr::new(Cad::List, sublist.into())).id)
            .collect();

        let e = Expr::new(Cad::List, list_of_lists);
        vec![egraph.add(e)]
    }
}

#[derive(Debug)]
struct UnpartApplier {
    part: QuestionMarkName,
    items: QuestionMarkName,
}

impl Applier<Cad, Meta> for UnpartApplier {
    fn apply(&self, egraph: &mut EGraph, map: &WildMap) -> Vec<AddResult> {
        let part: Partitioning = get_unit!(egraph, map[&self.part], Cad::Partitioning).clone();
        let items = &map[&self.items];
        assert_eq!(part.lengths.len(), items.len());

        if items.is_empty() {
            return vec![egraph.add(Expr::unit(Cad::Nil))];
        }

        let get_unsort = |id: Id| -> Option<(&Permutation, Id)> {
            egraph[id].nodes.iter().find_map(|n| match n.op {
                Cad::Unsort => {
                    let perm = get_unit!(egraph, n.children[..1], Cad::Permutation);
                    Some((perm, n.children[1]))
                }
                _ => None,
            })
        };

        let mut big_perm = vec![];
        let mut ids = vec![];
        let mut len_so_far = 0;
        for (&id, &len) in items.iter().zip(&part.lengths) {
            if let Some((perm, inner_id)) = get_unsort(id) {
                assert_eq!(perm.len(), len);
                big_perm.extend(perm.order.iter().map(|i| i + len_so_far));
                ids.push(inner_id);
            } else {
                big_perm.extend(len_so_far..len_so_far + len);
                ids.push(id);
            }
            len_so_far += len;
        }
        assert_eq!(len_so_far, part.total_len());
        assert_eq!(len_so_far, big_perm.len());

        let perm = Permutation::from_vec(big_perm);
        let is_ordered = perm.is_ordered();
        let perm = egraph.add(Expr::unit(Cad::Permutation(perm))).id;
        let part = egraph.add(Expr::unit(Cad::Partitioning(part))).id;

        let list = egraph.add(Expr::new(Cad::List, ids.into())).id;
        let unpart = egraph.add(Expr::new(Cad::Unpart, smallvec![part, list]));

        if is_ordered {
            vec![unpart]
        } else {
            let unsort = egraph.add(Expr::new(Cad::Unsort, smallvec![perm, unpart.id]));
            vec![unsort]
        }
    }
}

#[derive(Debug)]
struct SortUnpartApplier {
    sort: QuestionMarkName,
    part: QuestionMarkName,
    items: QuestionMarkName,
}

impl Applier<Cad, Meta> for SortUnpartApplier {
    fn apply(&self, egraph: &mut EGraph, map: &WildMap) -> Vec<AddResult> {
        let sort: Permutation = get_unit!(egraph, map[&self.sort], Cad::Permutation).clone();
        let part: Partitioning = get_unit!(egraph, map[&self.part], Cad::Partitioning).clone();
        let items = &map[&self.items];

        let mut sorts = vec![];
        let mut len_so_far = 0;
        for len in &part.lengths {
            let slice = &sort.order[len_so_far..len_so_far + len];
            if !slice
                .iter()
                .all(|&i| len_so_far <= i && i < len_so_far + len)
            {
                return vec![];
            }
            sorts.push(slice.iter().map(|i| i - len_so_far).collect());
            len_so_far += len;
        }

        let sorted_lists = sorts
            .into_iter()
            .zip(items)
            .map(|(p, &list_id)| {
                let perm = Permutation::from_vec(p);
                let sort_id = egraph.add(Expr::unit(Cad::Permutation(perm))).id;
                egraph
                    .add(Expr::new(Cad::Sort, smallvec![sort_id, list_id]))
                    .id
            })
            .collect();
        let list = egraph.add(Expr::new(Cad::List, sorted_lists)).id;
        let part_id = egraph.add(Expr::unit(Cad::Partitioning(part.clone()))).id;
        vec![egraph.add(Expr::new(Cad::Unpart, smallvec![part_id, list]))]
    }
}
