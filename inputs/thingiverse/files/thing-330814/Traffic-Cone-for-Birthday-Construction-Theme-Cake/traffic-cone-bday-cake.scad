$fn=200;
base_size=16;
cone_base_size=15;
cone_top_size=7;
cone_height=20;
wall_thickness=1.2;

difference() {
	union() {
		translate([-base_size/2,-base_size/2,0]) cube([base_size,base_size,wall_thickness]);
		cylinder(r1=cone_base_size/2,r2=cone_top_size/2, h=cone_height);
	}
	translate([0,0,-0.01]) cylinder(r1=cone_base_size/2-wall_thickness,r2=cone_top_size/2-wall_thickness, h=cone_height+0.02);
}
