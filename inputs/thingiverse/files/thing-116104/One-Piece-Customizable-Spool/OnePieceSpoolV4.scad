// One Piece Customizable Filament Spool (c) 2013 David Smith
// licensed under the Creative Commons - GNU GPL license.
// http://www.thingiverse.com/thing:116104

/* TODO:
Remove part of the inside_diameter tube 
Improve "might not print" error message
Catch settings where hub design visably separates from the spool
*/
use <write/Write.scad>

/* [Spool] */

// Diameter of the spool (mm). 
outside_diameter = 130; // [40:280]

// Diameter of the spool's middle (mm).
inside_diameter = 60; // [30:100]

// Diameter of the spindle - This should be at least 2 WALL WIDTHs smaller than the inside diameter (mm).
spindle_diameter = 16; // [4:80]

// Spool Width (mm).
width = 80;    // [25:300]

// Spool Walls Width (mm).
wall_width = 2;    // [1:5]

// Make the spool hollow (to decrease the amount of plastic needed). 
hollow = 1; // [0:Solid, 1:Hollow]

// Cutout shapes from the spool (to decrease the amount of plastic needed).
remove_shapes = 0; // [0:Solid, 1:Remove Shapes]

// Shape of the hole to cutout of the spool.
shape = 3; // [ 3:Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 7:Heptagon, 8:Octagon, 9:Nonagon, 10:Decagon, 16:Rough Circle, 128:Smooth Circle ]

/* [Filament] */

// Size of the filament for mass & length estimates (mm). 
filament_diameter = 1.75; 

// Density of the filament for mass and length estimates (grams / cm^3).
filament_density = 1.04;

// preview[view:south, tilt:top diagonal]
/* [Hidden] */
display_estimates = 1; // [0:No Estimates, 1:Display Estimates]
smooth = 128;

// Height of half of the usable area of the spool
half_spool = (width/2)-wall_width;

// Outer cones (for the filament)
outer_cone_width = min_not_less_than( (outside_diameter/2) - (inside_diameter / 2), half_spool, half_spool, (outside_diameter/2) - (inside_diameter / 2) );
outer_cone_height = outer_cone_width;

top_cone_offset = width - wall_width - outer_cone_height;
bottom_cone_offset = wall_width;

// Inner cones (for the internal hub)
inner_hub_radius = (spindle_diameter - wall_width) < inside_diameter ? (spindle_diameter / 2) + wall_width : (inside_diameter) / 2 - wall_width;

inner_cone_width = (inside_diameter/2) - inner_hub_radius + wall_width;
inner_cone_height = inner_cone_width;

top_inner_cone_offset = width - inner_cone_height-wall_width;
bottom_inner_cone_offset = wall_width;

// Calculate to make sure outer cones are not at more than a 45 degree angle
spool_center_radius = outside_diameter/2 - outer_cone_width;

cutouts_diameter = (outside_diameter/2 - inside_diameter/2-2*wall_width );
cutouts_offset = inside_diameter/2 + cutouts_diameter/2 + wall_width ; 

flat_section_height = max( 0, width-2*outer_cone_height-2*wall_width);

hub_flat_section_height = max( 0, width-2*inner_cone_height-2*wall_width);

// Filament
filament_hole = (filament_diameter / 2 );

// Spindle
spindle_width = width-2*inner_cone_height;
spindle_offset = 0;

// Number of shapes to cut out of the spool. 
pi = 3.14159265358979323846;
cutouts = floor((cutouts_offset * pi * 2) / (cutouts_diameter+wall_width));

// ESTIMATED: Filament Volume (in cubic cm^3)
// 2 TIMES (for the top and bottom) the height a cylinder(which is height of the top cone) - Top Cone + Top Cone's Tip (not visible)
// PLUS middle cylinder outer_diameter - middle cylinder inner diameter
// TIMES 0.785398; to account for filament taking up 78% as much space 
//   because cylinders(filament) wrapped around a spool have gaps between them.
filament_volume = ((2 * (
					cylinder_volume(outside_diameter/2, outer_cone_height) - 
				   	cone_volume(outside_diameter/2, outside_diameter/2) + 
					cone_volume(inside_diameter/2, inside_diameter/2)
				  )
			   + (
				 	cylinder_volume( outside_diameter/2, flat_section_height) -
			      	cylinder_volume( inside_diameter/2,  flat_section_height))
                    ) / 1000
				)  *  0.785398; 

// Filament Weight (in kg)
filament_weight = (filament_volume * filament_density / 1000);

// Filament Length 
filament_length = filament_volume / ( pi * (filament_diameter/2) * (filament_diameter/2));

echo("circle/square=", (pi*5*5)/(10*10) );
echo("half_spool=", half_spool );
echo("spool_center_radius=", spool_center_radius );
echo("width/2=", width/2 );
echo("cutouts_diameter=", cutouts_diameter );
echo("cutouts_offset=", cutouts_offset );
echo("outer_cone_width=", outer_cone_width );
echo("outer_cone_height=", outer_cone_height );
echo("inside_diameter/2=", inside_diameter/2 );
echo("outside_diameter/2=", outside_diameter/2 );
echo("spindle_diameter/2=", spindle_diameter/2 );
echo("inner_hub_radius=", inner_hub_radius);
echo("inner_cone_width=", inner_cone_width );
echo("inner_cone_height=", inner_cone_height );
echo("flat_section_height=", flat_section_height );

if ((flat_section_height == 0) && (1==1))
	display_warnings();
else
	display_spool_size();

difference() {
	union() {
		spool();	
		spool_core();
		hub();
		hub_core();
	}
	remove_filament_holes();
}

// Shapes look better when they are rotated to align with the spindle hole
shape_rotate_array=[0,0,0,30,45,54,0,64.5,0,65,0,70,0,0,0,0,0,0,0];
function shape_rotate(shape,i) = (shape < 12) ? shape_rotate_array[shape] : 0;

function cylinder_volume( radius, height ) = 
  pi * radius * radius * height;

function cone_volume( radius, height ) = 
  (1/3) * pi * radius * radius * height;

// Returns the maximum of two values not greater than max_value
// Returns default if both are larger than max_value
function max_not_greater_than( value1, value2, max_value, default ) =
  (value1 <= max_value) && (value2 <= max_value) ? max(value1, value2) :
  (value1 >= max_value) && (value2 >= max_value) ? default :
  (value1 <= max_value) ? value1 : 
  (value2 <= max_value) ? value2 : default;

// Returns the minimum of two values not less than min_value
// Returns default if both are small than min_value
function min_not_less_than( value1, value2, min_value, default ) =
  (value1 >= min_value) && (value2 >= min_value) ? min(value1, value2) :
  (value1 <= min_value) && (value2 <= min_value) ? default :
  (value1 >= min_value) ? value1 : 
  (value2 >= min_value) ? value2 : default;

module display_warnings() {

	%color("Red",0.8)
	if (flat_section_height == 0) {
		translate([0,-50, -50])
		rotate(60,[1,0,0])
		%write("Might not print correctly; increase width",
       		t=5,h=10,center=true, font = "write/orbitron.dxf"); 
	}
}

module display_spool_size_OLD() {

	if (display_estimates == 1) {
		translate([0,-50, -50])
		rotate(60,[1,0,0])
		%write(str("Holds an estimated ",  round(filament_weight*10)/10, " kg of filament"),
    	   t=5,h=10,center=true, font = "write/orbitron.dxf"); 		

		translate([0,-50,  - 75])
		rotate(60,[1,0,0])
		%write(str("Estimated filament length is ", round(filament_length), " m"),
    		   t=5,h=10,center=true, font = "write/orbitron.dxf"); 
	}
}

module display_spool_size() {

	if (display_estimates == 1) {
		translate([0,-50, -50])
		rotate(60,[1,0,0])
		%write(str("Capacity Estimate: ", round(filament_weight*10)/10, " kg, ", round(filament_length), " m long"),
    	   t=5,h=10,center=true, font = "write/orbitron.dxf"); 		
	}
}

module hub() {
	difference() {
		union() {
			// Center core
			if (hollow == 0) {
				cylinder(h=width, r=inside_diameter/2 + wall_width, $fn=smooth);	
			}
	
			// Top wall
			translate([0,0,width-wall_width])
			cylinder(h=wall_width, r=inner_hub_radius, $fn=smooth);

			// Bottom wall
			translate([0,0,0])
			cylinder(h=wall_width, r=inner_hub_radius, $fn=smooth);

			// Top inner spool cone
			translate([0,0, top_inner_cone_offset])
			cylinder(h=inner_cone_height, r1=(inside_diameter/2), r2=inner_hub_radius, $fn=smooth);

			// Bottom inner spool cone
			translate([0,0, bottom_inner_cone_offset])
			cylinder(h=inner_cone_height, r2=(inside_diameter/2), r1=inner_hub_radius, $fn=smooth);		
			}

		// Remove the center 
		translate([0,0,-1])
		cylinder(h=width*2, r=spindle_diameter/2, $fn=smooth);

		remove_shapes();

		// Remove extra plastic
		if (hollow == 1) {
			// And the center between the two inner cones
			translate([0,0,inner_cone_height+wall_width])
			cylinder(h=width-2*inner_cone_height-2*wall_width, r=inside_diameter/2, $fn=smooth);
	
			// Remove top cone
			translate([0,0, top_inner_cone_offset-0.01])
			cylinder(h=inner_cone_height+0.02, r1=inside_diameter/2-wall_width, r2=inner_hub_radius-wall_width, $fn=smooth);

			// Remove bottom cone
			translate([0,0, wall_width+0.01])
			cylinder(h=inner_cone_height+0.02, r2=(inside_diameter/2)-wall_width, r1=(inner_hub_radius-wall_width), $fn=smooth);		
		}
	}
}

module spool() {
	difference() {
		union() {
			// Top wall
			translate([0,0,width-wall_width])
			cylinder(h=wall_width, r=outside_diameter/2, $fn=smooth);

			// Bottom wall
			translate([0,0,0])
			cylinder(h=wall_width, r=outside_diameter/2, $fn=smooth);
	
			// Top spool cone
			translate([0,0, top_cone_offset])
			cylinder(h=outer_cone_height, r2=outside_diameter/2, r1=spool_center_radius, $fn=smooth);

			// Bottom spool cone
			translate([0,0, bottom_cone_offset])
			cylinder(h=outer_cone_height, r1=outside_diameter/2, r2=spool_center_radius, $fn=smooth);		
		}

		// Remove the center 
		translate([0,0,-1])
		cylinder(h=width*2, r=inside_diameter/2-wall_width, $fn=smooth);
	
		remove_shapes();

		// Remove extra plastic
		if (hollow == 1) {
			// Remove top cone
			translate([0,0, top_cone_offset-0.01])
			cylinder(h=outer_cone_height+0.02, r2=(outside_diameter/2)-wall_width, r1=spool_center_radius-wall_width, $fn=smooth);
			translate([0,0, top_cone_offset + outer_cone_height-0.01 ])
			cylinder(h=wall_width+0.02, r=(outside_diameter/2)-wall_width, $fn=smooth);

			// Remove bottom cone
			translate([0,0, +wall_width-0.01])
			cylinder(h=outer_cone_height+0.02, r1=(outside_diameter/2)-wall_width, r2=spool_center_radius-wall_width, $fn=smooth);		
			translate([0,0, -0.01])
			cylinder(h=wall_width+0.02, r=(outside_diameter/2)-wall_width, $fn=smooth);		

		}
	}
}

module spool_core() {
	difference() {
		// Center core
		translate([0,0,(width-flat_section_height)/2])
		cylinder(h=flat_section_height, r=spool_center_radius, $fn=smooth);	
	
		// Remove the center 
		translate([0,0,(width-flat_section_height)/2-1])
		cylinder(h=flat_section_height+2, r=spool_center_radius-wall_width, $fn=smooth);
	}
}

module hub_core() {
	difference() {
		// Center core
		translate([0,0,(width-hub_flat_section_height)/2])
		cylinder(h=hub_flat_section_height, r=spool_center_radius, $fn=smooth);	
	
		// Remove the center 
		translate([0,0,(width-hub_flat_section_height)/2-0.01])
		cylinder(h=hub_flat_section_height+0.02, r=spool_center_radius-wall_width, $fn=smooth);
	}
}

// Remove filament start/stop holes
module remove_filament_holes() {

	// Remove a hole for the filament start
	translate([0,0,width/2])
	rotate(90,[0,1,0])
	cylinder(h=inside_diameter/2+wall_width,r=filament_hole,$fn=smooth);
		
	// Make a hole for the filament end
	translate([inside_diameter/2+wall_width, 0, width-2-wall_width])
	rotate(90,[0,1,0])
	if (((hollow == 1) && (remove_shapes == 1)) || ((hollow == 0) && (remove_shapes == 1)))
		cylinder(h=3,r=filament_hole,$fn=smooth);
	else
		cylinder(h=outside_diameter,r=filament_hole,$fn=smooth);
	
	// Make another hole for the filament end
	translate([inside_diameter/2+wall_width, 0, 2+wall_width])
	rotate(90,[0,1,0])
	if (((hollow == 1) && (remove_shapes == 1)) || ((hollow == 0) && (remove_shapes == 1)))
		cylinder(h=3,r=filament_hole,$fn=smooth);
	else
		cylinder(h=outside_diameter,r=filament_hole,$fn=smooth);
}

// Remove some shapes
module remove_shapes() {
	if (remove_shapes == 1) {
		for ( i = [1 : cutouts] ) {
			rotate(((360/cutouts) * i),[0,0,1])
			translate([0,cutouts_offset,-1]) {
				rotate(shape_rotate(shape,i),[0,0,1])
				cylinder(h=width+2, r=cutouts_diameter/2, $fn=shape);
			}	
		}
	}
}


