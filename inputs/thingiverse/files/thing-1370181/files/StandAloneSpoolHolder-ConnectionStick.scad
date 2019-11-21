//
//
//  Connection Stick for Standalone Spool Holder by TouchWARE
//
//  Copyright (C) 2016 TouchWARE, Jan Verner
//
//

spoolwidth=95;         // Enter Spool Width Here (in mm)

module roundedRect(size, radius)
{
        // this function is from Round corners for Openscad - Tutorial by WilliamAAdams
        // http://www.thingiverse.com/thing:9347
    
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}



difference()
{
  roundedRect([spoolwidth+25,15,9],5,$fn=200);
  union()
  {
    translate([spoolwidth/2+6.75,5,-5]) cube([3.5,10,20]);
    translate([spoolwidth/2+6.75,-15,-5]) cube([3.5,10,20]);
    translate([-spoolwidth/2-10.25,5,-5]) cube([3.5,10,20]);
    translate([-spoolwidth/2-10.25,-15,-5]) cube([3.5,10,20]);
  }
        
}