hole_len = 2;
hole_rad = 0.3;

center_support_height = 16;
translate([0,1,0])
cube([3.2,center_support_height,1], center = true);

top_cone_hole = 13;
difference() {
translate([0,10,0])
rotate([0,90,90])
cylinder(2,1.7,0.3,$fn=100, center = true);

translate([0,10,0])
cylinder(top_cone_hole,hole_rad,hole_rad,$fn=100, center = true);

}


//Center bar
center_hole_distance = 6.5;
difference() {
cube([17,2,1], center = true);

translate([9,0.2,0]) 
rotate([0,0,25])
cube([2,2.7,1], center = true);

translate([-9,0.2,0])
rotate([0,0,-25])
cube([2,2.7,1], center = true);

translate([-center_hole_distance,0.2,0])
cylinder(hole_len,0.3,0.3,$fn=100, center = true);

translate([center_hole_distance,0.2,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

}


//Top bar1
topbar1_hole_distance = 3;
difference() {

translate([0,3,0])
cube([14,2,1], center = true);

translate([7.5,3.2,0])
rotate([0,0,25])
cube([2,2.7,1], center = true);

translate([-7.5,3.2,0])
rotate([0,0,-25])
cube([2,2.7,1], center = true);

translate([-topbar1_hole_distance,3.2,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

translate([topbar1_hole_distance,3.2,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);


}


//Top bar1
topbar2_hole_distance = 3.2;

difference() {
translate([0,6,0])
cube([10,2,1], center = true);


translate([5.5,6.2,0])
rotate([0,0,25])
cube([2,2.7,1], center = true);

translate([-5.5,6.2,0])
rotate([0,0,-25])
cube([2,2.7,1], center = true);

translate([-topbar2_hole_distance,6.2,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

translate([topbar2_hole_distance,6.2,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);


}


//BottomBar 1
bottombar_hole_distance = 5.7;
difference() {

translate([0,-3,0])
cube([19,2,1], center = true);

translate([10,-2.8,0])
rotate([0,0,25])
cube([2,2.7,1], center = true);

translate([-10,-2.8,0])
rotate([0,0,-25])
cube([2,2.7,1], center = true);

translate([-bottombar_hole_distance,-2.8,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

translate([bottombar_hole_distance,-2.8,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);


}


//BottomBar 2
bottombar2_innerhole_distance = 4;
bottombar2_outerhole_distance = 8;

difference() {
translate([0,-6,0])
cube([22,2,1], center = true);

translate([11.5,-5.8,0])
rotate([0,0,25])
cube([2,2.7,1], center = true);

translate([-11.5,-5.8,0])
rotate([0,0,-25])
cube([2,2.7,1], center = true);

translate([-bottombar2_outerhole_distance,-6,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

translate([bottombar2_outerhole_distance,-6,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

translate([-bottombar2_innerhole_distance,-6,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

translate([bottombar2_innerhole_distance,-6,0])
cylinder(hole_len,hole_rad,hole_rad,$fn=100, center = true);

}



