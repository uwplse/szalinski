$fa=1; $fs=0.5;
include <nutsnbolts/cyl_head_bolt.scad>; // TODO: Change to Customizer library
include <MCAD/nuts_and_bolts.scad>;
// PSU presets
psu_atx = [140, 85, 150]; // ATX PSU (PS2)
psu_sfx = [100, 63, 125]; // SFX PSU
psu_custom = [0, 0, 0]; // x,y,z (length,depth,height) dimensions in mm
// set PSU size
tolerance = 1.5; // tolerance in mm
nut_tolerance = 0.2; // nut hole tolerance in mm
psu_dim = psu_sfx; // choose PSU dimensions
psu = psu_dim + [tolerance, tolerance, tolerance];
// set screw distances
screw_dist = [86, 91]; // x,z (horizontal,vertical) in mm
// set solidity
thickness = 3.6; // x,y,z (sides,depth,bottom) in mm
fill = 0.5; // fill multiplier
wall_dist  = 0.55; // screw distance from left wall in mm

part = "top";

// bottom
if(part == "bottom"){
    Bottom();
}

// top
if(part == "top"){
    mirror([1,0,0])Bottom();
}

// preview
if(part == "preview"){
    // draw PSU
    %translate([thickness, thickness, thickness])cube(psu);
    Bottom();
    translate([0,0,psu[2]+2*thickness])rotate([0,180,0])mirror([1,0,0])Bottom();
}

// both
if(part == "both"){
    Bottom();
    mirror([1,0,0])Bottom();
}

// modules
module Bottom(){
    difference(){
        holder_hole(psu[0]+2*thickness, psu[1]+2*thickness, 3*thickness+(psu[2]-screw_dist[1])/2, thickness, fill);
        translate([thickness, thickness, thickness])cube(psu);
        screw(thickness+psu[0]-wall_dist-screw_dist[0],thickness+(psu[2]-screw_dist[1])/2); // v2 thickness+(psu[0]-screw_dist[0])/2
        screw(thickness+psu[0]-wall_dist,thickness+(psu[2]-screw_dist[1])/2); // v2 thickness+(psu[0]+screw_dist[0])/2
    }
}

module holder_hole(xdim, ydim, zdim, rdim, fill){
    difference(){
        holder(xdim, ydim, zdim, rdim);
        translate([xdim*fill/2, ydim*fill/2, -0.1])scale([1-fill,1-fill,1])holder(xdim, ydim, zdim+0.2, rdim);
    }
}
module holder(xdim, ydim, zdim, rdim){
    hull(){
        translate([rdim,rdim,0])cylinder(r=rdim,h=zdim);
        translate([xdim-rdim,rdim,0])cylinder(r=rdim,h=zdim);
        translate([xdim/2,ydim-rdim,0])cylinder(r=rdim,h=zdim);
    }
}

module screw(x,z){
//    translate([x, thickness+0.1, z])rotate([270,0,0])hole_through(name="M3", l=18+5, cl=0.1, h=2.1, hcl=0.4);
    union(){
        translate([x, thickness-METRIC_NUT_THICKNESS[3]+nut_tolerance/2, z])rotate([270,0,0])nutHole(3, MM, nut_tolerance);
        translate([x, thickness, z])rotate([270,0,0])nutHole(3, MM, nut_tolerance);
        radius = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[size]/2;
        translate([x, 0, z])rotate([270,0,0])cylinder(r=radius, h=thickness+nut_tolerance/2);
    }
}