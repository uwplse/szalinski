$fn = 100;

bearing_outer_diameter = 10; // in mm
bearing_thickness = 40; // in mm
mounting_hole_diameter=5; // diameter of the mounting bolts

bearing_OD_pillowblock_thickness = 7; // in mm
lip_size = 0; // lip intrusion into bearing holder
lip_thickness = 2; // lip thickness for holding the bearing in place

lift = 7; // thickness of lower block
mounting_pad=3; // ratio of width of the mounting tabs as a function of the bolt diameter

thickness=lip_thickness+bearing_thickness; // depth of the pillow block
r=bearing_outer_diameter + bearing_OD_pillowblock_thickness;  // outer radii, this should be calculated based on the desired hole size

difference()
{
  difference()
  {
    union()
    {
      linear_extrude(height=thickness, center=false, convexity=10, twist=0)
      {
	difference()
	{
	  union()
	  {
	    translate([mounting_hole_diameter*mounting_pad,0]) square([4*r,r+lift]);
	    translate([mounting_hole_diameter*mounting_pad+2*r,r+lift]) circle(r=r);
	    square([mounting_hole_diameter*mounting_pad,lift]);
	    translate([mounting_hole_diameter*mounting_pad+4*r,0]) square([mounting_hole_diameter*mounting_pad,lift]);
	  }
	  translate([mounting_hole_diameter*mounting_pad,r+lift]) circle(r=r);
	  translate([mounting_hole_diameter*mounting_pad+4*r,r+lift]) circle(r=r);
	  translate([mounting_hole_diameter*mounting_pad+2*r,r+lift]) circle(r=bearing_outer_diameter);
	}
      }

      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift]) cylinder(r=bearing_outer_diameter*1.1,h=lip_thickness);
    }

    translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,-0.5]) cylinder(r=bearing_outer_diameter-lip_size,h=lip_thickness+1);
  }

  translate([mounting_pad*mounting_hole_diameter/2,-1,thickness/2]) rotate([-90,0,0]) cylinder(r=mounting_hole_diameter/2,h=lift+2);
  translate([4*r+3*mounting_pad*mounting_hole_diameter/2,-1,thickness/2]) rotate([-90,0,0]) cylinder(r=mounting_hole_diameter/2,h=lift+2);

}