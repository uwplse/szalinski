//CUSTOMIZER VARIABLES

//Nut width, from flat side to flat side
nut_width = 7.2;

//Nut depth, the thickness of the nut
nut_depth = 2.2;

//How you want the nut oriented
nut_rotation = 0; //[0:Pointy to sides, 30:Flat to sides]

//The thickness of the washer, set to zero to exclude the washer
washer_thick = 0;

//The radius of the washer
washer_rad = 5;

//The radius of the shaft of the screw, in case the nut doesn't penetrate the bottom of the holder
screw_rad = 2.0;

//The length of the holder
total_nut_length = 16;

//The total width of the t-slot, at the top of the slot
slot_width = 11.5;


//The height of the t-slot at the very edges, usually pretty small
slot_edge_height = .8;

//The total height of the t-slot, in the middle
slot_total_height = 3.4;

//How far the flat bit at the bottom of the t-slot is from the edges
slot_middle_offset = 3.0;

//How many nuts to make in the x direction
nut_num_x = 5;

//How many nuts to make in the y direction
nut_num_y = 10;

module box(w,h,d) {
	scale ([w,h,d]) cube(1, true);
}
module hexagon(height, depth) {
	boxWidth=height/1.75;
	rotate([0,0,nut_rotation])
	union(){
		box(boxWidth, height, depth);
		rotate([0,0,60]) box(boxWidth, height, depth);
		rotate([0,0,-60]) box(boxWidth, height, depth);
	}
}

module nut() {
	translate([0,0,slot_total_height]) 
	difference() {
		translate([-0.5*slot_width, -0.5*total_nut_length, 0]) 
			rotate([270,0,0]) 
			linear_extrude(height=total_nut_length) 
			polygon([[0,0], 
					 [slot_width, 0], 
					 [slot_width, slot_edge_height], 
					 [slot_width-slot_middle_offset, slot_total_height], 
					 [slot_middle_offset, slot_total_height], 
					 [0, slot_edge_height]]);
		translate([0,0,-washer_thick+0.01]) cylinder(r=washer_rad, h=washer_thick, $fn=100);
		translate([0,0,-slot_total_height-0.01]) cylinder(r=screw_rad, h=slot_total_height+0.02, $fn=50);
		translate([0,0,-washer_thick-0.5*nut_depth+0.01]) hexagon(nut_width, nut_depth);
	}
}


for(x=[0:nut_num_x-1]) for(y=[0:nut_num_y-1]) {
	translate([-0.5*(nut_num_x-1)*(total_nut_length+2), -0.5*(nut_num_y-1)*(total_nut_length+2), 0])
	translate([x*(total_nut_length+2), y*(total_nut_length+2), 0]) 
	nut();
}
