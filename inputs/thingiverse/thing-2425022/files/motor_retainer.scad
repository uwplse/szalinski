// Parametric Motor Retainer created by: Nick Estes <nick@nickstoys.com>
// Released under a Creative Commons - share alike - attribution license

include <polyScrewThread_r1.scad>

PI=3.141592;

/*
// BT-50 settings
rocket_outer_diameter = 24.8;
rocket_inner_diameter = 24;
cap_inner_diameter = 18;
retainer_height=12.7;  // 1/2in is typical
thrust_ring_height=0; // set to 0 for no protruding thrust ring
cap_height=3; // height of cap portion of the retainer against ejection pressure
*/

// 29mm motor mount
rocket_outer_diameter = 30.7;
rocket_inner_diameter = 29;
cap_inner_diameter = 28;
retainer_height = 13;
thrust_ring_height = 6;
cap_height = 2;

/*
// Kwik-Switch
rocket_outer_diameter = 30.7;
rocket_inner_diameter = 54;
retainer_height=15;  // 1/2in is typical
cap_height=3; // height of cap portion of the retainer against ejection pressure
// 54mm
//thrust_ring_height=6; // set to 0 for no protruding thrust ring
//cap_inner_diameter = 54;
// 38mm
//thrust_ring_height=10; // set to 0 for no protruding thrust ring
//cap_inner_diameter = 38;
// 29mm
thrust_ring_height=10; // set to 0 for no protruding thrust ring
cap_inner_diameter = 29;
*/

// Things that shouldn't change much
cap_thickness=1.5;  // thickness of cap in addition to the thread for strength
thread_depth=3.5; // slightly more than the thread depth, allows for strength
lip=1; // sits against the end of the motor tube when epoxying on
fudge_factor=0.8; // clearance figure for the tube to fit cleanly, printer-specific
scale_factor=(rocket_outer_diameter+fudge_factor*2.5)/(rocket_outer_diameter);

// Make pretty circles
$fs=0.2;
$fa=0.2;

translate([rocket_outer_diameter+thread_depth*2+cap_thickness*2+10,0,0]) {
    difference() {
        screw_thread(rocket_outer_diameter+thread_depth*2,4,55,retainer_height+lip,PI/2,0);
        translate([0,0,-.5]) cylinder(retainer_height+lip+1, r=rocket_inner_diameter/2+fudge_factor);
        translate([0,0,lip]) cylinder(retainer_height+lip, r=rocket_outer_diameter/2+fudge_factor);
    }
}

scale([scale_factor,scale_factor,1]) union() {
    hex_nut(rocket_outer_diameter+thread_depth*2+cap_thickness*2 , retainer_height+thrust_ring_height+cap_height+lip, 4, 55, rocket_outer_diameter+thread_depth*2, 0.5);
    difference() {
        cylinder(cap_height, r=rocket_outer_diameter/2+thread_depth+cap_thickness);
        translate([0,0,-.5]) cylinder(cap_height+1, r=(cap_inner_diameter/2+fudge_factor)/scale_factor);
    }
}

