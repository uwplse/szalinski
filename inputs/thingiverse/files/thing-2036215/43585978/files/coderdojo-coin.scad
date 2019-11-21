// coderdojo coin
// created by weevilgenius

// preview[view:south, tilt:top]

// overall diameter of coin in mm
width = 40; // [20:100]
// total height of coin in mm
height = 4; // [2:10]
// width of border line around white portion
border = 1; //[0,1,2,3,4,5]
// font for numbers
font = "Roboto Mono:style=Bold";


shim = 1/10; // makes the cutout circles look tangent to the border
tolerance = 5/1000; // avoid coincident faces

union() {
  // lower body
  color("white") cylinder(d=width, h=height/2, $fn=60);
  // top swirl
  color("dimgray") translate([0, 0, height/2-tolerance])
  difference() {
    cylinder(d=width, h=height/2+tolerance, $fn=60);
    union() {
      // upper lobe
      translate([0, width/4-border/4+shim/2, 0])
        cylinder(d=width/2-border/2+shim, h=height+2, center=true, $fn=60);
      difference() {
        // smaller to create the border
        cylinder(d=width-border, h=height+2, center=true, $fn=60);
        translate([0, -width, -height/2-2])
          cube([width*2, width*2, height+4]);
        // lower lobe
        translate([0, -width/4+border/4-shim/2, 0])
          cylinder(d=width/2-border/2+shim, h=height+4, center=true, $fn=60);
      }
    }
    // number 1
    translate([0, -width/4+border/4, 0]) linear_extrude(height)
      text("1", font=font, valign="center", halign="center", size=width/4);
  }
  // number 0
  color("dimgray") translate([0, width/4-border/4, height/2])
    linear_extrude(height/2+tolerance)
      text("0", font=font, valign="center", halign="center", size=width/4);
}