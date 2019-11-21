/* [Outer Dimensions] */
//Width of the Box in mm
outer_width = 65; 	// [0:0.1:500]
//outer_length of the Box in mm
outer_length = 85; // [0:0.1:500]
//Height of the Box in mm
outer_height = 38;	// [0:0.1:500]

/* [Wall Settings] */
//Wallthickness in mm 
wall = 3.6; 	// [0:0.1:25]
//Radius of rounded Corner
corner = 2;	// [0:0.1:20]
//Gap between sides of case and Bottom in mm
gap_xy = 0.2; 	// [0:0.05:2]
//Gap between lip of case and Bottom in mm
gap_z = 0.2; 	// [0:0.05:2]

/* [Hole Settings] */
//Threaddiameter in mm 
screw_hole = 2; // [0:0.1:20]
//Wall thickness of screwpost in mm 
screw_wall_thickness = 2; // [0:0.1:20]
//Diameter of Screw Head in mm
screw_head = 7; // [0:0.1:50]
//Distance from Hole to Wall in mm
hole_distance = 1.5; // [0:0.1:50]
//Thickness of Circuit Board to be sandwiched between Case and Bottom in mm
pcb_height = 1.6; // [0:0.1:15]
//Step between Case and Bottom in mm
step = 1; 	// [0:0.1:10]

/* [Quality] */
//Quality (simply experiment) 
Quality = 25;	// [1:100]

$fn = Quality;
case(outer_width, outer_length,	outer_height, wall, corner, gap_xy, gap_z, screw_hole,
	screw_wall_thickness, screw_head, pcb_height, hole_distance, step, Quality);
	
//Case with rounded corners, screwholes and bottom
module case
(
	outer_width = 35, 
	outer_length = 45,
	outer_height = 38, 
	wall = 3.6, 
	corner = 2, 
	gap_xy = 0.2,
	gap_z = 1,
	screw_hole = 2,
	screw_wall_thickness = 2,
	screw_head = 7, 
	pcb_height = 0, 
	hole_distance = 1.5, 
	step = 1.5,
	quality = 25
)
{
    $fn = quality;
	
    //case
    union()
    {
        difference()
        {
            translate([corner, corner, corner])
            {
                minkowski()
                {   
                    cube([outer_width - 2*corner, outer_length - 2*corner, outer_height - 2*corner], false);
                    $fn = 15;
                    sphere(corner);
                }        
            }
			
            translate([wall, wall, wall])
            {
                cube([outer_width - 2*wall, outer_length - 2*wall, outer_height + corner], false);
            }
			
			translate([wall - step, wall - step, outer_height - wall])
            {
                cube([outer_width + 2*step - 2*wall, outer_length + 2*step - 2*wall, 2*wall], false);
            } 			
        }
    
        if(screw_hole > 0)
            {
                h_offset = wall + hole_distance + screw_hole/2;
                h_height = outer_height - 2 * wall - pcb_height + 0.1;
                dia = screw_hole + screw_wall_thickness*2;
                
                translate([h_offset, h_offset, wall - 0.1])
                {                                        
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder(outer_height, d = screw_hole);
                    }
                }
                
                translate([outer_width - h_offset, h_offset, wall - 0.1])
                {                                  
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder(outer_height, d = screw_hole);
                    }
                }
                
                translate([h_offset, outer_length - h_offset, wall - 0.1])
                {                                        
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder(outer_height, d = screw_hole);
                    }
                }
                
                translate([outer_width - h_offset, outer_length - h_offset, wall - 0.1])
                {                    
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder(outer_height, d = screw_hole);
                    }
                }
            }    
    }
    
    
    //Bottom
    //#translate([wall - step + gap_xy, wall - step + gap_xy, height - wall + gap_z]) //Mounted Pos
	translate([0, outer_length + 5*wall, 0]) //Printing Pos
    {
        difference()
        {
			cube_x = outer_width + 2*(step - wall - gap_xy);
			cube_y = outer_length + 2*(step - wall - gap_xy);
			
            cube([cube_x, cube_y, wall - gap_z], false);
        
            if(screw_hole > 0)
            {
                b_h_offset = step + screw_hole/2 - gap_xy + hole_distance;
                b_width = outer_width - 2 * wall;
                b_depth = outer_length - 2 * wall;
                h_depth = wall * (1/4);
                
                
                translate([b_h_offset, b_h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
					translate([0, 0, 1 + h_depth])cylinder(wall, d = screw_head);
                }
				
                translate([cube_x - b_h_offset, b_h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
					translate([0, 0, 1 + h_depth])cylinder(wall, d = screw_head);
                }	
                translate([b_h_offset, cube_y - b_h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
					translate([0, 0, 1 + h_depth])cylinder(wall, d = screw_head);
                }
				
                translate([cube_x - b_h_offset, cube_y - b_h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
					translate([0, 0, 1 + h_depth])cylinder(wall, d = screw_head);
                }				
                 
                    
            }
        }
    }   
}