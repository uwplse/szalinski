// keyhole slot remix of PEGSTR - Pegboard Wizard
// Modified by Shawn Featherly, October 2018
// Original PEGSTR - Pegboard Wizard by Marius Gheorghescu, November 2014

// preview[view:north, tilt:bottom diagonal]

// width / diameter of the keyslot neck
key_neck_width = 6;

// length of keyslot exposed neck
key_neck_length = 3;

// width / diameter of the keyslot head
key_head_width = 10;

// length of the keyslot head
key_head_length = 1;

// how far the 2 keyslots are from one another. 24.3
keyslot_seperation = 24.3;

// how thick are the walls. Hint: 6*extrusion width produces the best results.
wall_thickness = 1.85;

/* [Advanced] */
// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
strength_factor = 0.66;


/* [Hidden] */
// width of the panel
holder_x_size = keyslot_seperation + 10;

// depth of the orifice
holder_y_size = 10;

// hight of the holder
holder_height = 15;

// how many times to repeat the holder on X axis
holder_x_count = 1;

// how many times to repeat the holder on Y axis
holder_y_count = 2;

// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
corner_radius = 30;

// what is the $fn parameter
holder_sides = max(50, min(20, holder_x_size*2));

// dimensions the same outside US?
hole_spacing = 25.4;
hole_size = 6;//6.0035;
board_thickness = 5;


holder_total_x = wall_thickness + holder_x_count*(wall_thickness+holder_x_size);
holder_total_y = wall_thickness + holder_y_count*(wall_thickness+holder_y_size);
holder_total_z = round(holder_height/hole_spacing)*hole_spacing;
holder_roundness = min(corner_radius, holder_x_size/2, holder_y_size/2); 


// what is the $fn parameter for holders
fn = 32;

epsilon = 0.1;

clip_height = 2*hole_size + 2;
$fn = fn;

module round_rect_ex(x1, y1, x2, y2, z, r1, r2)
{
	$fn=holder_sides;
	brim = z/10;

	//rotate([0,0,(holder_sides==6)?30:((holder_sides==4)?45:0)])
	hull() {
        translate([-x1/2 + r1, y1/2 - r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([x1/2 - r1, y1/2 - r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([-x1/2 + r1, -y1/2 + r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([x1/2 - r1, -y1/2 + r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);

        translate([-x2/2 + r2, y2/2 - r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([x2/2 - r2, y2/2 - r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([-x2/2 + r2, -y2/2 + r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([x2/2 - r2, -y2/2 + r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);

    }
}

module pin(clip)
{
	rotate([0,0,15])
		#cylinder(r=hole_size/2, h=board_thickness*1.5+epsilon, center=true, $fn=12);

// top row inserts should have a rounded tip
    
	if (clip) {
		//
		rotate([0,0,90])
		intersection() {
			translate([0, 0, hole_size-epsilon])
				cube([hole_size+2*epsilon, clip_height, 2*hole_size], center=true);

			// [-hole_size/2 - 1.95,0, board_thickness/2]
			translate([0, hole_size/2 + 2, board_thickness/2]) 
				rotate([0, 90, 0])
				rotate_extrude(convexity = 5, $fn=20)
				translate([5, 0, 0])
				 circle(r = (hole_size*0.95)/2); 
			
			translate([0, hole_size/2 + 2 - 1.6, board_thickness/2]) 
				rotate([45,0,0])
				translate([0, -0, hole_size*0.6])
					cube([hole_size+2*epsilon, 3*hole_size, hole_size], center=true);
		}
	}
}


module pinboard_clips() 
{
	rotate([0,90,0])
	for(i=[0:round(holder_total_x/hole_spacing)]) {
		for(j=[0:max(strength_factor, round(holder_height/hole_spacing))]) {

			translate([
				j*hole_spacing, 
				-hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing, 
				0])
					pin(j==0);
		}
	}
}

module pinboard(clips)
{
	rotate([0,90,0])
	translate([-epsilon, 0, -wall_thickness - board_thickness/2 + epsilon])
	hull() {
		translate([-clip_height/2 + hole_size/2, 
			-hole_spacing*(round(holder_total_x/hole_spacing)/2),0])
			cylinder(r=hole_size/2, h=wall_thickness);

		translate([-clip_height/2 + hole_size/2, 
			hole_spacing*(round(holder_total_x/hole_spacing)/2),0])
			cylinder(r=hole_size/2,  h=wall_thickness);

		translate([max(strength_factor, round(holder_height/hole_spacing))*hole_spacing,
			-hole_spacing*(round(holder_total_x/hole_spacing)/2),0])
			cylinder(r=hole_size/2, h=wall_thickness);

		translate([max(strength_factor, round(holder_height/hole_spacing))*hole_spacing,
			hole_spacing*(round(holder_total_x/hole_spacing)/2),0])
			cylinder(r=hole_size/2,  h=wall_thickness);

	}
}

module key()
{
    // key neck
    #cylinder(r=key_neck_width/2, h=key_neck_length+epsilon, center=true, $fn=12);
    
    // key head
    //translate([0,0, -2*(key_neck_length- epsilon) - 2*key_head_length ])
    translate([0,0, -key_neck_length/2 - key_head_length/2 ])
    
    #cylinder(r=key_head_width/2, h=key_head_length+epsilon, center=true, $fn=12);
}
module keyslots();
{
	rotate([0,90,0])
	translate([-epsilon, 0, -wall_thickness - board_thickness/2 - key_neck_length/2 + epsilon])
    {
        // position keyslot1
        translate([0,-keyslot_seperation/2,0])
        key();
    
        // position keyslot2
        translate([0,keyslot_seperation/2,0])
        key();
    }
}
module pegstr() 
{
	difference() {
		union() {

// connects to pegboard insets
			pinboard();

// pegboard insets
			color([0,0,0])
			pinboard_clips();
            
// keyslot insets
            keyslots();
		}

/* Start Logo
		translate([-board_thickness/2,-1,-clip_height+5]) 
		rotate([-90,0,90]) {
			intersection() {
				union() {
					difference() {
						round_rect_ex(3, 10, 3, 10, 2, 1, 1);
						round_rect_ex(2, 9, 2, 9, 3, 1, 1);
					}
			
					translate([2.5, 0, 0]) 
						difference() {
							round_rect_ex(3, 10, 3, 10, 2, 1, 1);
							round_rect_ex(2, 9, 2, 9, 3, 1, 1);
						}
				}
			
				translate([0, -3.5, 0]) 
					cube([20,4,10], center=true);
			}
		
			translate([1.25, -2.5, 0]) 
				difference() {
					round_rect_ex(8, 7, 8, 7, 2, 1, 1);
					round_rect_ex(7, 6, 7, 6, 3, 1, 1);
		
					translate([3,0,0])
						cube([4,2.5,3], center=true);
				}
		
		
			translate([2.0, -1.0, 0]) 
				cube([8, 0.5, 2], center=true);
		
			translate([0,-2,0])
				cylinder(r=0.25, h=2, center=true, $fn=12);
		
			translate([2.5,-2,0])
				cylinder(r=0.25, h=2, center=true, $fn=12);
		}
End Logo */

	}
}


rotate([180,0,0]) pegstr();
