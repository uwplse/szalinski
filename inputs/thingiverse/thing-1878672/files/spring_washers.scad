/*
hotbed spring washers.
v0.01 2016oct03,ls  initial version
v0.02 2016oct06,ls  simplified, rim and hub heights separate items
*/


// thickness of base, rim and hub
wall = 0.4;	// [0.2:0.1:3]

// diameter, determines inner hub diameter.
screw = 3.4;	// [1:0.1:6]

// diameter, determines inner rim diameter.
spring = 6.4;	// [3:0.1:16]

// height over base
hub = 1;	// [0:0.1:10]

// height over base
rim = 1;	// [0:0.1:10]

// item height:       max(hub, rim)+wall
// item diameter:     max(hub_outer, rim_outer)*2
// item volume (mm²): pi*((rim+wall)*rim_outer²-rim*rim_inner²+hub*hub_outer²-(wall+hub)*hub_inner²));

hub_inner = screw/2;
hub_outer = hub_inner+wall;
rim_inner = spring/2;
rim_outer = rim_inner+wall;


/*
include <constants.scad>	// for pi
specific_mass = 1.2;		// roughly
volume = pi*((rim+wall)*pow(rim_outer,2)-rim*pow(rim_inner,2)+hub*pow(hub_outer,2)-(wall+hub)*pow(hub_inner,2));
mass = volume*specific_mass;
reel_price = 15;                // roughly
washer_price = reel_price*mass/1000000;
echo (washer_price);		// about 5 washers for a cent of material with these presets
*/

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
