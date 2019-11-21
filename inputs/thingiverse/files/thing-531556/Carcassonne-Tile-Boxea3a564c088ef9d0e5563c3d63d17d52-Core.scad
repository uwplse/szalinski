floor_thickness = 1;
wall_thickness = 1.3;
wall_height = 30; // [25:40]
tab_height = 28;

inside_length = 74.5;

/* [Hidden] */
length = inside_length + wall_thickness * 2;
width = 46 * 2 + wall_thickness * 3;
fudge = 0.1;

rotate(a=[0,0,-90]) {
union () {
difference () {
	cube([width,length,wall_height]);
	translate ([wall_thickness,wall_thickness,floor_thickness]) {
		cube([46,inside_length,wall_height]);
	}
	translate ([46 + wall_thickness*2,wall_thickness,floor_thickness]) {
		cube([46,inside_length,wall_height]);
	}
};
translate([46+wall_thickness,0,wall_height-.01])
rotate(a=[90,0,90])
linear_extrude(height = wall_thickness)
	polygon(points=[[10,0],[20,tab_height],[length - 20,tab_height],[length-10,0]]);
};

};

