/* [General] */

part="Complete Lockholder Set"; // [Complete Lockholder Set, Single Lockholder Set, Top Part, Bottom Part]

// wall thickness
Thickness = 4;

// lower is faster - higher is smoother (use a low value for drafting, increase it later)
Resolution = 20; // [20:300]

/* [Bike and Lock] */

TopTubeDiameter = 32.25;

// make it a little bigger for easy insertion
LockDiameter = 20;

// longer prevents vibrations but may be clumsy
LocktubeLength = 50; // [10:150]

// between top part and bottom part - bigger values for tighter fit (I suggest to leave it at 0)
Offset = 0;

/* [Screws and Nuts] */

// A/F in this [picture](http://en.wikipedia.org/wiki/Nut_%28hardware%29#Standard_metric_hex_nuts_sizes)
NutDiameter = 9;

ScrewThreadDiameter = 5.55;

// share of the wall thickness for the screw holes
ScrewholeThickness = 0.75;

/* [Hidden] */
$fn=Resolution;

if (part == "Complete Lockholder Set") {
        completeLockHolderSet(
                diameterTopTube = TopTubeDiameter,
                lengthLock = LocktubeLength,
                diameterLock = LockDiameter,
                nutSizeOuter = NutDiameter,
                nutSizeInner = ScrewThreadDiameter,
                thickness = Thickness,
                offset = Offset,
                screwOffsetShare = ScrewholeThickness
        );
} else if (part == "Single Lockholder Set") {
        lockHolderSet(
                diameterTopTube = TopTubeDiameter,
                lengthLock = LocktubeLength,
                diameterLock = LockDiameter,
                nutSizeOuter = NutDiameter,
                nutSizeInner = ScrewThreadDiameter,
                thickness = Thickness,
                offset = Offset,
                screwOffsetShare = ScrewholeThickness
        );
} else if (part == "Top Part") {
        topPart(
                diameterTopTube = TopTubeDiameter,
                diameterLock = LockDiameter,
                nutSizeOuter = NutDiameter,
                nutSizeInner = ScrewThreadDiameter,
                thickness = Thickness,
                offset = Offset,
                screwOffsetShare = ScrewholeThickness
        );
} else if (part == "Bottom Part") {
        bottomPart(
                diameterTopTube = TopTubeDiameter,
                lengthLock = LocktubeLength,
                diameterLock = LockDiameter,
                nutSizeOuter = NutDiameter,
                nutSizeInner = ScrewThreadDiameter,
                thickness = Thickness,
                offset = Offset,
                screwOffsetShare = ScrewholeThickness
        );
} else {
        completeLockHolderSet(
                diameterTopTube = TopTubeDiameter,
                lengthLock = LocktubeLength,
                diameterLock = LockDiameter,
                nutSizeOuter = NutDiameter,
                nutSizeInner = ScrewThreadDiameter,
                thickness = Thickness,
                offset = Offset,
                screwOffsetShare = ScrewholeThickness
        );
}

// lockholder v 1.1

// Functions
// - Set of Top Part and Bottom Part
module lockHolderSet
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [(diameterTopTube / 2) + screwBarWidth + (1.5 * thickness), 0, 0]) {
		topPart(diameterTopTube, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
	}

	translate(v = [(-1) * ((diameterTopTube / 2) + screwBarWidth + (1.5 * thickness)), 0, 0]) {
		rotate(a = [0, 0, 180]) {
			bottomPart(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
		}
	}
}

// - Complete Set of 2 Top Parts and 2 Bottom Parts
module completeLockHolderSet
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, (lengthTopTube + thickness) / 2, 0]) {
		lockHolderSet(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
	}

	translate(v = [0, (-1) * ((lengthTopTube + thickness) / 2), 0]) {
		lockHolderSet(diameterTopTube, lengthLock, diameterLock, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
	}
}

// - Top Part
module topPart
(
	diameterTopTube = 30,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, lengthTopTube / 2, 0]) {
		topPart1(lengthTopTube, diameterTopTube, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
		translate(v = [0, (-1) * (nutSizeOuter + (thickness / 2)), 0]) {
			doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
		translate(v = [0, (-1) * (lengthTopTube - (nutSizeOuter + (1.5 * thickness))), 0]) {
			doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
	}
}

// - Bottom Part
module bottomPart
(
	diameterTopTube = 30,
	lengthLock = 50,
	diameterLock = 15,
	nutSizeOuter = 10,
	nutSizeInner = 6,
	thickness = 5,
	offset = 2,
	screwOffsetShare = 0.75
)
{
	lengthTopTube = diameterLock + (2 * nutSizeOuter) + (3 * thickness);
	screwBarWidth = nutSizeOuter + (thickness / 2);

	translate(v = [0, lengthTopTube / 2, 0]) {
		difference() {
			union() {
				bottomPart1(lengthTopTube, diameterTopTube, lengthLock, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare);
				translate(v = [0, (-1) * (nutSizeOuter + (thickness / 2)), 0]) {
					doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
				}
				translate(v = [0, (-1) * (lengthTopTube - (nutSizeOuter + (1.5 * thickness))), 0]) {
					doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
				}
				translate(v = [0, (-1) * ((lengthTopTube - thickness) / 2), 0]) {
					lockBracing(diameterTopTube, lengthLock, thickness, offset);
				}
			}
			translate(v = [((diameterTopTube + diameterLock) / 2)+ thickness, (-1) * (lengthTopTube / 2), (lengthLock - (thickness / 2))]) {
				carveRoundTube(diameterLock, thickness);
			}
			translate(v = [((diameterTopTube + diameterLock) / 2)+ thickness, (-1) * (lengthTopTube / 2), 0]) {
				rotate(a = [180, 0, 0]) {
					difference() {
						translate(v = [0, 0, (-1) * (thickness / 2)]) {
						carveRoundTube(diameterLock, thickness);
						}
						difference() {
							translate(v = [screwBarWidth - diameterLock, 0, (-1) * thickness / 2]) {
								cube(size = [diameterLock, diameterLock + (2 * thickness) + 2, thickness + 2], center = true);
							}
							translate(v = [0, 0, (-1) * ((thickness + 4) / 2)])
							cylinder(h = thickness + 4, r = (diameterLock + thickness) / 2);
						}
					}
				}
			}
		}
	}
}

// Modules
module tube(height, diameter, thickness) {
	difference() {
		cylinder(h = height, r = ((diameter / 2) + thickness));
		translate(v = [0, 0, -1]) {
			cylinder(h = height + 2, r = diameter / 2);
		}
	}
}

module halfTube(height, diameter, thickness, offset) {
	difference() {
		tube(height, diameter, thickness);
		translate(v = [((-1) * (diameter + (2 * thickness))) / 2, (-1) * ((diameter / 2) + thickness) - 1, -1]) {
			cube([diameter + (2 * thickness), (diameter / 2) + thickness +1 + (offset / 2), height + 2]);
		}
	}
}

module screwBar(nutSizeOuter, lengthTopTube, diameterTopTube, thickness, offset, screwOffsetShare) {
	difference() {
		union() {
			hull() {
				translate(v = [((diameterTopTube + nutSizeOuter) / 2) + thickness, thickness + (offset / 2), (nutSizeOuter + thickness) / 2]) {
					rotate(a = [90, 0, 0]) {
						cylinder(r = ((nutSizeOuter + thickness) / 2), h = thickness);
					}
				}
				translate(v = [(-1) * (((diameterTopTube + nutSizeOuter) / 2) + thickness), thickness + (offset / 2), (nutSizeOuter + thickness) / 2]) {
					rotate(a = [90, 0, 0]) {
						cylinder(r = (nutSizeOuter + thickness) / 2, h = thickness);
					}
				}
				translate(v = [((diameterTopTube + nutSizeOuter) / 2) + thickness, thickness + (offset / 2), lengthTopTube - ((nutSizeOuter + thickness) / 2) ]) {
					rotate(a = [90, 0, 0]) {
						cylinder(r = ((nutSizeOuter + thickness) / 2), h = thickness);
					}
				}
				translate(v = [(-1) * (((diameterTopTube + nutSizeOuter) / 2) + thickness), thickness + (offset / 2), lengthTopTube - ((nutSizeOuter + thickness) / 2)]) {
					rotate(a = [90, 0, 0]) {
						cylinder(r = ((nutSizeOuter + thickness) / 2), h = thickness);
					}
				}
			}
			positionShells(nutSizeOuter, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset, screwOffsetShare);
		}
		translate(v = [0, 0, -1]) {
			cylinder(r = diameterTopTube / 2, h = lengthTopTube + 2);
		}
	}
}

module tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset, screwOffsetShare) {
	union() {
		halfTube(lengthTopTube, diameterTopTube, thickness, offset);
		screwBar(nutSizeOuter, lengthTopTube, diameterTopTube, thickness, offset, screwOffsetShare);
	}
}

module makeShell(diameter, thickness, offset, screwOffsetShare) {
	translate(v = [0, ((1 + screwOffsetShare) * thickness) + (offset / 2), 0]) {
		rotate(a = [90, 0, 0]) {
			cylinder(r = (diameter + thickness) / 2, h = thickness);
		}
	}
}

module makeNut(diameter, thickness, screwOffsetShare) {
	translate(v = [0, (screwOffsetShare * thickness) + 1, 0]) {
		rotate(a = [90, 0, 0]) {
			translate(v = [0, 0, (-1) * (thickness / 2)]) {
				hexagon(size = diameter, height = thickness + 2);
			}
		}
	}
}

module screwHeadHole(diameter, thickness, screwOffsetShare) {
	translate(v = [0, (screwOffsetShare * thickness), 0]) {
		rotate(a = [-90, 0, 0]) {
			cylinder(r = diameter / 2, h = thickness + 2);
		}
	}
}

module screwHole(diameter, thickness) {
	translate(v = [0, -1, 0]) {
		rotate(a = [-90, 0, 0]) {
			cylinder(r = diameter / 2, h = (2 * thickness) + 2);
		}
	}
}

module positionShells(diameter, plateSizeX, plateSizeY, thickness, offset, screwOffsetShare) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeShell(diameter, thickness, offset, screwOffsetShare);
	}
}

module positionNuts(diameter, plateSizeX, plateSizeY, thickness, screwOffsetShare) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		makeNut(diameter, thickness, screwOffsetShare);
	}
}

module positionScrewHeadHoles(diameter, plateSizeX, plateSizeY, thickness, screwOffsetShare) {
	translate(v = [(plateSizeX + diameter) / 2, 0, ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(plateSizeX + diameter) / 2, 0, plateSizeY - ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
	translate(v = [(-1) * ((plateSizeX + diameter) / 2), 0, plateSizeY - ((diameter + thickness) / 2)]) {
		screwHeadHole(diameter, thickness, screwOffsetShare);
	}
}

module positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness) {
	translate(v = [(plateSizeX + diameterOuter) / 2, 0, ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
	translate(v = [(plateSizeX + diameterOuter) / 2, 0, plateSizeY - ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameterOuter) / 2), 0, ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
	translate(v = [(-1) * ((plateSizeX + diameterOuter) / 2), 0, plateSizeY - ((diameterOuter + thickness) / 2)]) {
		screwHole(diameterInner, thickness);
	}
}

module nutHolesComplete(diameterOuter, diameterInner, plateSizeX, plateSizeY, thickness, offset, screwOffsetShare) {
	translate(v = [0, offset / 2, 0]) {
		union() {
			positionNuts(diameterOuter, plateSizeX, plateSizeY, thickness, screwOffsetShare);
			positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness);
		}
	}
}

module screwHeadHolesComplete(diameterOuter, diameterInner, plateSizeX, plateSizeY, thickness, offset, screwOffsetShare) {
	translate(v = [0, offset / 2, 0]) {
		union() {
			positionScrewHeadHoles(diameterOuter, plateSizeX, plateSizeY, thickness, screwOffsetShare);
			positionScrewHoles(diameterInner, diameterOuter, plateSizeX, plateSizeY, thickness);
		}
	}
}

module topPart1(lengthTopTube, diameterTopTube, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare) {
translate(v = [0, 0, (-1) * (offset / 2)]) {
		rotate(a = [90, 0, 0]) {
			difference() {
				difference() {
					tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset, screwOffsetShare);
					screwHeadHolesComplete(nutSizeOuter, nutSizeInner, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset, screwOffsetShare);
				}
	// -- Hole for Lock Tube
				translate(v = [((diameterTopTube + diameterLock) / 2) + thickness, thickness + (offset / 2) + 1, lengthTopTube / 2]) {
					rotate(a = [90, 0, 0]) {
						union() {
							difference() {
								carveRing(diameterLock, thickness);
								translate(v = [0, 0, 0]) {
									translate(v = [(-1) * ((diameterLock + thickness) / 2), 0, 0]) {
										cube([thickness, diameterLock + thickness + 2, ((thickness + 2))], true);
									}
									translate(v = [(-1) * ((diameterLock + thickness) / 2), (diameterLock + thickness) / 2, 0]) {
										cube([diameterLock + thickness + 4, thickness, ((thickness + 2))], true);
									}
									translate(v = [(-1) * ((diameterLock + thickness) / 2), (-1) * (diameterLock + thickness) / 2, 0]) {
										cube([diameterLock + thickness + 4, thickness, ((thickness + 2))], true);
									}
								}
							}
							translate(v = [screwBarWidth, 0, (thickness / 2) + 1]) {
								cube([diameterLock, diameterLock + thickness + 2, thickness + 4], true);
							}
						}
					}
				}
			}
		}
	}
}

module bottomPart1(lengthTopTube, diameterTopTube, lengthLock, diameterLock, screwBarWidth, nutSizeOuter, nutSizeInner, thickness, offset, screwOffsetShare) {
	translate(v = [0, 0, (-1) * (offset / 2)]) {
		rotate(a = [90, 0, 0]) {
			difference() {
				union() {
					difference() {
						tubeWithBar(lengthTopTube, diameterTopTube, nutSizeOuter, thickness, offset, screwOffsetShare);
						nutHolesComplete(nutSizeOuter, nutSizeInner, diameterTopTube + (2 * thickness), lengthTopTube, thickness, offset, screwOffsetShare);
					}
	// -- Lock Tube
					translate(v = [((diameterTopTube + diameterLock) / 2) + thickness, lengthLock + (offset / 2), lengthTopTube / 2]) {
						rotate(a = [90, 0, 0]) {
							tube(lengthLock, diameterLock, thickness);
						}
					}
				}
	// -- Hole for Lock Tube
				translate(v = [((diameterTopTube + diameterLock) / 2) + thickness, lengthLock + 1 + (offset / 2), lengthTopTube / 2]) {
						rotate(a = [90, 0, 0]) {
							cylinder(r = diameterLock / 2, h = lengthLock + 2);
						}
				}
			}
		}
	}
}

module stabilityBracing(diameterTopTube, screwBarWidth, thickness, offset) {
	rotate(a = [90, 0, 0]) {
		difference() {
			linear_extrude(height = thickness) {
					polygon(points = [[0, thickness], [(diameterTopTube / 2) + screwBarWidth + thickness, thickness], [0, ((diameterTopTube - offset) / 2) + thickness]], paths = [[0, 1, 2]]);
			}
			translate(v = [0, (-1) * (offset / 2), -1]) {
				cylinder(r = diameterTopTube / 2, h = thickness + 2);
			}
		}
	}
}

module doubleStabilityBracing(diameterTopTube, screwBarWidth, thickness, offset) {
	stabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
	rotate(a = [0, 0, 180]) {
		translate(v = [0, thickness, 0]) {
			stabilityBracing(diameterTopTube, screwBarWidth, thickness, offset);
		}
	}
}

module lockBracing(diameterTopTube, lengthLock, thickness, offset) {
	rotate(a = [90, 0, 0]) {
		difference() {
			linear_extrude(height = thickness) {
				polygon(points = [[0, 0], [(diameterTopTube / 2) + thickness, 0], [(diameterTopTube / 2) + thickness, lengthLock], [0, ((diameterTopTube - offset) / 2) + thickness]], paths = [[0, 1, 2, 3]]);
			}
			translate(v = [0, (-1) * (offset / 2), -1]) {
				cylinder(r = diameterTopTube / 2, h = thickness + 2);
			}
		}
	}
}

module carveRoundTube(diameter, thickness) {
	difference() {
		cylinder(h = (thickness / 2) + 1, r = ((diameter / 2) + thickness) + 1);
		rotate_extrude() {
			translate(v = [((diameter  + thickness) / 2), 0, 0]) {
				circle(r = (thickness / 2));
			}
		}
	}
}

module carveRing(diameter, thickness) {
	difference() {
		cylinder(h = thickness + 2, r = ((diameter + thickness) / 2));
		rotate_extrude() {
			translate(v = [((diameter + thickness) / 2), (thickness / 2) + 1, 0]) {
				circle(r = (thickness / 2));
			}
		}
	}
}

module hexagon(size, height) {
	// http://svn.clifford.at/openscad/trunk/libraries/shapes.scad
	/*
	 *  OpenSCAD Shapes Library (www.openscad.org)
	 *  Copyright (C) 2009  Catarina Mota
	 *
	 *  This program is free software; you can redistribute it and/or modify
	 *  it under the terms of the GNU General Public License as published by
	 *  the Free Software Foundation; either version 2 of the License, or
	 *  (at your option) any later version.
	 *
	 *  This program is distributed in the hope that it will be useful,
	 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
	 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	 *  GNU General Public License for more details.
	 *
	 *  You should have received a copy of the GNU General Public License
	 *  along with this program; if not, write to the Free Software
	 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
	 *
	*/
	boxWidth = size/1.75;
	for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
