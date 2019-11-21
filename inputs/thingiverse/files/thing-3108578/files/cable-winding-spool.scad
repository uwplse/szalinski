// This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// https://creativecommons.org/licenses/by-sa/3.0/

// total height of the spool
height = 148;
// how deep to inset the rails on which to wind your cord
depth = 16;
// minimum thickness of spars
thickness = 4;
// thickness of DIN rail clamp; overall thickness
clampThickness = 6;
// how deep the bolt should go into the solid part, past the spring clip
boltHoleDepth = 10;
// diameter where the bolt passes through the spring clip
looseBoltDiameter = 3.2;
// diameter where the bolt should screw into the DIN holder body
tightBoltDiameter = 2.9;

// DIN rail clamp
// adapted from Thingiverse 101024 by Robert Hunt
// made with 1mm wider opening: my rail is bigger or my printer prints too small
// Dimensions: 19.74 x 51 x clampThickness
module din_clip() {
	$fn = 12;
	difference() {
		linear_extrude(height=clampThickness, convexity=5) {
			// imported Robert's DXF to Inkscape, adjusted, then exported via https://github.com/martymcguire/inkscape-openscad-poly
			polygon(points=
				[[-9.731, 25.355], [5.910, 25.355], [6.675, 25.203], [7.324, 24.770], [7.758, 24.121], [7.910, 23.355], [7.910, 10.855],
				[7.764, 10.502], [7.410, 10.355], [6.854, 10.355], [6.320, 10.510], [5.951, 10.925], [4.910, 13.105], [3.910, 13.106],
				[3.910, -21.394], [3.832, -21.783], [3.617, -22.101], [3.299, -22.315], [2.910, -22.394], [-5.372, -22.394], [-5.736, -22.550],
				[-5.852, -22.894], [-5.729, -23.238], [-5.372, -23.394], [5.160, -23.394], [5.160, -21.464], [5.302, -21.239], [5.566, -21.269],
				[9.561, -24.465], [9.730, -24.717], [9.721, -25.021], [9.538, -25.263], [9.249, -25.355], [-9.731, -25.355]]
				, paths=
				[[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 0]]
			);
		}
		translate([0, -22.5, clampThickness / 2]) {
			rotate([90, 90, 0]) {
				cylinder(h= boltHoleDepth, r = looseBoltDiameter / 2);
			}
		}
		translate([0, -22.5, clampThickness / 2]) {
			rotate([-90, 90, 0]) {
				cylinder(h= boltHoleDepth, r = tightBoltDiameter / 2);
			}
		}
	}
}
// End of DIN clip by Robert Hunt

module lozenge(l, w, h) {
        union() {
                translate([w / -2, 0, 0])
                        cube([w, l - w, h]);
                translate([0, 0, 0])
                        cylinder(d=w,h=h);
                translate([0, l - w, 0])
                        cylinder(d=w,h=h);
        }
}

module flattened_cylinder(l, h, d) {
	intersection() {
		translate([0, 0, d - h]) rotate([0, 90, 0]) cylinder(d=d, h=l);
		translate([0, 0, 0]) cube([l, d, h]);
	}
}

module holder() {
	$fn = 24;
	union() {
		translate([-9.8 + thickness / 2, pocketDepth - 49.35 + 25.5, 0]) mirror([1, 0, 0]) din_clip();
		translate([0, height / -2 + thickness / 2, 0]) lozenge(height, thickness, clampThickness);
		translate([0, height / -2 + depth + thickness, 0]) mirror([0, 1, 0]) flattened_cylinder(depth + thickness, clampThickness, clampThickness * 1.5);
		translate([0, height / 2 - depth - thickness, 0]) flattened_cylinder(depth + thickness, clampThickness, clampThickness * 1.5);
		translate([depth + thickness, height / -2 + thickness / 2, 0]) lozenge(height, thickness, clampThickness);
	}
}

holder();
