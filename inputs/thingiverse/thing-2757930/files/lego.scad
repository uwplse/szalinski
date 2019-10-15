//!OpenSCAD
ruler_size = 5;
module moreThanOne() {
  union(){
    kuykv();
    mohammad();
  }
}

module mohammad() {
  for (j = [1 : abs(1) : ruler_size - 1]) {
    translate([((j - 1) * 7.9725), 0, 0]){
      difference() {
        translate([3.69, -3.69, 0]){
          cube([7.9725, 7.38, 7.76], center=false);
        }

        translate([3.69, 0, 0]){
          cylinder(r1=2.6, r2=2.6, h=7.76, center=false, $fs=0.01);
        }
        translate([11.6625, 0, 0]){
          cylinder(r1=2.6, r2=2.6, h=7.76, center=false, $fs=0.01);
        }
        translate([3.69, 0, -1]){
          cylinder(r1=3.2, r2=3.2, h=2, center=false, $fs=0.01);
        }
        translate([3.69, 0, 6.76]){
          cylinder(r1=3.2, r2=3.2, h=2, center=false, $fs=0.01);
        }
        translate([11.6625, 0, -1]){
          cylinder(r1=3.2, r2=3.2, h=2, center=false, $fs=0.01);
        }
        translate([11.6625, 0, 6.76]){
          cylinder(r1=3.2, r2=3.2, h=2, center=false, $fs=0.01, $fs=0.01);
        }
      }
    }
  }

}

module kuykv() {
  for (i = [1 : abs(1) : ruler_size]) {
    translate([((i - 1) * 7.9725 + 3.69), 0, 0]){
      difference() {
        difference() {
          difference() {
            cylinder(r1=3.69, r2=3.69, h=7.76, center=false, $fs=0.01);

            cylinder(r1=2.6, r2=2.6, h=7.76, center=false, $fs=0.01);
          }

          cylinder(r1=3.2, r2=3.2, h=1, center=false, $fs=0.01);
        }

        translate([0, 0, 6.76]){
          cylinder(r1=3.2, r2=3.2, h=1, center=false, $fs=0.01);
        }
      }
    }
  }

}


if (ruler_size == 0) {

} else {
  moreThanOne();
}