//
//
//  Pipe flange adapter
//    fits over the pipe, not inside.
//
//   R. Lazure   Nov. 1. 2018
//
inner_dia = 90;
depth = 80;
flange_thick= 4;
screw_hole_rad= 2.5;
//
/* Hidden */
flange_rad= inner_dia/2 +30;
screw_hole_rad_pos= flange_rad-7;
$fn=100;
//
difference() {
union() {
//
//   base
//
cylinder(h=flange_thick, r1=flange_rad, r2=flange_rad, center=false);
//
// upright support
//
translate([0,0,flange_thick])
 cylinder(h=depth, r1=inner_dia/2+15, r2=inner_dia/2+5, center=false);
 }
//
//  remove inner material
//
color("red")
 cylinder(h=2*depth+20, r1=inner_dia/2, r2=inner_dia/2, center=true);
//
//  Three hole pattern
//
color("green")
translate([screw_hole_rad_pos,0,0])
 cylinder(h=depth, r1=screw_hole_rad, r2=screw_hole_rad, center=true);
//
xp = screw_hole_rad_pos*0.5;
yp = screw_hole_rad_pos*0.866;
color("green")
translate([-xp,yp,0])
 cylinder(h=depth, r1=screw_hole_rad, r2=screw_hole_rad, center=true);
//
color("green")
translate([-xp,-yp,0])
 cylinder(h=depth, r1=screw_hole_rad, r2=screw_hole_rad, center=true);
//
//   cross-section check
//
// translate([-100,0,0])
// cube([200,200,300],true);
 }




