// Nut diameter (width across corners - check http://www.fairburyfastener.com/xdims_metric_nuts.htm)
nut_d_base= 6;
// Nut diameter additional tolerance (additional width to compensate for shrinkage, e.g.)
nut_tolerance= 0.2;
// Nut thickness
nut_th= 2.3;

// Handle length
handle_len= 70;

// Handle width
handle_width= 5;

// Handle thickness
handle_th= 1.8;

// Wall thickness around the nut
wall_th= 1.8;

// See-through hole diameter (zero to disable)
see_through_hole_d= 3.1;

// Direction to open the nut head (if any), eg. 90, -90, 180 for the main 3 left,right,top directions. Zero to disable.
open_side= 0;

// Split the nut head (specify the gap width, or zero)
split_head_th= 0.6;

// The head angle compared to the handle
head_angle= 10;

// Head offset on the X axis (most probably zero)
head_offset_x=0;
// Head offset on the Y axis (zero or positive)
head_offset_y=0;
// Head offset on the Z axis (necessarily positive)
head_offset_z=1;

// Nut holder for tricky inside walls
// Rev 2.2 for the customizer of thingiverse
// CC-BY-NC jeremie@tecrd.com / MoonCactus on thingiverse

/* [Hidden] */

$fn=20+0;

head_offset=[head_offset_x,-head_offset_y,head_offset_z+handle_th];
nut_d= nut_d_base + nut_tolerance;

difference()
{
  union()
  {
    // The handle
    translate([-handle_width/2,0,0])
      cube([handle_width, handle_len, handle_th]);

    // The head
    difference()
    {

      translate(head_offset) rotate([head_angle ,0,0]) difference()
      {
	hull()
	{
	  cylinder(r= nut_d/2+wall_th, h= nut_th); // top & outer
	  rotate([-head_angle ,0,0]) translate(-head_offset) cylinder(r=handle_width/2,h=handle_th); // bottom
	}
	// Nut hole
	translate([0,0,tol]) rotate([0,0,open_side])
	{
	  if(open_side==0)
	    cylinder(r= nut_d/2, h= nut_th+2, $fn=6);
	  else hull()
	  {
	    cylinder(r= nut_d/2, h= nut_th+2, $fn=6);
	    translate([0,nut_d_base*2+10,0]) cylinder(r= nut_d/2, h= nut_th+1, $fn=6);
	  }
	}
	
	if(split_head_th>0)
	  rotate([0,0,open_side])
	    translate([-nut_d-wall_th,-split_head_th/2,1]) cube([(nut_d+wall_th)*2,split_head_th,nut_th+2]); // split the head a bit

      }
    }
  }

  
  if(see_through_hole_d>0)
      translate(head_offset) rotate([head_angle ,0,0]) difference()
	  cylinder(r=see_through_hole_d/2, h=300,center=true);

  // prevent stuff from going past the floor
  translate([-(nut_d+head_offset_x+wall_th+handle_width),-(nut_d+head_offset_y+wall_th+handle_width),(-nut_d-head_offset_z-wall_th) + 0.05])
    cube([(nut_d+head_offset_x+wall_th+handle_width)*2,(nut_d+head_offset_y+wall_th+handle_width)*2 + handle_len, nut_d+head_offset_z+wall_th]);
}