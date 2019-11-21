/* [General] */
Snaps = 10;

SetOrSingle = "Set"; // [Single, Set]

Resolution = 120; // [20:300]

/* [Values] */

// in mm
Diameter = 40;

// in mm (can be helpful to overcome printing-precission issues)
SnapFreeArea = 4;

// in mm
SnapHeight = 4;

// in mm (for smaller torosional force - this value is added to [SnapHeight] and then cut off)
CutTip = 0;

// in mm
ScrewHole = 2;

// in mm
GroundPlateThickness = 2;

/* [Hide]*/

module singleSnap(snaps, h, ct, d, res, gpt) {
	// full height
	fh = h + ct;
	
	// original size
	angle = 180 / snaps;
	side = tan(angle) * d / 2;
	
	// adjusted size (necessary to overcome compilation issues)
	aH = fh + gpt / 2;
	ratio = aH / fh;
	aSide = side * ratio;

	translate([d/2,0,0]) {
		rotate([0,-90,0]) {
			linear_extrude(height = d/2,center = false, twist = 0, scale = [1,0], slices = res) {
				polygon(
					points=[[aH, 0],[0, aSide],[0, -aSide]],
					paths=[[0,1,2]]
				);
			}
		}
	}
}

module allSnaps(snaps, h, ct, d, res, snapfree, gpt) {
	translate([0, 0, - ct / 2]) {
		difference() {
			intersection() {
				for(i = [0:snaps - 1]) {
					rotate((360 / snaps) * i, [0, 0, 1]) {
						singleSnap(snaps, h, ct, d, res, gpt);
					}
				}
				translate([0, 0, ct / 2]) {
					cylinder(h = h + gpt / 2, r = d / 2);
				}
			}
			translate([0, 0, -1]) {
				cylinder(h = h + ct + gpt / 2 + 2, r = snapfree);
			}
		}
	}
}

module snapsWithPlate(snaps, h, ct, d, res, snapfree, gpt, screw) {
	difference() {
		union() {
			// 0.5 * gpt because of the necessary adjustment in singleSnap
			translate([0, 0, 0.5 * gpt]) {
				allSnaps(snaps, h, ct, d, res, snapfree, gpt);
			}
			cylinder(h = gpt, r = d / 2);
		}
		translate([0, 0, -1]) {
			cylinder(h = h + gpt + 2, r = screw);
		}
	}
}

module singleDisc(
	snaps = Snaps,
	d = Diameter,
	h = SnapHeight,
	ct = CutTip,
	res = Resolution,
	screw = ScrewHole,
	gpt = GroundPlateThickness,
	snapfree = SnapFreeArea
) {
	snapsWithPlate(snaps, h, ct, d, res, snapfree, gpt, screw);
}

module discSet(
	snaps = Snaps,
	d = Diameter,
	h = SnapHeight,
	ct = CutTip,
	res = Resolution,
	screw = ScrewHole,
	gpt = GroundPlateThickness,
	snapfree = SnapFreeArea
) {
	translate([-d/2 - 1, 0, 0]) {
		snapsWithPlate(snaps, h, ct, d, res, snapfree, gpt, screw);
	}
	translate([d/2 + 1, 0, 0]) {
		snapsWithPlate(snaps, h, ct, d, res, snapfree, gpt, screw);
	}
}

module generator(
	snaps = Snaps,
	d = Diameter,
	h = SnapHeight,
	ct = CutTip,
	screw = ScrewHole,
	gpt = GroundPlateThickness,
	snapfree = SnapFreeArea,
	res = Resolution,
	sos = SetOrSingle
) {
	$fn = res;
	if (sos == "Single") {
		singleDisc(snaps, d, h, ct, res, screw, gpt, snapfree);
	} else if (sos == "Set") {
		discSet(snaps, d, h, ct, res, screw, gpt, snapfree);
	} else {
		singleDisc(snaps, d, h, ct, res, screw, gpt, snapfree);
	}
}

generator(
	Snaps,
	Diameter,
	SnapHeight,
	CutTip,
	ScrewHole,
	GroundPlateThickness,
	SnapFreeArea,
	Resolution,
	SetOrSingle
);

