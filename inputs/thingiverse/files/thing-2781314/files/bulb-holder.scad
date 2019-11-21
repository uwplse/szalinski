
$fn=200;
inner_rad=20;
thickness=2;
height=68;
baseh=10; // below tube
baseh2=baseh+30; // switch cutout start height, top of beveled cylinder
baser=50;
cutout=8;

difference() {
  union() {
    translate([0,0,baseh]) {
      cylinder(r=inner_rad+thickness, h=height, center=false);
    }
    cylinder(r1=baser, r2=inner_rad, h=baseh2, center=false);
  }
  translate([0,0,-1]) {
    cylinder(r=inner_rad, h=100, center=false);
  }
  // switch cutout
  translate([-cutout/2,-inner_rad-cutout/2, baseh2]) {
    cube([cutout,cutout,100], center=false);
  }
  translate([-cutout/2,inner_rad-cutout/2, baseh2]) {
    cube([cutout,cutout,100], center=false);
  }
  // cord hole
  translate([-cutout/2,inner_rad-cutout/2, -1]) {
    cube([cutout,100,10], center=false);
  }
}



