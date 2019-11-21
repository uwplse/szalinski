$fn = 100;

// version 0.3

bearing_outer_diameter = 22; // in mm
bearing_thickness = 7; // in mm
mounting_hole_diameter=5; // diameter of the mounting bolts

bearing_OD_pillowblock_thickness = 5; // thickness of the bearing surround material
lip_size = 2; // lip intrusion into bearing holder
lip_thickness = 2; // lip thickness

lift = 4; // thickness of lower block
mounting_pad=2; // ratio of width of the mounting tabs as a function of the bolt diameter

print_endplate = true;

end_plate_bolt_diameter = 3; // fastener diameter for the end plate
end_plate_thickness = 2; // thickness of the endplate
end_plate_clearance = 0.5; // adds a bit of clearance for the endplate

thickness=lip_thickness+bearing_thickness+end_plate_thickness; // depth of the pillow block
r=bearing_outer_diameter/2 + bearing_OD_pillowblock_thickness;  // outer radii, this should be calculated based on the desired hole size

difference()
{
  difference()
  {
    union()
    {
      linear_extrude(height=thickness, center=false, convexity=10, twist=0)  // extrude the 2 pillow block
      {
	difference()
	{
	  union()
	  {
	    translate([mounting_hole_diameter*mounting_pad,0]) square([4*r,r+lift]); // bottom pad
	    translate([mounting_hole_diameter*mounting_pad+2*r,r+lift]) circle(r=r); // bearing holder
	    square([mounting_hole_diameter*mounting_pad,lift]); // left mouting tab
	    translate([mounting_hole_diameter*mounting_pad+4*r,0]) square([mounting_hole_diameter*mounting_pad,lift]); // right mounting tab
	  }
	  translate([mounting_hole_diameter*mounting_pad,r+lift]) circle(r=r); // left cutout for support
	  translate([mounting_hole_diameter*mounting_pad+4*r,r+lift]) circle(r=r); // right cutout for support
	  translate([mounting_hole_diameter*mounting_pad+2*r,r+lift]) circle(r=bearing_outer_diameter/2); // bearing hole
	}
      }

      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift]) cylinder(r=bearing_outer_diameter/2*1.1,h=lip_thickness); // lip
    }

    translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,-0.5]) cylinder(r=bearing_outer_diameter/2-lip_size,h=lip_thickness+1); // lip hole
  }

  translate([mounting_pad*mounting_hole_diameter/2,-1,thickness/2]) rotate([-90,0,0]) cylinder(r=mounting_hole_diameter/2,h=lift+2); // left mounting hole
  translate([4*r+3*mounting_pad*mounting_hole_diameter/2,-1,thickness/2]) rotate([-90,0,0]) cylinder(r=mounting_hole_diameter/2,h=lift+2); // right mounting hole

  translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,0]) rotate([0,0,0]) translate([0,bearing_outer_diameter/2+bearing_OD_pillowblock_thickness/2,-1]) cylinder(r=end_plate_bolt_diameter/2, h=thickness-end_plate_thickness+2);  // end plate mounting hole

  translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,0]) rotate([0,0,-120]) translate([0,bearing_outer_diameter/2+bearing_OD_pillowblock_thickness/2,-1]) cylinder(r=end_plate_bolt_diameter/2, h=thickness-end_plate_thickness+2);  // end plate mounting hole

  translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,0]) rotate([0,0,120]) translate([0,bearing_outer_diameter/2+bearing_OD_pillowblock_thickness/2,-1]) cylinder(r=end_plate_bolt_diameter/2, h=thickness-end_plate_thickness+2);  // end plate mounting hole

  translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,thickness-end_plate_thickness]) cylinder(r=bearing_outer_diameter/2+bearing_OD_pillowblock_thickness+end_plate_clearance, h=end_plate_thickness+1); // end plate

  translate([mounting_hole_diameter*mounting_pad+r-1, r+lift, thickness-end_plate_thickness]) cube([2*r+4,r+4,end_plate_thickness+2]); // clean up a zero thickness stuff

}

if(print_endplate == true)
{
  
  translate([-(mounting_hole_diameter*mounting_pad+2*r),+2,-thickness+end_plate_thickness]) // translate for printing
  //translate([0,0,10]) // shows the position over the bearing
  {
    difference()
    {
      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,thickness-end_plate_thickness]) cylinder(r=bearing_outer_diameter/2+bearing_OD_pillowblock_thickness, h=end_plate_thickness); // end plate

      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,0]) rotate([0,0,0]) translate([0,bearing_outer_diameter/2+bearing_OD_pillowblock_thickness/2,-1]) cylinder(r=end_plate_bolt_diameter/2, h=thickness+2);  // end plate mounting hole

      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,0]) rotate([0,0,-120]) translate([0,bearing_outer_diameter/2+bearing_OD_pillowblock_thickness/2,-1]) cylinder(r=end_plate_bolt_diameter/2, h=thickness+2);  // end plate mounting hole

      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,0]) rotate([0,0,120]) translate([0,bearing_outer_diameter/2+bearing_OD_pillowblock_thickness/2,-1]) cylinder(r=end_plate_bolt_diameter/2, h=thickness+2);  // end plate mounting hole

      translate([mounting_hole_diameter*mounting_pad+2*r,r+lift,thickness-end_plate_thickness-1]) cylinder(r=bearing_outer_diameter/2-lip_size, h=end_plate_thickness+2); // end plate bearing hole
    }
  }
}

// *************************//
echo("distance between centers of mounting bolts");
echo(4*r+3*mounting_pad*mounting_hole_diameter/2-mounting_pad*mounting_hole_diameter/2);