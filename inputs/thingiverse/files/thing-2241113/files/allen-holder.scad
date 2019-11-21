sizes = [ 4, 3, 2.5, 2, 1.5 ];
spacing = 1;
thickness = 2;
rotate = 30;
tolerance = 0.7;
height = 30;
cut_height = 15;
cut_angle = 20;

difference() {
  union() {
    linear_extrude(height)
    difference() {
      hull() // comment out here for hexagon shape body
      hexes(sizes, spacing, thickness);
      hexes(sizes, spacing);
    }
  }

  rotate([0, cut_angle, 0])
  translate([0, 0, 500+cut_height])
  cube([1000, 1000, 1000], center=true);
}

module hexes(array, spacing=0, offset=0, index=0) {
  d = array[index] * 2 / tan(60) + tolerance;
  rotate([0, 0, rotate]) circle(r=d/2 + offset, $fn=6);
  
  if (index < len(array) - 1) {
    d_2 = array[index+1] * 2 / tan(60);
    translate([(d + d_2)/2 + spacing, 0, 0])
    hexes(array, spacing, offset, index + 1);
  }
  
}


