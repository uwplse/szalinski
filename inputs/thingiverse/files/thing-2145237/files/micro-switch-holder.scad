include <MCAD/materials.scad>
include <MCAD/metric_fastners.scad>

bracket();
translate([0,20,0]) mirror([0,1,0]) bracket();

module bracket() {
    difference(){
union() {
//translate([3,-2,6.5]) cube([20,2,6.5]);
translate([0,-2,2]) cube([23,10,5]);
translate([-2,-22,-2]) cube([2,30,9]);
translate([0,0,5]) linear_extrude(height = 2) polygon(points=[[0,0],[10,0],[0,-10]]);
}
translate([8,2,-5]) cylinder(h=20, r=1.5, r2=1.5 );
translate([18,2,-5]) cylinder(h=20, r=1.5, r2=1.5 );

translate([-5,-7,2.5]) rotate([0,90,0])cylinder(h=10, r=2, r2=2 );
translate([-5,-15,2.5]) rotate([0,90,0])cylinder(h=10, r=2, r2=2 );
}
}
module micro_switch(with_extra_parts=false, exploded=false) {
  scale([-1,1,1]) translate([-19.8, 0, 0]){
    difference() {
      color(BlackPaint) cube([19.8, 10.8, 6.4]);

      translate([5.15, 2, 0]) {
        translate([0, 0, -0.5])
          cylinder(h = 7.4, R=2.6, $fn=100);
        translate([9.5, 0, -0.5])
        cylinder(h = 7.4, R=2.6, $fn=100);
      }
    }
    translate([2.8, 10.8, 1.2])
      rotate([0,0,10])
        color(Steel) cube([17,1,4]);

    if(with_extra_parts)
      micro_switch_extras(exploded_distance=(exploded?15:0));
  }

  module micro_switch_extras(exploded_distance=0) {
    screw_size = 2.2;
    screw_length = 13;
    echo("Non-Plastic Parts, 2, Self Tapping Screw 2.2 x 13 mm for micro switch");
    translate([5.15, 2, 0]) color(Steel) {
      translate([0, 0, 0.5+6.4+exploded_distance])
        rotate([180,0,0]) csk_bolt(screw_size, screw_length);
      translate([9.5, 0, 0.5+6.4+exploded_distance])
        rotate([180,0,0]) csk_bolt(screw_size, screw_length);
    }
  }

}


//micro_switch();
