struct Deg1 {
    a: f64,
    b: f64,
}

struct Deg2 {
    a: f64,
    b: f64,
    c: f64,
}

fn solve_deg1(vs: &Vec<f64>) -> Option<(f64, f64)> {
    let i1 = 0.0;
    let i2 = 1.0;
    let o1 = vs[0];
    let o2 = vs[1];
    let b = (o1 * i2) - (o2 * i1) / (i2 - i1);
    let a = (o2 - b) / i2;
    let mut ivs = vs.iter().enumerate();
    if ivs.all(|(i, &v)| a * i as f64 + b == v) {
        Some((a, b))
    } else {
        None
    }
}

fn solve_deg2(vs: &Vec<f64>) -> Option<(f64, f64, f64)> {
    let i1 = 0.0;
    let i2 = 1.0;
    let i3 = 2.0;
    let o1 = vs[0];
    let o2 = vs[1];
    let o3 = vs[2];
    let a = (((o2 * i3) - (o3 * i2)) - ((i2 - i3) * (((o1 * i2) - (o2 * i1)) / (i1 - i2))))
        / ((i2 - i3) * ((i2 * i3) - (i1 * i2)));
    let c = (a * i1 * i2) - (((o1 * i2) - (o2 * i1)) / (i1 - i2));
    let b = (o3 - c - (a * i3 * i3)) / i3;
    let mut ivs = vs.iter().enumerate();
    if ivs.all(|(i, &v)| a * i as f64 * i as f64 + b * i as f64 + c == v) {
        Some((a, b, c))
    } else {
        None
    }
}


#[test]
fn deg1_test1() {
    let input = vec![1.0, 2.0, 3.0, 4.0];
    let res = solve_deg1(&input).unwrap();
    assert_eq!(res.0, 1.0);
}

#[test]
fn deg2_test1() {
    let input = vec![0.0, 1.0, 4.0, 9.0];
    let res = solve_deg2(&input).unwrap();
    assert_eq!(res.0, 1.0);
}

#[test]
fn deg2_fail() {
    let input = vec![0.0, 1.0, 14.0, 9.0];
    assert_eq!(solve_deg2(&input), None);
}