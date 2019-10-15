sp=3; //thickness
asse=65; //distance between vertical wall
base_x=8+sp+asse+sp+8; //dimension X base
base_y=80; //dimension Y base
base_z=30; //dimension Z of the object
hole_dia=9; //four hole
sp_hole=5; //edge around hole of threaded rod
hole_pos_z=base_z-sp_hole-hole_dia/2; //hole position Z

module base(){
cube([8+sp+asse+sp+8,base_y,sp]);
}

module wall(){
translate([8, 0, 0])
  difference() { // difference with round_corner() to make roundness
      cube([sp,base_y,base_z]);
      translate([0, base_y-sp_hole-hole_dia/2, base_z-sp_hole-hole_dia/2]) round_corner();
      translate([0, sp_hole+hole_dia/2, base_z-sp_hole-hole_dia/2]) mirror([0,1,0]) round_corner();
  }

translate([base_y-8-sp, 0, 0])
  difference() { // difference with round_corner() to make roundness
      cube([sp,base_y,base_z]);
      translate([0, base_y-sp_hole-hole_dia/2, base_z-sp_hole-hole_dia/2]) round_corner();
      translate([0, sp_hole+hole_dia/2, base_z-sp_hole-hole_dia/2]) mirror([0,1,0]) round_corner();
  }
}

module round_corner(){  //rounder corner need for difference with cube
difference() {
  cube(size=[sp, sp_hole+hole_dia/2, sp_hole+hole_dia/2], center=false);
  rotate([0, 90, 0]) cylinder(r=sp_hole+hole_dia/2, h=sp, center=false);
  }
}

//main function
base(); //base of filament spool
difference(){
wall();
//hole for threaded rod
translate([0,sp_hole+hole_dia/2, hole_pos_z]) //first rod
rotate([0, 90, 0])
  cylinder(r=hole_dia/2, base_x, center=false);
translate([0,base_y-(sp_hole+hole_dia/2), hole_pos_z]) //second rod
  rotate([0, 90, 0])
    cylinder(r=hole_dia/2, base_x, center=false);
}
