/* [Global] */ 

// The country name to be displayed
country = "Greece";

// The year to be displayed
year    = "2002"; // [1999:2025]

// Mark after the year, eg for Germany states, Greece early minter
postmark = "F"; 

// Should a commemorative slot be included
open_commemorative = 0; // [1:Yes,0:No]

// Should the country/year label be printed in the front
label_front = 1; // [1:Yes, 0:No]

// Should the country/year label be printed on the side
label_side = 1; // [1:Yes, 0:No]

/* [Hidden] */

// Escape unicode to comply with Makerbot ASCII imports (FIX THIS!)
EURO = "\u20ac";
CENT = "\u00a2";

coins = [
 // Label, Hole radius, Row, Col, LabelXoffset, IsCommemorative
    [str( "1",CENT),    16.25, 0, 0, 4, 0],
    [str( "2",CENT),    18.75, 0, 1, 4, 0],
    [str( "5",CENT),    21.25, 0, 2, 5, 0],
    [str("10",CENT),    19.75, 1, 0, 0, 0],
    [str("20",CENT),    22.25, 1, 1, 0, 0],
    [str("50",CENT),    24.25, 1, 2, 0, 0],
    [str( "1",EURO),    23.25, 2, 0, 3, 0],
    [str( "2",EURO),    25.75, 2, 1, 3, 0],
    [str("2",EURO,"C"), 25.75, 2, 2, 0, 1]
];

// The grid container for each coin.
// All coins are given this amount of space for their holes
coin_slot = 30;

// How deep the labels should be dug
// For best results, should be divisible by 0.2 (def layer height)
label_depth = 1.2;

// How many "faces" are calculated for each circle
$fn=80;

// Makes a coin hole, with a bottom lip inset
module coin_hole(d) {
    // Make the hole for the coin
    translate([coin_slot/2,coin_slot/2,0.5])
    cylinder(d=d, h=3);
    
    // Make a coin holder to keep the coin from falling
    translate([coin_slot/2,coin_slot/2,-0.5])
    cylinder(d=d-1, h=3);
}

// Makes a mark that commemorative slot should not be available
module coin_nocom(d) {
    translate([coin_slot/2,coin_slot/2,3-label_depth])
        linear_extrude(height=3)
        difference() {
            circle(d=d);
            circle(d=d-1);
        };
    
    translate([5,coin_slot/2-2,3-label_depth])
        linear_extrude(height=3)
        text("No Com", size=4);
}

difference() {
  // Make the base with no slots/text
  translate([0, -10, 0]) cube([100, 115, 3]);
  
  // Loop to open each coin slot
  for(coin = coins) {
    if(coin[5] == 0 || open_commemorative == 1) {
    // First the coin hole
    translate([10+coin[2]*coin_slot, coin[3]*37, 0]) 
      coin_hole(coin[1]);
    }
    // Then the label
    translate([16+coin[2]*30+coin[4], coin[3]*37-6, 3-label_depth])
      linear_extrude(height=3)
      text(coin[0], size=8);
    
    // If this is a commemorative coin hole, but it is
    // not enabled, print a mark in its place so its not empty
    if(coin[5] == 1 && open_commemorative == 0) {
        translate([10+coin[2]*30, coin[3]*37, 0])
        coin_nocom(coin[1]);
    }
  }
  
  // Topside country / year mark
  if(label_front == 1) {
    translate([13,-5,3-label_depth])
    rotate([0,0,90])
    linear_extrude(height=3)
    text(str(country," - ",year,postmark), size=10);
  }
 
  // Side country / year mark
  if(label_side == 1) {
    translate([2,100,0.5])
    rotate([90,00,-90]) 
    linear_extrude(height=2)
    text(str(country," - ",year,postmark), size=2); 
  }
}
