// Created in 2016 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:1701300


quantity = 1;

cleaning_hole = 5;
thickness = 2.0;

length = 55.0;
height = 15.0;

text_size = 5;
override_text_len = 0;

label1 = "Extruder";
label2 = "Cleaner";


text_len = (override_text_len > 0) ? override_text_len : (text_size * 6.8);



module ExtruderCleaner() {
//  translate([thickness, length, 0])
//  rotate([90, 0, -90])
  union() {
    difference () {
      cube([length, height, thickness]);

      translate([length - height/2, height/2, -0.01])
        cylinder(h = thickness + 0.02, r=cleaning_hole/2+0.4);
      translate([length - height/2 - cleaning_hole/2 - text_len,
        (2*height - text_size)/3, thickness/2])
        linear_extrude(height=thickness/2+0.01)
        text(label1, size=text_size, spacing=1.2);
      translate([length - height/2 - cleaning_hole/2 - text_len,
        (height - 2*text_size)/3, thickness/2])
        linear_extrude(height=thickness/2+0.01)
        text(label2, size=text_size, spacing=1.2);
    }
  }
}


// This creates an array of the specified number its children, arranging them
// for the best chance of fitting on a typical build plate.
module MakeSet(quantity=1, x_len=30, y_len=30) {
  bed_yoverx = 1.35;
  x_space = ((x_len * 0.2) > 15) ? (x_len * 0.2) : 15;
  y_space = ((y_len * 0.2) > 15) ? (y_len * 0.2) : 15;
  function MaxVal(x, y) = (x > y) ? x : y;
  function MaxDist(x, y) = MaxVal((x_len*x + x_space*(x-1))*bed_yoverx,
    y_len*y + y_space*(y-1));
  function MinExtentX(x) = ((x >= quantity) ||
    (MaxDist(x+1, ceil(quantity/(x+1))) > MaxDist(x, ceil(quantity/x)))) ?
    x : MinExtentX(x+1);
  colmax = MinExtentX(1);

  for (i=[1:quantity]) {
    translate([(x_len + x_space)*((i-1)%colmax),
      (y_len + y_space)*floor((i-1)/colmax), 0])
      children();
  }
}


MakeSet(quantity, length, height)
ExtruderCleaner();

