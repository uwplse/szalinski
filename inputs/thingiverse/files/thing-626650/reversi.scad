// stones count = 1 + 3 * rr * (rr - 1)

/* [Board] */
// rows count (radius)
rr = 1; // [1:100]
// stone size
dx = 18;
// hexants
pp = 1; // [1:6]
// cut edge
ce = 0;
// stones, not board
so = 0; // [0:1]

/* [Joints] */
// plugs length (0 = none)
jp = 2;
// cuts plugs (radial)
cp = 1; // [0:1]
// edge plugs
ep = 1; // [0:1]
// plug fit
pf = 0.1;
// separated plugs - TODO
ps = 0; // [0:0]

/* [Carving] */
// hollow
hw = 1; // [0:1]
// wall thickness, if hollow
wt = 0.5;
// cuts wall (radial)
cw = 1;
// edge wall
ew = 1;
// ceiling && plugs 45' support - TODO
cs = 0; // [0:0]

/* [Global] */
// details
ds = 20;
// fudge factor
ff = 0.05;

/* [Hidden] */
pp_max = 6;
// hexagon
dq = sqrt(3) / 2;
dy = dx * dq;
dz = dx * 2 / 3;
// stone offset
oz = dx * 5 / 18;
// triangle
tri_dx = (rr + 1) * dx;
tri_dy = rr * dy;
tri_dz = dz / 2;

$fn = ds;

// -----

if (so) {
		translate([0, 0, oz+0.1]) board(pp, pp_max) hexa(rr - 1, dx) rand_flip() {
			color([0,0,0]) render() difference() {
				scale([0.75, 0.75, 0.5]) lentil(dz);
				translate([0, 0, -dx / 2]) cube(dx, center = true);
			}
			color([1,1,1]) render() intersection() {
				scale([0.75, 0.75, 0.5]) lentil(dz);
				translate([0, 0, -dx / 2]) cube(dx, center = true);
			}
		}
} else
translate([0, 0, tri_dz / 2])
union() {
	if (jp && pp < pp_max) union() { // plugs
		if (ep && !ce) hexa(rr, dx, true, true) translate([dx, 0, 0]) extrude([0, wt - jp, 0]) difference() { // edge plugs
			translate([-(dx / 2 - wt) / 2 + pf, wt / 2, wt / 2]) cube([dx / 2 - wt, wt, tri_dz - wt], center = true);
			translate([0, 0, oz - pf]) lentil(dz + 2 * wt);
			translate([-pf, 0, 0]) conus(tri_dz * 3 / 4, dx + 2 * wt) hole(dx, dy, tri_dz) translate([0, 0, oz]) lentil(dz + wt * 3 / 4);
		}
		if (cp) { // radial plugs
			radial_cuts(pp, pp_max, 0.5, rr - 0.5, dx, ce)
				rotate(-90) translate([dx / 2, 0, 0]) extrude([0, wt - jp, 0]) difference() {
				translate([-(dx / 2 - wt) / 2 + pf, wt / 2, wt / 2]) cube([dx / 2 - wt, wt, tri_dz - wt], center = true);
				translate([0, 0, oz - pf]) lentil(dz + 2 * wt);
				translate([-pf, 0, 0]) conus(tri_dz * 3 / 4, dx + 2 * wt) hole(dx, dy, tri_dz) translate([0, 0, oz]) lentil(dz + wt * 3 / 4);
			}
		}
	}
	intersection() {
		board(pp, pp_max) difference() { // solid
			triangle(tri_dx, tri_dy, tri_dz); // board
			hexa(ce ? rr - 1 : rr, dx) carving(dx, dy, tri_dz) translate([0, 0, oz]) lentil(dz); // holes
			if (ce) hexa(rr, dx, true) translate([0, 0, - tri_dz]) linear_extrude(dz) hexagon(dx + ff); // edge
		}
		if (hw) union() { // hollow
			board(pp, pp_max) { // hexants
				translate([0, 0, - tri_dz + wt]) triangle(tri_dx, tri_dy, tri_dz); // bottom
				hexa(ce ? rr - 1 : rr, dx) { // holes walls
					translate([0, 0, oz]) lentil(dz + 2 * wt);
					conus(tri_dz * 3 / 4, dx + 2 * wt) hole(dx, dy, tri_dz) translate([0, 0, oz]) lentil(dz + wt * 3 / 4);
				}
				if (ce) {
					if (ew) hexa(rr, dx, true) translate([0, 0, -tri_dz]) linear_extrude(dz) hexagon(dx + 2 * wt);
				} else {
					if (pp < pp_max && jp && ep) hexa(rr, dx, true, true) {
						translate([(dx - wt) / 2, ps + max(jp - ps, wt) / 2, 0]) cube([wt, max(jp - ps, wt), tri_dz], center = true); // edge sprockets
						if (!ps) translate([dx * 3/4 - wt, wt / 2, 0]) cube([dx / 2, wt, tri_dz], center = true); // edge half-walls
					} else if (ew)
						translate([0, -tri_dy, 0]) cube([tri_dx - dx, 2 * wt, tri_dz], center = true); // edge walls
				}
			}
			if (pp < pp_max) {
				if (jp && cp) {
					if (!(ce && ew) || rr > 1)
						radial_cuts(pp, pp_max, 0.5, rr - (ce && ew ? 1.5 : 0.5), dx)
							translate([ps + max(jp - ps, wt) / 2, wt / 2, 0]) cube([max(jp - ps, wt), wt, tri_dz], center = true); // radial sprockets
					radial_cuts(pp, pp_max, 0.5, rr - 0.5, dx, ce)
						translate([wt / 2, wt - dx / 4, 0]) cube([wt, dx / 2, tri_dz], center = true); // radial half-walls
				} else if (cw)
					radial_cuts(pp, pp_max, 1, 1, (tri_dx - dx) / 2) cube([2 * wt, tri_dx - dx, tri_dz], center = true); // radial walls
			}
		}
	}
}

// -----

module board(count, total) {
	for (i = [0 : count - 1]) translate([0,0,i*(so && pp > 1 ? 0.1 : 0)]) rotate(360 * i / total) children();
}

module triangle(tx, ty, tz) {
	difference() {
		rotate(0) translate([0, -ty / 2, 0])	cube([tx, ty, tz], center = true);
		rotate(60) translate([-tx / 2, ty / 2, 0]) cube([2 + tx, ty, tz * 2], center = true);
		rotate(-60) translate([tx / 2, ty / 2, 0]) cube([2 + tx, ty, tz * 2], center = true);
	}
}

module lentil(radius) {
	scale([1, 1, 0.5]) sphere(r = radius);
}

module hexa(r, x, outline = false, middle = false) {
	y = x * sqrt(3) / 2;
	mod = middle ? 1 : 0;
	for (j = [(outline ? r : mod) : r], i = [0 : j - mod])
		translate([(i - j / 2) * x, -j * y, 0]) children();
}

module carving(x, y, z) {
	spool(z, x) hole(x, y, z) children(); // bottom
	children(); // top
}

module spool(h, q) {
		translate([0, 0, h / 4]) conus(h * 3 / 4, 0) children();
		conus(h * 3 / 4, q) children();
}

module conus(h, q) {
	hull() {
		children();
		resize([q, q, 0]) translate([0, 0, -h]) mirror([0, 0, 1]) children();
	}
}

module hole(x, y, z) {
	intersection() {
		children();
		translate([0, 0, - z / 2]) cube([x, y, z], center = true);
	}
}

module hexagon(h) {
	x = h / 2;
	y = h / sqrt(3);
	polygon([[0, y], [-x, y / 2], [-x, -y / 2], [0, -y], [x, -y / 2], [x, y / 2]]);
}

module extrude(t) {
	hull() {
		children();
		translate(t) mirror([0, 1, 0]) children();
	}
}

module radial_cuts(count, total, min = 0, max = 0, ity = 0, cut_edge = false) {
	if (!cut_edge || max > 1) radial_cut(0, total, [min : max - (cut_edge ? 1 : 0)], ity, 0) children();
	radial_cut(count, total, [min : max], ity, 180) children();
}

module radial_cut(position, total, min_max = [0:0], ity = 0, angle = 0) {
	cut_turns(position, total) cut_steps(min_max, ity) rotate(angle) children();
}

module cut_steps(min_max, ity) {
	for (i = min_max) translate([0, -i * ity, 0]) children();
}

module cut_turns(position, total) {
	rotate((position - 0.5) * 360 / total) children();
}

module rand_flip(angle = 180, axis = [0,1,0]) {
	rotate(angle * round(rands(0,1,1)[0]), axis) children();
}