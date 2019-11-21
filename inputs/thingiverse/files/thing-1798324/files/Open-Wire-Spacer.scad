// Customizer Foot Designer Open_Wire-Spacer
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

// Diameter (mm)
wire = 3.0; //[2:0.1:6]

difference(){
union() {
  cube([spacing-10,9,3], center=true);
  translate ([-spacing/2,0,-1.5]) 
    roundedRect([10, 10, 3], 3, $fn=32, center=true);
  translate ([spacing/2,0,-1.5]) 
    roundedRect([10, 10, 3], 3, $fn=32, center=true);
  translate ([0,(2+wire/2)/2,1+wire/2]) 
    rotate([90,0,0]) 
      roundedRect([spacing+10, 1+wire, 2+wire/2], 3, $fn=32, center=true);
}
union() {
  translate ([-spacing/2,0,0.5+wire/2]) 
    rotate([90,0,0]) 
      cylinder(20,d=wire,center=true, $fn=32);
  translate ([spacing/2,0,0.5+wire/2]) 
    rotate([90,0,0]) 
      cylinder(20,d=wire,center=true, $fn=32);
  translate ([-spacing/2-3,0,0]) 
    cube([12,3+wire/2,3+wire], center=true);
  translate ([spacing/2+3,0,0]) 
    cube([12,3.5+wire/2,3+wire], center=true);
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