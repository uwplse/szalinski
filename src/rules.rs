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
    permute::Permutation,
};

fn rw<M: Metadata<Cad>>(name: &str, lhs: &str, rhs: &str) -> Rewrite<Cad, M> {
    Cad::parse_rewrite(name, lhs, rhs).unwrap()
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

        // rw("concat_lists", "(Concat (List ?a...) (List ?b...))", "(List ?a... ?b...)"),
        // rw("concat_concat_l", "(Concat (Concat ?a ?b) ?c)", "(Concat ?a (Concat ?b ?c))"),
        // rw("concat_concat_r", "(Concat ?a (Concat ?b ?c))", "(Concat (Concat ?a ?b) ?c)"),

        // cad rules

        rw("union_nil", "(Union ?a ?b)", "(FoldUnion (Cons ?a (Cons ?b Nil)))"),
        rw("union_cons", "(Union ?a (FoldUnion ?list))", "(FoldUnion (Cons ?a ?list))"),
        rw("fold_repeat",
           "(FoldUnion (Map ?op (Repeat ?n ?param) ?cads))",
           "(Do ?op ?param (FoldUnion ?cads))"),

        rw("fold_op",
           "(FoldUnion (Do ?op ?param ?cad))",
           "(Do ?op ?param (FoldUnion ?cad))"),

        rw("inter_nil", "(Inter ?a ?b)", "(FoldInter (Cons ?a (Cons ?b Nil)))"),
        rw("inter_cons", "(Inter ?a (FoldInter ?list))", "(FoldInter (Cons ?a ?list))"),

        rw("do_trans",   "(Trans      ?params ?a)", "(Do Trans       ?params ?a)"),
        rw("do_scale",   "(Scale      ?params ?a)", "(Do Scale       ?params ?a)"),
        rw("do_rotate",  "(Rotate     ?params ?a)", "(Do Rotate      ?params ?a)"),
        rw("do_transp",  "(TransPolar ?params ?a)", "(Do TransPolar  ?params ?a)"),
        rw("undo_trans",   "(Do Trans       ?params ?a)", "(Trans      ?params ?a)"),
        rw("undo_scale",   "(Do Scale       ?params ?a)", "(Scale      ?params ?a)"),
        rw("undo_rotate",  "(Do Rotate      ?params ?a)", "(Rotate     ?params ?a)"),
        rw("undo_transp",  "(Do TransPolar  ?params ?a)", "(TransPolar ?params ?a)"),

        rw("map_nil",
           "(Cons (Do ?op ?param ?cad) Nil)",
           "(Map ?op (Cons ?param Nil) (Cons ?cad Nil))"),
        rw("map_cons",
           "(Cons (Do ?op ?param ?cad) (Map ?op ?params ?cads))",
           "(Map ?op (Cons ?param ?params) (Cons ?cad ?cads))"),

        rw("union_trans",
           "(Union (Trans ?x ?y ?z ?a) (Trans ?x ?y ?z ?b))",
           "(Trans ?x ?y ?z (Union ?a ?b))"),

        rw("inter_empty", "(Inter ?a Empty)", "Empty"),

        // idempotent
        rw("union_same", "(Union ?a ?a)", "?a"),
        rw("inter_same", "(Inter ?a ?a)", "?a"),

        rw("inter_union", "(Inter ?a (Union ?a ?b))", "?a"),

        // unsort propagation

        // rw("unsort_unsort", // FIXME UNSOUND
        //    "(Unsort ?perm (Unsort ?perm2 ?list))",
        //    "(Unsort ?perm ?list)"),
        // rw("unsort_concat_l", // FIXME UNSOUND
        //    "(Concat (Unsort ?perm ?list1) ?list2)",
        //    "(Unsort ?perm (Concat ?list1 ?list2))"),
        // rw("unsort_concat_r", // FIXME UNSOUND
        //    "(Concat ?list1 (Unsort ?perm ?list2))",
        //    "(Unsort ?perm (Concat ?list1 ?list2))"),

        rw("unsort_map",
           "(Map ?op (Unsort ?perm ?params) (Unsort ?perm ?cads))",
           "(Unsort ?perm (Map ?op ?params ?cads))"),

        rw("unsort_repeat",
           "(Map ?op (Unsort ?perm ?params) (Repeat ?n ?cad))",
           "(Unsort ?perm (Map ?op ?params (Repeat ?n ?cad)))"),

        rw("unsort_fold",
           "(FoldUnion (Unsort ?perm ?x))",
           "(FoldUnion ?x)"),

        // unpolar
        rw("unpolar_trans",
           "(Map Trans (Unpolar ?n ?center ?params) ?cads)",
           "(Map Trans (Repeat ?n ?center) (Map TransPolar ?params ?cads))"),

        // NOTE we do these rules in ListApplier now
        // rw("nil_repeat",
        //    "(List ?a)",
        //    "(Repeat 1 ?a)"),

        // rw("cons_repeat",
        //    "(Cons ?a (Repeat ?n ?a))",
        //    "(Repeat (+ ?n 1) ?a)"),

        rw("diff_push_union",
           "(Diff (Union ?a ?b) ?c)",
           "(Union (Diff ?a ?c) (Diff ?b ?c))"),
        rw("diff_pull_union",
           "(Union (Diff ?a ?c) (Diff ?b ?c))",
           "(Diff (Union ?a ?b) ?c)"),

        rw("diff",
           "(Diff (Diff ?a ?b) ?c)",
           "(Diff ?a (Union ?b ?c))"),

        // NOTE this explode the egraph
        // rw("diff2",
        //    "(Diff ?a (Union ?b ?c))",
        //    "(Diff (Diff ?a ?b) ?c)"),

        // NOTE these explode graph on cads/pldi2020-eval/input/cnc_endmills_holder_nohull.csexp
        // rw("combine_trans",
        //    "(Trans ?a ?b ?c (Trans ?d ?e ?f ?cad))",
        //    "(Trans (+ ?a ?d) (+ ?b ?e) (+ ?c ?f) ?cad)"),
        // rw("combine_rotate",
        //    "(Rotate ?a ?b ?c (Rotate ?d ?e ?f ?cad))",
        //    "(Rotate (+ ?a ?d) (+ ?b ?e) (+ ?c ?f) ?cad)"),

        rw("lift_op",
           "(Union (Do ?op ?params ?a) (Do ?op ?params ?b))",
           "(Do ?op ?params (Union ?a ?b))"),

        rw("rotate_zero", "(Rotate (Vec3 0 0 0) ?a)", "(Trans (Vec3 0 0 0) ?a)"),
        rw("scale_zero",  "(Scale  (Vec3 1 1 1) ?a)", "(Trans (Vec3 0 0 0) ?a)"),
        rw("zero_rotate", "(Trans (Vec3 0 0 0) ?a)", "(Rotate (Vec3 0 0 0) ?a)"),

        rw("scale_flip", "(Scale (Vec3 -1 -1 1) ?a)", "(Rotate (Vec3 0 0 180) ?a)"),

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

        Rewrite::new (
            "listapplier",
            Cad::parse_pattern("(List ?items...)").unwrap(),
            ListApplier {
                var: "?items...".parse().unwrap(),
            },
        )
    ];

    if std::env::var("SUSPECT_RULES") == Ok("1".into()) {
        // NOTE
        // These will break other things
        info!("Using suspect rules");
        rules.extend(vec![
            rw("id", "(Trans (Vec3 0 0 0) ?a)", "?a"),
            rw("union_comm", "(Union ?a ?b)", "(Union ?b ?a)"),
            rw("combine_scale",
               "(Scale (Vec3 ?a ?b ?c) (Scale (Vec3 ?d ?e ?f) ?cad))",
               "(Scale (Vec3 (* ?a ?d) (* ?b ?e) (* ?c ?f)) ?cad)"),
        ]);
    } else {
        info!("Not using suspect rules");
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
    return None;
    type Pair<T> = (Vec<usize>, SmallVec<T>);
    let mut parts: IndexMap<K, Pair<_>> = Default::default();
    for (i, &id) in ids.iter().enumerate() {
        let key = key_fn(i, id);
        let (is, ids) = parts.entry(key).or_default();
        is.push(i);
        ids.push(id);
    }

    let mut order = Vec::new();
    let mut list_ids = smallvec![];
    for (_, (is, ids)) in parts.into_iter() {
        order.extend(is);
        list_ids.push(egraph.add(Expr::new(Cad::List, ids)).id);
    }
    let concat = egraph.add(Expr::new(Cad::Concat, list_ids));
    let res = if order.iter().enumerate().all(|(i0, i1)| i0 == *i1) {
        concat
    } else {
        let p = Cad::Permutation(Permutation::from_vec(order));
        let e = Expr::new(
            Cad::Unsort,
            smallvec![egraph.add(Expr::unit(p)).id, concat.id],
        );
        egraph.add(e)
    };

    if !res.was_there {
        // println!("Partition by {:?}: {:?}", k, parts);
    }
    return Some(res);
}

impl Applier<Cad, Meta> for ListApplier {
    fn apply(&self, egraph: &mut EGraph, map: &WildMap) -> Vec<AddResult> {
        let ids = &map[&self.var];
        let bests: Vec<_> = ids
            .iter()
            .map(|&id| egraph[id].metadata.best.clone())
            .collect();
        let mut results = vec![];

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
        results.extend(partition_list(egraph, ids, |i, _| {
            bests[i].as_ref().op.clone()
        }));

        // insert repeats
        if !ids.is_empty() {
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
