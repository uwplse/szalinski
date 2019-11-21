jack_length =16.5;
jack_width = 15;

wall_height = 10;
wall_thickness = 4;

catch_overhang = 2;

small_clip_depth = catch_overhang;
big_clip_depth = catch_overhang + 2;
big_clip_clearance = 4;
small_clip_clearance = 6.5;

outer_length = jack_length + small_clip_depth + big_clip_depth +
                            (wall_thickness * 2);
outer_width = jack_width + (wall_thickness * 2);


module clip_catch() {
  rotate([90, 0, 0]) {
    linear_extrude(height = outer_width) {
      polygon(points = [[0,0],
                                       [catch_overhang,0],
                                       [wall_thickness,catch_overhang],
                                       [0,catch_overhang]],
                      paths = [[0,1,2,3]]);
    }
  }
}

module keystone() {
union() {

difference() {
  difference() {
    cube([outer_length, outer_width, wall_height]);
   translate([wall_thickness, wall_thickness, big_clip_clearance]) {
      cube([outer_length, jack_width, wall_height]);
    }
  }
  translate([wall_thickness + small_clip_depth, wall_thickness, 0]){
    cube([jack_length, jack_width, wall_height + 1]);
  }
}

cube([wall_thickness, outer_width, wall_height]);

cube([wall_thickness + small_clip_depth,
           outer_width, small_clip_clearance]);

translate([2, 23, 8]) {
  clip_catch();
}

translate([26.5,0,0]) {
  cube([4, 23, 10]);
}

translate([28.5, 0, 8]) {
  rotate([0, 0, -180]) {
    clip_catch();
  }
}


}
}

keystone();