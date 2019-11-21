/******************************************************
*  A flexible bracelet with the customizable length   *
*  for the "Ultrasound-sensing based navigational     *
*  support for visually impaired"                     *
*  https://www.thingiverse.com/thing:3717730          *
*                                                     *
*  Instructions:
*  https://www.appropedia.org/Low-cost_open_source_ultrasound-sensing_based_navigational_support_for_visually_impaired
*                                                     *
*                                                     *
*  Aliaksei Petsiuk, 2019                             *
*  Licence: CC BY-SA 3.0                              *
*                                                     *
*******************************************************/

$fn = 50;  // resolution
len = 150; // variable length

// round fixator #1
difference(){
    cylinder(  29, d=5.8, center=false);
    cylinder(h=30, d1=2, d2=2, center=false);
}

// round fixator #2
translate([len, 0, 0])
difference(){
    cylinder(  29, d=5.8, center=false);
    cylinder(h=30, d1=2, d2=2, center=false);
}

// bracelet
difference(){
translate([0, -2.9, 0])
cube([len,2,29],false);

// perforation pattern
for(i=[0:len/10-3])
    translate([i*10+13.5,-4,4.5])
       cube([4,5,20],false);
}

// end