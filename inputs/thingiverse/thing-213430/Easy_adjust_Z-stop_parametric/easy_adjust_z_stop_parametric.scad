//------------------------------------------------------------
// Parametric easy adjust z-stop 
//
// http://www.thingiverse.com/wardwouts
// 
//
//------------------------------------------------------------

// Determines the heigth of the hole for the nut
nut_height = 3.85;
// Determines the width of the hole for the nut
nut_width_short = 5.4;
// Determines the depth of the hole for the nut
nut_width_long = 6.0;

// How thick should the bit above and below the nut be?
nut_holder_thickness = 2;

// of the piece
width = 10;
// Length of the base
base_length = 20;
// Thickness of the base
base_thickness = 5;

// How big should the screw hole be?
outer_thread = 3.2;

nut_holder_depth = nut_width_long;

// code below

module base() {
	// simple bar to glue to the x-idler
	cube([base_length,width/2,base_thickness]);
}

module end() {
	translate([0,0,base_thickness]){
		difference(){
			cube([nut_holder_thickness,width/2, nut_holder_depth]);
			translate([-nut_holder_thickness,width/2,nut_holder_depth/2]){
				rotate([0,90,0]){
					cylinder(h=nut_holder_thickness*3,r=outer_thread/2,$fn=20);
				}
			}
		}
	}
}

module side() {
	translate([nut_holder_thickness,0,base_thickness]){
		cube([nut_height,(width-nut_width_short)/2,nut_holder_depth]);
	}
}

module halfpart(){
	base();
	end();
	translate([nut_height+nut_holder_thickness,0,0]){
		end();
	}
	side();
}

halfpart();
translate([0,width,0]){
	mirror([0,1,0]){
		halfpart();
	}
}