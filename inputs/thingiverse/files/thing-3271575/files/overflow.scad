//plug size
l=48;
w=27.5;
h=2;

//wall thickness
wall=2;

//inner plug size
il=38;
iw=18;
ih=1;
id=20;

//hole size
hl=33;
hw=14;
hd=18;

//focal point for the inner pyramid extrusion
fp=45;

//connector tube dimensions
pipel=25;
pipew=15;
piped=12;
// connector tube length over plug side
tubel=22;

// screw dimensions
screw="M6";
screwl="M6x20";

include <rounded_square.scad>;
include <../nutsnbolts/cyl_head_bolt.scad>;
include <../nutsnbolts/materials.scad>;

difference() {
union() {
translate([-l/2,-w/2,0])
  cube([l,w,h]);
translate([-il/2,-iw/2,-ih])
  cube([il,iw,ih]);
    
translate([0,0,-ih])
  linear_extrude(height=fp+5, scale=-10)
  square([il,iw],center=true);

translate([0,-tubel-w/2,piped])
  rotate([-90,0,0])
  linear_extrude(height=tubel+w/2, scale=1.1)
    rounded_square([pipel, pipew],corners=[8,8,8,8],center=true);

}

translate([0,0,-ih])
  linear_extrude(height=fp, scale=-10)
  square([hl,hw],center=true);

translate([0,-tubel-w/2,piped])
  rotate([-90,0,0])
  linear_extrude(height=tubel+w/2, scale=1.1)
  rounded_square([pipel-wall*2, pipew-wall*2],corners=[6,6,6,6],center=true);

translate([-il/2,-iw/2,piped+pipew/2])
  cube([il, iw, fp]);

}

translate([-pipel/2,-pipew/2,piped+pipew/2-wall])
  cube([pipel, pipew, wall]);

difference() {
translate([-5,-iw/2,-ih]) 
cube([10,iw,ih+h+4]);
translate([0,0,6]) 
nutcatch_sidecut(screw, l=10);
translate([0,0,-15])
rotate([180,0,0])
screw(screwl);
}

