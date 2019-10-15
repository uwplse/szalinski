minimum = -3; // [-5:10]


// optimization test function
function f(x) = pow(x-minimum,2) / 5 + 2;

/*  Recursive optimization of a convex function f.
    [implemented as a binary-like tree search]

    Optimizes the input value x w.r.t. minimization of f(x).

    Parameters
    ----------
    rg_min, rg_max : float
        Maximum and minimum range to search in.
    eps : float
        Target precision.
    iter : int
        Maximumm number of recursive iterations.
        100 is a good choice because of OpenScad limitations.

    Notes
    -----
    Define the target function f(x) beforehand!
*/ 
function optim(rg_min, rg_max, eps, iter=100) = let(
        h = rg_min + (rg_max - rg_min) / 2,
        df = f(h + eps) - f(h - eps)
    )
    ((abs(rg_max - rg_min) < eps) || (iter < 1))
    ? h
    : ((df > 0)
       ? optim(rg_min, h, eps, iter-1)
       : optim(h, rg_max, eps, iter-1));


// visualization

range_start = -5;
range_end = 10;
for (i = [range_start:0.5:range_end]) {
    translate([i,0,f(i)]) sphere(0.5,center=true);
    translate([i,0,0]) sphere(0.3,center=true);
}

x_optim = optim(range_start, range_end, 0.0001);

translate([x_optim,0,0]) cube(0.8, center=true);