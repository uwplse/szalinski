/* Really simple "mending plate" with two #6 holes 
    -- I use this to clamp a GT2 belt, but it probably could be used
    for anything. Al Williams, April 2013 */
// Version 2 - Fixed holes where n>2

// Length of plate (mm)
length=17; // [10:100]
// Width of plate (mm)
width=6; // [5:100]
// Thickness of plate (mm)
thickness=3; // [.5:20]
// Offset from edge/hole spacing (mm)
edgeoffset=3.5	;  // [1:10]
// Number of holes (should be even)
n=2; // [[1:100]
// Hole radius (mm)
hole_radius=2;
loopct=n/2;
difference() {
cube([length,width,thickness]);
for (i=[1:loopct]) {
  translate([edgeoffset*i+2*hole_radius*(i-1),width/2,1]) cylinder(h=thickness*10,r=hole_radius,center=true,$fn=50);
  translate([length-(edgeoffset*i+2*hole_radius*(i-1)),width/2,1]) cylinder(h=thickness*10,r=hole_radius,center=true,$fn=50);
  }
}
