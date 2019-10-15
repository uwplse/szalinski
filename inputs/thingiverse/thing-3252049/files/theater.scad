dist=24;
head=5;
m=4;
ext=8;
wall=2;
hook=8;
side=3;

outer=ext+2*wall;

rotate([0,180,0]) {

translate([0,outer,dist-outer])
  cube([wall,side+wall,outer+head]);
translate([-hook,outer,dist])
  cube([hook,side,head]);
translate([-hook,outer+side,dist-outer])
  cube([hook,wall,outer+head]);
  
difference() {
  cube([outer, outer, dist+head]);
  translate([outer/2,outer/2,0])
    cylinder(r=m/2, h=dist);
  translate([outer/2,outer/2,dist])
    cylinder(r=ext/2, h=dist);
}
translate([-hook,0,dist])
cube([hook,outer,head]);
difference(){
  union(){
  translate([-outer+ext/2,0,0])
    rotate([0,45,0])
      cube([dist,wall,dist]);
  translate([-outer+ext/2,ext+wall,0])
    rotate([0,45,0])
      cube([dist,wall,dist]);
  }
  translate([-dist,0,-dist])
    cube([dist,dist,2*dist]);
  translate([-dist,0,-dist])
    cube([3*dist,dist,dist]);
}
//*/
}