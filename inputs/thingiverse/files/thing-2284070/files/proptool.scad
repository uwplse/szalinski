// Hole diameter (bottom)
bottomHole = 9.5;
// Hole diameter (top, this should be the bigger one)
topHole = 9.5;
// Height of the tool
height = 10;
// Thickness of the handle
thickness = 3;
// Length of the handle on each side
length = 20;
// Thickness of the walls
walls = 3;
// Diameter of the keychain hole
keyhole = 4.8;

/* [Hidden] */
$fn = 64;

difference() {
  group() {
    hull() {
      translate([-length, 0, 0])
        cylinder(r = thickness /2, h = height, center = true);
        
      translate([length, 0, 0])
        cylinder(r = thickness /2, h = height, center = true);
    }

    hull() {
      cylinder(r = (topHole + walls) / 2, h = height, center = true);
      
      translate([-length / 2, 0, 0])
        cylinder(r = thickness /2, h = height, center = true);
        
      translate([length / 2, 0, 0])
        cylinder(r = thickness /2, h = height, center = true);
    }
  }
  
  cylinder(r = bottomHole / 2, h = height + 2, center = true, $fn=6);
  
  translate([0, 0, height/2])
    cylinder(r = topHole / 2, h = height + 2, center = true, $fn=6);
  
  translate([length - keyhole / 2 - 1, 0, 0])
  rotate([90, 0, 0])
    cylinder(r = keyhole / 2, h = height + 2, center = true);
}