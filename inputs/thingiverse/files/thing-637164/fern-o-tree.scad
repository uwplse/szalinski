// recursion
n = 17;
// stem thickness
w = 0.5;
// stem length
d = 13;
// curling
a = -9;
// rotate
rot = 1; // [0:1]
// mirror
mir = 1; // [0:1]

// n+1 / n ratio
gc = (sqrt(5) - 1) / 2;
wgc = w * gc;
// short / long stem ratio
sq = pow(gc, 3);
dsq = d * sq;
// leaf length
lzs = 1 / gc;
// leaf dimensions
ls = [lzs * pow(gc, 2), lzs * pow(gc, 5), lzs];

// branching delay
q = 1 + (1 - gc) / 2;
// details
$fn = 10;
// leaf treshold
ee = 0.1;
// stem treshold
eee = 0.04;

long(n);

module long(i, e = 1) {
	rotate(a, [1, 0, 0]) {
		color([i/64,0.5-i/64,0]) {
			cylinder(d, w, wgc * (1 + sq)); // long stem
			translate([0, 0, d]) sphere(1.025 * wgc * (1 + sq)); // knee
		}
		translate([0, 0, d])
		do_rotate(rot)
		{
			if (i >= 1 && e > eee) short(i - 1, e); // short stem
			else leaf();

			rotate(-72, [0, 1, 0])
			do_mirror(mir)
			{
				if (i >= 4 && e > ee) scale(q*gc*gc) long(i - 4, e*q*gc*gc); // branch
				else leaf(i);
			}
		}
	}
}

module short(i, e = 1) {
	rotate(a*gc, [1, 0, 0]) {
		color([i/64,0.5-i/64,0]) {
			cylinder(dsq, wgc * (1 + sq), wgc); // short stem
			translate([0, 0, dsq]) sphere(1.025 * wgc); // knee
		}
		translate([0, 0, dsq])
		do_rotate(rot)
		{
			if (i >= 1 && e > eee) scale(gc) long(i - 1, e*gc); // long stem
			else leaf();

			rotate(72, [0, 1, 0])
			do_mirror(mir)
			{
				if (i >= 4 && e > ee) scale(q*gc*gc) long(i - 4, e*q*gc*gc); // branch
				else leaf(i);
			}
		}
	}
}

module leaf(i = 1, r = 6) {
	color([(i <= 3 ? i : 3)/3 * 63/255, (1 - (i<=3 ? i : 3)/6) * 255/255,0])
		translate([0, 0, r * lzs]) scale(ls) sphere(r);
}

module do_rotate(is_rotate) {
	if (is_rotate) {
		rotate(72, [1, 0, 3]) children();
	} else {
		children();
	}
}

module do_mirror(is_mirror) {
	if (is_mirror) {
		mirror([0, 1, 0]) children();
	} else {
		children();
	}
}