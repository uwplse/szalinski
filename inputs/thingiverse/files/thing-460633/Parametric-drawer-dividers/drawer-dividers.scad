bottom_width = 50;
top_width = 51;
height = 32;
thickness = 1.5;
bottom_radius = 1; // [0.01:10]
top_radius = 0.01; // [0.01:10]

grid_separation = 3;
grid_rows = 1;
grid_columns = 10;

/* [Hidden] */
$fn = 50;

module divider() {
	rotate(90, [1,0,0]) hull() {
		translate([bottom_width/2-bottom_radius,height-bottom_radius,0]) cylinder(r=bottom_radius, h=thickness);
		translate([-bottom_width/2+bottom_radius,height-bottom_radius,0]) cylinder(r=bottom_radius, h=thickness);
		translate([top_width/2-top_radius,top_radius,0]) cylinder(r=top_radius, h=thickness);
		translate([-top_width/2+top_radius,top_radius,0]) cylinder(r=top_radius, h=thickness);
	}
}

for(a = [1:grid_rows])
	for(b = [1:grid_columns])
		translate([a*(grid_separation + max(bottom_width, top_width)), b*(grid_separation + thickness), 0])
			divider();
