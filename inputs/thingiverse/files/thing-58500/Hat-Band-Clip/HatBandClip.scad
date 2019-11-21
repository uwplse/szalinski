use <write/Write.scad>

hat_band_width = 45; // [20:50]
clip_width = 60; // [60:100]
number_of_feathers = 1; // [0:No feather hole,1:One feather,2:Two feathers,3:Three feathers,4:Four feathers,5:Five feathers]
text = "MAKER";
text_size = 10; // [5:12]

feather_diameter = 2.1*1; 
negative_cylinder_diameter = 8*1;
positive_cylinder_diameter = 4*1;
clip_strengths = 5*1;
clip_border = 2*1;
clip_height = hat_band_width + 2*clip_border;

union() {
	difference() {
		translate([0, 0, 0]) cube([clip_width,clip_height,clip_strengths], center=true);
		rotate([90,0,0]) {
			translate([clip_width/2-10, -(clip_strengths/2)], 0) cylinder(r=negative_cylinder_diameter/2, $fn=50, h=hat_band_width, center=true);
			translate([-(clip_width/2-10), -(clip_strengths/2)], 0) cylinder(r=negative_cylinder_diameter/2, $fn=50, h=hat_band_width, center=true);
			translate([clip_width/2, -(clip_strengths/2)], 0) scale([1.25,1,1]) cylinder(r=negative_cylinder_diameter/2, $fn=50, h=hat_band_width, center=true);
			translate([-(clip_width/2), -(clip_strengths/2)], 0) scale([1.25,1,1]) cylinder(r=negative_cylinder_diameter/2, $fn=50, h=hat_band_width, center=true);
			if(number_of_feathers == 1) {
				translate([0, -0.5, -clip_height/2]) rotate([0,-17.5,0]) cylinder(r=feather_diameter/2, $fn=20, h=clip_height, center=true);
			}
			if(number_of_feathers == 2) {
				for(i = [0:number_of_feathers-1]) {
					translate([-5+i*10, -0.5, -clip_height/2]) rotate([0,-17.5,0]) cylinder(r=feather_diameter/2, $fn=20, h=clip_height, center=true);
				}
			}
			if(number_of_feathers == 3) {
				for(i = [0:number_of_feathers-1]) {
					translate([-5+i*5, -0.5, -clip_height/2]) rotate([0,-17.5,0]) cylinder(r=feather_diameter/2, $fn=20, h=clip_height, center=true);
				}
			}
			if(number_of_feathers == 4) {
				for(i = [0:number_of_feathers-1]) {
					translate([-4+i*5, -0.5, -clip_height/2]) rotate([0,-17.5,0]) cylinder(r=feather_diameter/2, $fn=20, h=clip_height, center=true);
				}
			}
			if(number_of_feathers == 5) {
				for(i = [0:number_of_feathers-1]) {
					translate([-5.5+i*5, -0.5, -clip_height/2]) rotate([0,-17.5,0]) cylinder(r=feather_diameter/2, $fn=20, h=clip_height, center=true);
				}
			}
		}
		translate([0,-(hat_band_width/4),3]) write(text, h=text_size, t=2, center=true);
	}

	difference() {
		rotate([90,0,0]) {
			translate([clip_width/2-10, -(clip_strengths/2)], 0) cylinder(r=positive_cylinder_diameter/2, $fn=40, h=hat_band_width, center=true);
			translate([-(clip_width/2-10), -(clip_strengths/2)], 0) cylinder(r=positive_cylinder_diameter/2, $fn=40, h=hat_band_width, center=true);
			translate([clip_width/2-1.5, -(clip_strengths/2)], 0) scale([.75,1,1]) cylinder(r=positive_cylinder_diameter/2, $fn=40, h=hat_band_width, center=true);
			translate([-(clip_width/2-1.5), -(clip_strengths/2)], 0) scale([.75,1,1]) cylinder(r=positive_cylinder_diameter/2, $fn=40, h=hat_band_width, center=true);
		}
		translate([0, 0, -clip_strengths]) cube([clip_width,clip_height,clip_strengths], center=true);
	}	
}
