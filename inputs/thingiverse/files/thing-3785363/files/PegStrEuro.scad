// PEGSTR - Pegboard Wizard
// Design by Marius Gheorghescu, November 2014
// Update log:
// November 9th 2014
//		- first coomplete version. Angled holders are often odd/incorrect.
// November 15th 2014
//		- minor tweaks to increase rendering speed. added logo. 
// November 28th 2014
//		- bug fixes

// preview[view:north, tilt:bottom diagonal]

// width of the orifice
holder_x_size = 62;

// depth of the orifice
holder_y_size = 29.5;

// hight of the holder
holder_height = 30;

// how thick are the walls. Hint: 6*extrusion width produces the best results.
wall_thickness = 1.80;

// how many times to repeat the holder on X axis
holder_x_count = 1;

// how many times to repeat the holder on Y axis
holder_y_count = 1;

// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
corner_radius = 1;

// Use values less than 1.0 to make the bottom of the holder narrow
taper_ratio = 1.0;

// Keyhole connector
keyhole_pin = true;


/* [Advanced] */

// offset from the peg board, typically 0 unless you have an object that needs clearance
holder_offset = 10.0;

// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
strength_factor = 0.5;

// for bins: what ratio of wall thickness to use for closing the bottom
closed_bottom = 1;

// what percentage cu cut in the front (example to slip in a cable or make the tool snap from the side)
holder_cutout_side = 0.7;

// set an angle for the holder to prevent object from sliding or to view it better from the top
holder_angle = 0;


/* [Hidden] */

// what is the $fn parameter
holder_sides = max(50, min(20, holder_x_size*2));

// dimensions the same outside US?
hole_spacing = 45;
hole_size = 5;
board_thickness = 2;


holder_total_x = wall_thickness + holder_x_count*(wall_thickness+holder_x_size);
holder_total_y = wall_thickness + holder_y_count*(wall_thickness+holder_y_size);
holder_total_z = round(holder_height/hole_spacing)*hole_spacing;
holder_roundness = min(corner_radius, holder_x_size/2, holder_y_size/2); 


// what is the $fn parameter for holders
fn = 10;

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
    if (!keyhole_pin){
        rotate([0,0,15])
        cylinder(r=hole_size/2, h=board_thickness*1.5+epsilon, center=true);
    }

	if (clip) {
	    if (keyhole_pin){
                        color([0,1,0,0.5]){

            hull(){
                cylinder(r=hole_size/2, h=board_thickness+epsilon, center=true);
                translate([-2,0,0])
                cylinder(r=hole_size/2, h=board_thickness+epsilon, center=true);
            }}
			translate([0, 0, (board_thickness+epsilon)/2]){
            cylinder(r=hole_size/2+2, 2, center=false);}
                        
        } else {
            
		rotate([0,0,90])
		intersection() {
			translate([0, 0, hole_size-epsilon])
				cube([hole_size+2*epsilon, clip_height, 2*hole_size], center=true);

			// [-hole_size/2 - 1.95,0, board_thickness/2]
			translate([0, hole_size/2 + 2, board_thickness/2]) 
				rotate([0, 90, 0])
				rotate_extrude(convexity = 5, $fn=200)
				translate([5, 0, 0])
				 circle(r = (hole_size*0.95)/2); 
			
			translate([0, hole_size/2 + 2 - 1.6, board_thickness/2]) 
				rotate([45,0,0])
				translate([0, -0, hole_size*0.6])
					cube([hole_size+2*epsilon, 3*hole_size, hole_size], center=true);
		}
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

module holder(negative)
{
 	for(x=[1:holder_x_count]){
		for(y=[1:holder_y_count]) 
/*		render(convexity=2)*/ {
			translate([
				-holder_total_y /*- (holder_y_size+wall_thickness)/2*/ + y*(holder_y_size+wall_thickness) + wall_thickness,

				-holder_total_x/2 + (holder_x_size+wall_thickness)/2 + (x-1)*(holder_x_size+wall_thickness) + wall_thickness/2,
				 0])			
	{
		rotate([0, holder_angle, 0])
		translate([
			-wall_thickness*abs(sin(holder_angle))-0*abs((holder_y_size/2)*sin(holder_angle))-holder_offset-(holder_y_size + 2*wall_thickness)/2 - board_thickness/2,
			0,
			-(holder_height/2)*sin(holder_angle) - holder_height/2 + clip_height/2
		])
		difference() {
			if (!negative)
				round_rect_ex(
					(holder_y_size + 2*wall_thickness), 
					holder_x_size + 2*wall_thickness, 
					(holder_y_size + 2*wall_thickness)*taper_ratio, 
					(holder_x_size + 2*wall_thickness)*taper_ratio, 
					holder_height, 
					holder_roundness + epsilon, 
					holder_roundness*taper_ratio + epsilon);

				translate([0,0,closed_bottom*wall_thickness])

				if (negative>1) {
					round_rect_ex(
						holder_y_size*taper_ratio, 
						holder_x_size*taper_ratio, 
						holder_y_size*taper_ratio, 
						holder_x_size*taper_ratio, 
						3*max(holder_height, hole_spacing),
						holder_roundness*taper_ratio + epsilon, 
						holder_roundness*taper_ratio + epsilon);
				} else {
					round_rect_ex(
						holder_y_size, 
						holder_x_size, 
						holder_y_size*taper_ratio, 
						holder_x_size*taper_ratio, 
						holder_height+2*epsilon,
						holder_roundness + epsilon, 
						holder_roundness*taper_ratio + epsilon);
				}

			if (!negative)
				if (holder_cutout_side > 0) {

				if (negative>1) {
					hull() {
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							3*max(holder_height, hole_spacing),
							holder_roundness*taper_ratio + epsilon, 
							holder_roundness*taper_ratio + epsilon);
		
						translate([0-(holder_y_size + 2*wall_thickness), 0,0])
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							3*max(holder_height, hole_spacing),
							holder_roundness*taper_ratio + epsilon, 
							holder_roundness*taper_ratio + epsilon);
					}
				} else {
					hull() {
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size, 
							holder_x_size, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_height+2*epsilon,
							holder_roundness + epsilon, 
							holder_roundness*taper_ratio + epsilon);
		
						translate([0-(holder_y_size + 2*wall_thickness), 0,0])
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size, 
							holder_x_size, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_height+2*epsilon,
							holder_roundness + epsilon, 
							holder_roundness*taper_ratio + epsilon);
						}
					}

				}
			}
		} // positioning
	} // for y
	} // for X
}


module pegstr() 
{




	difference() {
		union() {

			pinboard();

			difference() {
				hull() {
                    color ([0,0,0])

  					pinboard();

                    if (closed_bottom > 0)
                        holder(0);
                    else
					intersection() {

						translate([-holder_offset - (strength_factor-0.5)*holder_total_y - wall_thickness/4,0,0])
						cube([
							holder_total_y + 2*wall_thickness, 
							holder_total_x + wall_thickness, 
							2*holder_height
						], center=true);
	
						holder(0);
	
					}	
				}

				if (closed_bottom*wall_thickness < epsilon) {
						holder(2);
				}

			}

			difference() {
				holder(0);
				holder(2);
			}

            pinboard_clips();
		}
        
		holder(1);



	}
}

rotate([180,0,0]) pegstr();

