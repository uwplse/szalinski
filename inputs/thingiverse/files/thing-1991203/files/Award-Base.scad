// Customizable Award Base
// by György Balássy 2016 (http://gyorgybalassy.wordpress.com)
// Inspired by TheNewHobbyist's Customizable Movie Award Base (http://www.thingiverse.com/thing:244025).
// http://www.thingiverse.com/thing:1991203

// What do you want to print?
printItem = "Both"; // [Both, Base only, Label only]

// Do you want a square hole on the top of the base to mount a statue?
holeEnabled = "yes";  // [yes,no]

// The size of the mount hole for the statue in X dimension.
holeLength = 15.5; 

// The size of the mount hole for the statue in Y dimension.
holeWidth = 3;

// The depth of the mount hole for the statue in Z dimension.
holeDepth = 20;


/* [Hidden] */

$fn = 180;
delta = .01;

// Ring sizes: [0] = Ring diameter, [1] = Ring height.
c1 = [56.2, 3];
c2 = [52.5, 1.4];
c3 = [46.7, 21.5];
c4 = [40, 3.1];

// Label size.
labelThickness = 3;
labelMargin = 5;

if (printItem == "Both" || printItem == "Base only") {
  base();
}  
if (printItem == "Both" || printItem == "Label only") {
  label();
}

module label() {
  color("Gold")   
    rotate([0, 0, 90]) {
      difference(){	
        // External ring.
        translate([0, 0, 0 + c1[1] + c2[1] - delta + labelMargin / 2])              
          cylinder(d = c3[0] + delta, h = c3[1] - labelMargin, center = false);
        
        // Internal ring.
        translate([0, 0, 0 + c1[1] + c2[1] - delta * 2 + labelMargin / 2])          
          cylinder(d = c3[0] - labelThickness, h = c3[1] - labelMargin + delta * 2, center = false);
      
        // Cutting plane.
        translate([11, 0, 0]) // The first parameter determines the width of the label.
          cube([50,  100,  100], center = true);
      }
    }
}

module hole() {
  translate([0, 0, -holeDepth / 2 + c1[1] + c2[1] + c3[1] + c4[1] + delta])
    cube([holeLength,  holeWidth,  holeDepth], center = true);
}

module base() {
  color("DimGrey")   
    difference(){
      union(){ 
        translate([0, 0, 0]) 
          cylinder(d = c1[0], h = c1[1], center = false);
        translate([0, 0, 0 + c1[1] - delta]) 
          cylinder(d = c2[0], h = c2[1], center = false);
        translate([0, 0, 0 + c1[1] + c2[1] - delta]) 
          cylinder(d = c3[0], h = c3[1], center = false);
        translate([0, 0, 0 + c1[1] + c2[1] + c3[1]]) 
          cylinder(d = c4[0], h = c4[1], center = false);      
      }
      label();
      
      if (holeEnabled == "yes") {
        hole();
      }
    }
}
