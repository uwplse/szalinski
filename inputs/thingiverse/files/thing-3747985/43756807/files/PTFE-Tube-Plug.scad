/**
* PTFE Tube Plug for plugging the ends of PTFE tubes, or any tube, really.

* @author Brian Alano
* @license This software is licensed by Brian Alano under the Creative Commons 4.0 Attribution, Non-Commercial, Share-Alike license CC BY-NC-SA 4.0
    https://creativecommons.org/licenses/by-nc-sa/4.0/    
* @requires OpenSCAD version 2019.05
* @since 2019-07-14
* @version 1.0
*/
/* [Basic] */
//PTFE tube inner diameter
tube_id = 2.0; // [0.0 : 0.1 : 25.0]
//PTFE tube outer diameter
tube_od = 4.0; //[2.0 : 0.05 : 25.0]
//Include a lanyard?
lanyard = "yes"; //[no, yes]
//Preview in cutaway view?
cutaway = "no"; //[no, yes]
/* [Cap] */
wall_thickness = 2.0; //[0.2 : 0.1 : 25.0]
tube_depth = 10.0; //[0.0 : 0.1 : 25.0]
filament_depth = 10.0; // [0.0 : 0.1 : 25.0]
lip_height = 2.0; // [0.0 : 0.1 : 25.0]
lip_width = 2.0; // [0.0 : 0.1 : 25.0]
// Ribs may help grip PTFE if printed with flexible filament
ribs = "yes"; //[no, yes]
/* [Lanyard] */
lanyard_width = 4.0; // [0.1 : 0.1: 8.0]
lanyard_length = 40; // [1 : 100]
// The more brittle your filament, the thinner the lanyard should be
lanyard_thickness = 1.0; //[0.1 : 0.1 : 3.0]
/* [Rendering] */
//Higher is more round, but slower to generate
$fn=32;

/* [Hidden] */
epsilon = 0.01;

main();

module add() {
    cap_height = tube_depth + filament_depth;
    cap_od = tube_od + wall_thickness*2;
    lip_od = cap_od + lip_width*2;
    
    // lip
    cylinder(h=lip_height, d=lip_od);
    // main cap
    cylinder(h=cap_height, d=cap_od);
    // top chamfer
    translate([0, 0, cap_height]) cylinder(h=wall_thickness, d1=cap_od, d2=cap_od - wall_thickness*2 );
    // lanyard
    if (lanyard == "yes") {
        translate([0, -lanyard_width/2, 0]) cube([lanyard_length, lanyard_width, lanyard_thickness]); 
        translate([lanyard_length, 0, ,0]) cylinder(h=lanyard_thickness, d = cap_od);
    }
}

module subtract() {
    // tube cutout
    cylinder(h=tube_depth + filament_depth, d=tube_id);
    // chamfer the tube hole
    cylinder(h=wall_thickness/2, d1=tube_od + wall_thickness/2, d2 = tube_od);
    // filament cutout
    translate([0,0,-epsilon]) cylinder(h=tube_depth + epsilon, d=tube_od);
    // chamfer the filament hole
    translate([0, 0, tube_depth-epsilon])     cylinder(h=tube_od, d1=tube_od, d2 = 0);
    // ribs
    if (ribs == "yes") {
        for(i=[wall_thickness/2:wall_thickness/2:wall_thickness*1.5]) {
            translate([0, 0, i]) cylinder(h=wall_thickness/4, d=tube_od + wall_thickness/2);
        }
    }
    // lanyard cutout
   translate([lanyard_length, 0, -epsilon]) cylinder(h=lanyard_thickness + epsilon*2, d=tube_od);
    // cutaway preview
    if (cutaway == "yes") {
        translate([0, -25, -epsilon]) cube([200, 50, 100], center=true);
    }
}

module main() {
    difference() {
        add();
        subtract();
    }
}

