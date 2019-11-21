width = 20;
bottom_length = 100;
top_length = 50;

translate([bottom_length*-1,0,0]) {
  cube([bottom_length,50,5]);
}
translate([top_length*-1,0,width+5]) {
  cube([top_length,50,5]);
}
translate([0,0,0]) {
  cube([5,50,width+10]);
}
translate([5,0,(width/2)+2.5]) {
  difference() {
    union() {
      cube([5,50,5]);
      translate([5,0,-4]) {
        cube([4,50,13]);
      }
    }
    translate([4.5,25,-5]) {
      rotate(a=[0,0,30]) {
        linear_extrude(height = 15, $fn = 16) {
          circle(r=4.04145189, $fn=6);
        }
      }
    }
  }
}