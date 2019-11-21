// in mm	(include tolerance for printing)
bearing_outer_diameter = 8.5; 
// center axis of bearing to mounting surface
bearing_center_height = 15; 

// in mm (for openbeam, 15 or 14)
bearing_block_thickness = 15; 
// mm of material around bearing (wall thickness)
bearing_OD_pillowblock_thickness = 5; 

// diameter of the mounting bolt holes 	(for openbeam, 3.2)
mounting_hole_diameter=3.2; 
// distance between mounting holes 		(for openbeam, 30)
mounting_hole_spacing = 30;
//Diameter of bolt head (for openbeam, 6.5)
countersink_diameter = 6.5;	
// Countersink until this thickness is remaining (for openbeam, 2)
countersink_thickness = 2;	

// Diameter of set screws holes on the sides (0 to remove)
set_screw_diameter = 0;

// thickness of base of pillow block
base_thickness = 5;	
//fillet between base and bearing
base_fillet_radius = 5;	
// the four clipped corners
base_chamfer_size = 2;		

// lip intrusion into bearing holder
lip_size = 0; 
// lip thickness for holding the bearing in place
lip_thickness = 0; 

r=bearing_outer_diameter/2 + bearing_OD_pillowblock_thickness;  // outer radii, this should be calculated based on the desired hole size


$fn = 100;

difference()
{
	difference()
	{
		union()
		{
			linear_extrude(height=bearing_block_thickness, center=true, convexity=10, twist=0)
			{
				difference()
				{
					union()
					{
						translate([0,base_thickness/2]) 						// base
							square([mounting_hole_spacing+bearing_block_thickness,base_thickness], center=true);
						translate([0,bearing_center_height])					// main bearing block
							circle(r=r);											
				   		translate([0,bearing_center_height/2]) 
							square([2*r,bearing_center_height], center=true);  // fillet to main bearing block
				 	  	translate([0,base_thickness+(base_fillet_radius/2)]) 
							square([2*r+(2*base_fillet_radius),base_fillet_radius], center=true); // fillet to base
					}
					translate([r+base_fillet_radius,base_fillet_radius+base_thickness])
						circle(r=base_fillet_radius);							// fillet 1
					translate([-(r+base_fillet_radius),base_fillet_radius+base_thickness])
						circle(r=base_fillet_radius);							// fillet 2
					translate([0,bearing_center_height])
						circle(r=bearing_outer_diameter/2);					// main bearing hole
					translate([0,-base_thickness/2]) 							// area below the base (cleanup)
						square([mounting_hole_spacing+15,base_thickness], center=true);
				}
			}
			// the lip
			translate([0,bearing_center_height, (bearing_block_thickness/2)-lip_thickness]) 
				cylinder(r=(bearing_outer_diameter/2)*1.1,h=lip_thickness);
		}
		// hole in the lip
		translate([0,bearing_center_height,0]) 
			cylinder(r=(bearing_outer_diameter/2)-lip_size,h=bearing_block_thickness*2);
	}
	union()
	{
		// Mounting Holes
		translate([mounting_hole_spacing/2,-1,0]) 
			rotate([-90,0,0]) 
				cylinder(r=mounting_hole_diameter/2,h=base_thickness+2);
		translate([mounting_hole_spacing/-2,-1,0]) 
			rotate([-90,0,0])
				cylinder(r=mounting_hole_diameter/2,h=base_thickness+2);
		// Countersink
		translate([mounting_hole_spacing/2,countersink_thickness,0])
			rotate([-90,0,0])
				cylinder(r=countersink_diameter/2,h=bearing_center_height*2);
		translate([mounting_hole_spacing/-2,countersink_thickness,0])
			rotate([-90,0,0])
				cylinder(r=countersink_diameter/2,h=bearing_center_height*2);
	}
	union()
	{
		//Base Chamfers
		translate([(mounting_hole_spacing+bearing_block_thickness)/2,base_thickness/2,bearing_block_thickness/2])
			rotate([0,45,0])
				cube([base_chamfer_size/sin(45),base_thickness*1.1,base_chamfer_size/sin(45)], center=true);
		translate([(mounting_hole_spacing+bearing_block_thickness)/2,base_thickness/2,bearing_block_thickness/-2])
			rotate([0,45,0])
				cube([base_chamfer_size/sin(45),base_thickness*2,base_chamfer_size/sin(45)], center=true);
		translate([(mounting_hole_spacing+bearing_block_thickness)/-2,base_thickness/2,bearing_block_thickness/2])
			rotate([0,45,0])
				cube([base_chamfer_size/sin(45),base_thickness*2,base_chamfer_size/sin(45)], center=true);
		translate([(mounting_hole_spacing+bearing_block_thickness)/-2,base_thickness/2,bearing_block_thickness/-2])
			rotate([0,45,0])
				cube([base_chamfer_size/sin(45),base_thickness*2,base_chamfer_size/sin(45)], center=true);

	}
	union()
	{
		//Set screws
		translate([-bearing_OD_pillowblock_thickness - (bearing_outer_diameter),bearing_center_height,-lip_size/2])
			rotate([0,90,0])
				cylinder(h=(bearing_outer_diameter+bearing_OD_pillowblock_thickness)*2, r=set_screw_diameter/2);
	}
}