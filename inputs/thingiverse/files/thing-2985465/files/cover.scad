$fn = 30;

BASE_HEIGHT = 3;
BASE_DIA = 46.9;

INNER_HEIGHT = 2;
INNER_DIA = 34; // 34.5

HOLDER_SIZEX = 8;
HOLDER_SIZEY = 7;
// should be less than 9mm
HOLDER_HEIGHT = BASE_HEIGHT + INNER_HEIGHT;
HOLDER_THICKNESS = 1.5;

AXIS_TO_REF = 1.1;
AXIS_TO_TOP = 2.8; // 2.4
AXIS_DIA = 2.8;
AXIS_X = HOLDER_SIZEX / 2;
AXIS_Y = BASE_DIA/2 - AXIS_TO_TOP;
AXIS_Z = BASE_HEIGHT - AXIS_TO_REF;

TEXT_THICKNESS = 0.5;

difference() {
	union() {
		difference() {
			union() {
				cylinder(h=BASE_HEIGHT, d=BASE_DIA);
				translate([0, 0, BASE_HEIGHT])
					cylinder(h=INNER_HEIGHT, d=INNER_DIA);
			};
			
			translate([0, -HOLDER_SIZEY/2+BASE_DIA/2, 0])
				cube([9999, HOLDER_SIZEY, 9999], center=true);
		}

		translate([0, -HOLDER_SIZEY/2+BASE_DIA/2, HOLDER_HEIGHT/2])
			difference() {
				cube([HOLDER_SIZEX, HOLDER_SIZEY, HOLDER_HEIGHT], center=true);
				cube([HOLDER_SIZEX-2*HOLDER_THICKNESS, HOLDER_SIZEY, HOLDER_HEIGHT], center=true);
			}

		translate([-AXIS_X, AXIS_Y, AXIS_Z])
			sphere(d=AXIS_DIA);
		translate([AXIS_X, AXIS_Y, AXIS_Z])
			sphere(d=AXIS_DIA);

	}

	translate([0, 0, TEXT_THICKNESS])
		linear_extrude(height=BASE_HEIGHT+INNER_HEIGHT-TEXT_THICKNESS)
			text("别瞅", font="微软雅黑", size=8, halign="center", valign="center");
}