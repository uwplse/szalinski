// see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language for instructions

// vac tube outer radius (connector inner radius)
vr= 17.5; 
// vac connector height
vh= 20;
// shaft outer radius
sr= 4; 
// shaft height
sh= 35; 
// cylinder resolution
$fn=150; 
// vac connector
difference() {
    cylinder(h=vh, r=vr+1);
    cylinder(h=vh, r=vr);
}
// tube to valve shaft
translate([0,0,vh]) difference() {
    cylinder(h=20, r1=vr+1, r2=sr);
    cylinder(h=20, r1=vr, r2=sr-1);
}
// valve shaft
translate([0,0,vh+20]) difference() {
    difference() {
        cylinder(h=sh,r=sr);
        translate([-sr,0,sh-2*sr]) rotate([90,0,0]) difference() {
            translate([sr,sr,0]) cube(sr*2.005,center=true);
            cylinder(h=sr*4,r=sr*2,center=true);
        }
    }
    cylinder(h=sh,r=sr-1);
}

