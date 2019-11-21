// 2016Au12, v0.0.1, ls (http://www.thingiverse.com/Bushmills)
//                    initial version
//    
// creates a parametrised filled 90° T-joint. Those provide better
// resistance against breaking off the jointed leg than a square edge-on connect.   
// example:
// joint(20, 10, 8);
//    produces a T-joint piece 20mm wide, 10mm deep, with joint radius of 8mm.
//    no leg or bar to join are generated. Only the minimum volume filled
//    by the joint is the result.
//    As backs of joints are flat, they are easily printable.

// ***********************************************************
// ************ thingiverse customiser section ***************
//            (remove section when adding file to library)

width=10;    // [4:40]

depth=10;    // [4:40]

radius=8;    // [1:20]

$fn=60;      // [8:90]

joint(width, depth, radius);

// ***********************************************************

module joint(Breite, Tiefe, Radius)  {
	translate([0, -Radius, 0])
	difference()  {
		cube([Radius*2+Breite, Radius, Radius+Tiefe]);

		for (x=[0, Radius*2+Breite]) {		// left and right
			translate([x, 0, -0.01])
			rotate([0, 0,  90])
			cylinder(Radius+Tiefe, Radius, Radius);
		}

		translate([0, 0, Tiefe+Radius])		// front
		rotate([0, 90, 0])
		cylinder(Radius*2+Breite, Radius, Radius);
	}
}

