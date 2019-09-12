use egg::{
    pattern::Rewrite,
    parse::ParsableLanguage,
};

use crate::cad::Cad;

fn rw(name: &str, lhs: &str, rhs: &str) -> Rewrite<Cad> {
    Cad.parse_rewrite(name, lhs, rhs).unwrap()
}

pub fn slow_rules() -> Vec<Rewrite<Cad>> {
    vec![
        // rw("union_assoc", "(Union (Union ?a ?b) ?c)", "(Union ?a (Union ?b ?c))"),
    ]
}

#[rustfmt::skip]
pub fn rules() -> Vec<Rewrite<Cad>> {
    vec![
        rw("defloat", "(Float ?a)", "?a"),

        rw("union_nil",
           "(Union ?a ?b)",
           "(FoldUnion Empty (Cons ?a (Cons ?b Nil)))"),

        rw("union_cons",
           "(Union ?a (FoldUnion ?b ?c))",
           "(FoldUnion ?b (Cons ?a ?c))"),
        // rw("union_rec2", "(Union (FoldUnion ?a ?b) ?c)", "(FoldUnion ?a (Cons ?c ?b))"),
        rw("union_self", "(Union ?a ?a)", "?a"),

        rw("union_commute", "(Union ?a ?b)", "(Union ?b ?a)"),
        // rw("union_assoc", "(Union (Union ?a ?b) ?c)", "(Union ?a (Union ?b ?c))"),

        rw("union_trans",
           "(Union (Trans ?x ?y ?z ?a) (Trans ?x ?y ?z ?b))",
           "(Trans ?x ?y ?z (Union ?a ?b))"),

        rw("nil_trans",
           "(Cons (Trans ?x ?y ?z ?a) Nil)",
           "(MapTrans (Cons (Vec ?x ?y ?z) Nil) ?a)"),

        rw("cons_trans",
           "(Cons (Trans ?x ?y ?z ?a) (MapTrans ?list ?a))",
           "(MapTrans (Cons (Vec ?x ?y ?z) ?list) ?a)"),

        // rw("cons_trans2",
        //    "(Cons (Trans ?x ?y ?z ?a) (Cons (Trans ?x2 ?y2 ?z2 ?a) ?list))",
        //    "(Cons (MapTrans (Cons (Vec ?x ?y ?z) (Cons (Vec ?x2 ?y2 ?z2) Nil))) ?list)"),

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
    ]
}
