//////////////////////////////////////////////////////////////////////////////////////////////
// Public Domain Parametric Involute Spur Gear (and involute helical gear and involute rack)
// version 1.2
// by Leemon Baird, 2011, Leemon@Leemon.com
// http://www.thingiverse.com/thing:5505
// updated, 2015, by CNT.
// http://www.thingiverse.com/thing:900277
//   CNT updates:
//      -adopted NateTG's fix for rack
//      -fixed bad input to example gear
//      -replaced references to 3.14159... with PI
//      -removed use of depricated assign() function.
//      -added hole types
//      -added thingiverse customizer options
//
//
// This file is public domain.  Use it for any purpose, including commercial
// applications.  Attribution would be nice, but is not required.  There is
// no warranty of any kind, including its correctness, usefulness, or safety.
// 
// This is parameterized involute spur (or helical) gear.  It is much simpler and less powerful than
// others on Thingiverse.  But it is public domain.  I implemented it from scratch from the 
// descriptions and equations on Wikipedia and the web, using Mathematica for calculations and testing,
// and I now release it into the public domain.
//
//    http://en.wikipedia.org/wiki/Involute_gear
//    http://en.wikipedia.org/wiki/Gear
//    http://en.wikipedia.org/wiki/List_of_gear_nomenclature
//    http://gtrebaol.free.fr/doc/catia/spur_gear.html
//    http://www.cs.cmu.edu/~rapidproto/mechanisms/chpt7.html
//
// The module gear() gives an involute spur gear, with reasonable defaults for all the parameters.
// Normally, you should just choose the first 4 parameters, and let the rest be default values.
// The module gear() gives a gear in the XY plane, centered on the origin, with one tooth centered on
// the positive Y axis.  The various functions below it take the same parameters, and return various
// measurements for the gear.  The most important is pitch_radius, which tells how far apart to space
// gears that are meshing, and adendum_radius, which gives the size of the region filled by the gear.
// A gear has a "pitch circle", which is an invisible circle that cuts through the middle of each
// tooth (though not the exact center). In order for two gears to mesh, their pitch circles should 
// just touch.  So the distance between their centers should be pitch_radius() for one, plus pitch_radius() 
// for the other, which gives the radii of their pitch circles.
//
// In order for two gears to mesh, they must have the same mm_per_tooth and pressure_angle parameters.  
// mm_per_tooth gives the number of millimeters of arc around the pitch circle covered by one tooth and one
// space between teeth.  The pitch angle controls how flat or bulged the sides of the teeth are.  Common
// values include 14.5 degrees and 20 degrees, and occasionally 25.  Though I've seen 28 recommended for
// plastic gears. Larger numbers bulge out more, giving stronger teeth, so 28 degrees is the default here.
//
// The ratio of number_of_teeth for two meshing gears gives how many times one will make a full 
// revolution when the the other makes one full revolution.  If the two numbers are coprime (i.e. 
// are not both divisible by the same number greater than 1), then every tooth on one gear
// will meet every tooth on the other, for more even wear.  So coprime numbers of teeth are good.
//
// The module rack() gives a rack, which is a bar with teeth.  A rack can mesh with any
// gear that has the same mm_per_tooth and pressure_angle.
//
// Some terminology: 
// The outline of a gear is a smooth circle (the "pitch circle") which has mountains and valleys
// added so it is toothed.  So there is an inner circle (the "root circle") that touches the 
// base of all the teeth, an outer circle that touches the tips of all the teeth,
// and the invisible pitch circle in between them.  There is also a "base circle", which can be smaller than
// all three of the others, which controls the shape of the teeth.  The side of each tooth lies on the path 
// that the end of a string would follow if it were wrapped tightly around the base circle, then slowly unwound.  
// That shape is an "involute", which gives this type of gear its name.
//
//////////////////////////////////////////////////////////////////////////////////////////////
// preview[view:south, tilt:top]
/* [Hidden] */
$fn=50;

/* [Parameters] */
//choose gear type
gear_type = 1; //[1:Gear(or single-helical), 0:Rack, 2:Double-helical]
//choose number of teeth or pitch radius (num teeth = pitch)
num_teeth_or_pitch = 16; 
//helix angle for helical gears.  set to 0 for normal gears.  Note that meshing gears need opposite angles.
helix_angle = 0; //[-45:45]
//Gear thickness
thickness    = 6;
//hole diameter (flat to flat for hexagonal hole)
hole         = 5.2;
hole_type = 1; //[0:round, 1:D shaft, 2: hex bolt head]

//percent of tooth cutoff to allow for clearance between tooth.  A high clearance may cause backlash while a low percentage may cause binding if the gears aren't printed perfectly.
clearance_percentage = 5;

//height of gear rack (for racks only)
height_of_rack       = 10;


/* [Hidden] */
mm_per_tooth = 2*PI; //all meshing gears need the same mm_per_tooth (and the same pressure_angle)

ha = 90-helix_angle;
twst = 360*(thickness/tan(ha))/(2*PI*pitch_radius(mm_per_tooth,num_teeth_or_pitch));

if (gear_type==1) {
  difference () { 
    gear(mm_per_tooth,num_teeth_or_pitch,thickness,0,twst,clearance=mm_per_tooth*clearance_percentage/100);
    if (hole_type == 2) {
      hexagon (hole,2*thickness);
    }  
    if(hole_type == 1) {
      Dshaft(hole,hole/10.0,thickness*2);
    }
    if(hole_type == 0) {
      cylinder(h= thickness*2,r=hole/2,center=true);
    }
  }
}else if (gear_type==2) {
  difference () { 
    union() {
      translate([0,0,thickness/4])
        gear(mm_per_tooth,num_teeth_or_pitch,thickness/2,0,twst,clearance=mm_per_tooth*clearance_percentage/100);
      translate([0,0,-thickness/4]) mirror([0,0,1])
        gear(mm_per_tooth,num_teeth_or_pitch,thickness/2,0,twst,clearance=mm_per_tooth*clearance_percentage/100);
    }
    if (hole_type == 2) {
      hexagon (hole,2*thickness);
    }  
    if(hole_type == 1) {
      Dshaft(hole,hole/10.0,thickness*2);
    }
    if(hole_type == 0) {
      cylinder(h= thickness*2,r=hole/2,center=true);
    }
  }
} else {
  translate([-mm_per_tooth*num_teeth_or_pitch/2,0,0])
    rack(mm_per_tooth,num_teeth_or_pitch,thickness,height_of_rack);
}


// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module Dshaft(diameter,flat,height) {
  difference(){
    cylinder(h= height,r=diameter/2,center=true);
    translate([0,diameter-flat,0]) cube([diameter,diameter,height*2],center=true);
  }
}

//An involute spur gear, with reasonable defaults for all the parameters.
//Normally, you should just choose the first 4 parameters, and let the rest be default values.
//Meshing gears must match in mm_per_tooth, pressure_angle, and twist,
//and be separated by the sum of their pitch radii, which can be found with pitch_radius().
module gear (
  mm_per_tooth    = 3,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
  number_of_teeth = 11,   //total number of teeth around the entire perimeter
  thickness       = 6,    //thickness of gear in mm
  hole_diameter   = 3,    //diameter of the hole in the center, in mm
  twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
  teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
  pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
  clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
  backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
) {
  p  = mm_per_tooth * number_of_teeth / PI / 2;  //radius of pitch circle
  c  = p + mm_per_tooth / PI - clearance;        //radius of outer circle
  b  = p*cos(pressure_angle);                    //radius of base circle
  r  = p-(c-p)-clearance;                        //radius of root circle
  t  = mm_per_tooth/2-backlash/2 ;               //tooth thickness at PItch circle
  k  = -iang(b, p) - t/2/p/PI*180; {             //angle to where involute meets base circle on each side of tooth
    difference() {
      union() {
      for (i = [0:number_of_teeth-teeth_to_hide-1] )
        rotate([0,0,i*360/number_of_teeth])
          linear_extrude(height = thickness, center = true, convexity = 30, twist = twist)
            polygon(
              points=[
                [0, -hole_diameter/10],
                polar(r, -181/number_of_teeth),
                polar(r, r<b ? k : -180/number_of_teeth),
                q7(0/5,r,b,c,k, 1),q7(1/5,r,b,c,k, 1),q7(2/5,r,b,c,k, 1),q7(3/5,r,b,c,k, 1),q7(4/5,r,b,c,k, 1),q7(5/5,r,b,c,k, 1),
                q7(5/5,r,b,c,k,-1),q7(4/5,r,b,c,k,-1),q7(3/5,r,b,c,k,-1),q7(2/5,r,b,c,k,-1),q7(1/5,r,b,c,k,-1),q7(0/5,r,b,c,k,-1),
                polar(r, r<b ? -k : 180/number_of_teeth),
                polar(r, 181/number_of_teeth)
              ],
              paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]
            );
      //shouldn't need this but otherwise openSCAD creates a broken solid.
      cylinder(h=thickness,r=b,center=true);
      }
      cylinder(h=2*thickness+1, r=hole_diameter/2, center=true, $fn=50);
    }
  }
};  
//these 4 functions are used by gear
function polar(r,theta)   = r*[sin(theta), cos(theta)];                            //convert polar to cartesian coordinates
function iang(r1,r2)      = sqrt((r2/r1)*(r2/r1) - 1)/PI*180 - acos(r1/r2); //unwind a string this many degrees to go from radius r1 to radius r2
function q7(f,r,b,r2,t,s) = q6(b,s,t,(1-f)*max(b,r)+f*r2);                         //radius a fraction f up the curved side of the tooth 
function q6(b,s,t,d)      = polar(d,s*(iang(b,d)+t));                              //point at radius d on the involute curve

//a rack, which is a straight line with teeth (the same as a segment from a giant gear with a huge number of teeth).
//The "pitch circle" is a line along the X axis.
module rack (
  mm_per_tooth    = 3,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
  number_of_teeth = 11,   //total number of teeth along the rack
  thickness       = 6,    //thickness of rack in mm (affects each tooth)
  height          = 120,   //height of rack in mm, from tooth top to far side of rack.
  pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
  backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
) {
  a = mm_per_tooth / PI; //addendum
    //Note: applied NateTG's fix
  t = a/2*cos(pressure_angle);         //tooth side is tilted so top/bottom corners move this amount
    for (i = [0:number_of_teeth-1] )
        translate([i*mm_per_tooth,0,0])
            linear_extrude(height = thickness, center = true, convexity = 30)
                polygon(
                    points=[
                        [-mm_per_tooth * 3/4,                 a-height],
                        [-mm_per_tooth * 3/4 - backlash,     -a],
                        [-mm_per_tooth * 1/4 + backlash - t, -a],
                        [-mm_per_tooth * 1/4 + backlash + t,  a],
                        [ mm_per_tooth * 1/4 - backlash - t,  a],
                        [ mm_per_tooth * 1/4 - backlash + t, -a],
                        [ mm_per_tooth * 3/4 + backlash,     -a],
                        [ mm_per_tooth * 3/4,                 a-height],
                    ],
                    paths=[[0,1,2,3,4,5,6,7]]
                );
};  

//These 5 functions let the user find the derived dimensions of the gear.
//A gear fits within a circle of radius outer_radius, and two gears should have
//their centers separated by the sum of their pictch_radius.
function circular_pitch  (mm_per_tooth=3) = mm_per_tooth;                     //tooth density expressed as "circular pitch" in millimeters
function diametral_pitch (mm_per_tooth=3) = PI / mm_per_tooth;         //tooth density expressed as "diametral pitch" in teeth per millimeter
function module_value    (mm_per_tooth=3) = mm_per_tooth / PI;                //tooth density expressed as "module" or "modulus" in millimeters
function pitch_radius    (mm_per_tooth=3,number_of_teeth=11) = mm_per_tooth * number_of_teeth / PI / 2;
function outer_radius    (mm_per_tooth=3,number_of_teeth=11,clearance=0.1)    //The gear fits entirely within a cylinder of this radius.
  = mm_per_tooth*(1+number_of_teeth/2)/PI  - clearance;              

//////////////////////////////////////////////////////////////////////////////////////////////
//example gear train.  
//Try it with OpenSCAD View/Animate command with 20 steps and 24 FPS.
//The gears will continue to be rotated to mesh correctly if you change the number of teeth.



