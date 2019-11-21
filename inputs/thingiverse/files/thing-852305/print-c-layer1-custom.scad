//Depth inside
numerical_slider = 20; // [10:200]
height=numerical_slider;

module puzzle_container() {
  difference() {
    difference() {
      cube([90,135,height+10]);
      translate([5, 5, 5])
        cube([80,125,height+6]);
    }
    translate([5, 5, height+5])
      cube([80,135,6]);
  }
}
puzzle_container();