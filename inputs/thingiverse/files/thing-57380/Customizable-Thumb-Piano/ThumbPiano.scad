// A Thumb Piano
// by Patrick Wiseman
// Version 20130305
// thingiverse.com/thing:57380
use <utils/build_plate.scad>;
print_sound_board="no"; // [yes,no]
print_sound_box="no"; // [yes,no]
// For easy installation of socket to plug in to amplifier
print_sound_box_socket="no"; // [yes,no]
print_tines="yes"; // [yes,no]
// of the longest tine, in mm, to determine key (75x4 = F# with my red PLA!)
tine_length=75; // [20:80]
// from 3-5 mm
tine_width=4; // [3,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,4.9,5]
// between tines, from 1-2 mm
tine_gap=1.5; // [1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2]
// for future customization
tine_number=8*1; // [7,8,9,11,13]
build_plate(3,230,200); // Type A Machines Series 1 build plate
// Save each part as a separate STL file by answering "yes" one by one
// I print each part with .2mm layers, 3 solid layers top and bottom, 2 perimeters
if (print_tines=="yes") {
// print solid to provide consistent density, vibration
translate([-((tine_number+1)*(tine_width+tine_gap))/2,0,0]) cube([(tine_number+1)*(tine_width+tine_gap),6,6]);
translate([-20,0,6]) cube([40,4,4]);
linear_extrude(height=2) {
// the frequency ratios below use just intonation (Google it!)
// Use F = A/L^2 to find L for each frequency F, where A is a constant dependent on the material, and L is the length of the tine. Knowing L0 (our base length), L = sqrt(1/c)*L0, where c is the ratio defining the frequency
translate([0,6,0]) square([tine_width/2,tine_length]);
translate([tine_width/2+tine_gap,6,0]) square([tine_width,tine_length*sqrt(8/9)]); // major 2d
translate([tine_width/2+tine_width+2*tine_gap,6,0]) square([tine_width,tine_length*sqrt(3/4)]); // perfect 4th
translate([tine_width/2+2*tine_width+3*tine_gap,6,0]) square([tine_width,tine_length*sqrt(3/5)]); // major 6th
translate([tine_width/2+3*tine_width+4*tine_gap,6,0]) square([tine_width,tine_length*sqrt(1/2)]); // octave
mirror([1,0,0]) {
translate([0,6,0]) square([tine_width/2,tine_length]);
translate([tine_width/2+tine_gap,6,0]) square([tine_width,tine_length*sqrt(4/5)]); // major 3d
translate([tine_width/2+tine_width+2*tine_gap,6,0]) square([tine_width,tine_length*sqrt(2/3)]); // perfect 5th
translate([tine_width/2+2*tine_width+3*tine_gap,6,0]) square([tine_width,tine_length*sqrt(8/15)]); // major 7th
}
} // end linear_extrude
} // end print_tines
if (print_sound_board=="yes") {
// print with 15% infill
difference() {
translate([1,-85,0]) // 1,-(y+5),0
cube([100,80,3]); // x,y,z
union() {
translate([15,-66,0])
cube([4,40,4]);
translate ([75,-45,0]) cylinder(4,15,15);
}
}
translate([3,-83,3]) linear_extrude(height=3) difference() {
square([96,76]); // x-4,y-4
translate([1.5,1.5,0]) square([93,73]);
}
}
if (print_sound_box=="yes") {
// print with 50% infill
translate([-101,-85,0]) // -(x+1),-(y+5),0
difference() {
cube([100,80,40]);
union() {
translate([2,2,2]) cube([96,76,50]);
if (print_sound_box_socket=="yes") {
// hole for 1/4" (6.35mm) plug
translate([-4,20,20]) rotate([0,90,0]) cylinder(8,5.5,5.5);
}
}
}
}
