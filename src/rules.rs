use std::{fmt::Debug, hash::Hash, rc::Rc};

use egg::{
    egraph::{AddResult, Metadata},
    expr::{Expr, Id, QuestionMarkName, RecExpr},
    parse::ParsableLanguage,
    pattern::{Applier, Rewrite, WildMap},
};

use indexmap::IndexMap;
use log::*;
use smallvec::{smallvec, SmallVec};

use crate::cad::{Cad, EGraph, Meta, Num};

fn rw<M: Metadata<Cad>>(name: &str, lhs: &str, rhs: &str) -> Rewrite<Cad, M> {
    Cad::parse_rewrite(name, lhs, rhs).unwrap()
}

#[rustfmt::skip]
pub fn rules() -> Vec<Rewrite<Cad, Meta>> {
    vec![
        rw("defloat", "(Float ?a)", "?a"),

        rw("list_nil", "Nil", "(List)"),
        rw("list_cons", "(Cons ?a (List ?b...))", "(List ?a ?b...)"),

        rw("union_nil",
           "(Union ?a ?b)",
           "(FoldUnion Empty (Cons ?a (Cons ?b Nil)))"),

        rw("union_cons",
           "(Union ?a (FoldUnion ?b ?c))",
           "(FoldUnion ?b (Cons ?a ?c))"),
        // rw("union_rec2", "(Union (FoldUnion ?a ?b) ?c)", "(FoldUnion ?a (Cons ?c ?b))"),
        rw("union_self", "(Union ?a ?a)", "?a"),

        // rw("union_commute", "(Union ?a ?b)", "(Union ?b ?a)"),
        // rw("union_assoc", "(Union (Union ?a ?b) ?c)", "(Union ?a (Union ?b ?c))"),

        rw("union_trans",
           "(Union (Trans ?x ?y ?z ?a) (Trans ?x ?y ?z ?b))",
           "(Trans ?x ?y ?z (Union ?a ?b))"),

        // rw("nil_repeat",
        //    "(List ?a)",
        //    "(Repeat 1 ?a)"),

        // rw("cons_repeat",
        //    "(Cons ?a (Repeat ?n ?a))",
        //    "(Repeat (+ ?n 1) ?a)"),

        rw("nil_trans",
           "(Cons (Trans ?x ?y ?z ?a) Nil)",
           "(Map Trans (Cons (Vec ?x ?y ?z) Nil) (Cons ?a Nil))"),

        rw("cons_trans",
           "(Cons (Trans ?x ?y ?z ?a) (Map Trans ?args ?b))",
           "(Map Trans (Cons (Vec ?x ?y ?z) ?args) (Cons ?a ?b))"),

        // rw("cons_trans2",
        //    "(Cons (Trans ?x ?y ?z ?a) (Cons (Trans ?x2 ?y2 ?z2 ?a) ?list))",
        //    "(Cons (MapTrans (Cons (Vec ?x ?y ?z) (Cons (Vec ?x2 ?y2 ?z2) Nil))) ?list)"),

        rw("nil_rotate",
           "(Cons (Rotate ?x ?y ?z ?a) Nil)",
           "(Map Rotate (Cons (Vec ?x ?y ?z) Nil) (Cons ?a Nil))"),

        rw("cons_rotate",
           "(Cons (Rotate ?x ?y ?z ?a) (Map Rotate ?args ?b))",
           "(Map Rotate (Cons (Vec ?x ?y ?z) ?args) (Cons ?a ?b))"),

        rw("diff_union",
           "(Diff (Union ?a ?b) ?c)",
           "(Union ?a (Diff ?b ?c))"),

        rw("diff",
           "(Diff (Diff ?a ?b) ?c)",
           "(Diff ?a (Union ?b ?c))"),

        // NOTE this explode the egraph
        // rw("diff2",
        //    "(Diff ?a (Union ?b ?c))",
        //    "(Diff (Diff ?a ?b) ?c)"),

        rw("combine_trans",
           "(Trans ?x1 ?y1 ?z1 (Trans ?x2 ?y2 ?z2 ?a))",
           "(Trans (+ ?x1 ?x2) (+ ?y1 ?y2) (+ ?z1 ?z2) ?a)"),
        rw("no_trans", "(Trans 0 0 0 ?a)", "?a"),

        rw("lift_scale",
           "(Union (Scale ?x ?y ?z ?a) (Scale ?x ?y ?z ?b))",
           "(Scale ?x ?y ?z (Union ?a ?b))"),

        rw("scale_trans",
           "(Scale ?a ?b ?c (Trans ?x ?y ?z ?m))",
           "(Trans (* ?a ?x) (* ?b ?y) (* ?c ?z) (Scale ?a ?b ?c ?m))"),

        rw("trans_scale",
           "(Trans ?x ?y ?z (Scale ?a ?b ?c ?m))",
           "(Scale ?a ?b ?c (Trans (/ ?x ?a) (/ ?y ?b) (/ ?z ?c) ?m))"),

        rw("scale_rotate",
           "(Scale ?a ?a ?a (Rotate ?x ?y ?z ?m))",
           "(Rotate ?x ?y ?z (Scale ?a ?a ?a ?m))"),

        rw("combine_rotate",
           "(Rotate ?x1 ?y1 ?z1 (Rotate ?x2 ?y2 ?z2 ?a))",
           "(Rotate (+ ?x1 ?x2) (+ ?y1 ?y2) (+ ?z1 ?z2) ?a)"),

        rw("rotate_zero", "(Rotate 0 0 0 ?a)", "?a"),

        Rewrite {
            name: "listapplier".into(),
            lhs: Cad::parse_pattern("(List ?items...)").unwrap(),
            applier: Rc::new(ListApplier {
                var: "?items...".parse().unwrap(),
            }),
            conditions: vec![],
        }
    ]
}

fn get_float(expr: &RecExpr<Cad>) -> Num {
    match expr.as_ref().op {
        Cad::Num(f) => f.clone(),
        _ => panic!("Expected float, got {}", expr.to_sexp()),
    }
}

type Vec3 = (Num, Num, Num);
fn get_vec(expr: &RecExpr<Cad>) -> Option<Vec3> {
    if Cad::Vec == expr.as_ref().op {
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

// NOTE
// partitioning is unsound right now because it will reorder elements
fn partition_list<F, K>(egraph: &mut EGraph, ids: &[Id], mut key_fn: F) -> Option<AddResult>
where
    F: FnMut(usize, Id) -> K,
    K: Hash + Eq + Debug,
{
    let mut parts: IndexMap<K, SmallVec<_>> = Default::default();
    for (i, &id) in ids.iter().enumerate() {
        let key = key_fn(i, id);
        parts.entry(key).or_default().push(id);
    }
    if parts.len() > 1 {
        if parts.values().any(|ids| ids.len() > 2) {
            debug!("Partitioning: {:?}", parts);
            let new_ids = parts
                .into_iter()
                .map(|(op, ids)| egraph.add(Expr::new(Cad::List, ids)).id)
                .collect();
            let e = Expr::new(Cad::Concat, new_ids);
            return Some(egraph.add(e));
        }
    }
    None
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
                if let Some(formula) = crate::solve::solve(&vec_list) {
                    debug!("Found formula {:?}", formula);
                    let e = Expr::unit(Cad::MapI(len, formula));
                    results.push(egraph.add(e))
                }
            }
            // try to partition things by operator
            results.extend(partition_list(egraph, ids, |i, _| {
                vec_list[i].0
            }));
        }
        // try to partition things by operator
        results.extend(partition_list(egraph, ids, |i, _| {
            bests[i].as_ref().op.clone()
        }));

        // insert repeats
        if !ids.is_empty() && ids.iter().all(|id| ids[0] == *id) {
            let n = Num::new(ids.len() as f64).unwrap();
            let len = Expr::unit(Cad::Num(n));
            let e = Expr::new(Cad::Repeat, smallvec![egraph.add(len).id, ids[0]]);
            results.push(egraph.add(e))
        }

        results
    }
}
