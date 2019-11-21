// DC motor shaft to lego coupler
//
// Created by Moby Disk, 2015/02/08
// Thanks to mrob27 for thing 40410
// Changed by Drato to fit a Solarbotics GM8 Motor http://www.thingiverse.com/thing:1013155

// Diameters of various motor shafts:
// - Radio Shack 2730223: 2.0mm
// - Radio Shack 2730256: 2.3mm

// When 3D printing couplers, always try 0.1 - 0.3mm too big and test to see what actually fits

// Diameter of motor axle cutout, in mm, if motor axle is round without cutouts diameter is the same as motor_axle_diameter
motor_axle_cutout_diameter = 4.8;

// Diameter of motor axle, in mm
motor_axle_diameter = 7.1;

// Do you want to try some different axle sizes to see what fits best?
try_bigger_sizes = "no"; // [yes,no]

// Length of the axle part, in mm
axle_length = 7;
// Length of the motor axle part, in mm
motor_axle_length = 4;

// Outside radius of the coupler, in mm
coupler_outside_diameter = 9.2;

coupler_round_to_lego_axle(motor_axle_diameter,0, axle_length, motor_axle_length, coupler_outside_diameter);

spacing=coupler_outside_diameter*1.5;

if (try_bigger_sizes=="yes")
{
	for (bigger=[1:3])
	{
		translate([bigger*spacing,0,0])
		coupler_round_to_lego_axle(motor_axle_diameter,0.1*bigger, axle_length, motor_axle_length, coupler_outside_diameter);
	}
}

// Coupler for round DC motor shafts
// 
// diameter: diameter of the motor's axle
// fudge: Additional radius for the axle hole
//        - For 3D printing, the hole for the motor shaft must be larger than the actual axle itself
//        - 0.2mm and 0.3mm seem to work, but this may vary based on the printer and material
// length: A lego coupler is typically 15.9mm
// outside: outside diameter, increase for more strength
//
module coupler_round_to_lego_axle(diameter, fudge=0.2, axle_length=7, motor_axle_length=4, outside=7.2)
{
   // axle thickness is actually about 1.8 mm.  But for 3D printing, holes need to be bigger.
   axle_gap = 1.9;
   hole_radius = 2.65;

length = axle_length + motor_axle_length;
    
   motor_axle_diameter=diameter + fudge;
   difference()
   {
      // The coupler body
      translate([0,0,length/2])
      cylinder(r=outside/2,h=length,center=true,$fn=100);

      // The lego cross-axle hole
      translate([0 - hole_radius, 0 - axle_gap/2, -0.01])
      roundedRect([hole_radius * 2, axle_gap, axle_length+0.02], .2);
      translate([0 - axle_gap/2, 0 - hole_radius, -0.01])
      roundedRect([axle_gap, hole_radius * 2, axle_length+0.02], .2);

      difference()
      {
        // The hole for the motor shaft
        translate([0, 0, length-motor_axle_length/2+0.01])
        cylinder(r=motor_axle_diameter/2,h=motor_axle_length+0.01,center=true,$fn=100);
          
        translate([0,motor_axle_diameter/2+motor_axle_cutout_diameter/2, length-motor_axle_length/2+0.01])
        cube([motor_axle_diameter, motor_axle_diameter, motor_axle_length+0.01], true);
          
        translate([0,-motor_axle_diameter/2-motor_axle_cutout_diameter/2, length-motor_axle_length/2+0.01])
        cube([motor_axle_diameter, motor_axle_diameter, motor_axle_length+0.01], true);
      }
   }
}

// ---------------------------------------------------------------------------------
//
// module for rounded rectangles by tlrobinson on Thingiverse in a 
// comment posted to http://www.thingiverse.com/thing:9347 on March
// 29, 2012, 3:57:46 AM EDT
//
module roundedRect(size, radius) {  
  x = size[0];  
  y = size[1];  
  z = size[2];  
 
  linear_extrude(height=z)  
  hull() {  
    translate([radius, radius, 0])  
      circle(r=radius);  
 
    translate([x - radius, radius, 0])  
      circle(r=radius);  
 
    translate([x - radius, y - radius, 0])  
      circle(r=radius);  
 
    translate([radius, y - radius, 0])  
      circle(r=radius);  
  }  
}