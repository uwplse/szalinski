//
//
//  Sign post holder
//
//   R. Lazure   Nov. 6 2018
//
inner_dia = 90;
depth = 30;
board_width = 14;
board_height = 50;
hold_length= 50;
//
/* Hidden */
$fn=100;
outer_dia = inner_dia + 10;
//
difference() {
union() {

//
// outer diameter
//
translate([0,0,0])
 cylinder(h=depth, r1=outer_dia/2, r2=outer_dia/2, center=false);
 }
//
//  remove inner material
//
color("red")
 cylinder(h=2*depth+20, r1=inner_dia/2, r2=inner_dia/2, center=true);
 }
difference() {
//
// add sign holding block shell
translate([outer_dia/2-2,-9,0])
cube([hold_length+5,board_width+6,board_height+3],false);
//
//  remove sign
//
translate([outer_dia/2+3,-6,3])
cube([hold_length+10,board_width,board_height+15],false);
//
//  add retaining screw hole
//
 xt=(outer_dia+hold_length)/2;
 translate([xt+4,1,0])
cylinder(h=10, r1=2, r2=2, center=true);
 }
//
//   cross-section check
//
// translate([-100,0,0])
// cube([200,200,300],true);





