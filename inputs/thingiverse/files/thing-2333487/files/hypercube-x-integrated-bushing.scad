// parametric linear bushing by Dennis Hofmann - http://www.thingiverse.com/sasdensas/
// 2017-03-26 V3
// Modified for HyperCube x holder by Puzon 20.05.2017 V1

// Use the outer diameter of the rod + tolerance value of your printer. Do some test prints before print a whole set of bushings. Best way in my case is to choose the bushing where can push it in with some effort on the rod and slide it by hand without any tools. Then slide it back and forth along the rod, until the bushing has the expected behavior. I suggest you not to use any drill or heat. The sliding of the bushing generates enough heat from its friction against the rod. Standard values: 6.00 for LM6(L)UU, 8.00 (default 8.15) for LM8(L)UU, 10.00 for LM10(L)UU, 12.00 for LM12(L)UU, 16.00 for LM16UU, ...
inner_diameter_in_millimeter = 8.2;



// Use a value to get straight primeters without any zigzag between the outer and inner perimeter. I use the value of 0.48 for 0.4 nozzle. This is the auto extrusion width of 0.48 of simplify3d. More information about this in the description of this design on thingiverse.
extrusion_width_in_millimeter = 0.48; 

// Use even numbers. E.g. 4 for LM8(L)UU. Don't forget to set the perimeter number in your Slicer! 
number_of_perimeters = 4; //[2:2:10]

// Choose a number to provide a gap between the teeth in the bushing. E.g. 8 or 10 for LM8(L)UU. The tooth width depends on the extrusion_width_in_millimeter and the number_of_perimeters.
number_of_teeth = 10; //[3:20]


mounting_hole_diameter = 3.2;

handle_size = 14.25;
handle_additional_step = 0.5;
handle_thickness = 4;



gap_in_bushing = 10;
gap_step = 3;


outer_diameter_in_millimeter = 15; 


// ############# internal variables
dbl_handle_hole_pos = [3.0, 4.75]; // mounting holes positions from edge on double handler
sngl_handle_hole_pos = 3.0; // mounting hole x position on opposite handler;

bushing_length_in_millimeter = 40.0;

mounting_hole_distance = 17.5;
mounting_hole_vert_distance = 4.6-.35;
hole_faces = 16;

holder_offset = 1;

difference() {
    render(convexity = 2) {
        union() {
            linear_extrude(height = bushing_length_in_millimeter, slices = 100) {
                bushing();
                    

            
            }
            
            difference() {
                translate([0,holder_offset,0]) {
                    rotate([90,0,0]) {
                        linear_extrude(height = handle_thickness, slices = 1) {
                            polygon( points=[
                                [0,0],
                                [handle_size,0],
                                [handle_size, 8.75],
                                [outer_diameter_in_millimeter/2 + handle_additional_step, bushing_length_in_millimeter/3],
                            
                                [outer_diameter_in_millimeter/2 + handle_additional_step, bushing_length_in_millimeter/3 * 2],
                            
                            
                                [handle_size, bushing_length_in_millimeter - 8.75],
                                [handle_size,bushing_length_in_millimeter],
                                [0,bushing_length_in_millimeter],
                            
                                [-outer_diameter_in_millimeter/2 - handle_additional_step,bushing_length_in_millimeter],
                            
                                [-outer_diameter_in_millimeter/2 - handle_additional_step,bushing_length_in_millimeter * .75],
                            
                                [ - handle_size,bushing_length_in_millimeter/2 + 8/2],
                            
                                [ - handle_size,bushing_length_in_millimeter/2 - 8/2],
                            
                                
                                [-outer_diameter_in_millimeter/2 - handle_additional_step,bushing_length_in_millimeter * .25],
                                
                                [-outer_diameter_in_millimeter/2 - handle_additional_step,0],
                            
                                
                            ]);
                           
                            
                        }
                    }
                }
                translate([0,0,bushing_length_in_millimeter/2])
                    cylinder(h = bushing_length_in_millimeter, d1=outer_diameter_in_millimeter, d2=outer_diameter_in_millimeter, center = true, $fn=hole_faces);
                        
           }
        }
    }
    if(gap_in_bushing > 0) {
        gap();
    }
    
    
    // left double handle
    
    rotate([90, 0, 0])
        translate([handle_size - dbl_handle_hole_pos[0], dbl_handle_hole_pos[1], outer_diameter_in_millimeter/2 - handle_thickness/2])
        cylinder(h = handle_thickness + 50, d1=mounting_hole_diameter, d2=mounting_hole_diameter, center = true, $fn=hole_faces);
    
    rotate([90, 0, 0])
        translate([handle_size - dbl_handle_hole_pos[0], bushing_length_in_millimeter - dbl_handle_hole_pos[1], outer_diameter_in_millimeter/2 - handle_thickness/2])
        cylinder(h = handle_thickness + 50, d1=mounting_hole_diameter, d2=mounting_hole_diameter, center = true, $fn=hole_faces);
    
    rotate([90, 0, 0])
        translate([-handle_size + sngl_handle_hole_pos, bushing_length_in_millimeter/2, outer_diameter_in_millimeter/2 - handle_thickness/2])
        cylinder(h = handle_thickness + 50, d1=mounting_hole_diameter, d2=mounting_hole_diameter, center = true, $fn=hole_faces);
    
    
    
    // wciecie gora/dol
    //cylinder(h = 2, d1 = block_width, d2 = block_width, center = true, $fn = 100);
    //translate([0,0,bushing_length_in_millimeter-1])
    //   cylinder(h = 2, d1 = block_width, d2 = block_width, center = true, $fn = 100);
}
//translate([0,0,100])
//        gap();
module bushing() {
    difference() {
        union() {
            difference() {
                for(tooth_number = [0 : number_of_teeth - 1])
                    rotate([0, 0, 360 / number_of_teeth * tooth_number]) {
                        translate([outer_diameter_in_millimeter / 2, 0, 0]) {
                            square([outer_diameter_in_millimeter / 2, extrusion_width_in_millimeter * number_of_perimeters], center = true);
                        }
                    }
                ring(outer_diameter_in_millimeter * 2, outer_diameter_in_millimeter);
            }
            ring(outer_diameter_in_millimeter, outer_diameter_in_millimeter - extrusion_width_in_millimeter * number_of_perimeters * 2);
        }
        circle(d = inner_diameter_in_millimeter, center = true, $fn=100);        
    }
}
module ring(d1, d2) {
    difference() {
        circle(d = d1, center = true, $fn=100);
        circle(d = d2, center = true, $fn=100);
    }
}
module gap() {
    
    
    diam = outer_diameter_in_millimeter - extrusion_width_in_millimeter * number_of_perimeters * 2;
    
    translate([0,0,bushing_length_in_millimeter/2])
        cylinder(h = gap_in_bushing, d1 = diam, d2 = diam, $fn = 100, center = true);
    
    
    
    translate([0,0,bushing_length_in_millimeter/2 + gap_in_bushing/2 + gap_step/2])
        cylinder(h = gap_step, d1 = diam, d2 = inner_diameter_in_millimeter, $fn = 100, center = true);
    
    translate([0,0,bushing_length_in_millimeter/2 - gap_in_bushing/2 - gap_step/2 ])
        cylinder(h = gap_step, d2 = diam, d1 = inner_diameter_in_millimeter, $fn = 100, center = true);
    
}
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];

	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		square(radius*2, center = true);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		square(radius*2, center = true);
	}
}




