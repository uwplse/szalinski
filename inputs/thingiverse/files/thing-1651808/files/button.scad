$fn = 64*1;

inch = 25.4;

_1_diameter = 10; // 10; //[5:50]
_2_height = 2; //[1:25]
_3_number_of_holes = 4; //[1:5]
_4_hole_diameter = 1.5; //[1:10]
_5_hole_offset = 1.75; //[0:10]
_6_lip_ratio = 0.60; //[0:100]
_7_edge_ratio = 0.85; //[0:100]
_8_rounding=0.25;


module holes(h=2, r=1.5/2, o=2, n=2) {
  union()
    for(i = [1:n])
      rotate([0, 0, i * 360 / n])
        translate([o, 0, 0])
          cylinder(h=h, r=r);
}

module main(
    diameter=10, 
    height=2, 
    number_of_holes=4, 
    hole_diameter=1.5,
    hole_offset=1.5,
    lip_ratio=0.6, 
    edge_ratio=0.85, 
    rounding=0.25){
  difference(){
    minkowski() {
      translate([0, 0, rounding])
        cylinder(h=height - 2 * rounding, r = diameter/2 - rounding); 
      sphere(r=rounding);
    }
    holes(h=height, n=number_of_holes, r=hole_diameter/2, o=hole_offset);
    translate(v=[0, 0, height*lip_ratio])
      cylinder(h=height, r=edge_ratio*diameter/2);
  }
}

main(
  _1_diameter,
  _2_height,
  _3_number_of_holes,
  _4_hole_diameter,
  _5_hole_offset,
  _6_lip_ratio,
  _7_edge_ratio,
  _8_rounding);

