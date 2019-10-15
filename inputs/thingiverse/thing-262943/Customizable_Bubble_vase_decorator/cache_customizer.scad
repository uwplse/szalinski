// Vase radius (in mm, a 1 mm margin will be automatically added)
R_vase = 30;
// Decorator thickness (mm)
Thickness = 2;
// Decorator total height (mm)
Height = 100;
// Holes: Rotation factor
R_factor = 3; // [-10:10]
// Holes: Scale factor
S_factor = 0.15;

/* [Hidden] */
R_in  = R_vase + 1;
W_ext = Thickness;

W_bottom = 10;
R_ext = R_in + W_ext;

R_top = 2 * 3.14159 * R_in / 12;
V_top = R_top / 5; // Variation on top
H_sym = true;
H_ext = Height + R_top + V_top;

W_hole = 6;

nb_holes = (Height / R_top / 2);

$fa = 2;
$fs = 1;

intersection() {
	difference() {
		cylinder(r = R_ext, h = H_ext);
		translate([0, 0, W_ext]) cylinder(r = R_ext - W_ext, h = H_ext);
		cylinder(r = R_ext - W_bottom, h = W_ext);
		for (i = [0:5]) {
			for (j = [0:nb_holes]) {
				translate([0, 0, Height + V_top * ((i % 3) - 1) - j * (2 * R_top - W_hole)]) {
					rotate([90, 0, 60 * i  - R_factor * j * j]) {
						cylinder(r = (R_top - W_hole) - S_factor * j * (R_top - W_hole), h = 2 * R_ext, center = H_sym);
					}
				}
			}
		}
	}
	union() {
		for (i = [0:5]) {
			translate([0, 0, Height + V_top * ((i % 3) - 1)]) {
				rotate([90, 0, 60 * i]) {
					cylinder(r = R_top, h = 2 * R_ext, center = H_sym);
				}
			}
		}
		translate([-R_ext, -R_ext, 0]) cube([2 * R_ext, 2 * R_ext, Height]);
	}
}
