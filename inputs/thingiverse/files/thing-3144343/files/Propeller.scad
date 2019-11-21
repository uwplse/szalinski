/*****************************************************************************
    Propeller 
	
	Modified from: https://www.thingiverse.com/thing:291404/files			
                                    
*****************************************************************************/

// Thickness of outer ring wall.
outer_ring_thickness = 1.5;
outer_ring_od = 130;
blade_thickness = 1.0;
blade_angle = -40;
hub_od = 14;
slot_width = 11.25;
slot_length = 6;

// Overall height of the whole propeller.
thickness = 5;

// Rotational offset of first blade (to match originals).
rotational_offset = 90;

// Number of blades.
n_blades = 4;

/* [Hidden] */
slop = 0.1;

Propeller();

//---------------------------------------------------------------------
//
//---------------------------------------------------------------------
module Propeller()
{  
	difference() 
	{
	  union() 
	  {
		ring();
		blades();
		hub();
	  }
	  //slot();
	  slotCross();
	}
}  

//---------------------------------------------------------------------
//
//---------------------------------------------------------------------
module ring() {
  difference() {
    cylinder(h = thickness + slop, r = outer_ring_od/2, center = true, $fa = 5, $fs = 0.5);
    cylinder(h = thickness + 2*slop, r = outer_ring_od/2 - outer_ring_thickness, center = true, $fa = 5, $fs = 0.5);
  }
}

//---------------------------------------------------------------------
//
//---------------------------------------------------------------------
module blade() {
  difference() {
    difference() {
      rotate([blade_angle, 0, 0])
      translate([0, -25, -blade_thickness/2])
      cube([outer_ring_od/2 - outer_ring_thickness/2, 50, blade_thickness]);
    }
    translate([0, 0, thickness/2 + 10])
    cube([outer_ring_od, outer_ring_od, 20], center=true);
    translate([0, 0, -(thickness/2 + 10)])
    cube([outer_ring_od, outer_ring_od, 20], center=true);
  }
}

//---------------------------------------------------------------------
//
//---------------------------------------------------------------------
module blades() 
{
  for (i = [0 : n_blades - 1]) {
    rotate([0, 0, rotational_offset + i * 360/n_blades]) blade();
  }
}

module slot() 
{
  intersection() {
    cylinder(h = 2*thickness, r = slot_width/2, center = true);
    cube([slot_width + slop, slot_length, 2*thickness], center = true);
  }
}

module slotCross() 
{
	rotate([0, 90, 0])
	{
		scale(1.1)
			lego_axle_mm(thickness * 2);
	}
}

/*------------------------------------------------------------------  
------------------------------------------------------------------*/
module hub() {
  difference() {
    cylinder(h = thickness + slop, r = hub_od/2, center = true);
  }
}


/*------------------------------------------------------------------  
------------------------------------------------------------------*/
module lego_axle_mm(axle_length_mm) 
{
    // Brand-independent measurements.
    axle_spline_width = 1.5;   
    axle_diameter = 4.7;   

	union() 
	{
		cube([axle_length_mm, axle_diameter, axle_spline_width],center=true);
		cube([axle_length_mm, axle_spline_width, axle_diameter],center=true);
	}
}

//difference() {
  //union() {
    //ring();
//    blades();
//    hub();
  //}
//  slot();
//}