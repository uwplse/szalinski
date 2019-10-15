 /*
  *  Filename: 8mm-screw-bit.scad
  *  Author: Anhtien Nguyen
  * Date: 7/7/2018
  * Description: this is the screw bit to turn the 8mm lead screw nut up & down.
  */
  
// 8mmT8  rod diameter
T8 = 8;  
// # of sides
sides=64;
// clearance
gap = 0.2;  
// wall thickness
thick = 2;  
// 1/4 inch hex bit  in mm
hexbit = 6.35; 
// height
height=9.5;  
// calculate hex bit radius with added consideration for the filament width
hex_rad = calcRad(hexbit,6) - gap;

drawBit();

function calcRad(x, fn) = (1/cos(180/fn)) * (x/2);

module drawBit($fn=sides)
{
      // draw the T8 rod holder
        difference() {
            cylinder(r=T8/2+gap+thick,h=height,center=true);
            cylinder(r=T8/2+gap,h=height+2,center=true);
        }
        // add a transition ring on top to reduce the torque stress
        translate([0,0,height/2]) hull() 
        {
        cylinder(r=T8/2+gap+thick,h=2);
        translate([0,0,2])  cylinder(r=hex_rad,h=2,$fn=6);
        }
         // draw the bit 
        translate([0,0,height/2+4])  cylinder(r=hex_rad,h=height,$fn=6);
}

