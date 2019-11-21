// *********************************************
//
// Customizable/parametric clamp script
// Author: indazoo
// Credits : 
//   bardiir   https://www.thingiverse.com/thing:2427479
//   Marko22   https://www.thingiverse.com/thing:2484467
//
// *********************************************

/* [Clamp Definitions] */

//Diameter of the rod or pipe to clamp
clamp_inner_diameter = 20; //[1:200]

//Clamps need some space to apply pressure.
clamp_diameter_offset = 1; //[0:200]

//Clamp length
clamp_length = 50; //[1:200]

//Wall thickness
clamp_wall_thickness = 3; //[1:20]

/* [Plate Definitions] */

//Plate thickness where the screw holes are.
wall_plate_thickness = 4; //[1:20]

//Border around the screw recess.
wall_plate_border = 1; //[1:20]

/* [Screw Definitions] */

//Count of screw holes to be places alongside each side.
num_screws = 2; //[0:20]

//Diameter of screw holes.
screw_diameter = 4; //[1:15]

//Distance of opposite screws. Useful for repair parts where the screw/bolt distance must match. Must be at least larger than the clamps inner diameter. Zero disables this and gives automatic distance depending of clamp size.
screw_opposite_distance = 0; //[0:200]

//Distance for the first and the last screw from the edge. Zero disables this so the holes will placed according to plate border value.
screw_distance_from_edge = 0; //[0:100]

//Diameter of nut trap or screw head diameter (set to 0 to disable).
screw_recess_diameter = 8; //[0:20] 

//Make a recess as nut or round shape.
screw_recess_shape = "nut"; //[nut,round]

//How deep the recess is. Set to zero to get a flat clamp plate.
screw_head_nut_thickness = 2; //[0:20]

/* [Hidden] */
plate_r = clamp_wall_thickness/2;

// Output for thingiverse customizer//

rotate([0,90,0])
clamp(clamp_inner_diameter = clamp_inner_diameter,
            clamp_diameter_offset = clamp_diameter_offset,
            clamp_length = clamp_length,
            clamp_wall_thickness = clamp_wall_thickness,
            wall_plate_thickness = wall_plate_thickness,
            wall_plate_border = wall_plate_border,
            num_screws = num_screws,
            screw_diameter = screw_diameter,
            screw_opposite_distance = screw_opposite_distance,
            screw_distance_from_edge = screw_distance_from_edge,
            screw_recess_diameter = screw_recess_diameter,
            screw_recess_is_nut = screw_recess_shape == "nut" ? true : false,
            screw_head_nut_thickness= screw_head_nut_thickness);


// ************************************
// Samples / output for STL picture
// ************************************
/*
// narrow one screw clamp
translate([0,0,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 12,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 2,
            num_screws = 1,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 0,
            screw_recess_diameter = 8,
            screw_recess_is_nut = false,
            screw_head_nut_thickness = 2) ; 
            
translate([15,0,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 12,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 2,
            num_screws = 1,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 0,
            screw_recess_diameter = 8,
            screw_recess_is_nut = true,
            screw_head_nut_thickness = 2) ;

// narrow one screw clamp without recess at fixed distance
translate([50,0,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 12,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 8,
            wall_plate_border = 2,
            num_screws = 1,
            screw_diameter = 4,
            screw_opposite_distance = 36, 
            screw_distance_from_edge = 0,
            screw_recess_diameter = 8,
            screw_recess_is_nut = false,
            screw_head_nut_thickness = 0) ; 
            
translate([65,0,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 12,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 8,
            wall_plate_border = 2,
            num_screws = 1,
            screw_diameter = 4,
            screw_opposite_distance = 36,
            screw_distance_from_edge = 0,
            screw_recess_diameter = 8,
            screw_recess_is_nut = true,
            screw_head_nut_thickness = 0) ;

            
// Dual screw clamp
translate([0,45,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 10,
            clamp_diameter_offset = 1,
            clamp_length = 40,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 1,
            num_screws = 2,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 10,
            screw_recess_diameter = 8,
            screw_recess_is_nut = true,
            screw_head_nut_thickness = 2) ;
translate([50,45,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 10,
            clamp_diameter_offset = 1,
            clamp_length = 40,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 1,
            num_screws = 2,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 10,
            screw_recess_diameter = 8,
            screw_recess_is_nut = false,
            screw_head_nut_thickness = 0) ;

// triple screw clamp
translate([0,90,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 40,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 1,
            num_screws = 3,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 0,
            screw_recess_diameter = 8,
            screw_recess_is_nut = true,
            screw_head_nut_thickness = 2) ;
translate([50,90,0])
rotate([0,90,0])
clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 50,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 1,
            num_screws = 3,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 10,
            screw_recess_diameter = 8,
            screw_recess_is_nut = false,
            screw_head_nut_thickness = 0) ;
*/            
// *****************************************************
// Code
// *****************************************************
           

module clamp(clamp_inner_diameter = 20,
            clamp_diameter_offset = 1,
            clamp_length = 50,
            clamp_wall_thickness = 3,
            wall_plate_thickness = 4,
            wall_plate_border = 1,
            num_screws = 2,
            screw_diameter = 4,
            screw_opposite_distance = 0,
            screw_distance_from_edge = 10,
            screw_recess_diameter = 8,
            screw_recess_is_nut = true,
            screw_head_nut_thickness = 2) 
{
    plate_length_p = plate_length(
                        screw_opposite_distance = screw_opposite_distance,
                        wall_plate_border = wall_plate_border,
                        clamp_wall_thickness = clamp_wall_thickness,
                        clamp_inner_diameter = clamp_inner_diameter, 
                        screw_recess_is_nut = screw_recess_is_nut,
                        screw_recess_diameter = screw_recess_diameter);
    screwhole_distance_from_edge_p = screwhole_distance_from_edge(
                                        num_screws = num_screws,
                                        clamp_length = clamp_length,
                                        screw_distance_from_edge = screw_distance_from_edge,
                                        wall_plate_border = wall_plate_border,
                                        screw_recess_diameter = screw_recess_diameter
                                        );
    screwhole_distance_p = screwhole_distance(num_screws = num_screws,
                            clamp_length = clamp_length,
                            screwhole_distance_from_edge = screwhole_distance_from_edge_p
                            );
    difference()
    {
        //create clamp structure
        union()
        {
            translate([clamp_diameter_offset,0,0])
            difference() 
            {
                cylinder(d=clamp_inner_diameter+clamp_wall_thickness*2,h=clamp_length,$fn=100);
                translate([0,0,-1])
                //remove inner cylinder
                cylinder(d=clamp_inner_diameter,h=clamp_length+2,$fn=100);
                //cut half of clamp
                translate([-clamp_diameter_offset,
                            -(clamp_inner_diameter+clamp_wall_thickness*16)/2,
                            -clamp_length/2])
                    cube([(clamp_inner_diameter+clamp_wall_thickness)*2+1,
                        clamp_inner_diameter+clamp_wall_thickness*16,
                        clamp_length*2]);
            }
            //add plates on the left/right
            translate([0,
                        plate_center_x(clamp_inner_diameter = clamp_inner_diameter,
                                        plate_length = plate_length_p),
                        clamp_length/2])
            rotate([180,0,0])
            plate(plate_length = plate_length_p,
                    wall_plate_thickness = wall_plate_thickness,
                    clamp_length = clamp_length);
            translate([0,
                        -plate_center_x(clamp_inner_diameter = clamp_inner_diameter,
                                        plate_length = plate_length_p),
                        clamp_length/2])
            plate(plate_length = plate_length_p,
                    wall_plate_thickness = wall_plate_thickness,
                    clamp_length = clamp_length);
        }
        //remove screw holes
        if(num_screws > 0)
        {
            translate([0,-screw_center_x(screw_opposite_distance = screw_opposite_distance, 
                            clamp_inner_diameter = clamp_inner_diameter,
                            wall_plate_border = wall_plate_border,
                            screw_recess_is_nut = screw_recess_is_nut,
                            screw_recess_diameter = screw_recess_diameter,
                            plate_length = plate_length_p),
                        0])
               recess(num_screws = num_screws,
                        screw_diameter = screw_diameter, 
                        wall_plate_thickness = wall_plate_thickness,
                        screw_head_nut_thickness = screw_head_nut_thickness,
                        screw_recess_is_nut = screw_recess_is_nut,
                        screw_recess_diameter = screw_recess_diameter,
                        recess_height = screw_head_nut_thickness,
                        screwhole_distance_from_edge = screwhole_distance_from_edge_p,
                        screwhole_distance = screwhole_distance_p);
            translate([0,+screw_center_x(screw_opposite_distance = screw_opposite_distance, 
                            clamp_inner_diameter = clamp_inner_diameter,
                            wall_plate_border = wall_plate_border,
                            screw_recess_is_nut = screw_recess_is_nut,
                            screw_recess_diameter = screw_recess_diameter,
                            plate_length = plate_length_p),
                        0])
                recess(num_screws = num_screws,
                        screw_diameter = screw_diameter, 
                        wall_plate_thickness = wall_plate_thickness,
                        screw_head_nut_thickness = screw_head_nut_thickness,
                        screw_recess_is_nut = screw_recess_is_nut,
                        screw_recess_diameter = screw_recess_diameter,
                        recess_height = screw_head_nut_thickness,
                        screwhole_distance_from_edge = screwhole_distance_from_edge_p,
                        screwhole_distance = screwhole_distance_p);
        }
    }
}

//this function would minimize the width of the clamp but then the counterpart may not have the same width
function screw_recess_virtual_diameter(screw_recess_is_nut = true, 
                                        screw_recess_diameter = 8)
            //0.88 is relation between diameter of nut versus width of flat sides
            //= (screw_recess_is_nut ? screw_recess_diameter*0.88 : screw_recess_diameter);
            = screw_recess_diameter;

function plate_length(screw_opposite_distance = 0,
                    wall_plate_border = 2,
                    clamp_wall_thickness = 3,
                    clamp_inner_diameter = 20, 
                    screw_recess_is_nut = true,
                    screw_recess_diameter = 8
                    )
            = screw_opposite_distance == 0 ?
                screw_recess_virtual_diameter(screw_recess_is_nut = screw_recess_is_nut, 
                                        screw_recess_diameter = screw_recess_diameter)
                + wall_plate_border
                + clamp_wall_thickness
            : (screw_opposite_distance - clamp_inner_diameter)/2 
                + screw_recess_virtual_diameter(screw_recess_is_nut = screw_recess_is_nut, 
                                        screw_recess_diameter = screw_recess_diameter)/2
                + wall_plate_border ;

function plate_center_x(clamp_inner_diameter=20, 
                        plate_length = 10) 
            = clamp_inner_diameter/2 + plate_length/2;

function screw_center_x(screw_opposite_distance = 0, 
                        clamp_inner_diameter = 20,
                        wall_plate_border = 2,
                        screw_recess_is_nut = true,
                        screw_recess_diameter = 8,
                        plate_length = 10
                        ) 
            = screw_opposite_distance > 0 ?
            screw_opposite_distance/2
            :clamp_inner_diameter/2 
                + plate_length 
                - wall_plate_border 
                - screw_recess_virtual_diameter(screw_recess_is_nut = screw_recess_is_nut,
                                                screw_recess_diameter = screw_recess_diameter)/2
                +0.05 ; //correction factor because screw_recess_virtual_diameter() is not exact to prevent ultra thin wall with border = 0

function screwhole_distance_from_edge(num_screws = 2,
                                    clamp_length = 50,
                                    screw_distance_from_edge = 0,
                                    wall_plate_border = 2,
                                    screw_recess_diameter = 8
                                    )
            =
   num_screws == 1 ? clamp_length/2
   : screw_distance_from_edge == 0 || 2*screw_distance_from_edge > clamp_length ? wall_plate_border + screw_recess_diameter/2
   : screw_distance_from_edge; 

function screwhole_distance(num_screws = 2,
                            clamp_length = 50,
                            screwhole_distance_from_edge = 10
                            )
           = num_screws == 1 ? 0 : (clamp_length - 2*screwhole_distance_from_edge) / (num_screws-1) ;

/*
echo("clamp_length",clamp_length);
echo("screwhole_distance_from_edge()",screwhole_distance_from_edge());
echo("screwhole_distance()",screwhole_distance());
echo(clamp_length-screwhole_distance_from_edge()-(screwhole_distance()*1));
*/

module plate(plate_length = 10, wall_plate_thickness = 4, clamp_length = 50)
{
    translate([-wall_plate_thickness,0,0])
    rotate([0,90,0])
    roundedRect([clamp_length,plate_length,wall_plate_thickness],plate_r , $fn=30);
}

module recess(num_screws = 2,
                screw_diameter = 4, 
                wall_plate_thickness = 4,
                screw_head_nut_thickness = 3,
                screw_recess_is_nut = true,
                screw_recess_diameter = true,
                recess_height = 3,
                screwhole_distance_from_edge = 10,
                screwhole_distance = 0
             )
{
    if(num_screws>0)
    {
        for(i=[0:num_screws-1])
        {
            translate([0,0,screwhole_distance_from_edge+screwhole_distance*i])
                screwhole(screw_diameter = screw_diameter, 
                        wall_plate_thickness = wall_plate_thickness,
                        screw_head_nut_thickness = screw_head_nut_thickness,
                        screw_recess_is_nut = screw_recess_is_nut,
                        screw_recess_diameter = screw_recess_diameter,
                        recess_height = recess_height
                        );
        }
    }
}


module screwhole(screw_diameter = 4, 
                wall_plate_thickness = 4,
                screw_head_nut_thickness = 3,
                screw_recess_is_nut = true,
                screw_recess_diameter = true,
                recess_height = 3
                )
{
    rotate([0,90,0])
    union() {
        cylinder(d=screw_diameter, h=wall_plate_thickness+20, $fn=30, center=true);
        if(screw_head_nut_thickness > 0)
        {
            translate([0,0,(-(20+recess_height)/2)- (recess_height == 0 ? wall_plate_thickness +0.01: wall_plate_thickness-recess_height) ])
            if(screw_recess_is_nut)
                cylinder(d=screw_recess_diameter, h=recess_height+20, $fn=6, center=true);
            else
                cylinder(d=screw_recess_diameter, h=recess_height+20, $fn=30, center=true);
        }
    }
}

// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0]-radius;
	y = size[1]-radius;
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
        square(size = [radius*2, radius*2], center = true);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		square(size = [radius*2, radius*2], center = true);
	}
}