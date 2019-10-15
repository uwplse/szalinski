/*
A hanger for your mobile phone while it is charging.
Date: 19/11/2013
*/

//Frame for connecting the platform with the hook
translate([0,0,-5])
cube(size = [1,20,30], center = true);
//Change Hole radius parameters between 1-14
hole_radius = 15; //[5:14]
//Hook which goes around the charger
difference(){
translate([0,0,17])
rotate([90,0,90])
cylinder(h = 1, r = 15, center = true);

translate([0,0,17])
rotate([90,0,90])
cylinder(h = 1, r = hole_radius, center = true);
}
//Change base width
outer_width = 60;
//Change base length
outer_length = 30;

//Hollowed out base to place phone
difference(){
translate([14,0,-20])
rotate([0,90,0])
cube(size = [5,outer_width,outer_length], center = true);

translate([14,0,-19])
rotate([0,90,0])
cube(size = [3,outer_width-2,outer_length-2], center = true);
}




