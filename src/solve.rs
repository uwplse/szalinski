#![allow(dead_code)]

struct Input {
    i: i64,
    x: f64,
    y: f64,
    z: f64,
}

struct Deg1 {
    a_x: f64,
    b_x: f64,
    a_y: f64,
    b_y: f64,
    a_z: f64,
    b_z: f64,
}

struct Deg2 {
    a_x: f64,
    b_x: f64,
    c_x: f64,
    a_y: f64,
    b_y: f64,
    c_y: f64,
    a_z: f64,
    b_z: f64,
    c_z: f64,
}

fn solve_deg1(is: &Vec<f64>, vs: &Vec<f64>) -> (f64, f64) {
    let i1 = is[0];
    let i2 = is[1];
    let o1 = vs[0];
    let o2 = vs[1];
    let b = (o1 * i2) - (o2 * i1) / (i2 - i1);
    let a = (o2 - b) / i2;
    let mut ivs = is.iter().zip(vs.iter());
    assert!(ivs.all(|(&i, &v)| a * i + b == v), "unsat linear");
    return (a, b);
}

fn fun_deg1(ins: Vec<Input>) -> Deg1 {
    let is: Vec<f64> = ins.iter().map(|inp| inp.i as f64).collect();
    let xs: Vec<f64> = ins.iter().map(|inp| inp.x).collect();
    let ys: Vec<f64> = ins.iter().map(|inp| inp.y).collect();
    let zs: Vec<f64> = ins.iter().map(|inp| inp.z).collect();
    let (ax, bx) = solve_deg1(&is, &xs);
    let (ay, by) = solve_deg1(&is, &ys);
    let (az, bz) = solve_deg1(&is, &zs);
    return Deg1 {
        a_x: ax,
        b_x: bx,
        a_y: ay,
        b_y: by,
        a_z: az,
        b_z: bz,
    };
}

fn solve_deg2(is: &Vec<f64>, vs: &Vec<f64>) -> (f64, f64, f64) {
    let i1 = is[0];
    let i2 = is[1];
    let i3 = is[2];
    let o1 = vs[0];
    let o2 = vs[1];
    let o3 = vs[2];
    let a = (((o2 * i3) - (o3 * i2)) - ((i2 - i3) * (((o1 * i2) - (o2 * i1)) / (i1 - i2))))
        / ((i2 - i3) * ((i2 * i3) - (i1 * i2)));
    let c = (a * i1 * i2) - (((o1 * i2) - (o2 * i1)) / (i1 - i2));
    let b = (o3 - c - (a * i3 * i3)) / i3;
    let mut ivs = is.iter().zip(vs.iter());
    assert!(
        ivs.all(|(&i, &v)| a * i * i + b * i + c == v),
        "unsat quadratic"
    );
    return (a, b, c);
}

fn fun_deg2(ins: Vec<Input>) -> Deg2 {
    let is: Vec<f64> = ins.iter().map(|inp| inp.i as f64).collect();
    let xs: Vec<f64> = ins.iter().map(|inp| inp.x).collect();
    let ys: Vec<f64> = ins.iter().map(|inp| inp.y).collect();
    let zs: Vec<f64> = ins.iter().map(|inp| inp.z).collect();
    let (ax, bx, cx) = solve_deg2(&is, &xs);
    let (ay, by, cy) = solve_deg2(&is, &ys);
    let (az, bz, cz) = solve_deg2(&is, &zs);
    return Deg2 {
        a_x: ax,
        b_x: bx,
        c_x: cx,
        a_y: ay,
        b_y: by,
        c_y: cy,
        a_z: az,
        b_z: bz,
        c_z: cz,
    };
}

#[test]
fn deg1_test1() {
    let i1 = Input {
        i: 0,
        x: 1.0,
        y: 2.0,
        z: 3.0,
    };
    let i2 = Input {
        i: 1,
        x: 2.0,
        y: 3.0,
        z: 4.0,
    };
    let i3 = Input {
        i: 2,
        x: 3.0,
        y: 4.0,
        z: 5.0,
    };
    let i4 = Input {
        i: 3,
        x: 4.0,
        y: 5.0,
        z: 6.0,
    };
    let input = vec![i1, i2, i3, i4];
    let res = fun_deg1(input);
    assert_eq!(res.a_x, 1.0);
}

#[test]
fn deg2_test1() {
    let i1 = Input {
        i: 0,
        x: 0.0,
        y: 0.0,
        z: 0.0,
    };
    let i2 = Input {
        i: 1,
        x: 1.0,
        y: 1.0,
        z: 1.0,
    };
    let i3 = Input {
        i: 2,
        x: 4.0,
        y: 4.0,
        z: 4.0,
    };
    let i4 = Input {
        i: 3,
        x: 9.0,
        y: 9.0,
        z: 9.0,
    };
    let input = vec![i1, i2, i3, i4];
    let res = fun_deg2(input);
    assert_eq!(res.a_x, 1.0);
}
