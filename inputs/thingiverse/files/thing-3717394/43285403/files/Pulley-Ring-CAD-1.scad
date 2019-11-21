// *** Variables ***
size = 16; // The size of the inner hole in mm
height = 7.5;  // the Z height of the ring
thickness = 2.5; // the thickness of the ring and the bars
gap = 12;  // the size of the gap to fit over the finger
bar_length = 4;  // the size of the bars to help fit over the finger

outer = size + (thickness / 2);

module base()
    union() {
      cylinder(height, size + thickness, size + thickness, true);
      hull() {
        translate([-outer + (thickness*2), outer, -height/2]) cylinder(height, thickness, thickness);
        translate([ outer - (thickness*2), outer, -height/2]) cylinder(height, thickness, thickness);
        translate([-outer + thickness, 0, -height/2]) cylinder(height, thickness, thickness);
        translate([ outer - thickness, 0, -height/2]) cylinder(height, thickness, thickness);
      }
      hull() {
          translate([-gap/2 - thickness, 0, -height/2]) cylinder(height, thickness/2);
          translate([-gap/2 - thickness, -outer - bar_length, -height/2]) cylinder(height, thickness/2, thickness/2);
      }
      hull() {
          translate([gap/2 + thickness, 0, -height/2]) cylinder(height, thickness/2);
          translate([gap/2 + thickness, -outer - bar_length, -height/2]) cylinder(height, thickness/2, thickness/2);
      }
    }

union() {
    difference() {
        base();
        cylinder( height, size, size, true);
        translate([-gap/2 - thickness/2, -outer - thickness, -height/2]) cube(gap + thickness);
    }
}

/* 
difference() {
      hull() {
          translate([-outer, outer, -height/2]) cylinder(height, thickness);
          translate([ outer, outer, -height/2]) cylinder(height, thickness);
          translate([-outer, outer * 2/3, -height/2]) cylinder(height, thickness);
          translate([ outer, outer * 2/3, -height/2]) cylinder(height, thickness);
      }
      hull() {
          translate([-outer/2, outer*2/3 - thickness, -height/2]) cylinder(height, thickness, thickness);
          translate([outer/2, outer*2/3 - thickness, -height/2]) cylinder(height, thickness, thickness);
      }
*/