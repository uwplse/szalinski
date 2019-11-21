// Customizer Foot Designer Open_Wire-Center
//
// REV 1.0 29/09/2016

// Standard Thingiverse Configurations:
// Range = [:] Slider
// Range = [,] Drop Down Box
// Range = None Text Box

// Start Parameters for for Customizer ----
// preview[view:south, tilt:top]

// between Wires (mm)
spacing = 120; //[30:5:200]


difference(){
roundedRect([spacing + 10, 40, 5], 5, $fn=32, center=true);
union() {
  translate([spacing/2,15,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([-spacing/2,15,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([0,12.5,2.5])
    cylinder(6,d=10,center=true, $fn=32);
  translate([-15,5,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([15,5,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([-15,-5,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([15,-5,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([spacing/2,-15,2.5])
    cylinder(6,d=5,center=true, $fn=32);
  translate([-spacing/2,-15,2.5])
    cylinder(6,d=5,center=true, $fn=32);
}
}
// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
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
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}