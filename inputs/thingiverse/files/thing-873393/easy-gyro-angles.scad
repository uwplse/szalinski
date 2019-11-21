/*[Gimbal Settings]*/
//in mm
largest_diameter = 60; //[40:140]
//prefered number of rings, limited by largest diameter
rings = 5; //[1:22]
//thickness of each layer, in mm
ring_thickness = 3; //[2:.1:10]
//hieght of the gimbal, in mm
ring_height = 8; //[3:.1:15]
//in mm
ring_spacing = 1; //[.3:.1:2]
//angle to move the gimbal for each ring
gimbal_angle = 45; //[0:180]
//how detailed is the surface
resolution = 50; //[30:Draft, 50:Normal, 80:Smooth]

//lets draw some rings!
for(i = [0 : rings - 1]) {
    
    //we use i to set the diameter of each ring
    current_outer_diameter = largest_diameter - ((ring_thickness + ring_spacing) * 2 * i);
    
    //lets check the diameter of the next innermost ring
    next_outer_diameter = largest_diameter - ((ring_thickness + ring_spacing) * 2 * (i + 1));
    
    //are we an innermost or outermost ring?
    //we are an innermost ring if we either are the last ring requested
    //or if the next ring would be too small to generate
    innermost = ((i == rings - 1) || (next_outer_diameter <= ring_thickness * 4)) ? true : false;
    //the first ring we generate is always the outermost ring
    outermost = (i == 0) ? true : false;
    
    //we don't want to draw rings that aren't actually rings
    if (current_outer_diameter > ring_thickness * 4) {
        //gimbals need orthogonally rotating rings, so lets turn each ring
        rotate([0,0,gimbal_angle * i]) {
            //everything besides diameter, inner and outer is the same for every ring
            axial_ring(current_outer_diameter,ring_thickness,ring_spacing,ring_height,resolution,innermost,outermost);
        }
    }
}


module ring(outer_diameter, thickness, height, resolution)
{
    //this is a value we'll use to make sure our shapes
    //overlap when we are cutting one out of another
    epsilon = .01;

    outer_radius = outer_diameter / 2;
    inner_radius = outer_radius - thickness;

    //this gives us the bounding box of the ring (plus a border epsilon units wide)
    cutter_width = (outer_radius + epsilon) * 2;

    //move the ring onto the ground plane
    translate([0,0,height / 2]) {
        //rotate the profile around a central axis to create the ring
        rotate_extrude($fn = resolution, convexity = 3){
            difference(){
                //this builds the cross section of the curved wall of the ring
                //outer vertical radius
                circle(r = outer_radius, $fn = resolution);
                //inner vertical radius
                circle(r = inner_radius, $fn = resolution);

                //cut a flat top into the profile
                translate([0,cutter_width / 2 + height / 2]) {
                    square([cutter_width,cutter_width], center = true);
                }
                
                //cut a flat bottom into the profile    
                translate([0,-(cutter_width / 2 + height / 2)]) {
                    square([cutter_width,cutter_width], center = true);
                }
                
                //cut away the extra scrap
                translate([-cutter_width / 2,0]) {
                    square([cutter_width,cutter_width], center = true);
                }
            }
        }        
    }
}

module axial_ring(outer_diameter, thickness, spacing, height, resolution, innermost = false, outermost = false)
{
    //this is a value we'll use to make sure our shapes
    //overlap when we are cutting one out of another
    epsilon = .01;
    
    outer_radius = outer_diameter / 2;
    inner_radius = outer_radius - thickness;
    
    //this gives us a perfect axis that won't interfere with other rings
    axis_height = min(thickness - epsilon, height / 2);

    //parts to cut away
    difference() {
        //all the solid parts
        union() {
            ring(outer_diameter, thickness, height, resolution);

            //are we not an innermost ring?
            if(!innermost) {
                //then we add the cones for our inner axis
                //cone 1
                translate([0, (inner_radius + epsilon), height / 2]) {
                    rotate([90,0,0]) {
                        cylinder(r1 = axis_height, r2 = 0, h = axis_height , $fn = 24);
                    }
                }
                //cone 2
                translate([0, -(inner_radius + epsilon), height / 2]) {
                    rotate([-90,0,0]) {
                        cylinder(r1 = axis_height, r2 = 0, h = axis_height , $fn = 24);
                    }
                }
            }
        }
        
        //using a smaller gap between the axis vs the rings
        //produces a lower friction gyro because the rings can never quite touch each other
        //most printers will have a hard time with a gap smaller than .2mm
        //so we don't allow it to go lower than that
        //above a 1mm gap the gyro will be too loose so we don't allow it to go above that
        axis_spacing = max(.2, min(1, spacing / 2));

        //are we not an outermost ring?
        if(!outermost) {
            //then we cut away the cones for our next ring out
            //cone 1
            translate([-outer_radius, 0, height / 2]) {
                rotate([0,90,0]) {
                    cylinder(r1 = axis_height, r2 = 0, h = axis_height - spacing + axis_spacing, $fn = 24);
                }
            }
            //cone 2
            translate([outer_radius, 0, height / 2]) {
                rotate([0,-90,0]) {
                    cylinder(r1 = axis_height, r2 = 0, h = axis_height - spacing + axis_spacing , $fn = 24);
                }
            }
        } 
    }         
} 
