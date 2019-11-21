dist_M8=24.5; //distance between M8 center
side_x=23;  //X measure
side_y=50;  //Y measure
thickness=3; //thickness
thick_high=thickness+3; //higher thickness
thick_donut=3.5; //thickness donut M8
central_nut=4.5; //central nut
nut_precision=6; //central hole number of faces

//MAIN PIECE
difference(){ //necessary for nut presence
  union(){
    translate([0, -1*side_y/2, 0])
    main();
    mirror([0, 1, 0])
    translate([0, -1*side_y/2, 0])
    main();
  }
  translate([side_x/2, 0, 0])
  cylinder(r=central_nut, h=10,$fn=nut_precision, center=true);
}

module main() {
union(){  //UNION for translating before mirroring
difference(){ //DIFFERENCE with cube1
  union() {
    difference(){
      cube([side_x,side_y/2,thickness]);
      translate([side_x/2, (side_y-dist_M8)/2, 0]) foro();}
    translate([side_x/2, (side_y-dist_M8)/2, 0]) bordi();
          }
  translate([side_x/2-4, 0, 0]) cube(size=[8, (side_y-dist_M8)/2-1.5, 10], center=false); //cube1
            }
#translate([side_x/2-4, (side_y-dist_M8)/2-2, 0]) tondi(); // to reduce M8 hole and block them
} //fine UNION
}

module foro () {  //hole for smooth rod M8
  cylinder(r=8/2, h=thick_high, $fn=20, center=false);
}

module bordi () {
  difference() {
    cylinder(r=8/2+thick_donut, h=thick_high, center=false);
    cylinder(r=8/2, h=thick_high, center=false);
  }

}

module tondi() {
  translate([0, -5, 0]) {
    intersection() {
      cube(size=[8, 10,10], center=false);
        union(){
        translate([-0.5, 5, 0])
        cylinder(r=1, h=thick_high, $fn=10, center=false);    //rounded left
        translate([8.5, 5, 0])
        cylinder(r=1, h=thick_high, $fn=10, center=false);  //rounded right
        }
    }
  }
}
