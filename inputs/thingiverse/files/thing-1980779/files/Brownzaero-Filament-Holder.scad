// License:  Creative Commons Attribtion
// https://creativecommons.org/licenses/by/3.0/

// Author: Brownzaero, 19-Dec-2016
// Simple Vertical PVC Filament Spool Holder
// This OPENscad file generates models for two different PVC Pipe fittings

// Dimensions in [mm]

// SELECT A MODEL TO GENERATE!
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
model = "bottom";   // options are "top" and "bototm"
//model = "top";
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$fn = 100;  // higher number generates higher quality cylinders/spheres/etc

// PVC pipe dimensions
outer_diameter_pvc = 28.575;    // outer diameter of pipe
inner_diameter_pvc = 19.05;     // inner diameter of pipe
pvc_error = 0;                  // desired "wiggle" room between PVC pipe and holding cylinder

// cylindrical holder dimensions
holder_thickness = 3.175;   // thickness of the printed cylindrical pipe
inner_diameter = outer_diameter_pvc + pvc_error;
outer_diameter = inner_diameter + 2*holder_thickness;
holder_length = 25.4;   // height of the cylinder on the base. 
chamfer = 3.175;        // height of the 45degree chamfer between the cylinder and the base

// base dimensions
base_length = outer_diameter*1.4;   // make the base length/width just big enough to contain the screw holes and be sturdy
base_width = base_length;           // set this to base_length for a square base
base_height = 6.35;                 // thickness of the base 
screw_hole_diameter = 4.7625;       // diameter of the 4 holes on the base
screw_hole_edge_distance = 6.35;    // distance between a screw hole's center and each corner edge

//top dimensions
upper_rack_length = outer_diameter; // this is the width of the U-shaped supprt on the top piece. bigger number = wider support

module pre_base(){
    // base
    cube([base_width, base_length, base_height],center=true);
    // cylindrical holder
    translate([0,0,base_height/2+holder_length/2]){cylinder(h=holder_length,d=outer_diameter,center=true);}
}
module cylindrical_chamfer(chamfer_diameter,chamfer_height){
    // chamfer
    cylinder(h=chamfer_height,d1=chamfer_diameter+chamfer_height*2,d2=chamfer_diameter,center=true);
}
module base_no_holes(){
    // assemble the base pieces so we can cut holes
    pre_base();
    translate([0,0,base_height/2+chamfer/2])
    cylindrical_chamfer(outer_diameter,chamfer);
}
module base(){
    difference(){
        base_no_holes();
        // cut out hole where PVC pipe will go
        cylinder(h=holder_length*3,d=inner_diameter,center=true);
        
        // START: four screw holes
        translate([-base_width/2+screw_hole_edge_distance,-base_length/2+screw_hole_edge_distance,0])
            cylinder(h=base_height*2,d=screw_hole_diameter,center=true);
        translate([-base_width/2+screw_hole_edge_distance,base_length/2-screw_hole_edge_distance,0])
            cylinder(h=base_height*2,d=screw_hole_diameter,center=true);
        translate([base_width/2-screw_hole_edge_distance,-base_length/2+screw_hole_edge_distance,0])
            cylinder(h=base_height*2,d=screw_hole_diameter,center=true);
        translate([base_width/2-screw_hole_edge_distance,base_length/2-screw_hole_edge_distance,0])
            cylinder(h=base_height*2,d=screw_hole_diameter,center=true);
        // END: four screw holes
        
        // horizontal screw hole to attach PVC pipe and part together
        translate([0,0,holder_length/2+base_height/2])
            rotate([0,90,0])
                cylinder(h=outer_diameter*2,d=screw_hole_diameter,center=true);
        }
}
module top(){
    difference(){
        hull(){
            //vertical cylinder
            cylinder(h=holder_length,d=outer_diameter,center=true);
            //horizontal cylinder
            translate([0,0,holder_length/2+outer_diameter/2])
                rotate([0,90,0])
                    cylinder(h=upper_rack_length,d=outer_diameter,center=true);}
        // horizontal hole
        translate([0,0,holder_length/2+outer_diameter/2])
            rotate([0,90,0])
                cylinder(h=upper_rack_length*2,d=inner_diameter,center=true);
        // final horizontal cutout
        translate([0,0,holder_length/2+outer_diameter/2+inner_diameter/2])
            cube([upper_rack_length*2,inner_diameter,inner_diameter],center=true);
        //vertical hole
        cylinder(h=holder_length*3,d=inner_diameter,center=true);
        //horizontal screw hole
        rotate([0,90,0])
            cylinder(h=outer_diameter*3,d=screw_hole_diameter,center=true);}
}
if (model=="bottom"){base();}
if (model=="top"){top();}


