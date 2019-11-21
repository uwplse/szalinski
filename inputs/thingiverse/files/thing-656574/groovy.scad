$fn=64+0;

// Diameter (mm)
diameter=75;  // [10:1000]
// Rim amount (%)
rim=10; //[1:99]
// Thickness (mm)
thickness=4;     // [1:25]
// Width of interior beams (mm)
beamw=5;  //[1:25]  

// Angle of "wings" (degrees)
angle=33; //[0:359]

// size of attachment point (0=none)
attach_radius=3;  //[0:10]
// size of attachment hole
attach_hole=1;  //[0:9]
// Shape
circular=1;  // [1:Circular, 0: Eliptical]
// Eliptical stretch factor (Golden Ratio=1.618)
factor=1.618; 



r=diameter/2;



module attach() {
  difference() {
    cylinder(r=attach_radius,h=thickness,center=true);
		cylinder(r=attach_hole,h=thickness+1,center=true);
   }
}

module ring() {
   difference() {
     cylinder(r=r,h=thickness,center=true);
		 cylinder(r=(100-rim)/100*r,h=thickness+1,center=true);
     }
}

module groovy() {
	union() {
 	  ring();
		rotate([0,0,-angle]) translate([0,-beamw/2,-thickness/2]) cube([r*.95,beamw,thickness],center=false);
		rotate([0,0,angle]) translate([-r*.95,-beamw/2,-thickness/2])  cube([r*.95,beamw,thickness],center=false);
	  cube([beamw,diameter*.95,thickness],center=true);
   }
}

union() {
if (circular==0) {
  scale([1,factor,1]) groovy();
// don't want to scale the attach point
// but do need to adjust the amount to move
  if (attach_radius!=0) translate([0,r*factor+attach_radius/2,0]) attach();
}
else {
  groovy();
// don't want to scale the attach point
// but do need to adjust the amount to move
  if (attach_radius!=0) translate([0,r+attach_radius/2,0]) attach();
}

}