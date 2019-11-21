/*
hotbed spring washers.
v0.01 2016oct03,ls  initial version
v0.02 2016oct06,ls  simplified, rim and hub heights separate items
*/


// thickness base, rim and hub
wall = 0.8;	// [0.2:0.1:3]

// diameter, determines hub diameter.
screw = 3.6;	// [1:0.1:6]

// diameter, determines rim diameter.
spring = 8;	// [3:0.1:16]

// height over base
hub = 1.5;	// [0:0.1:10]

// height over base
rim = 2;	// [0:0.1:10]


hub_inner = screw/2;
hub_outer = hub_inner+wall;
rim_inner = spring/2;
rim_outer = rim_inner+wall;

little = 0+0.01;
$fn = 90;

module pipe(len, inner, outer)  {
	difference()  {
		cylinder(len, outer, outer);
		translate([0, 0, -little/2])
		cylinder(len+little, inner, inner);
	}
}

module washer()  {
	pipe(wall, hub_inner, rim_outer);		// base
	pipe(hub+wall, hub_inner, hub_outer);		// hub
	pipe(rim+wall, rim_inner, rim_outer);		// rim
}

dist = 2*rim_outer+3;
for (i=[0:2], j=[0:2]) translate([i*dist, j*dist, 0]) washer();
