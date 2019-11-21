open_beam = 15; //open beam dimensions (square)
r_corners = 3;
extrusion=0.3;

w_t_mod = 0.5;
beam_width = 15;
slot_depth = 15;
cross_b_length = beam_width+beam_width*w_t_mod ;
//variables for edge fillet
b = 13;
h = 20;
w = 90*0.5888888+r_corners;


//===========================================================================================
//===========================================================================================
module beam_cap(){
	difference(){
		difference(){
			translate([0, 0, beam_width/2])
			cube([beam_width+beam_width*w_t_mod, beam_width+beam_width*w_t_mod, slot_depth+beam_width*w_t_mod], center=true);
			translate([0, 0, (beam_width*w_t_mod+beam_width)/2])
			cube([beam_width+extrusion*2, beam_width+extrusion*2, slot_depth], center=true);

		}
			union(){
				translate([0, 0, -(slot_depth+beam_width*w_t_mod+beam_width)/4])
				rotate([90, 0, 0])
				cube([beam_width+extrusion*2, beam_width+extrusion*2, cross_b_length*2], center=true);
				translate([0, 0, -(slot_depth+beam_width*w_t_mod+beam_width)/4])
				rotate([0, 90, 0])
				cylinder(r=1.5+extrusion*2, h=cross_b_length*2,center = true,  $fn=15);
				translate([0, 0, (slot_depth+beam_width*w_t_mod+beam_width)/4])
				rotate([0, 90, 0])
				cylinder(r=1.5+extrusion*2, h=cross_b_length*2,center = true,  $fn=15);
				translate([0, 0, (slot_depth+beam_width*w_t_mod+beam_width)/4])
				rotate([90, 0, 0])
				cylinder(r=1.5+extrusion*2, h=cross_b_length*2,center = true,  $fn=15);
			}
	}	
}

module cross_beam(){
	difference(){
	difference(){
		cube([beam_width+beam_width*w_t_mod, beam_width+beam_width*w_t_mod, cross_b_length], center=true);
		cube([beam_width+extrusion*2, beam_width+extrusion*2, cross_b_length], center=true);

	}
	rotate([0, 90, 0])
	cylinder(r=1.5+extrusion*2, h=cross_b_length*2,center = true,  $fn=15);
	rotate([90, 0, 0])
	cylinder(r=1.5+extrusion*2, h=cross_b_length*2,center = true,  $fn=15);
	}

}
//cross_beam();

union(){
translate([0, 0, -(slot_depth+beam_width*w_t_mod+beam_width)/4])
rotate([90, 0, 0])
cross_beam();
beam_cap();
}
